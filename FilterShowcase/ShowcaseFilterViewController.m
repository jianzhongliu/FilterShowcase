#import "ShowcaseFilterViewController.h"
#import <CoreImage/CoreImage.h>

@implementation ShowcaseFilterViewController
@synthesize faceDetector;
@synthesize checkedArray,checkedIndexArray,arrayTemp,allCellArray;


@synthesize nameLabel1;
@synthesize nameLabel2;
@synthesize nameLabel3;
@synthesize nameLabel4;
@synthesize nameLabel5;
@synthesize nameLabel6;
@synthesize nameLabel7;
@synthesize nameLabel8;

@synthesize currentValueLabel1;
@synthesize currentValueLabel2;
@synthesize currentValueLabel3;
@synthesize currentValueLabel4;
@synthesize currentValueLabel5;
@synthesize currentValueLabel6;
@synthesize currentValueLabel7;
@synthesize currentValueLabel8;


@synthesize contentImageView;

@synthesize isStatic,stillImage;

#pragma mark -
#pragma mark Initialization and teardown

- (id)initWithFilterType:(GPUImageShowcaseFilterType)newFilterType;
{
    self = [super initWithNibName:@"ShowcaseFilterViewController" bundle:nil];
    if (self) 
    {
        filterType = newFilterType;
        countColor = 0;
        //        isStatic = YES; // 处理静态图片
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [finishBtn setTitle:@"Save" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(SaveAction:) forControlEvents:UIControlEventTouchDown];
    finishBtn.frame = CGRectMake(0, 0, 52, 36);
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
	self.navigationItem.rightBarButtonItem = rightButtonItem;

    
    if([checkedIndexArray count] == 1)
    {
        _filterSettingsSlider1.hidden = YES;
        _filterSettingsSlider2.hidden = YES;
        _filterSettingsSlider3.hidden = YES;
        _filterSettingsSlider4.hidden = YES;
        _filterSettingsSlider5.hidden = YES;
        _filterSettingsSlider6.hidden = YES;
        _filterSettingsSlider7.hidden = YES;
        
        UITableViewCell * cell = (UITableViewCell *)[self.allCellArray objectAtIndex:[[self.checkedIndexArray objectAtIndex:0] intValue]];
        nameLabel1.text = cell.textLabel.text;
        
        nameLabel2.hidden = YES;
        nameLabel3.hidden = YES;
        nameLabel4.hidden = YES;
        nameLabel5.hidden = YES;
        nameLabel6.hidden = YES;
        nameLabel7.hidden = YES;
        nameLabel8.hidden = YES;
        
        currentValueLabel2.hidden = YES;
         currentValueLabel3.hidden = YES;
         currentValueLabel4.hidden = YES;
         currentValueLabel5.hidden = YES;
        currentValueLabel6.hidden = YES;
        currentValueLabel7.hidden = YES;
        currentValueLabel8.hidden = YES;

    }
    UIImage *inputImage = [UIImage imageNamed:@"sample1.jpg"];
    
    staticPicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
//
    pipeline = [[GPUImageFilterPipeline alloc]initWithOrderedFilters:arrayTemp input:staticPicture output:(GPUImageView*)self.view];
//    filter = [[GPUImageRGBFilter alloc] init];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerColor) userInfo:nil repeats:YES];
    
//    [staticPicture processImage];
    
    
    [self setupFilter];

}

- (void)timerColor {
    countColor += 0.1;
    [(GPUImageRGBFilter *)filter setGreen:countColor];
    [staticPicture processImage];
}

- (void)setupFilter;
{
    

   
    facesSwitch.hidden = YES;
    facesLabel.hidden = YES;
    
    
   
    UILabel * tempLabel = nil;
    
    BOOL needsSecondImage = NO;
    for(int i = 0;i<[checkedIndexArray count];i++)
    {
        int _index = [[checkedIndexArray objectAtIndex:i] intValue];
        if(i == 0 )
        {
            self.filterSettingsSlider = self.filterSettingsSlider;
            tempLabel = currentValueLabel1;
            filterSettingsSliderTemp = self.filterSettingsSlider;
        }
        switch (_index)
        {
            case GPUIMAGE_RGB_GREEN:
            {
                self.title = @"RGB Green";
                self.filterSettingsSlider.hidden = NO;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:2.0];
                [self.filterSettingsSlider setValue:1.0];
                tempLabel.text = [NSString stringWithFormat:@"%.2f",1.0];
                
                filter = [[GPUImageRGBFilter alloc] init];
            }; break;
            default: filter = [[GPUImageSepiaFilter alloc] init]; break;
        }
        
    if(arrayTemp == nil)
    {
         arrayTemp = [[NSMutableArray alloc]init];
    }
   

    if(i ==0)
    {
        tempFilter = filter;
        [arrayTemp addObject:filter];
        
    }

    }
    filter = tempFilter;
    self.filterSettingsSlider = filterSettingsSliderTemp;

    
    UIImage *inputImage = [UIImage imageNamed:@"sample1.jpg"];
    
    staticPicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    
    pipeline = [[GPUImageFilterPipeline alloc]initWithOrderedFilters:arrayTemp input:staticPicture output:(GPUImageView*)self.view];
}

#pragma mark -
#pragma mark Filter adjustments

- (IBAction)updateFilterFromSlider:(id)sender;
{
    UISlider * slider = (UISlider *)sender;
    UILabel  *currentValue = nil;
    if(slider == _filterSettingsSlider)
    {
        filter = [arrayTemp objectAtIndex:0];
        filterType = [[checkedIndexArray objectAtIndex:0] intValue];
        currentValue = currentValueLabel1;

    }
    

    
    if(self.isStatic)
    {

        [(GPUImageRGBFilter *)filter setGreen:[(UISlider *)sender value]];
        
        [staticPicture processImage];
    }
}

#pragma mark - Face Detection Delegate Callback
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    if (!faceThinking) {
        CFAllocatorRef allocator = CFAllocatorGetDefault();
        CMSampleBufferRef sbufCopyOut;
        CMSampleBufferCreateCopy(allocator,sampleBuffer,&sbufCopyOut);
        [self performSelectorInBackground:@selector(grepFacesForSampleBuffer:) withObject:CFBridgingRelease(sbufCopyOut)];
    }
}

- (void)grepFacesForSampleBuffer:(CMSampleBufferRef)sampleBuffer{}

- (void)GPUVCWillOutputFeatures:(NSArray*)featureArray forClap:(CGRect)clap
                 andOrientation:(UIDeviceOrientation)curDeviceOrientation
{}

-(IBAction)facesSwitched:(UISwitch*)sender{
    if (![sender isOn]) {
        [videoCamera setDelegate:nil];
        if (faceView) {
            [faceView removeFromSuperview];
            faceView = nil;
        }
    }else{
        [videoCamera setDelegate:self];

    }
}

#pragma mark - SaveAction
- (void)SaveAction:(id)sender
{
    UIImage *img = [pipeline currentFilteredFrame];
//    
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
//    imgView.frame = self.view.frame;
//    [self.view addSubview:imgView];
    
    
    if(img)
    {
        UIImageWriteToSavedPhotosAlbum(img, self,
                                       @selector(image:didFinishSavingWithError:contextInfo:), nil);
        finishBtn.enabled = NO;
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if(!error)
    {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@""
                                                                 message:@"Save succeed!!"
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
        [errorAlertView show];
    }
 

    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    finishBtn.enabled = YES;
}

-(IBAction)hideAll:(id)sender
{}

#pragma mark -
#pragma mark Accessors

@synthesize filterSettingsSlider = _filterSettingsSlider;
@synthesize filterSettingsSlider1 = _filterSettingsSlider1;
@synthesize filterSettingsSlider2 = _filterSettingsSlider2;
@synthesize filterSettingsSlider3 = _filterSettingsSlider3;
@synthesize filterSettingsSlider4 = _filterSettingsSlider4;
@synthesize filterSettingsSlider5 = _filterSettingsSlider5;
@synthesize filterSettingsSlider6 = _filterSettingsSlider6;
@synthesize filterSettingsSlider7 = _filterSettingsSlider7;

@end

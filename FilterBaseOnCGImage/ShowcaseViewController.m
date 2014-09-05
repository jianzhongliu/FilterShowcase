//
//  ShowcaseViewController.m
//  FilterShowcase
//
//  Created by jianzhong on 4/9/14.
//  Copyright (c) 2014 Cell Phone. All rights reserved.
//

#import "ShowcaseViewController.h"
#import "GPUImage.h"
#import "UIView+draggable.h"
#import "GPUImageFilter.h"
#import "GPUImageTwoInputFilter.h"
//#import "GPUImagePixellateFilter.h"
//#import "GPUImageSepiaFilter.h"
//#import "GPUImageColorInvertFilter.h"
//#import "GPUImageSaturationFilter.h"
//#import "GPUImageContrastFilter.h"
//#import "GPUImageExposureFilter.h"
//#import "GPUImageBrightnessFilter.h"
//#import "GPUImageSharpenFilter.h"
//#import "GPUImageGammaFilter.h"
//#import "GPUImageSobelEdgeDetectionFilter.h"
//#import "GPUImageSketchFilter.h"
//#import "GPUImageToonFilter.h"
//#import "GPUImageSmoothToonFilter.h"
//#import "GPUImageMultiplyBlendFilter.h"
//#import "GPUImageDissolveBlendFilter.h"
//#import "GPUImageKuwaharaFilter.h"
//#import "GPUImageVignetteFilter.h"
//#import "GPUImageGaussianBlurFilter.h"
//#import "GPUImageGaussianSelectiveBlurFilter.h"
//#import "GPUImageOverlayBlendFilter.h"
//#import "GPUImageDarkenBlendFilter.h"
//#import "GPUImageLightenBlendFilter.h"
//#import "GPUImageSwirlFilter.h"
//#import "GPUImageFastBlurFilter.h"
//#import "GPUImageSourceOverBlendFilter.h"
//#import "GPUImageColorBurnBlendFilter.h"
//#import "GPUImageColorDodgeBlendFilter.h"
//#import "GPUImageScreenBlendFilter.h"
//#import "GPUImageExclusionBlendFilter.h"
//#import "GPUImageDifferenceBlendFilter.h"
//#import "GPUImageSubtractBlendFilter.h"
//#import "GPUImageHardLightBlendFilter.h"
//#import "GPUImageSoftLightBlendFilter.h"
//#import "GPUImageCropFilter.h"
//#import "GPUImageGrayscaleFilter.h"
//#import "GPUImageTransformFilter.h"
//#import "GPUImageChromaKeyBlendFilter.h"
//#import "GPUImageHazeFilter.h"
//#import "GPUImageLuminanceThresholdFilter.h"
//#import "GPUImagePosterizeFilter.h"
//#import "GPUImageBoxBlurFilter.h"
//#import "GPUImageAdaptiveThresholdFilter.h"
//#import "GPUImageUnsharpMaskFilter.h"
//#import "GPUImageBulgeDistortionFilter.h"
//#import "GPUImagePinchDistortionFilter.h"
//#import "GPUImageCrosshatchFilter.h"
//#import "GPUImageCGAColorspaceFilter.h"
//#import "GPUImagePolarPixellateFilter.h"
//#import "GPUImageStretchDistortionFilter.h"
//#import "GPUImagePerlinNoiseFilter.h"
//#import "GPUImageJFAVoroniFilter.h"
//#import "GPUImageVoroniConsumerFilter.h"
//#import "GPUImageMosaicFilter.h"
//#import "GPUImageTiltShiftFilter.h"
//#import "GPUImage3x3ConvolutionFilter.h"
//#import "GPUImageEmbossFilter.h"
//#import "GPUImageCannyEdgeDetectionFilter.h"
//#import "GPUImageThresholdEdgeDetection.h"
//#import "GPUImageMaskFilter.h"
//#import "GPUImageHistogramFilter.h"
//#import "GPUImageHistogramGenerator.h"
//#import "GPUImagePrewittEdgeDetectionFilter.h"
//#import "GPUImageXYDerivativeFilter.h"
//#import "GPUImageHarrisCornerDetectionFilter.h"
//#import "GPUImageAlphaBlendFilter.h"
//#import "GPUImageNonMaximumSuppressionFilter.h"
//#import "GPUImageRGBFilter.h"
//#import "GPUImageMedianFilter.h"
//#import "GPUImageBilateralFilter.h"
//#import "GPUImageCrosshairGenerator.h"
//#import "GPUImageToneCurveFilter.h"
//#import "GPUImageNobleCornerDetectionFilter.h"
//#import "GPUImageShiTomasiFeatureDetectionFilter.h"
//#import "GPUImageErosionFilter.h"
//#import "GPUImageRGBErosionFilter.h"
//#import "GPUImageDilationFilter.h"
//#import "GPUImageRGBDilationFilter.h"
//#import "GPUImageOpeningFilter.h"
//#import "GPUImageRGBOpeningFilter.h"
//#import "GPUImageClosingFilter.h"
//#import "GPUImageRGBClosingFilter.h"
//#import "GPUImageColorPackingFilter.h"
//#import "GPUImageSphereRefractionFilter.h"
//#import "GPUImageMonochromeFilter.h"
//#import "GPUImageOpacityFilter.h"
//#import "GPUImageHighlightShadowFilter.h"
//#import "GPUImageFalseColorFilter.h"
#import "GPUImageHueFilter.h"
//#import "GPUImageGlassSphereFilter.h"
//#import "GPUImageLookupFilter.h"
//#import "GPUImageAmatorkaFilter.h"
//#import "GPUImageMissEtikateFilter.h"
//#import "GPUImageSoftEleganceFilter.h"
//#import "GPUImageAddBlendFilter.h"
//#import "GPUImageDivideBlendFilter.h"
//#import "GPUImagePolkaDotFilter.h"
//#import "GPUImageLocalBinaryPatternFilter.h"
//#import "GPUImageLanczosResamplingFilter.h"
@interface ShowcaseViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UILabel *_labelValue;
    GPUImagePicture *_imageSource;
    
    UIImage *_resultImage;
    UIImageView *_imgView;
    GPUImageFilter *currentFilter;
}

@property (nonatomic, strong) GPUImageBrightnessFilter *brightFilter;
@property (nonatomic, strong) NSMutableArray *arrayfilter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ShowcaseViewController
@synthesize imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 330, self.view.frame.size.width, 200) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    UIButton *redbu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [redbu addTarget:self action:@selector(resetHard) forControlEvents:UIControlEventTouchUpInside];
    redbu.frame = CGRectMake(0, 200, 60, 60);
    redbu.backgroundColor = [UIColor yellowColor];
    [redbu enableDragging];
    
    [self.view addSubview:redbu];
    [self.view bringSubviewToFront:redbu];
}

- (void)initData {
    self.arrayfilter = [NSMutableArray array];
    [self.arrayfilter addObject:@"GPUImageHueFilter"];
    [self.arrayfilter addObject:@"GPUImageBrightnessFilter"];
    [self.arrayfilter addObject:@"GPUImageRGBFilter"];
    
    
}

- (void)leftSwip {
//    self.brightFilter.brightness += 0.1f;
//    _labelValue.text = [NSString stringWithFormat:@"%f",self.brightFilter.brightness];
//        [_imageSource processImage];
//    _resultImage = [self.brightFilter imageFromCurrentlyProcessedOutput];
//    _imgView.image = _resultImage ;
    
    [self reloadCurrentFilterInfectionToImageL];
}
- (void)rightSwip {
    self.brightFilter.brightness -= 0.1f;
    [_imageSource processImage];
    _labelValue.text = [NSString stringWithFormat:@"%f",self.brightFilter.brightness];
    
    _resultImage = [self.brightFilter imageFromCurrentlyProcessedOutput];
    _imgView.image = _resultImage ;
}

- (void)upSwip {
    self.brightFilter.brightness -= 0.01f;
    [_imageSource processImage];
    _labelValue.text = [NSString stringWithFormat:@"%f",self.brightFilter.brightness];
    
    _resultImage = [self.brightFilter imageFromCurrentlyProcessedOutput];
    _imgView.image = _resultImage ;
}

- (void)downSwip {
    self.brightFilter.brightness += 0.01f;
    [_imageSource processImage];
    _labelValue.text = [NSString stringWithFormat:@"%f",self.brightFilter.brightness];
    
    _resultImage = [self.brightFilter imageFromCurrentlyProcessedOutput];
    _imgView.image = _resultImage ;
}
- (void)reloadCurrentFilterInfectionToImageL {
    if ([currentFilter isKindOfClass:[GPUImageHueFilter class]]) {
        GPUImageHueFilter *filter = (GPUImageHueFilter*)currentFilter;
        filter.hue += 1.0f;
        [_imageSource addTarget:filter];
        //开始渲染
        [_imageSource processImage];
        //从滤镜中取出处理过的图片资源
        _resultImage = [filter imageFromCurrentlyProcessedOutput];
        //加载出来
        _imgView.image = _resultImage ;
        _labelValue.text = [NSString stringWithFormat:@"=====%f",filter.hue];
        currentFilter = filter;
    } else if ([currentFilter isKindOfClass:[GPUImageBrightnessFilter class]]){
        GPUImageBrightnessFilter *filter = (GPUImageBrightnessFilter*)currentFilter;
        filter.brightness += 0.1f;
        [_imageSource addTarget:filter];
        //开始渲染
        [_imageSource processImage];
        //从滤镜中取出处理过的图片资源
        _resultImage = [filter imageFromCurrentlyProcessedOutput];
        //加载出来
        _imgView.image = _resultImage ;
        _labelValue.text = [NSString stringWithFormat:@"%f",filter.brightness];
        currentFilter = filter;
    }else if ([currentFilter isKindOfClass:[GPUImageRGBFilter class]]){
        GPUImageRGBFilter *filter = (GPUImageRGBFilter*)currentFilter;
        filter.red += 0.1f;
        [_imageSource addTarget:filter];
        //开始渲染
        [_imageSource processImage];
        //从滤镜中取出处理过的图片资源
        _resultImage = [filter imageFromCurrentlyProcessedOutput];
        //加载出来
        _imgView.image = _resultImage ;
        _labelValue.text = [NSString stringWithFormat:@"%f",filter.red];
        currentFilter = filter;
    }
}

- (void)resetHard {
    
    imagePicker = [[UIImagePickerController alloc]init];
    UIImagePickerControllerSourceType	soureType;
    
    soureType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate =self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = soureType;
    [self presentModalViewController:imagePicker animated:YES];
}

- (void) loadResourceWithImage:(UIImage *)image {
#warning TODO //当图片不存在时会crash
    //    UIImage *image = [UIImage imageNamed:@"sample1.jpg"];
    //创建一个高亮滤镜
    self.brightFilter = [[GPUImageBrightnessFilter alloc] init];
    self.brightFilter.brightness = 0.0f;
    
    //设置渲染区域
    [self.brightFilter forceProcessingAtSize:image.size];
//    [self.brightFilter useNextFrameForImageCapture];
    
    //获取数据源
    _imageSource = [[GPUImagePicture alloc] initWithImage:image];
    
    //给数据源添加滤镜
    [_imageSource addTarget:self.brightFilter];
    
    //开始渲染
    [_imageSource processImage];
    //从滤镜中取出处理过的图片资源
    _resultImage = [self.brightFilter imageFromCurrentlyProcessedOutput];
    //加载出来
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
    _imgView.image = _resultImage ;
    [self.view addSubview:_imgView];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] init];
    [swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swip addTarget:self action:@selector(leftSwip)];
    [self.view addGestureRecognizer:swip];
    
    UISwipeGestureRecognizer *swipr = [[UISwipeGestureRecognizer alloc] init];
    [swipr setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipr addTarget:self action:@selector(rightSwip)];
    [self.view addGestureRecognizer:swipr];
    
    UISwipeGestureRecognizer *swipup = [[UISwipeGestureRecognizer alloc] init];
    [swipup setDirection:UISwipeGestureRecognizerDirectionDown];
    [swipup addTarget:self action:@selector(downSwip)];
    [self.view addGestureRecognizer:swipup];
    
    UISwipeGestureRecognizer *swipd = [[UISwipeGestureRecognizer alloc] init];
    [swipd setDirection:UISwipeGestureRecognizerDirectionUp];
    [swipd addTarget:self action:@selector(upSwip)];
    [self.view addGestureRecognizer:swipd];
    
    _labelValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 320, 25)];
    _labelValue.backgroundColor = [UIColor redColor];
    _labelValue.text = @"===";
    [self.view bringSubviewToFront:_labelValue];
    [self.view addSubview:_labelValue];
    [self.view bringSubviewToFront:self.tableView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Disable the last filter (Core Image face detection) if running on iOS 4.0
    return self.arrayfilter.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"UITableViewCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:cellIdentify];
        cell.textLabel.text = [self.arrayfilter objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentFilter = [(GPUImageFilter *)[NSClassFromString([self.arrayfilter objectAtIndex:indexPath.row]) alloc] init];
    //设置渲染区域
    [currentFilter forceProcessingAtSize:_imgView.frame.size];
    //    [brightFilter useNextFrameForImageCapture];
    
    //给数据源添加滤镜
    [_imageSource addTarget:currentFilter];
}

#pragma mark - UIImagePicker
// UIImagePicker  选择图片处理方法
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIDevice *device  = [UIDevice currentDevice];
    NSLog(@"device.model %@",device.model);
    if([device.model isEqualToString:@"iPad"])
    {
        [_accountBookPopSelectViewController dismissPopoverAnimated:YES];
    }
    else
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIDevice *device  = [UIDevice currentDevice];
    NSLog(@"device.model %@",device.model);
    if([device.model isEqualToString:@"iPad"])
    {
        [_accountBookPopSelectViewController dismissPopoverAnimated:YES];
    }
    else
    {
        [self dismissModalViewControllerAnimated:YES];
    }
	UIImage *imageselect= [info valueForKey:UIImagePickerControllerOriginalImage];
    [self loadResourceWithImage:imageselect];
    
}



@end

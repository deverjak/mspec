clc, clear all

featureText = readlines('features/test.feature');

feature = mspec.parser.Feature();
feature.FileContent = featureText;
feature.parseScenarios();

document = mspec.generator.Document();
document.Name = "Test";
document.setFeature(feature);

generator = mspec.generator.CodeGenerator();
generator.Document = document;
generator.OutputFolder = fullfile(pwd, 'features');
generator.createMSpecFile();
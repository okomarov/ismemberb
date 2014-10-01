classdef ismemberb_unit < matlab.unittest.TestCase
       
    methods (Test)
        function defaultTest(testCase)
            A = 1:10;
            B = 1:10;
            [aidx, apos] = ismember(A,B);
            [eidx, epos] = ismemberb(A,B);
            testCase.verifyEqual(aidx,eidx);
            testCase.verifyEqual(apos,cast(epos,'like',apos));
        end
        function repeatA(testCase)
            A = [1:10 1:10];
            B = 10:-1:1;
            [aidx, apos] = ismember(A,B);
            [eidx, epos] = ismemberb(A,B);
            testCase.verifyEqual(aidx,eidx);
            testCase.verifyEqual(apos,cast(epos,'like',apos));
        end
        function repeatB(testCase)
            A = 1:10;
            B = [5,6,5,6,20 20,7,7,8,8];
            [aidx, apos] = ismember(A,B);
            [eidx, epos] = ismemberb(A,B);
            testCase.verifyEqual(aidx,eidx);
            testCase.verifyEqual(apos,cast(epos,'like',apos));
        end
        function repeatAB(testCase)
            A = [1:10 1:10];
            B = [8:20 8:20];
            [aidx, apos] = ismember(A,B);
            [eidx, epos] = ismemberb(A,B);
            testCase.verifyEqual(aidx,eidx);
            testCase.verifyEqual(apos,cast(epos,'like',apos));
        end
        function repeatABlegacy(testCase)
            A = [1:10 1:10];
            B = [8:20 8:20];
            [aidx, apos] = ismember(A,B,'legacy');
            [eidx, epos] = ismemberb(A,B,[],'legacy');
            testCase.verifyEqual(aidx,eidx);
            testCase.verifyEqual(apos,cast(epos,'like',apos));
        end
    end
    
end
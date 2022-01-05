Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A494856CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiAEQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:40:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:29050 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241976AbiAEQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641400792; x=1672936792;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MJGlFymBOWXb6emPTwHsKqt8QrHli/pufZLtqlB9knw=;
  b=TBgwQj4cBUA0j+o9/cxspdWFucw6f/UQoj+3mzf2TFAOZi0kqJdPZ2Sh
   14+7GsdHXR5LBiTmn9V/5ZgYxddLrApmSGr7X0b/hg8FX3LsO+9ktcrTY
   H9vDA/QdcfK+KW1iIGW9X9qLrlbds61AO3TCUTREFBIbNJPeno45+6iXS
   LR7H0ympFYBjzQRQg/MSchJeSds9vj7vU78Vn2ebbJ2nQ82icXbDODsfD
   8uu59rpW6iCJA9BSYdzU2vR/0ni+YqiujvknbxCCJNxCNO5i9Gzst4J6L
   qgT8rurzihTngJqJQJoMUXFZpqCJhu1d5rVaPa+XOXKsKJR7ORhoD/fhr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242276619"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242276619"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 08:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="556592791"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2022 08:39:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n59KE-000GrJ-7V; Wed, 05 Jan 2022 16:39:46 +0000
Date:   Thu, 6 Jan 2022 00:39:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Subject: drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c:31:20: warning: unused
 function 'mdss_write'
Message-ID: <202201060040.iyvFP9ru-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

First bad commit (maybe !=3D root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: b3ed524f84f573ece1aa2f26e9db3c34a593e0d1 drm/msm: allow compile_tes=
t on !ARM
date:   3 months ago
config: mips-randconfig-r002-20220105 (https://download.01.org/0day-ci/arch=
ive/20220106/202201060040.iyvFP9ru-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e3=
0ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Db3ed524f84f573ece1aa2f26e9db3c34a593e0d1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3ed524f84f573ece1aa2f26e9db3c34a593e0d1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/gpu/drm/msm/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c:31:20: warning: unused functio=
n 'mdss_write'
   static inline void mdss_write(struct mdp5_mdss u32 reg, u32 data)
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 133, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   and $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://bugs.llvm.org/ and include the cra=
sh backtrace, preprocessed source, and associated run script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/gpu/drm/msm/disp/mdp5/.mdp5=
_mdss.o.d -nostdinc -isystem /opt/cross/clang-d5b6e30ed3/lib/clang/14.0.0/i=
nclude -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./in=
clude -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclu=
de/uapi -I./include/generated/uapi -include include/linux/compiler-version.=
h -include include/linux/kconfig.h -include include/linux/compiler_types.h =
-D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDR=
ESS=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=
=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-tri=
graphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dim=
plicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -W=
no-format-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -We=
rror=3Dunknown-warning-option -mno-check-zero-division -mabi=3D32 -G 0 -mno=
-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-fl=
oat -ffreestanding -EL -fno-stack-check -march=3Dmips32 -Wa,--trap -DTOOLCH=
AIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-au1x00 -Iarch/mips/include/a=
sm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-ch=
ecks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-th=
an=3D1024 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-but-s=
et-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dpattern -f=
no-stack-clash-protection -pg -falign-functions=3D64 -Wdeclaration-after-st=
atement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno=
-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wext=
ra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-a=
ttribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs=
 -Wunused-but-set-variable -Wunused-const-variable -Wno-missing-field-initi=
alizers -Wno-sign-compare -Wno-type-limits -I drivers/gpu/drm/msm -I driver=
s/gpu/drm/msm/disp/dpu1 -I drivers/gpu/drm/msm/dp -fsanitize=3Darray-bounds=
 -fsanitize=3Dunreachable -fsanitize=3Dobject-size -fsanitize=3Denum -fsani=
tize-coverage=3Dtrace-pc -I drivers/gpu/drm/msm -I ./drivers/gpu/drm/msm -f=
function-sections -fdata-sections -DKBUILD_MODFILE=3D"drivers/gpu/drm/msm/m=
sm" -DKBUILD_BASENAME=3D"mdp5_mdss" -DKBUILD_MODNAME=3D"msm" -D__KBUILD_MOD=
NAME=3Dkmod_msm -c -o drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.o drivers/gpu=
/drm/msm/disp/mdp5/mdp5_mdss.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/gpu/drm/msm/d=
isp/mdp5/mdp5_mdss.c'.
   4. Running pass 'Mips Assembly Printer' on function '@mdss_hw_mask_irq'
   #0 0x000056459b78eb3f Signals.cpp:0:0
   #1 0x000056459b78ca8c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d5b6e30ed3/bin/clang-14+0x3401a8c)
   #2 0x000056459b6d0667 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d5b6e30ed3/bin/clang-14+0x3345667)
   #3 0x000056459b78513e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d5b6e30ed3/bin/clang-14+0x33fa13e)
   #4 0x000056459940b33b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x108033=
b)
   #5 0x000056459b6d710c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x334c10c)
   #6 0x000056459c3b99b8 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x402e9b8)
   #7 0x000056459c3b5759 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d5b6e30ed3/bin/clang-14+0x402a759)
   #8 0x0000564599e6682e llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x1adb82e)
   #9 0x000056459aafd2fd llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000056459af35867 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa867)
   #11 0x000056459af359e1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa9e1)
   #12 0x000056459af36cbf llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2babcbf)
   #13 0x000056459baa04fa clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3715=
4fa)
   #14 0x000056459c6cdea3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x4342ea3)
   #15 0x000056459d1d1fd9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d5b6e30ed3/bin/clang-14+0x4e46fd9)
   #16 0x000056459c6cccff clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d5b6e30ed3/bin/clang-14+0x4341cff)
   #17 0x000056459c0cc001 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d5b6e30ed3/bin/clang-14+0x3d41001)
   #18 0x000056459c063bda clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3cd8bda)
   #19 0x000056459c19507b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3e0a0=
7b)
   #20 0x000056459940c084 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d5b6e30ed3/bin/clang-14+0x1081084)
   #21 0x00005645994095cb ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000056459bf00b15 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000056459b6d0523 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3345523)
   #24 0x000056459bf0140e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000056459bed7ee7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d5b=
6e30ed3/bin/clang-14+0x3b4cee7)
   #26 0x000056459bed88c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b4d8c7)
   #27 0x000056459bee2139 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b57139)
   #28 0x000056459933419f main (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x=
fa919f)
   #29 0x00007fd134c40d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x00005645994090ea _start (/opt/cross/clang-d5b6e30ed3/bin/clang-14+=
0x107e0ea)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project d5b6e30ed3acad794dd0a=
ec400e617daffc6cc3d)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d5b6e30ed3/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers fs include kernel net nr_bisected scripts sound so=
urce usr
--
>> drivers/gpu/drm/msm/dp/dp_catalog.c:119:19: warning: unused function 'dp=
_read_p0'
   static inline u32 dp_read_p0(struct dp_catalog_private
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: '.if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_bran=
ch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace=
_branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/incl=
ude/asm/barrier.h", .line =3D 16, $); 0x00 ) !=3D -1)) : $))) ) && ( (1 << =
0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else;=
 ; .endif'
   PLEASE submit a bug report to https://bugs.llvm.org/ and include the cra=
sh backtrace, preprocessed source, and associated run script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/gpu/drm/msm/dp/.dp_catalog.=
o.d -nostdinc -isystem /opt/cross/clang-d5b6e30ed3/lib/clang/14.0.0/include=
 -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./include =
-Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uap=
i -I./include/generated/uapi -include include/linux/compiler-version.h -inc=
lude include/linux/kconfig.h -include include/linux/compiler_types.h -D__KE=
RNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D=
0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DK=
BUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs =
-fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-=
function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-form=
at-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3D=
unknown-warning-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-abical=
ls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ff=
reestanding -EL -fno-stack-check -march=3Dmips32 -Wa,--trap -DTOOLCHAIN_SUP=
PORTS_VIRT -Iarch/mips/include/asm/mach-au1x00 -Iarch/mips/include/asm/mach=
-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -W=
no-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-than=3D10=
24 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-but-set-vari=
able -Wno-unused-const-variable -ftrivial-auto-var-init=3Dpattern -fno-stac=
k-clash-protection -pg -falign-functions=3D64 -Wdeclaration-after-statement=
 -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-=
check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -Wun=
used -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribut=
e -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunus=
ed-but-set-variable -Wunused-const-variable -Wno-missing-field-initializers=
 -Wno-sign-compare -Wno-type-limits -I drivers/gpu/drm/msm -I drivers/gpu/d=
rm/msm/disp/dpu1 -I drivers/gpu/drm/msm/dp -fsanitize=3Darray-bounds -fsani=
tize=3Dunreachable -fsanitize=3Dobject-size -fsanitize=3Denum -fsanitize-co=
verage=3Dtrace-pc -I drivers/gpu/drm/msm -I ./drivers/gpu/drm/msm -ffunctio=
n-sections -fdata-sections -DKBUILD_MODFILE=3D"drivers/gpu/drm/msm/msm" -DK=
BUILD_BASENAME=3D"dp_catalog" -DKBUILD_MODNAME=3D"msm" -D__KBUILD_MODNAME=
=3Dkmod_msm -c -o drivers/gpu/drm/msm/dp/dp_catalog.o drivers/gpu/drm/msm/d=
p/dp_catalog.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/gpu/drm/msm/d=
p/dp_catalog.c'.
   4. Running pass 'Mips Assembly Printer' on function '@dp_catalog_aux_rea=
d_data'
   #0 0x0000564ef7f1cb3f Signals.cpp:0:0
   #1 0x0000564ef7f1aa8c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d5b6e30ed3/bin/clang-14+0x3401a8c)
   #2 0x0000564ef7e5e667 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d5b6e30ed3/bin/clang-14+0x3345667)
   #3 0x0000564ef7f1313e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d5b6e30ed3/bin/clang-14+0x33fa13e)
   #4 0x0000564ef5b9933b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x108033=
b)
   #5 0x0000564ef7e6510c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x334c10c)
   #6 0x0000564ef8b479b8 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x402e9b8)
   #7 0x0000564ef8b43759 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d5b6e30ed3/bin/clang-14+0x402a759)
   #8 0x0000564ef65f482e llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x1adb82e)
   #9 0x0000564ef728b2fd llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000564ef76c3867 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa867)
   #11 0x0000564ef76c39e1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa9e1)
   #12 0x0000564ef76c4cbf llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2babcbf)
   #13 0x0000564ef822e4fa clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3715=
4fa)
   #14 0x0000564ef8e5bea3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x4342ea3)
   #15 0x0000564ef995ffd9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d5b6e30ed3/bin/clang-14+0x4e46fd9)
   #16 0x0000564ef8e5acff clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d5b6e30ed3/bin/clang-14+0x4341cff)
   #17 0x0000564ef885a001 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d5b6e30ed3/bin/clang-14+0x3d41001)
   #18 0x0000564ef87f1bda clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3cd8bda)
   #19 0x0000564ef892307b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3e0a0=
7b)
   #20 0x0000564ef5b9a084 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d5b6e30ed3/bin/clang-14+0x1081084)
   #21 0x0000564ef5b975cb ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000564ef868eb15 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000564ef7e5e523 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3345523)
   #24 0x0000564ef868f40e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000564ef8665ee7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d5b=
6e30ed3/bin/clang-14+0x3b4cee7)
   #26 0x0000564ef86668c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b4d8c7)
   #27 0x0000564ef8670139 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b57139)
   #28 0x0000564ef5ac219f main (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x=
fa919f)
   #29 0x00007fcd5dcaad0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x0000564ef5b970ea _start (/opt/cross/clang-d5b6e30ed3/bin/clang-14+=
0x107e0ea)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project d5b6e30ed3acad794dd0a=
ec400e617daffc6cc3d)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d5b6e30ed3/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers fs include kernel net nr_bisected scripts sound so=
urce usr


vim +/mdss_write +31 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c

990a40079a55b8 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 2016=
-05-07  30 =20
bc3220be22577e drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c Rajesh Yadav  2018=
-06-21 @31  static inline void mdss_write(struct mdp5_mdss *mdp5_mdss, u32 =
reg, u32 data)
990a40079a55b8 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 2016=
-05-07  32  {
bc3220be22577e drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c Rajesh Yadav  2018=
-06-21  33  	msm_writel(data, mdp5_mdss->mmio + reg);
990a40079a55b8 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 2016=
-05-07  34  }
990a40079a55b8 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 2016=
-05-07  35 =20

:::::: The code at line 31 was first introduced by commit
:::::: bc3220be22577e199452edbb6a24a980a4ab5c73 drm/msm/mdp5: subclass msm_=
mdss for mdp5

:::::: TO: Rajesh Yadav <ryadav@codeaurora.org>
:::::: CC: Sean Paul <seanpaul@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

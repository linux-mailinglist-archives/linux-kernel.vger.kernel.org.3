Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C64F8D81
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiDHFRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiDHFR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:17:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB734AD1F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649394923; x=1680930923;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tL8vwa6ZsMUBKXbmlJi7RhpKIR3x23RnaCNZ8tNqDwg=;
  b=kGBkUONeIAmg/Ztx3X7snnTtn7MoPp1Oapjhw76h9TMoCadYH3+1FVXC
   rEp8k0wpede63rqGJyt5CvXq6Cv437qkOXFFXZvrBKK1dmYNwXcmlLS+H
   P/5NaQiGoOvWyMIMpjSegHaok+tX/XtMSPTxiev5mJg3nxcjd/p2lGNAq
   3LGfhz/bI96IPXA+ITab4HVA6qlrDfNWIjTSAITt4/nppujVNhN4+PZuS
   btLQFS2bJ3JEH64b7fo5m4JrDDC4drikg5WD8ns9v5EA0eX/7DTP2vGb4
   dnJrkWsZPCaL28pYJORRPakB7bwkUWADPuEaCryA/C6YBQP4LWp0dUU4G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241445385"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="241445385"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 22:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="525234247"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2022 22:15:21 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncgxs-000654-S3;
        Fri, 08 Apr 2022 05:15:20 +0000
Date:   Fri, 8 Apr 2022 13:15:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Subject: drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c:31:20: warning: unused
 function 'mdss_write'
Message-ID: <202204081345.EzafqoPx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

First bad commit (maybe !=3D root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   42e7a03d3badebd4e70aea5362d6914dfc7c220b
commit: b3ed524f84f573ece1aa2f26e9db3c34a593e0d1 drm/msm: allow compile_tes=
t on !ARM
date:   6 months ago
config: mips-randconfig-r012-20220408 (https://download.01.org/0day-ci/arch=
ive/20220408/202204081345.EzafqoPx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51=
b3a257908aebc01cd7c4655665db317d66)
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
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/gpu/drm/msm/

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
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/gpu/drm/msm/disp/mdp5/.mdp5=
_mdss.o.d -nostdinc -isystem /opt/cross/clang-c29a51b3a2/lib/clang/15.0.0/i=
nclude -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./in=
clude -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclu=
de/uapi -I./include/generated/uapi -include include/linux/compiler-version.=
h -include include/linux/kconfig.h -include include/linux/compiler_types.h =
-D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff80010000 -DLINKER_LOAD_ADDR=
ESS=3D0x80010000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=
=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-tri=
graphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dim=
plicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -W=
no-format-security -std=3Dgnu89 --target=3Dmips-linux -fintegrated-as -Werr=
or=3Dunknown-warning-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-a=
bicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-floa=
t -ffreestanding -EB -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--tra=
p -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips=
/include/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-=
pointer-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe=
-larger-than=3D1024 -fstack-protector -Wno-gnu -mno-global-merge -Wno-unuse=
d-but-set-variable -Wno-unused-const-variable -fno-stack-clash-protection -=
pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds =
-fno-strict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompa=
tible-pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declar=
ations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definiti=
on -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-const-variable=
 -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -I driv=
ers/gpu/drm/msm -I drivers/gpu/drm/msm/disp/dpu1 -I drivers/gpu/drm/msm/dsi=
 -I drivers/gpu/drm/msm/dp -I drivers/gpu/drm/msm -I ./drivers/gpu/drm/msm =
-ffunction-sections -fdata-sections -DKBUILD_MODFILE=3D"drivers/gpu/drm/msm=
/msm" -DKBUILD_BASENAME=3D"mdp5_mdss" -DKBUILD_MODNAME=3D"msm" -D__KBUILD_M=
ODNAME=3Dkmod_msm -c -o drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.o drivers/g=
pu/drm/msm/disp/mdp5/mdp5_mdss.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/gpu/drm/msm/d=
isp/mdp5/mdp5_mdss.c'.
   4. Running pass 'Mips Assembly Printer' on function '@mdss_hw_mask_irq'
   #0 0x000055e12f486bff Signals.cpp:0:0
   #1 0x000055e12f484a24 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-c29a51b3a2/bin/clang-15+0x34e8a24)
   #2 0x000055e12f3c43b7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-c29a51b3a2/bin/clang-15+0x34283b7)
   #3 0x000055e12f47d05e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-c29a51b3a2/bin/clang-15+0x34e105e)
   #4 0x000055e12d05696b (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x10ba96=
b)
   #5 0x000055e12f3caedc llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x342eedc)
   #6 0x000055e1300f9560 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x415d560)
   #7 0x000055e1300f5492 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-c29a51b3a2/bin/clang-15+0x4159492)
   #8 0x000055e12dadb9d7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x1b3f9d7)
   #9 0x000055e12e7b457d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055e12ebfd087 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x2c61087)
   #11 0x000055e12ebfd201 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-c29a51b3a2/bin/clang-15+0x2c61201)
   #12 0x000055e12ebfdd7f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x2c61d7f)
   #13 0x000055e12f7b11e6 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3815=
1e6)
   #14 0x000055e13041a2b3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x447e2b3)
   #15 0x000055e130f4de21 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-c29a51b3a2/bin/clang-15+0x4fb1e21)
   #16 0x000055e1304199a5 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-c29a51b3a2/bin/clang-15+0x447d9a5)
   #17 0x000055e12fe10a51 clang::FrontendAction::Execute() (/opt/cross/clan=
g-c29a51b3a2/bin/clang-15+0x3e74a51)
   #18 0x000055e12fda5f2a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3e09f2a)
   #19 0x000055e12fed771b (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3f3b7=
1b)
   #20 0x000055e12d057f1c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-c29a51b3a2/bin/clang-15+0x10bbf1c)
   #21 0x000055e12d054beb ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055e12fc37b65 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055e12f3c4273 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3428273)
   #24 0x000055e12fc3845e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055e12fc0c557 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-c29=
a51b3a2/bin/clang-15+0x3c70557)
   #26 0x000055e12fc0cf37 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3c70f37)
   #27 0x000055e12fc16589 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3c7a589)
   #28 0x000055e12cfa1ccf main (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x=
1005ccf)
   #29 0x00007f8ffa5597fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055e12d05470a _start (/opt/cross/clang-c29a51b3a2/bin/clang-15+=
0x10b870a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project c29a51b3a257908aebc01=
cd7c4655665db317d66)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-c29a51b3a2/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts source usr
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
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/gpu/drm/msm/dp/.dp_catalog.=
o.d -nostdinc -isystem /opt/cross/clang-c29a51b3a2/lib/clang/15.0.0/include=
 -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./include =
-Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uap=
i -I./include/generated/uapi -include include/linux/compiler-version.h -inc=
lude include/linux/kconfig.h -include include/linux/compiler_types.h -D__KE=
RNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff80010000 -DLINKER_LOAD_ADDRESS=3D=
0x80010000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DK=
BUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs =
-fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-=
function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-form=
at-security -std=3Dgnu89 --target=3Dmips-linux -fintegrated-as -Werror=3Dun=
known-warning-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls=
 -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffre=
estanding -EB -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DTOO=
LCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/includ=
e/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer=
-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger=
-than=3D1024 -fstack-protector -Wno-gnu -mno-global-merge -Wno-unused-but-s=
et-variable -Wno-unused-const-variable -fno-stack-clash-protection -pg -Wde=
claration-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-st=
rict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-p=
ointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations =
-Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmi=
ssing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-m=
issing-field-initializers -Wno-sign-compare -Wno-type-limits -I drivers/gpu=
/drm/msm -I drivers/gpu/drm/msm/disp/dpu1 -I drivers/gpu/drm/msm/dsi -I dri=
vers/gpu/drm/msm/dp -I drivers/gpu/drm/msm -I ./drivers/gpu/drm/msm -ffunct=
ion-sections -fdata-sections -DKBUILD_MODFILE=3D"drivers/gpu/drm/msm/msm" -=
DKBUILD_BASENAME=3D"dp_catalog" -DKBUILD_MODNAME=3D"msm" -D__KBUILD_MODNAME=
=3Dkmod_msm -c -o drivers/gpu/drm/msm/dp/dp_catalog.o drivers/gpu/drm/msm/d=
p/dp_catalog.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/gpu/drm/msm/d=
p/dp_catalog.c'.
   4. Running pass 'Mips Assembly Printer' on function '@dp_catalog_aux_rea=
d_data'
   #0 0x0000555b7306ebff Signals.cpp:0:0
   #1 0x0000555b7306ca24 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-c29a51b3a2/bin/clang-15+0x34e8a24)
   #2 0x0000555b72fac3b7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-c29a51b3a2/bin/clang-15+0x34283b7)
   #3 0x0000555b7306505e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-c29a51b3a2/bin/clang-15+0x34e105e)
   #4 0x0000555b70c3e96b (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x10ba96=
b)
   #5 0x0000555b72fb2edc llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x342eedc)
   #6 0x0000555b73ce1560 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x415d560)
   #7 0x0000555b73cdd492 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-c29a51b3a2/bin/clang-15+0x4159492)
   #8 0x0000555b716c39d7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x1b3f9d7)
   #9 0x0000555b7239c57d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000555b727e5087 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x2c61087)
   #11 0x0000555b727e5201 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-c29a51b3a2/bin/clang-15+0x2c61201)
   #12 0x0000555b727e5d7f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x2c61d7f)
   #13 0x0000555b733991e6 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3815=
1e6)
   #14 0x0000555b740022b3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x447e2b3)
   #15 0x0000555b74b35e21 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-c29a51b3a2/bin/clang-15+0x4fb1e21)
   #16 0x0000555b740019a5 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-c29a51b3a2/bin/clang-15+0x447d9a5)
   #17 0x0000555b739f8a51 clang::FrontendAction::Execute() (/opt/cross/clan=
g-c29a51b3a2/bin/clang-15+0x3e74a51)
   #18 0x0000555b7398df2a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3e09f2a)
   #19 0x0000555b73abf71b (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3f3b7=
1b)
   #20 0x0000555b70c3ff1c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-c29a51b3a2/bin/clang-15+0x10bbf1c)
   #21 0x0000555b70c3cbeb ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000555b7381fb65 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000555b72fac273 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3428273)
   #24 0x0000555b7382045e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000555b737f4557 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-c29=
a51b3a2/bin/clang-15+0x3c70557)
   #26 0x0000555b737f4f37 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3c70f37)
   #27 0x0000555b737fe589 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x3c7a589)
   #28 0x0000555b70b89ccf main (/opt/cross/clang-c29a51b3a2/bin/clang-15+0x=
1005ccf)
   #29 0x00007f6e768377fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x0000555b70c3c70a _start (/opt/cross/clang-c29a51b3a2/bin/clang-15+=
0x10b870a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project c29a51b3a257908aebc01=
cd7c4655665db317d66)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-c29a51b3a2/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts source usr


vim +/mdss_write +31 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c

990a40079a55b81 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 201=
6-05-07  30 =20
bc3220be22577e1 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c Rajesh Yadav  201=
8-06-21 @31  static inline void mdss_write(struct mdp5_mdss *mdp5_mdss, u32=
 reg, u32 data)
990a40079a55b81 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 201=
6-05-07  32  {
bc3220be22577e1 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c Rajesh Yadav  201=
8-06-21  33  	msm_writel(data, mdp5_mdss->mmio + reg);
990a40079a55b81 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 201=
6-05-07  34  }
990a40079a55b81 drivers/gpu/drm/msm/mdp/mdp5/mdp5_mdss.c  Archit Taneja 201=
6-05-07  35 =20

:::::: The code at line 31 was first introduced by commit
:::::: bc3220be22577e199452edbb6a24a980a4ab5c73 drm/msm/mdp5: subclass msm_=
mdss for mdp5

:::::: TO: Rajesh Yadav <ryadav@codeaurora.org>
:::::: CC: Sean Paul <seanpaul@chromium.org>

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp

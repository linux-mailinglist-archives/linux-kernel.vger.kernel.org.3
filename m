Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA54C356D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiBXTLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiBXTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:11:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4FD20DB1E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645729835; x=1677265835;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C97Grhj8HyOLmESmNf6nqgC0dGRqj4xgghwAC4ixRAQ=;
  b=Qf6iQlie0OAlNcW8P3tVC/RrIaDLaTmjcIYI1Ai+e7hQIbHhbJ1R7Zwm
   D1/JJoEo8+n3RQX8XwsYtqDbwd5AMWlBs4mYv06PjIZfrvHezv4Dicwfs
   cZh8RhIHDaL1TSqYBC3fD+RIUaX3ol5sZx2HL62+yGjh2ssvk7i1qqh+D
   XQUWozlFedrYpjzOSe0V6L5wxgngMmbDiy9MURuzv8N+CTmI2kjBMPR2a
   S8vN94XowcKlY/F2dyBNbXyon1pB9EuXzXQfVfrNx49S5xzINOfLFutDs
   t/A+m/xWTNOpDetCdF30M3UTy+96dJ1WbA9d1mDomeC5AxKrRMX15qKJ3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="249908250"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="249908250"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="592198002"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2022 11:10:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNJVX-0003OW-L0; Thu, 24 Feb 2022 19:10:31 +0000
Date:   Fri, 25 Feb 2022 03:10:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/media/test-drivers/vivid/vivid-core.c:1986:12: warning:
 stack frame size (2256) exceeds limit (2048) in 'vivid_probe'
Message-ID: <202202250245.7k14zZf6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   23d04328444a8fa0ca060c5e532220dac8e8bc26
commit: c37495d6254c237578db3121dcf79857e033f8ff slab: add __alloc_size att=
ributes for better bounds checking
date:   4 months ago
config: mips-randconfig-r034-20220223 (https://download.01.org/0day-ci/arch=
ive/20220225/202202250245.7k14zZf6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc=
04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Dc37495d6254c237578db3121dcf79857e033f8ff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c37495d6254c237578db3121dcf79857e033f8ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/gpu/drm/radeon/ drive=
rs/media/pci/saa7164/ drivers/media/test-drivers/vivid/ drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/test-drivers/vivid/vivid-core.c:1986:12: warning: stack fr=
ame size (2256) exceeds limit (2048) in 'vivid_probe'
   static int vivid_probe(struct platform_device
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 101, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $1
   dins $0, $3, $2, 1
   scd $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/media/test-drivers/vivid/.v=
ivid-core.o.d -nostdinc -isystem /opt/cross/clang-d271fc04d5/lib/clang/15.0=
=2E0/include -Iarch/mips/include -I./arch/mips/include/generated -Iinclude =
-I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -=
Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler-ve=
rsion.h -include include/linux/kconfig.h -include include/linux/compiler_ty=
pes.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOA=
D_ADDRESS=3D0xffffffff84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-=
prefix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-protot=
ypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE=
 -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dr=
eturn-type -Wno-format-security -std=3Dgnu89 --target=3Dmips64el-linux -fin=
tegrated-as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization=
-argument -mabi=3D64 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_H=
AS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -DTOO=
LCHAIN_SUPPORTS_VIRT -Wa,--trap -mips64r2 -U_MIPS_ISA -D_MIPS_ISA=3D_MIPS_I=
SA_MIPS64 -Iarch/mips/include/asm/mach-loongson64 -mno-branch-likely -Iarch=
/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-=
null-pointer-checks -Os -Wframe-larger-than=3D2048 -fno-stack-protector -Wn=
o-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unused-const-vari=
able -ftrivial-auto-var-init=3Dzero -enable-trivial-auto-var-init-zero-know=
ing-it-will-be-removed-from-clang -fno-stack-clash-protection -pg -Wdeclara=
tion-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-=
overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointe=
r-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmis=
sing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing=
-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-missin=
g-field-initializers -Wno-sign-compare -Wno-type-limits -fsanitize=3Dshift =
-fsanitize=3Dunreachable -fsanitize=3Dobject-size -fsanitize=3Dbool -I driv=
ers/media/test-drivers/vivid -I ./drivers/media/test-drivers/vivid -DMODULE=
 -mlong-calls -DKBUILD_BASENAME=3D"vivid_core" -DKBUILD_MODNAME=3D"vivid" -=
D__KBUILD_MODNAME=3Dkmod_vivid -c -o drivers/media/test-drivers/vivid/vivid=
-core.o drivers/media/test-drivers/vivid/vivid-core.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/media/test-dr=
ivers/vivid/vivid-core.c'.
   4. Running pass 'Mips Assembly Printer' on function '@vivid_probe'
   #0 0x0000557dc649ed7f Signals.cpp:0:0
   #1 0x0000557dc649cc5c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d271fc04d5/bin/clang-15+0x348ec5c)
   #2 0x0000557dc63dcfd7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d271fc04d5/bin/clang-15+0x33cefd7)
   #3 0x0000557dc649530e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d271fc04d5/bin/clang-15+0x348730e)
   #4 0x0000557dc40c0ccb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x10b2cc=
b)
   #5 0x0000557dc63e3a8c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33d5a8c)
   #6 0x0000557dc70ed5c0 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x40df5c0)
   #7 0x0000557dc70e94f4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d271fc04d5/bin/clang-15+0x40db4f4)
   #8 0x0000557dc4b2a887 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x1b1c887)
   #9 0x0000557dc57e754d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000557dc5c2e807 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20807)
   #11 0x0000557dc5c2e981 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20981)
   #12 0x0000557dc5c2f4ff llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c214ff)
   #13 0x0000557dc67b9147 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x37ab=
147)
   #14 0x0000557dc7407693 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x43f9693)
   #15 0x0000557dc7ee26e9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d271fc04d5/bin/clang-15+0x4ed46e9)
   #16 0x0000557dc74064cf clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d271fc04d5/bin/clang-15+0x43f84cf)
   #17 0x0000557dc6e09561 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d271fc04d5/bin/clang-15+0x3dfb561)
   #18 0x0000557dc6d9ffaa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3d91faa)
   #19 0x0000557dc6ecdcbb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3ebfc=
bb)
   #20 0x0000557dc40c227c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d271fc04d5/bin/clang-15+0x10b427c)
   #21 0x0000557dc40bef4b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000557dc6c38d95 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000557dc63dce93 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33cee93)
   #24 0x0000557dc6c3968e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000557dc6c0e267 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d27=
1fc04d5/bin/clang-15+0x3c00267)
   #26 0x0000557dc6c0ec47 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c00c47)
   #27 0x0000557dc6c182f9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c0a2f9)
   #28 0x0000557dc3fe763f main (/opt/cross/clang-d271fc04d5/bin/clang-15+0x=
fd963f)
   #29 0x00007f59e0ce6d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x0000557dc40bea6a _start (/opt/cross/clang-d271fc04d5/bin/clang-15+=
0x10b0a6a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project d271fc04d5b97b12e6b79=
7c6067d3c96a8d7470e)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d271fc04d5/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel nr_bisected scripts sound source=
 usr virt
--
>> drivers/media/test-drivers/vivid/vivid-core.c:1986:12: warning: stack fr=
ame size (2256) exceeds limit (2048) in 'vivid_probe'
   static int vivid_probe(struct platform_device
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 101, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $1
   dins $0, $3, $2, 1
   scd $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/media/test-drivers/vivid/.v=
ivid-core.o.d -nostdinc -isystem /opt/cross/clang-d271fc04d5/lib/clang/15.0=
=2E0/include -Iarch/mips/include -I./arch/mips/include/generated -Iinclude =
-I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -=
Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler-ve=
rsion.h -include include/linux/kconfig.h -include include/linux/compiler_ty=
pes.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOA=
D_ADDRESS=3D0xffffffff84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-=
prefix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-protot=
ypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE=
 -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dr=
eturn-type -Wno-format-security -std=3Dgnu89 --target=3Dmips64el-linux -fin=
tegrated-as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization=
-argument -mabi=3D64 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_H=
AS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -DTOO=
LCHAIN_SUPPORTS_VIRT -Wa,--trap -mips64r2 -U_MIPS_ISA -D_MIPS_ISA=3D_MIPS_I=
SA_MIPS64 -Iarch/mips/include/asm/mach-loongson64 -mno-branch-likely -Iarch=
/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-=
null-pointer-checks -Os -Wframe-larger-than=3D2048 -fno-stack-protector -Wn=
o-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unused-const-vari=
able -ftrivial-auto-var-init=3Dzero -enable-trivial-auto-var-init-zero-know=
ing-it-will-be-removed-from-clang -fno-stack-clash-protection -pg -Wdeclara=
tion-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-=
overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointe=
r-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmis=
sing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing=
-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-missin=
g-field-initializers -Wno-sign-compare -Wno-type-limits -fsanitize=3Dshift =
-fsanitize=3Dunreachable -fsanitize=3Dobject-size -fsanitize=3Dbool -DMODUL=
E -mlong-calls -DKBUILD_BASENAME=3D"vivid_core" -DKBUILD_MODNAME=3D"vivid" =
-D__KBUILD_MODNAME=3Dkmod_vivid -c -o drivers/media/test-drivers/vivid/vivi=
d-core.o drivers/media/test-drivers/vivid/vivid-core.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/media/test-dr=
ivers/vivid/vivid-core.c'.
   4. Running pass 'Mips Assembly Printer' on function '@vivid_probe'
   #0 0x000055a050776d7f Signals.cpp:0:0
   #1 0x000055a050774c5c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d271fc04d5/bin/clang-15+0x348ec5c)
   #2 0x000055a0506b4fd7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d271fc04d5/bin/clang-15+0x33cefd7)
   #3 0x000055a05076d30e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d271fc04d5/bin/clang-15+0x348730e)
   #4 0x000055a04e398ccb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x10b2cc=
b)
   #5 0x000055a0506bba8c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33d5a8c)
   #6 0x000055a0513c55c0 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x40df5c0)
   #7 0x000055a0513c14f4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d271fc04d5/bin/clang-15+0x40db4f4)
   #8 0x000055a04ee02887 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x1b1c887)
   #9 0x000055a04fabf54d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055a04ff06807 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20807)
   #11 0x000055a04ff06981 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20981)
   #12 0x000055a04ff074ff llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c214ff)
   #13 0x000055a050a91147 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x37ab=
147)
   #14 0x000055a0516df693 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x43f9693)
   #15 0x000055a0521ba6e9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d271fc04d5/bin/clang-15+0x4ed46e9)
   #16 0x000055a0516de4cf clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d271fc04d5/bin/clang-15+0x43f84cf)
   #17 0x000055a0510e1561 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d271fc04d5/bin/clang-15+0x3dfb561)
   #18 0x000055a051077faa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3d91faa)
   #19 0x000055a0511a5cbb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3ebfc=
bb)
   #20 0x000055a04e39a27c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d271fc04d5/bin/clang-15+0x10b427c)
   #21 0x000055a04e396f4b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055a050f10d95 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055a0506b4e93 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33cee93)
   #24 0x000055a050f1168e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055a050ee6267 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d27=
1fc04d5/bin/clang-15+0x3c00267)
   #26 0x000055a050ee6c47 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c00c47)
   #27 0x000055a050ef02f9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c0a2f9)
   #28 0x000055a04e2bf63f main (/opt/cross/clang-d271fc04d5/bin/clang-15+0x=
fd963f)
   #29 0x00007fcd5934ad0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055a04e396a6a _start (/opt/cross/clang-d271fc04d5/bin/clang-15+=
0x10b0a6a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project d271fc04d5b97b12e6b79=
7c6067d3c96a8d7470e)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d271fc04d5/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel nr_bisected scripts sound source=
 usr virt


vim +/vivid_probe +1986 drivers/media/test-drivers/vivid/vivid-core.c

c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1981 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1982     The real maximum number of virtual drivers will depend on h=
ow many drivers
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1983     will succeed. This is limited to the maximum number of devi=
ces that
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1984     videodev supports, which is equal to VIDEO_NUM_DEVICES.
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1985   */
f46d740fb02589 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2015-=
03-13 @1986  static int vivid_probe(struct platform_device *pdev)
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1987  {
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1988  	const struct font_desc *font =3D find_font("VGA8x16");
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1989  	int ret =3D 0, i;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1990 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1991  	if (font =3D=3D NULL) {
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1992  		pr_err("vivid: could not find font\n");
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1993  		return -ENODEV;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1994  	}
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1995 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1996  	tpg_set_font(font->data);
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1997 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1998  	n_devs =3D clamp_t(unsigned, n_devs, 1, VIVID_MAX_DEVS);
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  1999 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2000  	for (i =3D 0; i < n_devs; i++) {
f46d740fb02589 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2015-=
03-13  2001  		ret =3D vivid_create_instance(pdev, i);
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2002  		if (ret) {
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2003  			/* If some instantiations succeeded, keep driver */
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2004  			if (i)
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2005  				ret =3D 0;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2006  			break;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2007  		}
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2008  	}
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2009 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2010  	if (ret < 0) {
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2011  		pr_err("vivid: error %d while loading driver\n", ret);
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2012  		return ret;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2013  	}
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2014 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2015  	/* n_devs will reflect the actual number of allocated devices=
 */
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2016  	n_devs =3D i;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2017 =20
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2018  	return ret;
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2019  }
c88a96b023d823 drivers/media/platform/vivid/vivid-core.c Hans Verkuil 2014-=
08-25  2020 =20

:::::: The code at line 1986 was first introduced by commit
:::::: f46d740fb0258982f00ffdbddc6486e674edafb5 [media] vivid: turn this in=
to a platform_device

:::::: TO: Hans Verkuil <hans.verkuil@cisco.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

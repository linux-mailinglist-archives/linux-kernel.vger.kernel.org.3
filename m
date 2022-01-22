Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07496496A06
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiAVEiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:38:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:64759 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232303AbiAVEiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642826299; x=1674362299;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S+nUIaCfMLL+mVL2TRXy/z0BUimqRFpYyNprNfq6rLg=;
  b=RDM141XfDvT8T72ASP8CdRbyKGOOnnn0/0VUWyGLy9cdaAE6FMKWBOSR
   nMR7+QKhnR8gpA4emJ/uLF18FWCuCTEGVxqu89NGS4wvs7dLE7vQojyzr
   CF169y1jffSFgHLrM5lmtqAfucihWG+7MatYbZRQj7m1UWpFLttWXc/yd
   9l3XG9JHAB1KOcuRitAuKubelyfSlxhO+Qj5BQ9IL2EW69/7XEMUkvm77
   LKcniCjw7fwvMJd0W94Mp5P1M+NFas1YpRnfOIymiE2Af1HbEmU7uyPqH
   cqoZls4LI4bus1O+FKNks//dI9PgtpIAIe6uD/+68V0befeVEyUV7U0gU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="332143546"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="332143546"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 20:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="623527651"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2022 20:38:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB8AK-000G2k-KE; Sat, 22 Jan 2022 04:38:16 +0000
Date:   Sat, 22 Jan 2022 12:37:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: fs/ext4/super.c:2295:1: warning: unused function 'ctx_test_flags'
Message-ID: <202201221207.g5vwf1MI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   9b57f458985742bd1c585f4c7f36d04634ce1143
commit: 6e47a3cc68fc525428297a00524833361ebbb0e9 ext4: get rid of super blo=
ck and sbi from handle_mount_ops()
date:   6 weeks ago
config: mips-randconfig-c004-20220118 (https://download.01.org/0day-ci/arch=
ive/20220122/202201221207.g5vwf1MI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d=
25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D6e47a3cc68fc525428297a00524833361ebbb0e9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e47a3cc68fc525428297a00524833361ebbb0e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/super.c:2295:1: warning: unused function 'ctx_test_flags'
   EXT4_SET_CTX(flags);
   ^
   fs/ext4/super.c:2290:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline bool ctx_test_##name(struct ext4_fs_context int flag) ^
   <scratch space>:85:1: note: expanded from here
   ctx_test_flags
   ^
>> fs/ext4/super.c:2298:1: warning: unused function 'ctx_clear_mount_flags'
   EXT4_SET_CTX(mount_flags);
   ^
   fs/ext4/super.c:2285:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context int flag) ^
   <scratch space>:106:1: note: expanded from here
   ctx_clear_mount_flags
   ^
>> fs/ext4/super.c:2298:1: warning: unused function 'ctx_test_mount_flags'
   fs/ext4/super.c:2290:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline bool ctx_test_##name(struct ext4_fs_context int flag) ^
   <scratch space>:109:1: note: expanded from here
   ctx_test_mount_flags
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 105, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,fs/ext4/.super.o.d -nostdinc -Iarch=
/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/=
mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./i=
nclude/generated/uapi -include include/linux/compiler-version.h -include in=
clude/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ =
-DVMLINUX_LOAD_ADDRESS=3D0xffffffff80100000 -DLINKER_LOAD_ADDRESS=3D0x80100=
000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_E=
XTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-st=
rict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-functio=
n-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-secu=
rity -std=3Dgnu89 --target=3Dmips-linux -fintegrated-as -Werror=3Dunknown-w=
arning-option -Werror=3Dignored-optimization-argument -mno-check-zero-divis=
ion -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET=
_HARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-stack-check -march=3Dmi=
ps32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-gene=
ric -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -f=
no-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-mem=
ber -O2 -Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fallthro=
ugh -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unused-con=
st-variable -fno-stack-clash-protection -pg -Wdeclaration-after-statement -=
Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-ch=
eck -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -Wunus=
ed -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribute =
-Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused=
-but-set-variable -Wunused-const-variable -Wno-missing-field-initializers -=
Wno-sign-compare -Wno-type-limits -I fs/ext4 -I ./fs/ext4 -DKBUILD_MODFILE=
=3D"fs/ext4/ext4" -DKBUILD_BASENAME=3D"super" -DKBUILD_MODNAME=3D"ext4" -D_=
_KBUILD_MODNAME=3Dkmod_ext4 -c -o fs/ext4/super.o fs/ext4/super.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/ext4/super.c'.
   4. Running pass 'Mips Assembly Printer' on function '@ext4_read_bh_nowai=
t'
   #0 0x000056120809e14f Signals.cpp:0:0
   #1 0x000056120809c02c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-7b3d307288/bin/clang-14+0x342202c)
   #2 0x0000561207fdb747 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-7b3d307288/bin/clang-14+0x3361747)
   #3 0x00005612080946de llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-7b3d307288/bin/clang-14+0x341a6de)
   #4 0x0000561205d04bcb (/opt/cross/clang-7b3d307288/bin/clang-14+0x108abc=
b)
   #5 0x0000561207fe21fc llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-7b3d307288/bin/clang-14+0x33681fc)
   #6 0x0000561208cc6487 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-7b3d307288/bin/clang-14+0x404c487)
   #7 0x0000561208cc23e4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-7b3d307288/bin/clang-14+0x40483e4)
   #8 0x00005612067617e7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-7b3d307288/bin/clang-14+0x1ae77e7)
   #9 0x0000561207405ced llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000056120783e8a7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-7b3d307288/bin/clang-14+0x2bc48a7)
   #11 0x000056120783ea21 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-7b3d307288/bin/clang-14+0x2bc4a21)
   #12 0x000056120783fcff llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-7b3d307288/bin/clang-14+0x2bc5cff)
   #13 0x00005612083adb7a clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-7b3d307288/bin/clang-14+0x3733=
b7a)
   #14 0x0000561208fdde53 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-7b3d307288/bin/clang-14+0x4363e53)
   #15 0x0000561209ae8769 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-7b3d307288/bin/clang-14+0x4e6e769)
   #16 0x0000561208fdcc9f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-7b3d307288/bin/clang-14+0x4362c9f)
   #17 0x00005612089dcca1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-7b3d307288/bin/clang-14+0x3d62ca1)
   #18 0x000056120897432a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-7b3d307288/bin/clang-14+0x3cfa32a)
   #19 0x0000561208aa0e0b (/opt/cross/clang-7b3d307288/bin/clang-14+0x3e26e=
0b)
   #20 0x0000561205d05914 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-7b3d307288/bin/clang-14+0x108b914)
   #21 0x0000561205d02e5b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000056120880f8a5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000561207fdb603 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-7b3d307288/bin/clang-14+0x3361603)
   #24 0x000056120881019e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x00005612087e6877 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-7b3=
d307288/bin/clang-14+0x3b6c877)
   #26 0x00005612087e7257 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-7b3d307288/bin/clang-14+0x3b6d257)
   #27 0x00005612087f0bc9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-7b3d307288/bin/clang-14+0x3b76bc9)
   #28 0x0000561205c2d25f main (/opt/cross/clang-7b3d307288/bin/clang-14+0x=
fb325f)
   #29 0x00007faabc246d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x0000561205d0297a _start (/opt/cross/clang-7b3d307288/bin/clang-14+=
0x108897a)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 7b3d30728816403d1fd73=
cc5082e9fb761262bce)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-7b3d307288/bin
   clang-14: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib =
mm net scripts security sound source usr virt


vim +/ctx_test_flags +2295 fs/ext4/super.c

  2294=09
> 2295	EXT4_SET_CTX(flags);
  2296	EXT4_SET_CTX(mount_opt);
  2297	EXT4_SET_CTX(mount_opt2);
> 2298	EXT4_SET_CTX(mount_flags);
  2299=09

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

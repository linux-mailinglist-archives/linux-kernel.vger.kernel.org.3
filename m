Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E44A59B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiBAKM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:12:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:64124 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233697AbiBAKM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643710376; x=1675246376;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uczqTHPaODNK+FmpdWwJvl32r3xpXoPRvf6PzZCAbW4=;
  b=Btn6WiU2iSbwR3DW2PqNClRLD5nl9XDD8j8iS7CtnD3vca8nRwdhmlzi
   TosKIj3Wpkde+IJG2bhPrFLl25fHp6rkycCT9lC1E2c27qaIWri+lLGRY
   nIthnm+iIrAVYPJRmj5BG4aqQ9mEOC0lYclsHVGgjVrvAD1xQnS03XHMA
   SXkjjd7T9fYQuyzPTNpxwwRUtMtjYebk+juUeZHZqykazubFVEBNUkSai
   7lQsR9O8mMYtiPg/ubgpvMtsf4s+biNIcqNXuJU0XrGOhYgYXES4sL3yX
   Xadc8+VhTT/jPlpw5+3joENsNSBSB96wd2jD+f6uXJZ4RuOxPBOEIi/FG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="272137919"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="272137919"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="534479772"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2022 02:12:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEq9F-000T69-OT; Tue, 01 Feb 2022 10:12:29 +0000
Date:   Tue, 1 Feb 2022 18:11:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: fs/ext4/super.c:2173:1: warning: unused function 'ctx_clear_flags'
Message-ID: <202202011815.ZdbRejCO-lkp@intel.com>
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
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: 4437992be7ca3ac5dd0a62cad10357112d4fb43e ext4: remove lazytime/nola=
zytime mount options handled by MS_LAZYTIME
date:   6 weeks ago
config: mips-randconfig-r026-20220201 (https://download.01.org/0day-ci/arch=
ive/20220201/202202011815.ZdbRejCO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e84=
4b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D4437992be7ca3ac5dd0a62cad10357112d4fb43e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4437992be7ca3ac5dd0a62cad10357112d4fb43e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/super.c:2173:1: warning: unused function 'ctx_clear_flags'
   EXT4_SET_CTX(flags);
   ^
   fs/ext4/super.c:2161:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context ^
   <scratch space>:59:1: note: expanded from here
   ctx_clear_flags
   ^
   fs/ext4/super.c:2173:1: warning: unused function 'ctx_test_flags'
   fs/ext4/super.c:2167:34: note: expanded from macro 'EXT4_SET_CTX'
   static inline unsigned long ^
   <scratch space>:62:1: note: expanded from here
   ctx_test_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_clear_mount_flags'
   EXT4_SET_CTX(mount_flags);
   ^
   fs/ext4/super.c:2161:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context ^
   <scratch space>:83:1: note: expanded from here
   ctx_clear_mount_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_test_mount_flags'
   fs/ext4/super.c:2167:34: note: expanded from macro 'EXT4_SET_CTX'
   static inline unsigned long ^
   <scratch space>:86:1: note: expanded from here
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
   #0 0x000055a97e99bc1f Signals.cpp:0:0
   #1 0x000055a97e999afc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-6b1e844b69/bin/clang-14+0x3441afc)
   #2 0x000055a97e8da497 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-6b1e844b69/bin/clang-14+0x3382497)
   #3 0x000055a97e9921ae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-6b1e844b69/bin/clang-14+0x343a1ae)
   #4 0x000055a97c5ef61b (/opt/cross/clang-6b1e844b69/bin/clang-14+0x109761=
b)
   #5 0x000055a97e8e0f4c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3388f4c)
   #6 0x000055a97f5c5337 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-6b1e844b69/bin/clang-14+0x406d337)
   #7 0x000055a97f5c1294 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-6b1e844b69/bin/clang-14+0x4069294)
   #8 0x000055a97d0525f7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x1afa5f7)
   #9 0x000055a97dcfe42d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055a97e137727 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x2bdf727)
   #11 0x000055a97e1378a1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-6b1e844b69/bin/clang-14+0x2bdf8a1)
   #12 0x000055a97e138b7f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-6b1e844b69/bin/clang-14+0x2be0b7f)
   #13 0x000055a97ecad8a7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3755=
8a7)
   #14 0x000055a97f8dd283 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x4385283)
   #15 0x000055a9804025b9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-6b1e844b69/bin/clang-14+0x4eaa5b9)
   #16 0x000055a97f8dc0cf clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-6b1e844b69/bin/clang-14+0x43840cf)
   #17 0x000055a97f2dbec1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-6b1e844b69/bin/clang-14+0x3d83ec1)
   #18 0x000055a97f2736da clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3d1b6da)
   #19 0x000055a97f3a069b (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3e486=
9b)
   #20 0x000055a97c5f0bc4 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-6b1e844b69/bin/clang-14+0x1098bc4)
   #21 0x000055a97c5ed89b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055a97f10d945 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055a97e8da353 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3382353)
   #24 0x000055a97f10e23e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055a97f0e4297 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-6b1=
e844b69/bin/clang-14+0x3b8c297)
   #26 0x000055a97f0e4c77 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3b8cc77)
   #27 0x000055a97f0ee6d9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-6b1e844b69/bin/clang-14+0x3b966d9)
   #28 0x000055a97c51752f main (/opt/cross/clang-6b1e844b69/bin/clang-14+0x=
fbf52f)
   #29 0x00007fdae2a03d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055a97c5ed3ba _start (/opt/cross/clang-6b1e844b69/bin/clang-14+=
0x10953ba)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 6b1e844b69f15bb7dffaf=
9365cd2b355d2eb7579)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-6b1e844b69/bin
   clang-14: note: diagnostic msg:
   Makefile arch fs include kernel nr_bisected scripts source usr


vim +/ctx_clear_flags +2173 fs/ext4/super.c

6e47a3cc68fc52 Lukas Czerner 2021-10-27  2172 =20
6e47a3cc68fc52 Lukas Czerner 2021-10-27 @2173  EXT4_SET_CTX(flags);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2174  EXT4_SET_CTX(mount_opt);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2175  EXT4_SET_CTX(mount_opt2);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2176  EXT4_SET_CTX(mount_flags);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2177 =20

:::::: The code at line 2173 was first introduced by commit
:::::: 6e47a3cc68fc525428297a00524833361ebbb0e9 ext4: get rid of super bloc=
k and sbi from handle_mount_ops()

:::::: TO: Lukas Czerner <lczerner@redhat.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F014B328B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 02:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiBLBt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 20:49:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBLBtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 20:49:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79ED99
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644630560; x=1676166560;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q70RSixdGhGdUkBSNFdHP3bJOmw/VGApndNA0dtN8rk=;
  b=MBohzpkLDAq1NqklUZW+5chfSHsE98KTPHD0CYyrlOMEvIGNU9xc8zjd
   3w8s8u9M9SQgeqvzLncD3scGHlu7WQSvJjwohPr82Dx35nsiWpcszdnuR
   2QPINCjLjy86Q+0nZKI/N7IJiU30BRyQe9KsEfWtihTOEJhVYRicreePF
   99Q9WlIUzeYeC2FlbzzTXh7V7Shz8igLsHHisZkTacg9c2OoqsLAlMwiN
   O37CoH3qrZKseVnahBqGGulBgO4LyUgpBg3b3OOI1RgYQTm2fXqqRuFsW
   /qs5ri11zL8jjlxJc02V3ePpkK0IrZI+USpDbv4JD46VkeLBxquKN32rl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="247435788"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="247435788"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483793628"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2022 17:49:18 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIhXJ-0005UB-Bt; Sat, 12 Feb 2022 01:49:17 +0000
Date:   Sat, 12 Feb 2022 09:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/misc/cardreader/alcor_pci.c:229:20: warning: unused function
 'alcor_mask_sd_irqs'
Message-ID: <202202120902.ajxmfFok-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

First bad commit (maybe !=3D root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   f1baf68e1383f6ed93eb9cff2866d46562607a43
commit: 1d987052e32f3554e84a296c4494551bc60f3877 MIPS: BMIPS: Enable PCI Kc=
onfig
date:   3 months ago
config: mips-randconfig-r005-20220211 (https://download.01.org/0day-ci/arch=
ive/20220212/202202120902.ajxmfFok-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f=
774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D1d987052e32f3554e84a296c4494551bc60f3877
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1d987052e32f3554e84a296c4494551bc60f3877
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/hwmon/ drivers/misc/c=
ardreader/ drivers/video/fbdev/ fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/cardreader/alcor_pci.c:229:20: warning: unused function 'al=
cor_mask_sd_irqs'
   static inline void alcor_mask_sd_irqs(struct alcor_pci_priv
   ^
>> drivers/misc/cardreader/alcor_pci.c:234:20: warning: unused function 'al=
cor_unmask_sd_irqs'
   static inline void alcor_unmask_sd_irqs(struct alcor_pci_priv
   ^
>> drivers/misc/cardreader/alcor_pci.c:242:20: warning: unused function 'al=
cor_mask_ms_irqs'
   static inline void alcor_mask_ms_irqs(struct alcor_pci_priv
   ^
>> drivers/misc/cardreader/alcor_pci.c:247:20: warning: unused function 'al=
cor_unmask_ms_irqs'
   static inline void alcor_unmask_ms_irqs(struct alcor_pci_priv
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
   0. Program arguments: clang -Wp,-MMD,drivers/misc/cardreader/.alcor_pci.=
o.d -nostdinc -isystem /opt/cross/clang-f6685f7746/lib/clang/15.0.0/include=
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
reestanding -EL -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DT=
OOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/incl=
ude/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-point=
er-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larg=
er-than=3D1024 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-=
but-set-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero =
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -f=
no-stack-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-poin=
ter-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=3D=
date-time -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused=
-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prot=
otypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-varia=
ble -Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compa=
re -Wno-type-limits -DMODULE -mlong-calls -DKBUILD_BASENAME=3D"alcor_pci" -=
DKBUILD_MODNAME=3D"alcor_pci" -D__KBUILD_MODNAME=3Dkmod_alcor_pci -c -o dri=
vers/misc/cardreader/alcor_pci.o drivers/misc/cardreader/alcor_pci.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/misc/cardread=
er/alcor_pci.c'.
   4. Running pass 'Mips Assembly Printer' on function '@alcor_write8'
   #0 0x000056118b75091f Signals.cpp:0:0
   #1 0x000056118b74e7fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-f6685f7746/bin/clang-15+0x34787fc)
   #2 0x000056118b68ea97 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-f6685f7746/bin/clang-15+0x33b8a97)
   #3 0x000056118b746eae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-f6685f7746/bin/clang-15+0x3470eae)
   #4 0x000056118937d8eb (/opt/cross/clang-f6685f7746/bin/clang-15+0x10a78e=
b)
   #5 0x000056118b69554c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x33bf54c)
   #6 0x000056118c387470 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-f6685f7746/bin/clang-15+0x40b1470)
   #7 0x000056118c3833a4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-f6685f7746/bin/clang-15+0x40ad3a4)
   #8 0x0000561189de9217 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x1b13217)
   #9 0x000056118aaa16ed llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000056118aee22f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c2f7)
   #11 0x000056118aee2471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c471)
   #12 0x000056118aee2fef llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0cfef)
   #13 0x000056118ba689b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3792=
9b7)
   #14 0x000056118c6a0343 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x43ca343)
   #15 0x000056118d176ab9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-f6685f7746/bin/clang-15+0x4ea0ab9)
   #16 0x000056118c69f17f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-f6685f7746/bin/clang-15+0x43c917f)
   #17 0x000056118c09c5c1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-f6685f7746/bin/clang-15+0x3dc65c1)
   #18 0x000056118c0333aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3d5d3aa)
   #19 0x000056118c160edb (/opt/cross/clang-f6685f7746/bin/clang-15+0x3e8ae=
db)
   #20 0x000056118937ee9c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-f6685f7746/bin/clang-15+0x10a8e9c)
   #21 0x000056118937bb6b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000056118beca8d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000056118b68e953 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-f6685f7746/bin/clang-15+0x33b8953)
   #24 0x000056118becb1ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000056118be9fdc7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-f66=
85f7746/bin/clang-15+0x3bc9dc7)
   #26 0x000056118bea07a7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bca7a7)
   #27 0x000056118bea9e39 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bd3e39)
   #28 0x00005611892a43bf main (/opt/cross/clang-f6685f7746/bin/clang-15+0x=
fce3bf)
   #29 0x00007f277c1ded0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000056118937b68a _start (/opt/cross/clang-f6685f7746/bin/clang-15+=
0x10a568a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project f6685f774697c85d6a352=
dcea013f46a99f9fe31)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-f6685f7746/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel nr_bisected scripts source=
 usr
--
>> drivers/hwmon/sis5595.c:158:18: warning: unused function 'DIV_TO_REG'
   static inline u8 DIV_TO_REG(int val)
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
   0. Program arguments: clang -Wp,-MMD,drivers/hwmon/.sis5595.o.d -nostdin=
c -isystem /opt/cross/clang-f6685f7746/lib/clang/15.0.0/include -Iarch/mips=
/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/mips/=
include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./includ=
e/generated/uapi -include include/linux/compiler-version.h -include include=
/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ -DVML=
INUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x84000000 -=
DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_EXTRA_=
WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-=
aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-dec=
laration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-security =
-std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunknown-warn=
ing-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic =
-pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding =
-EL -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DTOOLCHAIN_SUP=
PORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/include/asm/mach=
-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -W=
no-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-than=3D10=
24 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-but-set-vari=
able -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero -enable-triv=
ial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -fno-stack-cla=
sh-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wn=
o-array-bounds -fno-strict-overflow -fno-stack-check -Werror=3Ddate-time -W=
error=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -=
Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold=
-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused=
-const-variable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type=
-limits -DDEBUG -I drivers/hwmon -I ./drivers/hwmon -DMODULE -mlong-calls -=
DKBUILD_BASENAME=3D"sis5595" -DKBUILD_MODNAME=3D"sis5595" -D__KBUILD_MODNAM=
E=3Dkmod_sis5595 -c -o drivers/hwmon/sis5595.o drivers/hwmon/sis5595.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/hwmon/sis5595=
=2Ec'.
   4. Running pass 'Mips Assembly Printer' on function '@sis5595_probe'
   #0 0x0000564dab6e291f Signals.cpp:0:0
   #1 0x0000564dab6e07fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-f6685f7746/bin/clang-15+0x34787fc)
   #2 0x0000564dab620a97 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-f6685f7746/bin/clang-15+0x33b8a97)
   #3 0x0000564dab6d8eae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-f6685f7746/bin/clang-15+0x3470eae)
   #4 0x0000564da930f8eb (/opt/cross/clang-f6685f7746/bin/clang-15+0x10a78e=
b)
   #5 0x0000564dab62754c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x33bf54c)
   #6 0x0000564dac319470 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-f6685f7746/bin/clang-15+0x40b1470)
   #7 0x0000564dac3153a4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-f6685f7746/bin/clang-15+0x40ad3a4)
   #8 0x0000564da9d7b217 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x1b13217)
   #9 0x0000564daaa336ed llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000564daae742f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c2f7)
   #11 0x0000564daae74471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c471)
   #12 0x0000564daae74fef llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0cfef)
   #13 0x0000564dab9fa9b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3792=
9b7)
   #14 0x0000564dac632343 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x43ca343)
   #15 0x0000564dad108ab9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-f6685f7746/bin/clang-15+0x4ea0ab9)
   #16 0x0000564dac63117f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-f6685f7746/bin/clang-15+0x43c917f)
   #17 0x0000564dac02e5c1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-f6685f7746/bin/clang-15+0x3dc65c1)
   #18 0x0000564dabfc53aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3d5d3aa)
   #19 0x0000564dac0f2edb (/opt/cross/clang-f6685f7746/bin/clang-15+0x3e8ae=
db)
   #20 0x0000564da9310e9c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-f6685f7746/bin/clang-15+0x10a8e9c)
   #21 0x0000564da930db6b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000564dabe5c8d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000564dab620953 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-f6685f7746/bin/clang-15+0x33b8953)
   #24 0x0000564dabe5d1ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000564dabe31dc7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-f66=
85f7746/bin/clang-15+0x3bc9dc7)
   #26 0x0000564dabe327a7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bca7a7)
   #27 0x0000564dabe3be39 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bd3e39)
   #28 0x0000564da92363bf main (/opt/cross/clang-f6685f7746/bin/clang-15+0x=
fce3bf)
   #29 0x00007efff966cd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x0000564da930d68a _start (/opt/cross/clang-f6685f7746/bin/clang-15+=
0x10a568a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project f6685f774697c85d6a352=
dcea013f46a99f9fe31)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-f6685f7746/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel nr_bisected scripts source=
 usr
--
>> drivers/misc/cardreader/alcor_pci.c:229:20: warning: unused function 'al=
cor_mask_sd_irqs'
   static inline void alcor_mask_sd_irqs(struct alcor_pci_priv
   ^
>> drivers/misc/cardreader/alcor_pci.c:234:20: warning: unused function 'al=
cor_unmask_sd_irqs'
   static inline void alcor_unmask_sd_irqs(struct alcor_pci_priv
   ^
>> drivers/misc/cardreader/alcor_pci.c:242:20: warning: unused function 'al=
cor_mask_ms_irqs'
   static inline void alcor_mask_ms_irqs(struct alcor_pci_priv
   ^
>> drivers/misc/cardreader/alcor_pci.c:247:20: warning: unused function 'al=
cor_unmask_ms_irqs'
   static inline void alcor_unmask_ms_irqs(struct alcor_pci_priv
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
   0. Program arguments: clang -Wp,-MMD,drivers/misc/cardreader/.alcor_pci.=
o.d -nostdinc -isystem /opt/cross/clang-f6685f7746/lib/clang/15.0.0/include=
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
reestanding -EL -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DT=
OOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/incl=
ude/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-point=
er-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larg=
er-than=3D1024 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-=
but-set-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero =
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -f=
no-stack-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-poin=
ter-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=3D=
date-time -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused=
-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prot=
otypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-varia=
ble -Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compa=
re -Wno-type-limits -I drivers/misc/cardreader -I ./drivers/misc/cardreader=
 -DMODULE -mlong-calls -DKBUILD_BASENAME=3D"alcor_pci" -DKBUILD_MODNAME=3D"=
alcor_pci" -D__KBUILD_MODNAME=3Dkmod_alcor_pci -c -o drivers/misc/cardreade=
r/alcor_pci.o drivers/misc/cardreader/alcor_pci.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/misc/cardread=
er/alcor_pci.c'.
   4. Running pass 'Mips Assembly Printer' on function '@alcor_write8'
   #0 0x000055d938bea91f Signals.cpp:0:0
   #1 0x000055d938be87fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-f6685f7746/bin/clang-15+0x34787fc)
   #2 0x000055d938b28a97 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-f6685f7746/bin/clang-15+0x33b8a97)
   #3 0x000055d938be0eae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-f6685f7746/bin/clang-15+0x3470eae)
   #4 0x000055d9368178eb (/opt/cross/clang-f6685f7746/bin/clang-15+0x10a78e=
b)
   #5 0x000055d938b2f54c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x33bf54c)
   #6 0x000055d939821470 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-f6685f7746/bin/clang-15+0x40b1470)
   #7 0x000055d93981d3a4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-f6685f7746/bin/clang-15+0x40ad3a4)
   #8 0x000055d937283217 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x1b13217)
   #9 0x000055d937f3b6ed llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055d93837c2f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c2f7)
   #11 0x000055d93837c471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c471)
   #12 0x000055d93837cfef llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0cfef)
   #13 0x000055d938f029b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3792=
9b7)
   #14 0x000055d939b3a343 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x43ca343)
   #15 0x000055d93a610ab9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-f6685f7746/bin/clang-15+0x4ea0ab9)
   #16 0x000055d939b3917f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-f6685f7746/bin/clang-15+0x43c917f)
   #17 0x000055d9395365c1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-f6685f7746/bin/clang-15+0x3dc65c1)
   #18 0x000055d9394cd3aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3d5d3aa)
   #19 0x000055d9395faedb (/opt/cross/clang-f6685f7746/bin/clang-15+0x3e8ae=
db)
   #20 0x000055d936818e9c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-f6685f7746/bin/clang-15+0x10a8e9c)
   #21 0x000055d936815b6b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055d9393648d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055d938b28953 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-f6685f7746/bin/clang-15+0x33b8953)
   #24 0x000055d9393651ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055d939339dc7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-f66=
85f7746/bin/clang-15+0x3bc9dc7)
   #26 0x000055d93933a7a7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bca7a7)
   #27 0x000055d939343e39 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bd3e39)
   #28 0x000055d93673e3bf main (/opt/cross/clang-f6685f7746/bin/clang-15+0x=
fce3bf)
   #29 0x00007fcbf5c7fd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055d93681568a _start (/opt/cross/clang-f6685f7746/bin/clang-15+=
0x10a568a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project f6685f774697c85d6a352=
dcea013f46a99f9fe31)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-f6685f7746/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel nr_bisected scripts source=
 usr
--
>> drivers/video/fbdev/tridentfb.c:1127:20: warning: unused function 'shado=
wmode_off'
   static inline void shadowmode_off(struct tridentfb_par
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
   0. Program arguments: clang -Wp,-MMD,drivers/video/fbdev/.tridentfb.o.d =
-nostdinc -isystem /opt/cross/clang-f6685f7746/lib/clang/15.0.0/include -Ia=
rch/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iar=
ch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I=
=2E/include/generated/uapi -include include/linux/compiler-version.h -inclu=
de include/linux/kconfig.h -include include/linux/compiler_types.h -D__KERN=
EL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x=
84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBU=
ILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -f=
no-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-fu=
nction-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format=
-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dun=
known-warning-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls=
 -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffre=
estanding -EL -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DTOO=
LCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/includ=
e/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer=
-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger=
-than=3D1024 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-bu=
t-set-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero -e=
nable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -fno=
-stack-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointe=
r-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=3Dda=
te-time -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-p=
arameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-protot=
ypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variabl=
e -Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compare=
 -Wno-type-limits -I drivers/video/fbdev -I ./drivers/video/fbdev -ffunctio=
n-sections -fdata-sections -DKBUILD_MODFILE=3D"drivers/video/fbdev/tridentf=
b" -DKBUILD_BASENAME=3D"tridentfb" -DKBUILD_MODNAME=3D"tridentfb" -D__KBUIL=
D_MODNAME=3Dkmod_tridentfb -c -o drivers/video/fbdev/tridentfb.o drivers/vi=
deo/fbdev/tridentfb.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/video/fbdev/t=
ridentfb.c'.
   4. Running pass 'Mips Assembly Printer' on function '@trident_pci_probe'
   #0 0x000055ca0132491f Signals.cpp:0:0
   #1 0x000055ca013227fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-f6685f7746/bin/clang-15+0x34787fc)
   #2 0x000055ca01262a97 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-f6685f7746/bin/clang-15+0x33b8a97)
   #3 0x000055ca0131aeae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-f6685f7746/bin/clang-15+0x3470eae)
   #4 0x000055c9fef518eb (/opt/cross/clang-f6685f7746/bin/clang-15+0x10a78e=
b)
   #5 0x000055ca0126954c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x33bf54c)
   #6 0x000055ca01f5b470 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-f6685f7746/bin/clang-15+0x40b1470)
   #7 0x000055ca01f573a4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-f6685f7746/bin/clang-15+0x40ad3a4)
   #8 0x000055c9ff9bd217 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x1b13217)
   #9 0x000055ca006756ed llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055ca00ab62f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c2f7)
   #11 0x000055ca00ab6471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c471)
   #12 0x000055ca00ab6fef llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0cfef)
   #13 0x000055ca0163c9b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3792=
9b7)
   #14 0x000055ca02274343 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x43ca343)
   #15 0x000055ca02d4aab9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-f6685f7746/bin/clang-15+0x4ea0ab9)
   #16 0x000055ca0227317f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-f6685f7746/bin/clang-15+0x43c917f)
   #17 0x000055ca01c705c1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-f6685f7746/bin/clang-15+0x3dc65c1)
   #18 0x000055ca01c073aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3d5d3aa)
   #19 0x000055ca01d34edb (/opt/cross/clang-f6685f7746/bin/clang-15+0x3e8ae=
db)
   #20 0x000055c9fef52e9c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-f6685f7746/bin/clang-15+0x10a8e9c)
   #21 0x000055c9fef4fb6b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055ca01a9e8d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055ca01262953 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-f6685f7746/bin/clang-15+0x33b8953)
   #24 0x000055ca01a9f1ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055ca01a73dc7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-f66=
85f7746/bin/clang-15+0x3bc9dc7)
   #26 0x000055ca01a747a7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bca7a7)
   #27 0x000055ca01a7de39 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bd3e39)
   #28 0x000055c9fee783bf main (/opt/cross/clang-f6685f7746/bin/clang-15+0x=
fce3bf)
   #29 0x00007f5bdc990d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055c9fef4f68a _start (/opt/cross/clang-f6685f7746/bin/clang-15+=
0x10a568a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project f6685f774697c85d6a352=
dcea013f46a99f9fe31)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-f6685f7746/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel nr_bisected scripts source=
 usr
--
>> drivers/video/fbdev/arkfb.c:321:18: warning: unused function 'dac_read_r=
eg'
   static inline u8 dac_read_reg(struct dac_info u8 reg)
   ^
>> drivers/video/fbdev/arkfb.c:328:20: warning: unused function 'dac_read_r=
egs'
   static inline void dac_read_regs(struct dac_info u8 int count)
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
   0. Program arguments: clang -Wp,-MMD,drivers/video/fbdev/.arkfb.o.d -nos=
tdinc -isystem /opt/cross/clang-f6685f7746/lib/clang/15.0.0/include -Iarch/=
mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/m=
ips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./in=
clude/generated/uapi -include include/linux/compiler-version.h -include inc=
lude/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ -=
DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x840000=
00 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_EX=
TRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-str=
ict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function=
-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-secur=
ity -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunknown-=
warning-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-=
pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestand=
ing -EL -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DTOOLCHAIN=
_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/include/asm/=
mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-check=
s -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-than=
=3D1024 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-but-set=
-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero -enable=
-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -fno-stac=
k-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sig=
n -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=3Ddate-ti=
me -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-parame=
ter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes =
-Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wu=
nused-const-variable -Wno-missing-field-initializers -Wno-sign-compare -Wno=
-type-limits -I drivers/video/fbdev -I ./drivers/video/fbdev -ffunction-sec=
tions -fdata-sections -DKBUILD_MODFILE=3D"drivers/video/fbdev/arkfb" -DKBUI=
LD_BASENAME=3D"arkfb" -DKBUILD_MODNAME=3D"arkfb" -D__KBUILD_MODNAME=3Dkmod_=
arkfb -c -o drivers/video/fbdev/arkfb.o drivers/video/fbdev/arkfb.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/video/fbdev/a=
rkfb.c'.
   4. Running pass 'Mips Assembly Printer' on function '@ark_dac_read_regs'
   #0 0x000055ac07c3d91f Signals.cpp:0:0
   #1 0x000055ac07c3b7fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-f6685f7746/bin/clang-15+0x34787fc)
   #2 0x000055ac07b7ba97 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-f6685f7746/bin/clang-15+0x33b8a97)
   #3 0x000055ac07c33eae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-f6685f7746/bin/clang-15+0x3470eae)
   #4 0x000055ac0586a8eb (/opt/cross/clang-f6685f7746/bin/clang-15+0x10a78e=
b)
   #5 0x000055ac07b8254c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x33bf54c)
   #6 0x000055ac08874470 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-f6685f7746/bin/clang-15+0x40b1470)
   #7 0x000055ac088703a4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-f6685f7746/bin/clang-15+0x40ad3a4)
   #8 0x000055ac062d6217 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x1b13217)
   #9 0x000055ac06f8e6ed llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055ac073cf2f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c2f7)
   #11 0x000055ac073cf471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c471)
   #12 0x000055ac073cffef llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0cfef)
   #13 0x000055ac07f559b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3792=
9b7)
   #14 0x000055ac08b8d343 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x43ca343)
   #15 0x000055ac09663ab9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-f6685f7746/bin/clang-15+0x4ea0ab9)
   #16 0x000055ac08b8c17f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-f6685f7746/bin/clang-15+0x43c917f)
   #17 0x000055ac085895c1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-f6685f7746/bin/clang-15+0x3dc65c1)
   #18 0x000055ac085203aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3d5d3aa)
   #19 0x000055ac0864dedb (/opt/cross/clang-f6685f7746/bin/clang-15+0x3e8ae=
db)
   #20 0x000055ac0586be9c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-f6685f7746/bin/clang-15+0x10a8e9c)
   #21 0x000055ac05868b6b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055ac083b78d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055ac07b7b953 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-f6685f7746/bin/clang-15+0x33b8953)
   #24 0x000055ac083b81ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055ac0838cdc7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-f66=
85f7746/bin/clang-15+0x3bc9dc7)
   #26 0x000055ac0838d7a7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bca7a7)
   #27 0x000055ac08396e39 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bd3e39)
   #28 0x000055ac057913bf main (/opt/cross/clang-f6685f7746/bin/clang-15+0x=
fce3bf)
   #29 0x00007f059998ad0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055ac0586868a _start (/opt/cross/clang-f6685f7746/bin/clang-15+=
0x10a568a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project f6685f774697c85d6a352=
dcea013f46a99f9fe31)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-f6685f7746/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel nr_bisected scripts source=
 usr
--
>> drivers/hwmon/sis5595.c:158:18: warning: unused function 'DIV_TO_REG'
   static inline u8 DIV_TO_REG(int val)
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
   0. Program arguments: clang -Wp,-MMD,drivers/hwmon/.sis5595.o.d -nostdin=
c -isystem /opt/cross/clang-f6685f7746/lib/clang/15.0.0/include -Iarch/mips=
/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/mips/=
include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./includ=
e/generated/uapi -include include/linux/compiler-version.h -include include=
/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ -DVML=
INUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x84000000 -=
DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_EXTRA_=
WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-=
aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-dec=
laration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-security =
-std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunknown-warn=
ing-option -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic =
-pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding =
-EL -fno-stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DTOOLCHAIN_SUP=
PORTS_VIRT -Iarch/mips/include/asm/mach-bmips/ -Iarch/mips/include/asm/mach=
-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -W=
no-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-than=3D10=
24 -fno-stack-protector -Wno-gnu -mno-global-merge -Wno-unused-but-set-vari=
able -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero -enable-triv=
ial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -fno-stack-cla=
sh-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wn=
o-array-bounds -fno-strict-overflow -fno-stack-check -Werror=3Ddate-time -W=
error=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -=
Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold=
-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused=
-const-variable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type=
-limits -DDEBUG -DMODULE -mlong-calls -DKBUILD_BASENAME=3D"sis5595" -DKBUIL=
D_MODNAME=3D"sis5595" -D__KBUILD_MODNAME=3Dkmod_sis5595 -c -o drivers/hwmon=
/sis5595.o drivers/hwmon/sis5595.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/hwmon/sis5595=
=2Ec'.
   4. Running pass 'Mips Assembly Printer' on function '@sis5595_probe'
   #0 0x000055f46067891f Signals.cpp:0:0
   #1 0x000055f4606767fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-f6685f7746/bin/clang-15+0x34787fc)
   #2 0x000055f4605b6a97 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-f6685f7746/bin/clang-15+0x33b8a97)
   #3 0x000055f46066eeae llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-f6685f7746/bin/clang-15+0x3470eae)
   #4 0x000055f45e2a58eb (/opt/cross/clang-f6685f7746/bin/clang-15+0x10a78e=
b)
   #5 0x000055f4605bd54c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x33bf54c)
   #6 0x000055f4612af470 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-f6685f7746/bin/clang-15+0x40b1470)
   #7 0x000055f4612ab3a4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-f6685f7746/bin/clang-15+0x40ad3a4)
   #8 0x000055f45ed11217 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x1b13217)
   #9 0x000055f45f9c96ed llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055f45fe0a2f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c2f7)
   #11 0x000055f45fe0a471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0c471)
   #12 0x000055f45fe0afef llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-f6685f7746/bin/clang-15+0x2c0cfef)
   #13 0x000055f4609909b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3792=
9b7)
   #14 0x000055f4615c8343 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x43ca343)
   #15 0x000055f46209eab9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-f6685f7746/bin/clang-15+0x4ea0ab9)
   #16 0x000055f4615c717f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-f6685f7746/bin/clang-15+0x43c917f)
   #17 0x000055f460fc45c1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-f6685f7746/bin/clang-15+0x3dc65c1)
   #18 0x000055f460f5b3aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3d5d3aa)
   #19 0x000055f461088edb (/opt/cross/clang-f6685f7746/bin/clang-15+0x3e8ae=
db)
   #20 0x000055f45e2a6e9c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-f6685f7746/bin/clang-15+0x10a8e9c)
   #21 0x000055f45e2a3b6b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055f460df28d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055f4605b6953 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-f6685f7746/bin/clang-15+0x33b8953)
   #24 0x000055f460df31ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055f460dc7dc7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-f66=
85f7746/bin/clang-15+0x3bc9dc7)
   #26 0x000055f460dc87a7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bca7a7)
   #27 0x000055f460dd1e39 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-f6685f7746/bin/clang-15+0x3bd3e39)
   #28 0x000055f45e1cc3bf main (/opt/cross/clang-f6685f7746/bin/clang-15+0x=
fce3bf)
   #29 0x00007f18e0f2fd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055f45e2a368a _start (/opt/cross/clang-f6685f7746/bin/clang-15+=
0x10a568a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project f6685f774697c85d6a352=
dcea013f46a99f9fe31)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-f6685f7746/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel nr_bisected scripts source=
 usr


vim +/alcor_mask_sd_irqs +229 drivers/misc/cardreader/alcor_pci.c

4f556bc04e3c0de Oleksij Rempel 2018-12-02  228 =20
4f556bc04e3c0de Oleksij Rempel 2018-12-02 @229  static inline void alcor_ma=
sk_sd_irqs(struct alcor_pci_priv *priv)
4f556bc04e3c0de Oleksij Rempel 2018-12-02  230  {
4f556bc04e3c0de Oleksij Rempel 2018-12-02  231  	alcor_write32(priv, 0, AU6=
601_REG_INT_ENABLE);
4f556bc04e3c0de Oleksij Rempel 2018-12-02  232  }
4f556bc04e3c0de Oleksij Rempel 2018-12-02  233 =20
4f556bc04e3c0de Oleksij Rempel 2018-12-02 @234  static inline void alcor_un=
mask_sd_irqs(struct alcor_pci_priv *priv)
4f556bc04e3c0de Oleksij Rempel 2018-12-02  235  {
4f556bc04e3c0de Oleksij Rempel 2018-12-02  236  	alcor_write32(priv, AU6601=
_INT_CMD_MASK | AU6601_INT_DATA_MASK |
4f556bc04e3c0de Oleksij Rempel 2018-12-02  237  		  AU6601_INT_CARD_INSERT =
| AU6601_INT_CARD_REMOVE |
4f556bc04e3c0de Oleksij Rempel 2018-12-02  238  		  AU6601_INT_OVER_CURRENT=
_ERR,
4f556bc04e3c0de Oleksij Rempel 2018-12-02  239  		  AU6601_REG_INT_ENABLE);
4f556bc04e3c0de Oleksij Rempel 2018-12-02  240  }
4f556bc04e3c0de Oleksij Rempel 2018-12-02  241 =20
4f556bc04e3c0de Oleksij Rempel 2018-12-02 @242  static inline void alcor_ma=
sk_ms_irqs(struct alcor_pci_priv *priv)
4f556bc04e3c0de Oleksij Rempel 2018-12-02  243  {
4f556bc04e3c0de Oleksij Rempel 2018-12-02  244  	alcor_write32(priv, 0, AU6=
601_MS_INT_ENABLE);
4f556bc04e3c0de Oleksij Rempel 2018-12-02  245  }
4f556bc04e3c0de Oleksij Rempel 2018-12-02  246 =20
4f556bc04e3c0de Oleksij Rempel 2018-12-02 @247  static inline void alcor_un=
mask_ms_irqs(struct alcor_pci_priv *priv)
4f556bc04e3c0de Oleksij Rempel 2018-12-02  248  {
4f556bc04e3c0de Oleksij Rempel 2018-12-02  249  	alcor_write32(priv, 0x3d00=
fa, AU6601_MS_INT_ENABLE);
4f556bc04e3c0de Oleksij Rempel 2018-12-02  250  }
4f556bc04e3c0de Oleksij Rempel 2018-12-02  251 =20

:::::: The code at line 229 was first introduced by commit
:::::: 4f556bc04e3c0de2f5c69adc9e9f2bcefcad079d misc: cardreader: add new A=
lcor Micro Cardreader PCI driver

:::::: TO: Oleksij Rempel <linux@rempel-privat.de>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

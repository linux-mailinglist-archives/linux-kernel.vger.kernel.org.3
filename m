Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8F50297D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353203AbiDOMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiDOMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:22:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6513E9A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650025181; x=1681561181;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qZVk/Xe+IKEsEbB77c9HX6YzkDjWq85PLgWZYEh7jOo=;
  b=ch/L+WTatIduGvT/7QvxBvRup1oav1UEIxAh1upmQ2+SjK+ms/05jeFZ
   OZsp/i83E0cUdNeu+htrfpsAk7+qauP+JIpcU5m3p8C0ej6QTs8/tesZj
   PsAKVt9in1YBcefYZeZsAK86fKLEiPHTqTcoTpzQmS1Pb1Fwnw2P6voPK
   5pkzgoWQlOpVWXBgWff27VbibhJXj5j2oX4ZJ3sY+k4etwPocwVvAimby
   HduBrTt44KGf/osKy1YHSPquwrs2pmgjnKnqWtu/fmBcI7hXIcOw77ddL
   HXdhn0Pe3pXReh7fBLPBvhZrfP+d5bQYuKGPvpR0PCMa5VH30bDKPIs/q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="260741186"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="260741186"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 05:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="527379544"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2022 05:19:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfKv3-0001vx-8R;
        Fri, 15 Apr 2022 12:19:21 +0000
Date:   Fri, 15 Apr 2022 20:18:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/dma-buf/st-dma-fence-unwrap.c:25:4: warning: unused function
 'to_mock_fence'
Message-ID: <202204152004.TReE0FcA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
commit: 64a8f92fd783e750cdb81af75942dcd53bbf61bd dma-buf: add dma_fence_unw=
rap v2
date:   3 weeks ago
config: mips-randconfig-c004-20220414 (https://download.01.org/0day-ci/arch=
ive/20220415/202204152004.TReE0FcA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6e=
a489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D64a8f92fd783e750cdb81af75942dcd53bbf61bd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 64a8f92fd783e750cdb81af75942dcd53bbf61bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma-buf/st-dma-fence-unwrap.c:125:6: warning: variable 'err' set=
 but not used
   int err =3D 0;
   ^
   drivers/dma-buf/st-dma-fence-unwrap.c:167:6: warning: variable 'err' set=
 but not used
   int err =3D 0;
   ^
   drivers/dma-buf/st-dma-fence-unwrap.c:209:6: warning: variable 'err' set=
 but not used
   int err =3D 0;
   ^
>> drivers/dma-buf/st-dma-fence-unwrap.c:25:4: warning: unused function 'to=
_mock_fence'
   } dma_fence {
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 156, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/dma-buf/.st-dma-fence-unwra=
p.o.d -nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iinclu=
de -I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uap=
i -Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler=
-version.h -include include/linux/kconfig.h -include include/linux/compiler=
_types.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_=
LOAD_ADDRESS=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefi=
x-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes =
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Wer=
ror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn=
-type -Wno-format-security -std=3Dgnu89 --target=3Dmips-linux -fintegrated-=
as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument=
 -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -mso=
ft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-s=
tack-check -march=3Dmips32r2 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mi=
ps/include/asm/mach-ath79 -Iarch/mips/include/asm/mach-generic -fno-asynchr=
onous-unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno=
-address-of-packed-member -O2 -Wframe-larger-than=3D1024 -fstack-protector =
-Wimplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-varia=
ble -Wno-unused-const-variable -fno-stack-clash-protection -pg -Wdeclaratio=
n-after-statement -Wvla -Wno-pointer-sign -Wcast-function-type -Wno-array-b=
ounds -fno-strict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Di=
ncompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-=
declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-de=
finition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-const-va=
riable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -=
I drivers/dma-buf -I ./drivers/dma-buf -DMODULE -mlong-calls -DKBUILD_BASEN=
AME=3D"st_dma_fence_unwrap" -DKBUILD_MODNAME=3D"dmabuf_selftests" -D__KBUIL=
D_MODNAME=3Dkmod_dmabuf_selftests -c -o drivers/dma-buf/st-dma-fence-unwrap=
=2Eo drivers/dma-buf/st-dma-fence-unwrap.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/dma-buf/st-dm=
a-fence-unwrap.c'.
   4. Running pass 'Mips Assembly Printer' on function '@sanitycheck'
   #0 0x000055e4c7382a7f Signals.cpp:0:0
   #1 0x000055e4c73808a4 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-6b7e6ea489/bin/clang-15+0x34f18a4)
   #2 0x000055e4c72c0087 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-6b7e6ea489/bin/clang-15+0x3431087)
   #3 0x000055e4c7378ede llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-6b7e6ea489/bin/clang-15+0x34e9ede)
   #4 0x000055e4c4f4c92b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x10bd92=
b)
   #5 0x000055e4c72c6bac llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3437bac)
   #6 0x000055e4c7ff6260 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4167260)
   #7 0x000055e4c7ff2162 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-6b7e6ea489/bin/clang-15+0x4163162)
   #8 0x000055e4c59d2d07 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x1b43d07)
   #9 0x000055e4c66ae47d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055e4c6af8457 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c69457)
   #11 0x000055e4c6af85d1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c695d1)
   #12 0x000055e4c6af914f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c6a14f)
   #13 0x000055e4c76ad4c6 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x381e=
4c6)
   #14 0x000055e4c8316ca3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4487ca3)
   #15 0x000055e4c8e4aa01 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-6b7e6ea489/bin/clang-15+0x4fbba01)
   #16 0x000055e4c8316395 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-6b7e6ea489/bin/clang-15+0x4487395)
   #17 0x000055e4c7d0c831 clang::FrontendAction::Execute() (/opt/cross/clan=
g-6b7e6ea489/bin/clang-15+0x3e7d831)
   #18 0x000055e4c7ca1b1a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3e12b1a)
   #19 0x000055e4c7dd363b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3f446=
3b)
   #20 0x000055e4c4f4dedc cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-6b7e6ea489/bin/clang-15+0x10beedc)
   #21 0x000055e4c4f4abab ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055e4c7b343f5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055e4c72bff43 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3430f43)
   #24 0x000055e4c7b34cee clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055e4c7b08de7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-6b7=
e6ea489/bin/clang-15+0x3c79de7)
   #26 0x000055e4c7b097c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c7a7c7)
   #27 0x000055e4c7b12e19 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c83e19)
   #28 0x000055e4c4e97d2f main (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x=
1008d2f)
   #29 0x00007ff272d617fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055e4c4f4a6ca _start (/opt/cross/clang-6b7e6ea489/bin/clang-15+=
0x10bb6ca)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 6b7e6ea489f6dd45a9b0d=
a9ac20871560917b9b0)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-6b7e6ea489/bin
   clang-15: note: diagnostic msg:
   Makefile arch certs crypto drivers fs include init ipc kernel lib mm net=
 scripts security sound source usr virt
--
   drivers/dma-buf/st-dma-fence-unwrap.c:125:6: warning: variable 'err' set=
 but not used
   int err =3D 0;
   ^
   drivers/dma-buf/st-dma-fence-unwrap.c:167:6: warning: variable 'err' set=
 but not used
   int err =3D 0;
   ^
   drivers/dma-buf/st-dma-fence-unwrap.c:209:6: warning: variable 'err' set=
 but not used
   int err =3D 0;
   ^
>> drivers/dma-buf/st-dma-fence-unwrap.c:25:4: warning: unused function 'to=
_mock_fence'
   } dma_fence {
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 156, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/dma-buf/.st-dma-fence-unwra=
p.o.d -nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iinclu=
de -I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uap=
i -Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler=
-version.h -include include/linux/kconfig.h -include include/linux/compiler=
_types.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_=
LOAD_ADDRESS=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefi=
x-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes =
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Wer=
ror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn=
-type -Wno-format-security -std=3Dgnu89 --target=3Dmips-linux -fintegrated-=
as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument=
 -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -mso=
ft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-s=
tack-check -march=3Dmips32r2 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mi=
ps/include/asm/mach-ath79 -Iarch/mips/include/asm/mach-generic -fno-asynchr=
onous-unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno=
-address-of-packed-member -O2 -Wframe-larger-than=3D1024 -fstack-protector =
-Wimplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-varia=
ble -Wno-unused-const-variable -fno-stack-clash-protection -pg -Wdeclaratio=
n-after-statement -Wvla -Wno-pointer-sign -Wcast-function-type -Wno-array-b=
ounds -fno-strict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Di=
ncompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-=
declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-de=
finition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-const-va=
riable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -=
DMODULE -mlong-calls -DKBUILD_BASENAME=3D"st_dma_fence_unwrap" -DKBUILD_MOD=
NAME=3D"dmabuf_selftests" -D__KBUILD_MODNAME=3Dkmod_dmabuf_selftests -c -o =
drivers/dma-buf/st-dma-fence-unwrap.o drivers/dma-buf/st-dma-fence-unwrap.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/dma-buf/st-dm=
a-fence-unwrap.c'.
   4. Running pass 'Mips Assembly Printer' on function '@sanitycheck'
   #0 0x000055724d179a7f Signals.cpp:0:0
   #1 0x000055724d1778a4 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-6b7e6ea489/bin/clang-15+0x34f18a4)
   #2 0x000055724d0b7087 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-6b7e6ea489/bin/clang-15+0x3431087)
   #3 0x000055724d16fede llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-6b7e6ea489/bin/clang-15+0x34e9ede)
   #4 0x000055724ad4392b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x10bd92=
b)
   #5 0x000055724d0bdbac llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3437bac)
   #6 0x000055724dded260 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4167260)
   #7 0x000055724dde9162 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-6b7e6ea489/bin/clang-15+0x4163162)
   #8 0x000055724b7c9d07 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x1b43d07)
   #9 0x000055724c4a547d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055724c8ef457 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c69457)
   #11 0x000055724c8ef5d1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c695d1)
   #12 0x000055724c8f014f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c6a14f)
   #13 0x000055724d4a44c6 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x381e=
4c6)
   #14 0x000055724e10dca3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4487ca3)
   #15 0x000055724ec41a01 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-6b7e6ea489/bin/clang-15+0x4fbba01)
   #16 0x000055724e10d395 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-6b7e6ea489/bin/clang-15+0x4487395)
   #17 0x000055724db03831 clang::FrontendAction::Execute() (/opt/cross/clan=
g-6b7e6ea489/bin/clang-15+0x3e7d831)
   #18 0x000055724da98b1a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3e12b1a)
   #19 0x000055724dbca63b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3f446=
3b)
   #20 0x000055724ad44edc cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-6b7e6ea489/bin/clang-15+0x10beedc)
   #21 0x000055724ad41bab ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055724d92b3f5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055724d0b6f43 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3430f43)
   #24 0x000055724d92bcee clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055724d8ffde7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-6b7=
e6ea489/bin/clang-15+0x3c79de7)
   #26 0x000055724d9007c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c7a7c7)
   #27 0x000055724d909e19 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c83e19)
   #28 0x000055724ac8ed2f main (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x=
1008d2f)
   #29 0x00007f7a246957fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055724ad416ca _start (/opt/cross/clang-6b7e6ea489/bin/clang-15+=
0x10bb6ca)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 6b7e6ea489f6dd45a9b0d=
a9ac20871560917b9b0)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-6b7e6ea489/bin
   clang-15: note: diagnostic msg:
   Makefile arch certs crypto drivers fs include init ipc kernel lib mm net=
 scripts security sound source usr virt


vim +/to_mock_fence +25 drivers/dma-buf/st-dma-fence-unwrap.c

    21=09
    22	static inline struct mock_fence {
    23		struct dma_fence base;
    24		spinlock_t lock;
  > 25	} *to_mock_fence(struct dma_fence *f) {
    26		return container_of(f, struct mock_fence, base);
    27	}
    28=09
    29	static const char *mock_name(struct dma_fence *f)
    30	{
    31		return "mock";
    32	}
    33=09
    34	static const struct dma_fence_ops mock_ops =3D {
    35		.get_driver_name =3D mock_name,
    36		.get_timeline_name =3D mock_name,
    37	};
    38=09
    39	static struct dma_fence *mock_fence(void)
    40	{
    41		struct mock_fence *f;
    42=09
    43		f =3D kmalloc(sizeof(*f), GFP_KERNEL);
    44		if (!f)
    45			return NULL;
    46=09
    47		spin_lock_init(&f->lock);
    48		dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0);
    49=09
    50		return &f->base;
    51	}
    52=09
    53	static struct dma_fence *mock_array(unsigned int num_fences, ...)
    54	{
    55		struct dma_fence_array *array;
    56		struct dma_fence **fences;
    57		va_list valist;
    58		int i;
    59=09
    60		fences =3D kcalloc(num_fences, sizeof(*fences), GFP_KERNEL);
    61		if (!fences)
    62			return NULL;
    63=09
    64		va_start(valist, num_fences);
    65		for (i =3D 0; i < num_fences; ++i)
    66			fences[i] =3D va_arg(valist, typeof(*fences));
    67		va_end(valist);
    68=09
    69		array =3D dma_fence_array_create(num_fences, fences,
    70					       dma_fence_context_alloc(1),
    71					       1, false);
    72		if (!array)
    73			goto cleanup;
    74		return &array->base;
    75=09
    76	cleanup:
    77		for (i =3D 0; i < num_fences; ++i)
    78			dma_fence_put(fences[i]);
    79		kfree(fences);
    80		return NULL;
    81	}
    82=09
    83	static struct dma_fence *mock_chain(struct dma_fence *prev,
    84					    struct dma_fence *fence)
    85	{
    86		struct dma_fence_chain *f;
    87=09
    88		f =3D dma_fence_chain_alloc();
    89		if (!f) {
    90			dma_fence_put(prev);
    91			dma_fence_put(fence);
    92			return NULL;
    93		}
    94=09
    95		dma_fence_chain_init(f, prev, fence, 1);
    96		return &f->base;
    97	}
    98=09
    99	static int sanitycheck(void *arg)
   100	{
   101		struct dma_fence *f, *chain, *array;
   102		int err =3D 0;
   103=09
   104		f =3D mock_fence();
   105		if (!f)
   106			return -ENOMEM;
   107=09
   108		array =3D mock_array(1, f);
   109		if (!array)
   110			return -ENOMEM;
   111=09
   112		chain =3D mock_chain(NULL, array);
   113		if (!chain)
   114			return -ENOMEM;
   115=09
   116		dma_fence_signal(f);
   117		dma_fence_put(chain);
   118		return err;
   119	}
   120=09
   121	static int unwrap_array(void *arg)
   122	{
   123		struct dma_fence *fence, *f1, *f2, *array;
   124		struct dma_fence_unwrap iter;
 > 125		int err =3D 0;
   126=09
   127		f1 =3D mock_fence();
   128		if (!f1)
   129			return -ENOMEM;
   130=09
   131		f2 =3D mock_fence();
   132		if (!f2) {
   133			dma_fence_put(f1);
   134			return -ENOMEM;
   135		}
   136=09
   137		array =3D mock_array(2, f1, f2);
   138		if (!array)
   139			return -ENOMEM;
   140=09
   141		dma_fence_unwrap_for_each(fence, &iter, array) {
   142			if (fence =3D=3D f1) {
   143				f1 =3D NULL;
   144			} else if (fence =3D=3D f2) {
   145				f2 =3D NULL;
   146			} else {
   147				pr_err("Unexpected fence!\n");
   148				err =3D -EINVAL;
   149			}
   150		}
   151=09
   152		if (f1 || f2) {
   153			pr_err("Not all fences seen!\n");
   154			err =3D -EINVAL;
   155		}
   156=09
   157		dma_fence_signal(f1);
   158		dma_fence_signal(f2);
   159		dma_fence_put(array);
   160		return 0;
   161	}
   162=09

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp

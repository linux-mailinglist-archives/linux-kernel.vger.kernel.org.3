Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B669485DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbiAFBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:12:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:2015 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240018AbiAFBMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641431526; x=1672967526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a9cgR3ZklLRLXSGatWcixupy5U4iqX77Qg420ljyNvY=;
  b=WK3cuGwdrd0NmqsDPFpNHvZGyC27NZW5A1n1W5jsMP/oCywq3u1/1knR
   /ry9QbWBaam39pWKDOES2VxRN3njxAMmg9nanoZNK9HZiuMkahk6TOTvi
   VuTJLiz7DzZ1n2KMftVBDT3STq31A5RIytRF8Q7pjf8alpyom/5opJAes
   vsr73NANnXp2XQdrzGlcgHkAPU0gpoqo4ZqBY0SVAXo2F+cuGP5ApeSkF
   0q1uEYtlYrkEcn1FgsMKMEMnyg/T2yeqVc8JV4Yei12HXHceT740rSsgi
   IN8oFdH7nfWCiT0vLo3IpxGa3mHXFGEzmAkxX6PmjHRkO5FXmqlktwzce
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223250966"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="223250966"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="668287898"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jan 2022 17:12:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5HJw-000HCW-VW; Thu, 06 Jan 2022 01:12:00 +0000
Date:   Thu, 6 Jan 2022 09:11:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/5] nvmem: core: Remove unused devm_nvmem_unregister()
Message-ID: <202201060932.tcQFIVfQ-lkp@intel.com>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes char-misc/char-misc-testing linus=
/master v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/nvmem-core=
-Remove-unused-devm_nvmem_unregister/20220104-213933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/n=
ext
config: mips-randconfig-r002-20220105 (https://download.01.org/0day-ci/arch=
ive/20220106/202201060932.tcQFIVfQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e3=
0ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/7877de3d47433a75d2beea38b=
696b3c4fde62082
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/nvmem-core-Remove-=
unused-devm_nvmem_unregister/20220104-213933
        git checkout 7877de3d47433a75d2beea38b696b3c4fde62082
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvmem/core.c:946:12: warning: unused function 'devm_nvmem_match'
   static int devm_nvmem_match(struct device void void
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 157, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   PLEASE submit a bug report to https://bugs.llvm.org/ and include the cra=
sh backtrace, preprocessed source, and associated run script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/nvmem/.core.o.d -nostdinc -=
Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./include -I=
arch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi =
-I./include/generated/uapi -include include/linux/compiler-version.h -inclu=
de include/linux/kconfig.h -include include/linux/compiler_types.h -D__KERN=
EL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x=
84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBU=
ILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -f=
no-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-fu=
nction-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format=
-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dun=
known-warning-option -Werror=3Dignored-optimization-argument -mno-check-zer=
o-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_=
HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -mar=
ch=3Dmips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/ma=
ch-au1x00 -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tab=
les -fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-pack=
ed-member -O2 -Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fa=
llthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unus=
ed-const-variable -ftrivial-auto-var-init=3Dpattern -fno-stack-clash-protec=
tion -pg -falign-functions=3D64 -Wdeclaration-after-statement -Wvla -Wno-po=
inter-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=
=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unu=
sed-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-p=
rototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-va=
riable -Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-co=
mpare -Wno-type-limits -fsanitize=3Darray-bounds -fsanitize=3Dunreachable -=
fsanitize=3Dobject-size -fsanitize=3Denum -fsanitize-coverage=3Dtrace-pc -I=
 drivers/nvmem -I ./drivers/nvmem -ffunction-sections -fdata-sections -DKBU=
ILD_MODFILE=3D"drivers/nvmem/nvmem_core" -DKBUILD_BASENAME=3D"core" -DKBUIL=
D_MODNAME=3D"nvmem_core" -D__KBUILD_MODNAME=3Dkmod_nvmem_core -c -o drivers=
/nvmem/core.o drivers/nvmem/core.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/nvmem/core.c'.
   4. Running pass 'Mips Assembly Printer' on function '@kref_put'
   #0 0x000055c30463cb3f Signals.cpp:0:0
   #1 0x000055c30463aa8c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d5b6e30ed3/bin/clang-14+0x3401a8c)
   #2 0x000055c30457e667 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d5b6e30ed3/bin/clang-14+0x3345667)
   #3 0x000055c30463313e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d5b6e30ed3/bin/clang-14+0x33fa13e)
   #4 0x000055c3022b933b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x108033=
b)
   #5 0x000055c30458510c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x334c10c)
   #6 0x000055c3052679b8 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x402e9b8)
   #7 0x000055c305263759 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d5b6e30ed3/bin/clang-14+0x402a759)
   #8 0x000055c302d1482e llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x1adb82e)
   #9 0x000055c3039ab2fd llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055c303de3867 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa867)
   #11 0x000055c303de39e1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa9e1)
   #12 0x000055c303de4cbf llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2babcbf)
   #13 0x000055c30494e4fa clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3715=
4fa)
   #14 0x000055c30557bea3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x4342ea3)
   #15 0x000055c30607ffd9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d5b6e30ed3/bin/clang-14+0x4e46fd9)
   #16 0x000055c30557acff clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d5b6e30ed3/bin/clang-14+0x4341cff)
   #17 0x000055c304f7a001 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d5b6e30ed3/bin/clang-14+0x3d41001)
   #18 0x000055c304f11bda clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3cd8bda)
   #19 0x000055c30504307b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3e0a0=
7b)
   #20 0x000055c3022ba084 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d5b6e30ed3/bin/clang-14+0x1081084)
   #21 0x000055c3022b75cb ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055c304daeb15 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055c30457e523 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3345523)
   #24 0x000055c304daf40e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055c304d85ee7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d5b=
6e30ed3/bin/clang-14+0x3b4cee7)
   #26 0x000055c304d868c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b4d8c7)
   #27 0x000055c304d90139 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b57139)
   #28 0x000055c3021e219f main (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x=
fa919f)
   #29 0x00007fcd1a9e4d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055c3022b70ea _start (/opt/cross/clang-d5b6e30ed3/bin/clang-14+=
0x107e0ea)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project d5b6e30ed3acad794dd0a=
ec400e617daffc6cc3d)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d5b6e30ed3/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts security source=
 usr


vim +/devm_nvmem_match +946 drivers/nvmem/core.c

f1f50eca5f9052 Andrey Smirnov 2018-03-09  945 =20
f1f50eca5f9052 Andrey Smirnov 2018-03-09 @946  static int devm_nvmem_match(=
struct device *dev, void *res, void *data)
f1f50eca5f9052 Andrey Smirnov 2018-03-09  947  {
f1f50eca5f9052 Andrey Smirnov 2018-03-09  948  	struct nvmem_device **r =3D=
 res;
f1f50eca5f9052 Andrey Smirnov 2018-03-09  949 =20
f1f50eca5f9052 Andrey Smirnov 2018-03-09  950  	return *r =3D=3D data;
f1f50eca5f9052 Andrey Smirnov 2018-03-09  951  }
f1f50eca5f9052 Andrey Smirnov 2018-03-09  952 =20

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

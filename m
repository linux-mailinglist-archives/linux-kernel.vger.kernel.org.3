Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BFF4E7BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiCYTed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiCYTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:18 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91F3C14D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648236371; x=1679772371;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4oz8FNc7VQZ9nJ5DanNmi5yvkvN37sM5PxJBCPDtsg0=;
  b=ZzRGgyKVMruLsbTBNPqxy5GpZM2btJ2OmS7RVxv/DuzJECujC/JiwDn3
   dSC3yIseEngWDI1A4pC6Wd/9Jgh//fLMnufepASuDZrBRDywOfxal9Z91
   mhOnvbY+uPtjR07HuUwtCcejOi5sjMyj1dxrlVBUzA1EMnT4ueWZaXBii
   oTARgS8GGI9EfZMoKdJ8t4RzNlL625bVAxtjAwa7DflLRtCaoTMLCpUB3
   vYzb+Jmu/UyrP8N06nE29p1Z04oktFeKLpyL4SmJkphbbHQ4q7AsevfGt
   TBe4iM85QAHvd97PPwucnZfx8HfShypmzn9CI30fH9UQis4boAn54Rwdx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="319397981"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="319397981"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 11:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="650331665"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2022 11:19:04 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXoWd-000MTl-83; Fri, 25 Mar 2022 18:19:03 +0000
Date:   Sat, 26 Mar 2022 02:18:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>
Subject: [kraxel:drm-qemu-next 3/4]
 drivers/gpu/drm/virtio/virtgpu_ioctl.c:271:13: warning: unused variable
 'ret'
Message-ID: <202203260237.93aoZ8XS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kraxel.org/linux drm-qemu-next
head:   718c903962a65c138303c8933f8cdb44947b66a5
commit: c9940219406e5e5d0f449fc9dc1526806ec8683e [3/4] drm/virtio: Fix caps=
et-id query size
config: mips-buildonly-randconfig-r002-20220324 (https://download.01.org/0d=
ay-ci/archive/20220326/202203260237.93aoZ8XS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d95=
01cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        git remote add kraxel git://git.kraxel.org/linux
        git fetch --no-tags kraxel drm-qemu-next
        git checkout c9940219406e5e5d0f449fc9dc1526806ec8683e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/gpu/drm/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/virtio/virtgpu_ioctl.c:271:13: warning: unused variable =
'ret'
   int value, ret, sz =3D sizeof(int);
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
   0. Program arguments: clang -Wp,-MMD,drivers/gpu/drm/virtio/.virtgpu_ioc=
tl.o.d -nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iincl=
ude -I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/ua=
pi -Iinclude/uapi -I./include/generated/uapi -include include/linux/compile=
r-version.h -include include/linux/kconfig.h -include include/linux/compile=
r_types.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff80001000 -DLINKER=
_LOAD_ADDRESS=3D0x80001000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-pref=
ix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes=
 -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -We=
rror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dretur=
n-type -Wno-format-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrat=
ed-as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argum=
ent -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -=
msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fn=
o-stack-check -march=3Dmips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/m=
ips/include/asm/mach-bcm47xx -Iarch/mips/include/asm/mach-generic -fno-asyn=
chronous-unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -=
Wno-address-of-packed-member -Os -Wframe-larger-than=3D1024 -fno-stack-prot=
ector -Wimplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set=
-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dpattern -fno=
-stack-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointe=
r-sign -Wcast-function-type -Wno-array-bounds -fno-strict-overflow -fno-sta=
ck-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -=
Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attri=
bute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wu=
nused-but-set-variable -Wunused-const-variable -Wno-missing-field-initializ=
ers -Wno-sign-compare -Wno-type-limits -I drivers/gpu/drm/virtio -I ./drive=
rs/gpu/drm/virtio -DKBUILD_MODFILE=3D"drivers/gpu/drm/virtio/virtio-gpu" -D=
KBUILD_BASENAME=3D"virtgpu_ioctl" -DKBUILD_MODNAME=3D"virtio_gpu" -D__KBUIL=
D_MODNAME=3Dkmod_virtio_gpu -c -o drivers/gpu/drm/virtio/virtgpu_ioctl.o dr=
ivers/gpu/drm/virtio/virtgpu_ioctl.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/gpu/drm/virti=
o/virtgpu_ioctl.c'.
   4. Running pass 'Mips Assembly Printer' on function '@virtio_gpu_execbuf=
fer_ioctl'
   #0 0x0000555bdad583af Signals.cpp:0:0
   #1 0x0000555bdad561d4 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-0f6d9501cf/bin/clang-15+0x34aa1d4)
   #2 0x0000555bdac95b87 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-0f6d9501cf/bin/clang-15+0x33e9b87)
   #3 0x0000555bdad4e80e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-0f6d9501cf/bin/clang-15+0x34a280e)
   #4 0x0000555bd894b40b (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x109f40=
b)
   #5 0x0000555bdac9c6ac llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x33f06ac)
   #6 0x0000555bdb9b8780 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x410c780)
   #7 0x0000555bdb9b46b4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-0f6d9501cf/bin/clang-15+0x41086b4)
   #8 0x0000555bd93c67f7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x1b1a7f7)
   #9 0x0000555bda0973dd llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000555bda4def67 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x2c32f67)
   #11 0x0000555bda4df0e1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-0f6d9501cf/bin/clang-15+0x2c330e1)
   #12 0x0000555bda4dfc5f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x2c33c5f)
   #13 0x0000555bdb078777 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x37cc=
777)
   #14 0x0000555bdbcd88d3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x442c8d3)
   #15 0x0000555bdc7faaa1 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-0f6d9501cf/bin/clang-15+0x4f4eaa1)
   #16 0x0000555bdbcd7fb5 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-0f6d9501cf/bin/clang-15+0x442bfb5)
   #17 0x0000555bdb6d1aa1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-0f6d9501cf/bin/clang-15+0x3e25aa1)
   #18 0x0000555bdb66733a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x3dbb33a)
   #19 0x0000555bdb7976cb (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x3eeb6=
cb)
   #20 0x0000555bd894c9bc cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-0f6d9501cf/bin/clang-15+0x10a09bc)
   #21 0x0000555bd894968b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000555bdb4fdf45 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000555bdac95a43 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x33e9a43)
   #24 0x0000555bdb4fe83e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000555bdb4d3037 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-0f6=
d9501cf/bin/clang-15+0x3c27037)
   #26 0x0000555bdb4d3a17 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x3c27a17)
   #27 0x0000555bdb4dd069 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x3c31069)
   #28 0x0000555bd889695f main (/opt/cross/clang-0f6d9501cf/bin/clang-15+0x=
fea95f)
   #29 0x00007f85b768bd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x0000555bd89491aa _start (/opt/cross/clang-0f6d9501cf/bin/clang-15+=
0x109d1aa)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 0f6d9501cf49ce0293709=
9350d08f20c4af86f3d)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-0f6d9501cf/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts source usr

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SSB_EMBEDDED
   Depends on SSB && SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
   Selected by
   - BCM47XX_SSB && BCM47XX


vim +/ret +271 drivers/gpu/drm/virtio/virtgpu_ioctl.c

   265=09
   266	static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *d=
ata,
   267					     struct drm_file *file)
   268	{
   269		struct virtio_gpu_device *vgdev =3D dev->dev_private;
   270		struct drm_virtgpu_getparam *param =3D data;
 > 271		int value, ret, sz =3D sizeof(int);
   272		uint64_t value64;
   273=09
   274		switch (param->param) {
   275		case VIRTGPU_PARAM_3D_FEATURES:
   276			value =3D vgdev->has_virgl_3d ? 1 : 0;
   277			break;
   278		case VIRTGPU_PARAM_CAPSET_QUERY_FIX:
   279			value =3D 1;
   280			break;
   281		case VIRTGPU_PARAM_RESOURCE_BLOB:
   282			value =3D vgdev->has_resource_blob ? 1 : 0;
   283			break;
   284		case VIRTGPU_PARAM_HOST_VISIBLE:
   285			value =3D vgdev->has_host_visible ? 1 : 0;
   286			break;
   287		case VIRTGPU_PARAM_CROSS_DEVICE:
   288			value =3D vgdev->has_resource_assign_uuid ? 1 : 0;
   289			break;
   290		case VIRTGPU_PARAM_CONTEXT_INIT:
   291			value =3D vgdev->has_context_init ? 1 : 0;
   292			break;
   293		case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:
   294			value64 =3D vgdev->capset_id_mask;
   295			sz =3D sizeof(value64);
   296			break;
   297		default:
   298			return -EINVAL;
   299		}
   300=09
   301		if (sz =3D=3D sizeof(int)) {
   302			if (copy_to_user(u64_to_user_ptr(param->value), &value, sz))
   303				return -EFAULT;
   304		} else {
   305			if (copy_to_user(u64_to_user_ptr(param->value), &value64, sz))
   306				return -EFAULT;
   307		}
   308=09
   309		return 0;
   310	}
   311=09

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp

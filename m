Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255CE46B989
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhLGKz1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 05:55:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:57266 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhLGKz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:55:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323807456"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="323807456"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611630779"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 02:51:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muY4e-000MTV-L4; Tue, 07 Dec 2021 10:51:52 +0000
Date:   Tue, 7 Dec 2021 18:51:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fbdev: savagefb: make a variable local
Message-ID: <202112071822.Ry2XAYAN-lkp@intel.com>
References: <20211203095715.GD2480@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20211203095715.GD2480@kili>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc4 next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dan-Carpenter/fbdev-savagefb-make-a-variable-local/20211203-175849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5f58da2befa58edf3a70b91ed87ed9bf77f1e70e
config: mips-buildonly-randconfig-r004-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071822.Ry2XAYAN-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f50be8eb0a12a61d23db6cda452c693001d76898)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/9ea7012b220fc1bd8aa2f0a65b97403cea046343
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dan-Carpenter/fbdev-savagefb-make-a-variable-local/20211203-175849
        git checkout 9ea7012b220fc1bd8aa2f0a65b97403cea046343
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/video/fbdev/savage/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/savage/savagefb_driver.c:2173:17: warning: unused variable 'edid'
   unsigned char
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   PLEASE submit a bug report to https://bugs.llvm.org/ and include the crash backtrace, preprocessed source, and associated run script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/video/fbdev/savage/.savagefb_driver.o.d -nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler-version.h -include include/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=0xffffffff80100000 -DLINKER_LOAD_ADDRESS=0xffffffff80100000 -DDATAOFFSET=0 -Qunused-arguments -fmacro-prefix-map== -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Wno-format-security -std=gnu89 --target=mips64el-linux -fintegrated-as -Werror=unknown-warning-option -Werror=ignored-optimization-argument -mabi=64 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -march=mips64 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-malta -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-than=2048 -fstack-protector -Wimplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unused-const-variable -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -fno-stack-clash-protection -pg -falign-functions=64 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -I drivers/video/fbdev/savage -I ./drivers/video/fbdev/savage -ffunction-sections -fdata-sections -DKBUILD_MODFILE="drivers/video/fbdev/savage/savagefb" -DKBUILD_BASENAME="savagefb_driver" -DKBUILD_MODNAME="savagefb" -D__KBUILD_MODNAME=kmod_savagefb -c -o drivers/video/fbdev/savage/savagefb_driver.o drivers/video/fbdev/savage/savagefb_driver.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/video/fbdev/savage/savagefb_driver.c'.
   4. Running pass 'Mips Assembly Printer' on function '@savagefb_probe'
   #0 0x000055c047cb37df Signals.cpp:0:0
   #1 0x000055c047cb16fc llvm::sys::CleanupOnSignal(unsigned long) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x339a6fc)
   #2 0x000055c047bfef87 llvm::CrashRecoveryContext::HandleExit(int) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x32e7f87)
   #3 0x000055c047ca9dae llvm::sys::Process::Exit(int, bool) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3392dae)
   #4 0x000055c04597378b (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x105c78b)
   #5 0x000055c047c05a2c llvm::report_fatal_error(llvm::Twine const&, bool) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x32eea2c)
   #6 0x000055c0488b15e8 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr const (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3f9a5e8)
   #7 0x000055c0488ad3e9 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3f963e9)
   #8 0x000055c0463c0afe llvm::MipsAsmPrinter::runOnMachineFunction(llvm::MachineFunction&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x1aa9afe)
   #9 0x000055c047045a1d llvm::MachineFunctionPass::runOnFunction(llvm::Function&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055c04746dfc7 llvm::FPPassManager::runOnFunction(llvm::Function&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x2b56fc7)
   #11 0x000055c04746e141 llvm::FPPassManager::runOnModule(llvm::Module&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x2b57141)
   #12 0x000055c04746f41f llvm::legacy::PassManagerImpl::run(llvm::Module&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x2b5841f)
   #13 0x000055c047fbab9a clang::EmitBackendOutput(clang::DiagnosticsEngine&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x36a3b9a)
   #14 0x000055c048c39443 clang::BackendConsumer::HandleTranslationUnit(clang::ASTContext&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x4322443)
   #15 0x000055c049738d99 clang::ParseAST(clang::Sema&, bool, bool) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x4e21d99)
   #16 0x000055c048c3829f clang::CodeGenAction::ExecuteAction() (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x432129f)
   #17 0x000055c0485c1401 clang::FrontendAction::Execute() (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3caa401)
   #18 0x000055c0485594ea clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3c424ea)
   #19 0x000055c04868a5ab (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3d735ab)
   #20 0x000055c0459744d4 cc1_main(llvm::ArrayRef<char char (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x105d4d4)
   #21 0x000055c045971a1b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.cpp:0:0
   #22 0x000055c0483fc4b5 void llvm::function_ref<void ()>::callback_fn<clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055c047bfee43 llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x32e7e43)
   #24 0x000055c0483fcdb7 clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055c0483d40c7 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3abd0c7)
   #26 0x000055c0483d4aa7 clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command >&) const (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3abdaa7)
   #27 0x000055c0483ddde9 clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::Command >&) (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x3ac6de9)
   #28 0x000055c04589f17f main (/opt/cross/clang-097a1cb1d5/bin/clang-14+0xf8817f)
   #29 0x00007f312c6b8d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x26d0a)
   #30 0x000055c04597153a _start (/opt/cross/clang-097a1cb1d5/bin/clang-14+0x105a53a)
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-097a1cb1d5/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts source usr


vim +/edid +2173 drivers/video/fbdev/savage/savagefb_driver.c

  2167	
  2168	static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
  2169	{
  2170		struct fb_info *info;
  2171		struct savagefb_par *par;
  2172		u_int h_sync, v_sync;
> 2173		unsigned char *edid;
  2174		int err, lpitch;
  2175		int video_len;
  2176	
  2177		DBG("savagefb_probe");
  2178	
  2179		info = framebuffer_alloc(sizeof(struct savagefb_par), &dev->dev);
  2180		if (!info)
  2181			return -ENOMEM;
  2182		par = info->par;
  2183		mutex_init(&par->open_lock);
  2184		err = pci_enable_device(dev);
  2185		if (err)
  2186			goto failed_enable;
  2187	
  2188		if ((err = pci_request_regions(dev, "savagefb"))) {
  2189			printk(KERN_ERR "cannot request PCI regions\n");
  2190			goto failed_enable;
  2191		}
  2192	
  2193		err = -ENOMEM;
  2194	
  2195		if ((err = savage_init_fb_info(info, dev, id)))
  2196			goto failed_init;
  2197	
  2198		err = savage_map_mmio(info);
  2199		if (err)
  2200			goto failed_mmio;
  2201	
  2202		video_len = savage_init_hw(par);
  2203		/* FIXME: can't be negative */
  2204		if (video_len < 0) {
  2205			err = video_len;
  2206			goto failed_mmio;
  2207		}
  2208	
  2209		err = savage_map_video(info, video_len);
  2210		if (err)
  2211			goto failed_video;
  2212	
  2213		INIT_LIST_HEAD(&info->modelist);
  2214	#if defined(CONFIG_FB_SAVAGE_I2C)
  2215		savagefb_create_i2c_busses(info);
  2216		savagefb_probe_i2c_connector(info, &edid);
  2217		fb_edid_to_monspecs(edid, &info->monspecs);
  2218		kfree(edid);
  2219		fb_videomode_to_modelist(info->monspecs.modedb,
  2220					 info->monspecs.modedb_len,
  2221					 &info->modelist);
  2222	#endif
  2223		info->var = savagefb_var800x600x8;
  2224		/* if a panel was detected, default to a CVT mode instead */
  2225		if (par->SavagePanelWidth) {
  2226			struct fb_videomode cvt_mode;
  2227	
  2228			memset(&cvt_mode, 0, sizeof(cvt_mode));
  2229			cvt_mode.xres = par->SavagePanelWidth;
  2230			cvt_mode.yres = par->SavagePanelHeight;
  2231			cvt_mode.refresh = 60;
  2232			/* FIXME: if we know there is only the panel
  2233			 * we can enable reduced blanking as well */
  2234			if (fb_find_mode_cvt(&cvt_mode, 0, 0))
  2235				printk(KERN_WARNING "No CVT mode found for panel\n");
  2236			else if (fb_find_mode(&info->var, info, NULL, NULL, 0,
  2237					      &cvt_mode, 0) != 3)
  2238				info->var = savagefb_var800x600x8;
  2239		}
  2240	
  2241		if (mode_option) {
  2242			fb_find_mode(&info->var, info, mode_option,
  2243				     info->monspecs.modedb, info->monspecs.modedb_len,
  2244				     NULL, 8);
  2245		} else if (info->monspecs.modedb != NULL) {
  2246			const struct fb_videomode *mode;
  2247	
  2248			mode = fb_find_best_display(&info->monspecs, &info->modelist);
  2249			savage_update_var(&info->var, mode);
  2250		}
  2251	
  2252		/* maximize virtual vertical length */
  2253		lpitch = info->var.xres_virtual*((info->var.bits_per_pixel + 7) >> 3);
  2254		info->var.yres_virtual = info->fix.smem_len/lpitch;
  2255	
  2256		if (info->var.yres_virtual < info->var.yres) {
  2257			err = -ENOMEM;
  2258			goto failed;
  2259		}
  2260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

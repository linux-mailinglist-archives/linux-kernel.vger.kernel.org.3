Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705E549FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbiFMUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351492AbiFMUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:44:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324213DC0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655149920; x=1686685920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ys+Jz00mWBLR7AMJLZPSeRatbOei+s3IvuUxFwLQVjQ=;
  b=TozePgwTp2CTlSbPMH08H4ZKFDjPMI+hXhWPD0aGcfsQBL8OEVoXgDrQ
   eLsxnqy7Bsg9DrcJSufwNfwdpXQMJAeZZO66e/7mroIRR83EEsi4AcWXj
   uLkYRd6easbj3xYak4JSvPWpsrvfBLlKcYwfpYICLsKaWpnWyK0Djzku2
   BbA5X6AAaoQTWkKzTwvDk1Hxt6JlNyQFeX5RGxM+x1XyWbGTYXCRkeiou
   I7SnDPsdjV8qzjWuJQZb//+nNvO3J/WlSoXqIEwVCaThLO88QOghB2bY2
   8lyuClddSnAw+12lPzEw8wr0N0d4XXmXfJKNcmzLqjBtXbFQ2Ds9/G/fB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258838083"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="258838083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 12:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="686235486"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2022 12:51:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0q6Q-000L5l-Du;
        Mon, 13 Jun 2022 19:51:58 +0000
Date:   Tue, 14 Jun 2022 03:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/machine_kexec.c:69:55: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202206140333.5MSD46Kd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: b7fb4d78a6ade6026d9e5cf438c2a46ab962e032 RISC-V: use memcpy for kexec_file mode
date:   4 weeks ago
config: riscv-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140333.5MSD46Kd-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7fb4d78a6ade6026d9e5cf438c2a46ab962e032
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7fb4d78a6ade6026d9e5cf438c2a46ab962e032
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/machine_kexec.c:69:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __user *buf @@
   arch/riscv/kernel/machine_kexec.c:69:55: sparse:     expected void const *
   arch/riscv/kernel/machine_kexec.c:69:55: sparse:     got void [noderef] __user *buf
   arch/riscv/kernel/machine_kexec.c:169:1: sparse: sparse: symbol 'machine_kexec' redeclared with different type (different modifiers):
   arch/riscv/kernel/machine_kexec.c:169:1: sparse:    void extern [addressable] [noreturn] [toplevel] machine_kexec( ... )
   arch/riscv/kernel/machine_kexec.c: note: in included file:
   include/linux/kexec.h:325:13: sparse: note: previously declared as:
   include/linux/kexec.h:325:13: sparse:    void extern [addressable] [toplevel] machine_kexec( ... )

vim +69 arch/riscv/kernel/machine_kexec.c

    42	
    43	/*
    44	 * machine_kexec_prepare - Initialize kexec
    45	 *
    46	 * This function is called from do_kexec_load, when the user has
    47	 * provided us with an image to be loaded. Its goal is to validate
    48	 * the image and prepare the control code buffer as needed.
    49	 * Note that kimage_alloc_init has already been called and the
    50	 * control buffer has already been allocated.
    51	 */
    52	int
    53	machine_kexec_prepare(struct kimage *image)
    54	{
    55		struct kimage_arch *internal = &image->arch;
    56		struct fdt_header fdt = {0};
    57		void *control_code_buffer = NULL;
    58		unsigned int control_code_buffer_sz = 0;
    59		int i = 0;
    60	
    61		kexec_image_info(image);
    62	
    63		/* Find the Flattened Device Tree and save its physical address */
    64		for (i = 0; i < image->nr_segments; i++) {
    65			if (image->segment[i].memsz <= sizeof(fdt))
    66				continue;
    67	
    68			if (image->file_mode)
  > 69				memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
    70			else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
    71				continue;
    72	
    73			if (fdt_check_header(&fdt))
    74				continue;
    75	
    76			internal->fdt_addr = (unsigned long) image->segment[i].mem;
    77			break;
    78		}
    79	
    80		if (!internal->fdt_addr) {
    81			pr_err("Device tree not included in the provided image\n");
    82			return -EINVAL;
    83		}
    84	
    85		/* Copy the assembler code for relocation to the control page */
    86		if (image->type != KEXEC_TYPE_CRASH) {
    87			control_code_buffer = page_address(image->control_code_page);
    88			control_code_buffer_sz = page_size(image->control_code_page);
    89	
    90			if (unlikely(riscv_kexec_relocate_size > control_code_buffer_sz)) {
    91				pr_err("Relocation code doesn't fit within a control page\n");
    92				return -EINVAL;
    93			}
    94	
    95			memcpy(control_code_buffer, riscv_kexec_relocate,
    96				riscv_kexec_relocate_size);
    97	
    98			/* Mark the control page executable */
    99			set_memory_x((unsigned long) control_code_buffer, 1);
   100		}
   101	
   102		return 0;
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

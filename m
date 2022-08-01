Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35D587139
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiHATNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiHATMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:12:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76EE83
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659380985; x=1690916985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tom3g7yIzEAkO9xNQcySMRrkC1MbjgY8VnF5cjIrsLY=;
  b=kT1Wp3RKwtcZoI6C3NwEOmBzC3lsR/R9eXUA8MFFLZvKGWoBBRBcvezS
   naJEj9RVhq0EDI/Kvul3lIVq8DAVMfOHP+ZFFgQ7xgjxJeRY2/e2B5dJ0
   JNOH6z9vIUfP1+PGudasm26Md83m5hrlT/qcaJu+SsTRK/TsO1M4RXbgU
   XJqw4EIMmKr0G0yido9iZ7ViIBrKQtebVrzOXZyDzgqhA8gVKNm9y43kP
   R1SlN8tZfyl3lnyPffL65X30BxqxSs3WvuT83deTZxH1qOq1GoB4+VXIU
   KNzUiXqEcp4R8IWelbD1wtBbdKED6r0X/vVkcow9ZaA8HFAmc/UHbPdlZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290438365"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="290438365"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="929670087"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2022 12:09:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIanO-000FEv-1i;
        Mon, 01 Aug 2022 19:09:42 +0000
Date:   Tue, 2 Aug 2022 03:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/machine_kexec.c:69:55: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202208020251.Nj0b2oNq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cec3f24a7cedc726f8790d693aaff2c535dc4ce
commit: b7fb4d78a6ade6026d9e5cf438c2a46ab962e032 RISC-V: use memcpy for kexec_file mode
date:   2 months ago
config: riscv-randconfig-s041-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020251.Nj0b2oNq-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7fb4d78a6ade6026d9e5cf438c2a46ab962e032
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7fb4d78a6ade6026d9e5cf438c2a46ab962e032
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

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

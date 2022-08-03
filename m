Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A69589223
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbiHCSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiHCSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:19:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC410B6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659550760; x=1691086760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w19o1hnNnq6OOfS+LaeNYW801PSw3dXJL03kRZ3EDwQ=;
  b=TPaeG771AU6Alh33SMn+lTWO0WQ+c6NKUxC/ddoRUySS+k2ieSWX2i3Q
   idUSRmQf4YT8PmXnr6tuA06yiBwFhIr+o1ri/rW4+0uzyo2yBqKxHiSpK
   5z1Xe93L4qpLLZn06+sXVjOiayIvC2/2bZHPwd003e+W6VTRvmHI44sD3
   GdO4RLxjiXAI6ElaMIddUSj8koRVGmWJg/hmVItd0QNUYk8Q2WP1vOimV
   CA8VewKL/fvy04/fUYbJSdztGATCSFYUrRjKtuvgx7LCvveW0d4JAushj
   ZOasIaaUTJUaufwPzUJvWI2yYO4C5oyiZ2Rcq31MUCwwRJ0nLEUkPTdhs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="289755653"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="289755653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578754816"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 11:19:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJIxh-000HXf-0t;
        Wed, 03 Aug 2022 18:19:17 +0000
Date:   Thu, 4 Aug 2022 02:18:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Fedorenko <vadfed@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kuba:dpll-changes 2062/2068] drivers/ptp/ptp_ocp.c:3721:48: error:
 implicit declaration of function 'dpll_priv'
Message-ID: <202208040249.V90ifuu7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git dpll-changes
head:   9fe25d755c104116a844f268fb6bae41569e28fb
commit: 48c4cd1d7a94aeb6ab460989f1561117291092a5 [2062/2068] ptp_ocp: implement DPLL ops
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220804/202208040249.V90ifuu7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git/commit/?id=48c4cd1d7a94aeb6ab460989f1561117291092a5
        git remote add kuba https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
        git fetch --no-tags kuba dpll-changes
        git checkout 48c4cd1d7a94aeb6ab460989f1561117291092a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_get_status':
>> drivers/ptp/ptp_ocp.c:3721:48: error: implicit declaration of function 'dpll_priv' [-Werror=implicit-function-declaration]
    3721 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                                                ^~~~~~~~~
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_sma_get_dpll_type':
   drivers/ptp/ptp_ocp.c:3743:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3743 |                 tbl = bp->sma_op->tbl[0];
         |                     ^
   drivers/ptp/ptp_ocp.c:3745:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3745 |                 tbl = bp->sma_op->tbl[1];
         |                     ^
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_type_supported':
   drivers/ptp/ptp_ocp.c:3754:36: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3754 |         struct ocp_selector *tbl = bp->sma_op->tbl[dir];
         |                                    ^~
   drivers/ptp/ptp_ocp.c: At top level:
>> drivers/ptp/ptp_ocp.c:3794:15: error: variable 'dpll_ops' has initializer but incomplete type
    3794 | static struct dpll_device_ops dpll_ops = {
         |               ^~~~~~~~~~~~~~~
>> drivers/ptp/ptp_ocp.c:3795:10: error: 'struct dpll_device_ops' has no member named 'get_status'
    3795 |         .get_status             = ptp_ocp_dpll_get_status,
         |          ^~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3795:35: warning: excess elements in struct initializer
    3795 |         .get_status             = ptp_ocp_dpll_get_status,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3795:35: note: (near initialization for 'dpll_ops')
>> drivers/ptp/ptp_ocp.c:3796:10: error: 'struct dpll_device_ops' has no member named 'get_lock_status'
    3796 |         .get_lock_status        = ptp_ocp_dpll_get_lock_status,
         |          ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3796:35: warning: excess elements in struct initializer
    3796 |         .get_lock_status        = ptp_ocp_dpll_get_lock_status,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3796:35: note: (near initialization for 'dpll_ops')
>> drivers/ptp/ptp_ocp.c:3797:10: error: 'struct dpll_device_ops' has no member named 'get_source_type'
    3797 |         .get_source_type        = ptp_ocp_dpll_get_source_type,
         |          ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3797:35: warning: excess elements in struct initializer
    3797 |         .get_source_type        = ptp_ocp_dpll_get_source_type,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3797:35: note: (near initialization for 'dpll_ops')
>> drivers/ptp/ptp_ocp.c:3798:10: error: 'struct dpll_device_ops' has no member named 'get_source_supported'
    3798 |         .get_source_supported   = ptp_ocp_dpll_get_source_supported,
         |          ^~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3798:35: warning: excess elements in struct initializer
    3798 |         .get_source_supported   = ptp_ocp_dpll_get_source_supported,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3798:35: note: (near initialization for 'dpll_ops')
>> drivers/ptp/ptp_ocp.c:3799:10: error: 'struct dpll_device_ops' has no member named 'get_output_type'
    3799 |         .get_output_type        = ptp_ocp_dpll_get_output_type,
         |          ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3799:35: warning: excess elements in struct initializer
    3799 |         .get_output_type        = ptp_ocp_dpll_get_output_type,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3799:35: note: (near initialization for 'dpll_ops')
>> drivers/ptp/ptp_ocp.c:3800:10: error: 'struct dpll_device_ops' has no member named 'get_output_supported'
    3800 |         .get_output_supported   = ptp_ocp_dpll_get_output_supported,
         |          ^~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3800:35: warning: excess elements in struct initializer
    3800 |         .get_output_supported   = ptp_ocp_dpll_get_output_supported,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3800:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_probe':
>> drivers/ptp/ptp_ocp.c:3859:20: error: implicit declaration of function 'dpll_device_alloc'; did you mean 'acpi_spi_device_alloc'? [-Werror=implicit-function-declaration]
    3859 |         bp->dpll = dpll_device_alloc(&dpll_ops, ARRAY_SIZE(bp->sma), ARRAY_SIZE(bp->sma), bp);
         |                    ^~~~~~~~~~~~~~~~~
         |                    acpi_spi_device_alloc
   drivers/ptp/ptp_ocp.c:3859:18: warning: assignment to 'struct dpll_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3859 |         bp->dpll = dpll_device_alloc(&dpll_ops, ARRAY_SIZE(bp->sma), ARRAY_SIZE(bp->sma), bp);
         |                  ^
>> drivers/ptp/ptp_ocp.c:3864:9: error: implicit declaration of function 'dpll_device_register'; did you mean 'mtd_device_register'? [-Werror=implicit-function-declaration]
    3864 |         dpll_device_register(bp->dpll);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         mtd_device_register
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_remove':
>> drivers/ptp/ptp_ocp.c:3883:9: error: implicit declaration of function 'dpll_device_unregister'; did you mean 'mtd_device_unregister'? [-Werror=implicit-function-declaration]
    3883 |         dpll_device_unregister(bp->dpll);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         mtd_device_unregister
>> drivers/ptp/ptp_ocp.c:3884:9: error: implicit declaration of function 'dpll_device_free' [-Werror=implicit-function-declaration]
    3884 |         dpll_device_free(bp->dpll);
         |         ^~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c: At top level:
>> drivers/ptp/ptp_ocp.c:3794:31: error: storage size of 'dpll_ops' isn't known
    3794 | static struct dpll_device_ops dpll_ops = {
         |                               ^~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/dpll/dpll_core.c:77:21: error: conflicting types for 'dpll_device_alloc'; have 'struct dpll_device *(struct dpll_device_ops *, int,  const char *, int,  void *)'
      77 | struct dpll_device *dpll_device_alloc(struct dpll_device_ops *ops, int sources_count,
         |                     ^~~~~~~~~~~~~~~~~
   In file included from drivers/dpll/dpll_core.h:9,
                    from drivers/dpll/dpll_core.c:15:
   include/linux/dpll.h:23:21: note: previous declaration of 'dpll_device_alloc' with type 'struct dpll_device *(struct dpll_device_ops *, int,  int,  void *)'
      23 | struct dpll_device *dpll_device_alloc(struct dpll_device_ops *ops, int sources_count,
         |                     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dpll/dpll_core.c:10:
   drivers/dpll/dpll_core.c:110:19: error: conflicting types for 'dpll_device_alloc'; have 'struct dpll_device *(struct dpll_device_ops *, int,  const char *, int,  void *)'
     110 | EXPORT_SYMBOL_GPL(dpll_device_alloc);
         |                   ^~~~~~~~~~~~~~~~~
   include/linux/export.h:87:28: note: in definition of macro '___EXPORT_SYMBOL'
      87 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
     147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:151:41: note: in expansion of macro '_EXPORT_SYMBOL'
     151 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "_gpl")
         |                                         ^~~~~~~~~~~~~~
   drivers/dpll/dpll_core.c:110:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     110 | EXPORT_SYMBOL_GPL(dpll_device_alloc);
         | ^~~~~~~~~~~~~~~~~
   In file included from drivers/dpll/dpll_core.h:9,
                    from drivers/dpll/dpll_core.c:15:
   include/linux/dpll.h:23:21: note: previous declaration of 'dpll_device_alloc' with type 'struct dpll_device *(struct dpll_device_ops *, int,  int,  void *)'
      23 | struct dpll_device *dpll_device_alloc(struct dpll_device_ops *ops, int sources_count,
         |                     ^~~~~~~~~~~~~~~~~
--
   drivers/dpll/dpll_netlink.c: In function 'dpll_genl_cmd_set_source':
>> drivers/dpll/dpll_netlink.c:227:39: error: initialization of 'const struct nlattr **' from incompatible pointer type 'struct nlattr **' [-Werror=incompatible-pointer-types]
     227 |         const struct nlattr **attrs = p->attrs;
         |                                       ^
   drivers/dpll/dpll_netlink.c: In function 'dpll_genl_cmd_set_output':
   drivers/dpll/dpll_netlink.c:252:39: error: initialization of 'const struct nlattr **' from incompatible pointer type 'struct nlattr **' [-Werror=incompatible-pointer-types]
     252 |         const struct nlattr **attrs = p->attrs;
         |                                       ^
   drivers/dpll/dpll_netlink.c: At top level:
   drivers/dpll/dpll_netlink.c:600:13: warning: no previous prototype for 'dpll_netlink_fini' [-Wmissing-prototypes]
     600 | void __exit dpll_netlink_fini(void)
         |             ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/dpll_priv +3721 drivers/ptp/ptp_ocp.c

  3718	
  3719	static int ptp_ocp_dpll_get_status(struct dpll_device *dpll)
  3720	{
> 3721		struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
  3722		int sync;
  3723	
  3724		sync = ioread32(&bp->reg->status) & OCP_STATUS_IN_SYNC;
  3725		return sync;
  3726	}
  3727	
  3728	static int ptp_ocp_dpll_get_lock_status(struct dpll_device *dpll)
  3729	{
  3730		struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
  3731		int sync;
  3732	
  3733		sync = ioread32(&bp->reg->status) & OCP_STATUS_IN_SYNC;
  3734		return sync;
  3735	}
  3736	
  3737	static int ptp_ocp_sma_get_dpll_type(struct ptp_ocp *bp, int sma_nr)
  3738	{
  3739		struct ocp_selector *tbl;
  3740		u32 val;
  3741	
  3742		if (bp->sma[sma_nr].mode == SMA_MODE_IN)
  3743			tbl = bp->sma_op->tbl[0];
  3744		else
  3745			tbl = bp->sma_op->tbl[1];
  3746	
  3747		val = ptp_ocp_sma_get(bp, sma_nr);
  3748		return tbl[val].dpll_type;
  3749	}
  3750	
  3751	static int ptp_ocp_dpll_type_supported(struct dpll_device *dpll, int sma, int type, int dir)
  3752	{
  3753		struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
  3754		struct ocp_selector *tbl = bp->sma_op->tbl[dir];
  3755		int i;
  3756	
  3757		for (i = 0; i < sizeof(*tbl); i++) {
  3758			if (tbl[i].dpll_type == type)
  3759				return 1;
  3760		}
  3761		return 0;
  3762	}
  3763	
  3764	static int ptp_ocp_dpll_get_source_type(struct dpll_device *dpll, int sma)
  3765	{
  3766		struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
  3767	
  3768		if (bp->sma[sma].mode != SMA_MODE_IN)
  3769			return -1;
  3770	
  3771		return ptp_ocp_sma_get_dpll_type(bp, sma);
  3772	}
  3773	
  3774	static int ptp_ocp_dpll_get_source_supported(struct dpll_device *dpll, int sma, int type)
  3775	{
  3776		return ptp_ocp_dpll_type_supported(dpll, sma, type, 0);
  3777	}
  3778	
  3779	static int ptp_ocp_dpll_get_output_type(struct dpll_device *dpll, int sma)
  3780	{
  3781		struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
  3782	
  3783		if (bp->sma[sma].mode != SMA_MODE_OUT)
  3784			return -1;
  3785	
  3786		return ptp_ocp_sma_get_dpll_type(bp, sma);
  3787	}
  3788	
  3789	static int ptp_ocp_dpll_get_output_supported(struct dpll_device *dpll, int sma, int type)
  3790	{
  3791		return ptp_ocp_dpll_type_supported(dpll, sma, type, 1);
  3792	}
  3793	
> 3794	static struct dpll_device_ops dpll_ops = {
> 3795		.get_status		= ptp_ocp_dpll_get_status,
> 3796		.get_lock_status	= ptp_ocp_dpll_get_lock_status,
> 3797		.get_source_type	= ptp_ocp_dpll_get_source_type,
> 3798		.get_source_supported	= ptp_ocp_dpll_get_source_supported,
> 3799		.get_output_type	= ptp_ocp_dpll_get_output_type,
> 3800		.get_output_supported	= ptp_ocp_dpll_get_output_supported,
  3801	};
  3802	
  3803	static int
  3804	ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  3805	{
  3806		struct devlink *devlink;
  3807		struct ptp_ocp *bp;
  3808		int err;
  3809	
  3810		devlink = devlink_alloc(&ptp_ocp_devlink_ops, sizeof(*bp), &pdev->dev);
  3811		if (!devlink) {
  3812			dev_err(&pdev->dev, "devlink_alloc failed\n");
  3813			return -ENOMEM;
  3814		}
  3815	
  3816		err = pci_enable_device(pdev);
  3817		if (err) {
  3818			dev_err(&pdev->dev, "pci_enable_device\n");
  3819			goto out_free;
  3820		}
  3821	
  3822		bp = devlink_priv(devlink);
  3823		err = ptp_ocp_device_init(bp, pdev);
  3824		if (err)
  3825			goto out_disable;
  3826	
  3827		/* compat mode.
  3828		 * Older FPGA firmware only returns 2 irq's.
  3829		 * allow this - if not all of the IRQ's are returned, skip the
  3830		 * extra devices and just register the clock.
  3831		 */
  3832		err = pci_alloc_irq_vectors(pdev, 1, 17, PCI_IRQ_MSI | PCI_IRQ_MSIX);
  3833		if (err < 0) {
  3834			dev_err(&pdev->dev, "alloc_irq_vectors err: %d\n", err);
  3835			goto out;
  3836		}
  3837		bp->n_irqs = err;
  3838		pci_set_master(pdev);
  3839	
  3840		err = ptp_ocp_register_resources(bp, id->driver_data);
  3841		if (err)
  3842			goto out;
  3843	
  3844		bp->ptp = ptp_clock_register(&bp->ptp_info, &pdev->dev);
  3845		if (IS_ERR(bp->ptp)) {
  3846			err = PTR_ERR(bp->ptp);
  3847			dev_err(&pdev->dev, "ptp_clock_register: %d\n", err);
  3848			bp->ptp = NULL;
  3849			goto out;
  3850		}
  3851	
  3852		err = ptp_ocp_complete(bp);
  3853		if (err)
  3854			goto out;
  3855	
  3856		ptp_ocp_info(bp);
  3857		devlink_register(devlink);
  3858	
> 3859		bp->dpll = dpll_device_alloc(&dpll_ops, ARRAY_SIZE(bp->sma), ARRAY_SIZE(bp->sma), bp);
  3860		if (!bp->dpll) {
  3861			dev_err(&pdev->dev, "dpll_device_alloc failed\n");
  3862			return 0;
  3863		}
> 3864		dpll_device_register(bp->dpll);
  3865	
  3866		return 0;
  3867	
  3868	out:
  3869		ptp_ocp_detach(bp);
  3870	out_disable:
  3871		pci_disable_device(pdev);
  3872	out_free:
  3873		devlink_free(devlink);
  3874		return err;
  3875	}
  3876	
  3877	static void
  3878	ptp_ocp_remove(struct pci_dev *pdev)
  3879	{
  3880		struct ptp_ocp *bp = pci_get_drvdata(pdev);
  3881		struct devlink *devlink = priv_to_devlink(bp);
  3882	
> 3883		dpll_device_unregister(bp->dpll);
> 3884		dpll_device_free(bp->dpll);
  3885		devlink_unregister(devlink);
  3886		ptp_ocp_detach(bp);
  3887		pci_disable_device(pdev);
  3888	
  3889		devlink_free(devlink);
  3890	}
  3891	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

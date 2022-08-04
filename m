Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52081589BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiHDMt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiHDMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:49:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B61AF1F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659617362; x=1691153362;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+7TkLWEOWJUivI6IYIVqO/8bzqNP8U9uCdgPXPZXekI=;
  b=SbpJqYVdqVD34nn+XNsjxwH0P83TwSZY5i5JaRRVw3hnRk9UwZUdH4J7
   zKfykX6h1cHoTVGUP/ivYTV+rfSw7evZczFmRoTJwjY/lSE8Mjj9Ywart
   QUnaX+Hpje60vfYo+jp2VstJetGRZ0vu/Lg/JUg+Y9axn6CJBGN/vGGox
   HRbdTBEtgMwbIZW4ytPFXJLrzzwuIvJsiF9mof7DbHr3Iy0hEOfW5r9LT
   t08a8/6SuMkNslwN9G5Fp3nKnmlNNyz+/TRJz7VdXu3/HMXDFL4fk0MqZ
   +v6WZ1Pfp0+tOv6rqbMN1vbtJC7rLABiyfMDfhsnNnEzllXOdORcPxXI4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="272968439"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="272968439"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 05:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="553709230"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 05:49:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJaHu-000IRz-2z;
        Thu, 04 Aug 2022 12:49:18 +0000
Date:   Thu, 4 Aug 2022 20:49:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Fedorenko <vadfed@fb.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kuba:gnl-gen-dpll 111/133] drivers/ptp/ptp_ocp.c:3721:41: error:
 call to undeclared function 'dpll_priv'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202208042049.C42zYO15-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git gnl-gen-dpll
head:   fe9b39bc400264b4403591191c918670b7766de9
commit: 48c4cd1d7a94aeb6ab460989f1561117291092a5 [111/133] ptp_ocp: implement DPLL ops
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220804/202208042049.C42zYO15-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git/commit/?id=48c4cd1d7a94aeb6ab460989f1561117291092a5
        git remote add kuba https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
        git fetch --no-tags kuba gnl-gen-dpll
        git checkout 48c4cd1d7a94aeb6ab460989f1561117291092a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ptp/ptp_ocp.c:3721:41: error: call to undeclared function 'dpll_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                                  ^
   drivers/ptp/ptp_ocp.c:3721:23: warning: cast to 'struct ptp_ocp *' from smaller integer type 'int' [-Wint-to-pointer-cast]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3730:41: error: call to undeclared function 'dpll_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                                  ^
   drivers/ptp/ptp_ocp.c:3730:23: warning: cast to 'struct ptp_ocp *' from smaller integer type 'int' [-Wint-to-pointer-cast]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ptp/ptp_ocp.c:3743:7: error: assigning to 'struct ocp_selector *' from 'const struct ocp_selector *const' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   tbl = bp->sma_op->tbl[0];
                       ^ ~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3745:7: error: assigning to 'struct ocp_selector *' from 'const struct ocp_selector *const' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   tbl = bp->sma_op->tbl[1];
                       ^ ~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3753:41: error: call to undeclared function 'dpll_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                                  ^
   drivers/ptp/ptp_ocp.c:3753:23: warning: cast to 'struct ptp_ocp *' from smaller integer type 'int' [-Wint-to-pointer-cast]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ptp/ptp_ocp.c:3754:23: error: initializing 'struct ocp_selector *' with an expression of type 'const struct ocp_selector *const' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           struct ocp_selector *tbl = bp->sma_op->tbl[dir];
                                ^     ~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3766:41: error: call to undeclared function 'dpll_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                                  ^
   drivers/ptp/ptp_ocp.c:3766:23: warning: cast to 'struct ptp_ocp *' from smaller integer type 'int' [-Wint-to-pointer-cast]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3781:41: error: call to undeclared function 'dpll_priv'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                                  ^
   drivers/ptp/ptp_ocp.c:3781:23: warning: cast to 'struct ptp_ocp *' from smaller integer type 'int' [-Wint-to-pointer-cast]
           struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ptp/ptp_ocp.c:3794:31: error: variable has incomplete type 'struct dpll_device_ops'
   static struct dpll_device_ops dpll_ops = {
                                 ^
   drivers/ptp/ptp_ocp.c:3794:15: note: forward declaration of 'struct dpll_device_ops'
   static struct dpll_device_ops dpll_ops = {
                 ^
>> drivers/ptp/ptp_ocp.c:3859:13: error: call to undeclared function 'dpll_device_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           bp->dpll = dpll_device_alloc(&dpll_ops, ARRAY_SIZE(bp->sma), ARRAY_SIZE(bp->sma), bp);
                      ^
>> drivers/ptp/ptp_ocp.c:3864:2: error: call to undeclared function 'dpll_device_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           dpll_device_register(bp->dpll);
           ^
   drivers/ptp/ptp_ocp.c:3864:2: note: did you mean 'device_register'?
   include/linux/device.h:895:18: note: 'device_register' declared here
   int __must_check device_register(struct device *dev);
                    ^
>> drivers/ptp/ptp_ocp.c:3883:2: error: call to undeclared function 'dpll_device_unregister'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           dpll_device_unregister(bp->dpll);
           ^
>> drivers/ptp/ptp_ocp.c:3884:2: error: call to undeclared function 'dpll_device_free'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           dpll_device_free(bp->dpll);
           ^
   5 warnings and 13 errors generated.
--
>> drivers/dpll/dpll_core.c:77:21: error: conflicting types for 'dpll_device_alloc'
   struct dpll_device *dpll_device_alloc(struct dpll_device_ops *ops, int sources_count,
                       ^
   include/linux/dpll.h:23:21: note: previous declaration is here
   struct dpll_device *dpll_device_alloc(struct dpll_device_ops *ops, int sources_count,
                       ^
   1 error generated.
--
>> drivers/dpll/dpll_netlink.c:227:24: error: initializing 'const struct nlattr **' with an expression of type 'struct nlattr **' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           const struct nlattr **attrs = p->attrs;
                                 ^       ~~~~~~~~
   drivers/dpll/dpll_netlink.c:252:24: error: initializing 'const struct nlattr **' with an expression of type 'struct nlattr **' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           const struct nlattr **attrs = p->attrs;
                                 ^       ~~~~~~~~
   drivers/dpll/dpll_netlink.c:600:13: warning: no previous prototype for function 'dpll_netlink_fini' [-Wmissing-prototypes]
   void __exit dpll_netlink_fini(void)
               ^
   drivers/dpll/dpll_netlink.c:600:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __exit dpll_netlink_fini(void)
   ^
   static 
   1 warning and 2 errors generated.


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
> 3743			tbl = bp->sma_op->tbl[0];
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
> 3754		struct ocp_selector *tbl = bp->sma_op->tbl[dir];
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
  3795		.get_status		= ptp_ocp_dpll_get_status,
  3796		.get_lock_status	= ptp_ocp_dpll_get_lock_status,
  3797		.get_source_type	= ptp_ocp_dpll_get_source_type,
  3798		.get_source_supported	= ptp_ocp_dpll_get_source_supported,
  3799		.get_output_type	= ptp_ocp_dpll_get_output_type,
  3800		.get_output_supported	= ptp_ocp_dpll_get_output_supported,
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

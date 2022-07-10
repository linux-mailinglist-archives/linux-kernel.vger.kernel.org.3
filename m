Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656A456CEAA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGJLDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGJLDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 07:03:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AAC13DCF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657450990; x=1688986990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a5EpTEHt0mEv4EB00IPxFbBlhl1LFO+JvU58D70o5k8=;
  b=WAPp8aRIbpo+n6bBAVdGy3ZfInNGZzzGlazbuqWtPp4P9PfIPAgQOFSR
   uCkF/QMpxNPSVM3KxvEbwCgaZKMPoSGgtWrqLrKlYN9cqxToFGd+CcQTZ
   dWW/zG+yWw46nwKSSgvLLrH71OiMCK6jw9OdHxsRMnkDV/gm0mVzpAZ/4
   F2cL3f5sLJ2Bjs2GRDWkALnOVOc9n5KzGTxc7PzPV3MR6/xGcdVyR94Vk
   WUF/qoVxD02HDshTsgpsTlUhfAqUnW/TU+HmSBhcUlu6L5iLSrsqFWCEm
   RQnm773t9AypqXgPu2NH0Anmr+xdvM6Zna+G05OL8uWzVM9bGv9gueBhX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264912245"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="264912245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 04:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="569447858"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2022 04:03:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAUiR-000Pjo-7X;
        Sun, 10 Jul 2022 11:03:07 +0000
Date:   Sun, 10 Jul 2022 19:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [sudeep-holla:for-next/scmi 22/22]
 drivers/powercap/arm_scmi_powercap.c:429 scmi_powercap_probe() warn:
 unsigned 'pr->num_zones' is never less than zero.
Message-ID: <202207101807.UYiCXGqy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for-next/scmi
head:   31afdd34f2b9e1f33018baa4f279e2b2a91f5afa
commit: 31afdd34f2b9e1f33018baa4f279e2b2a91f5afa [22/22] powercap: arm_scmi: Add SCMI powercap based driver
config: microblaze-randconfig-m031-20220706 (https://download.01.org/0day-ci/archive/20220710/202207101807.UYiCXGqy-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/powercap/arm_scmi_powercap.c:429 scmi_powercap_probe() warn: unsigned 'pr->num_zones' is never less than zero.
drivers/powercap/arm_scmi_powercap.c:494 scmi_powercap_probe() error: uninitialized symbol 'ret'.

vim +429 drivers/powercap/arm_scmi_powercap.c

   406	
   407	static int scmi_powercap_probe(struct scmi_device *sdev)
   408	{
   409		int ret, i;
   410		struct scmi_powercap_root *pr;
   411		struct scmi_powercap_zone *spz;
   412		struct scmi_protocol_handle *ph;
   413		struct device *dev = &sdev->dev;
   414		const struct scmi_handle *handle = sdev->handle;
   415	
   416		if (!handle)
   417			return -ENODEV;
   418	
   419		powercap_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_POWERCAP,
   420							 &ph);
   421		if (IS_ERR(powercap_ops))
   422			return PTR_ERR(powercap_ops);
   423	
   424		pr = devm_kzalloc(dev, sizeof(*pr), GFP_KERNEL);
   425		if (!pr)
   426			return -ENOMEM;
   427	
   428		pr->num_zones = powercap_ops->num_domains_get(ph);
 > 429		if (pr->num_zones < 0) {
   430			dev_err(dev, "number of powercap domains not found\n");
   431			return pr->num_zones;
   432		}
   433	
   434		pr->spzones = devm_kcalloc(dev, pr->num_zones,
   435					   sizeof(*pr->spzones), GFP_KERNEL);
   436		if (!pr->spzones)
   437			return -ENOMEM;
   438	
   439		/* Allocate for worst possible scenario of maximum tree height. */
   440		pr->registered_zones = devm_kcalloc(dev, pr->num_zones,
   441						    sizeof(*pr->registered_zones),
   442						    GFP_KERNEL);
   443		if (!pr->registered_zones)
   444			return -ENOMEM;
   445	
   446		for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
   447			/*
   448			 * Powercap domains are validate by the protocol layer, i.e.
   449			 * when only non-NULL domains are returned here, whose
   450			 * parent_id is assured to point to another valid domain.
   451			 */
   452			spz->info = powercap_ops->info_get(ph, i);
   453	
   454			spz->dev = dev;
   455			spz->ph = ph;
   456			spz->spzones = pr->spzones;
   457			INIT_LIST_HEAD(&spz->node);
   458			INIT_LIST_HEAD(&pr->registered_zones[i]);
   459	
   460			/*
   461			 * Forcibly skip powercap domains using an abstract scale.
   462			 * Note that only leaves domains can be skipped, so this could
   463			 * lead later to a global failure.
   464			 */
   465			if (!spz->info->powercap_scale_uw &&
   466			    !spz->info->powercap_scale_mw) {
   467				dev_warn(dev,
   468					 "Abstract power scale not supported. Skip %s.\n",
   469					 spz->info->name);
   470				spz->info = NULL;
   471				continue;
   472			}
   473		}
   474	
   475		/*
   476		 * Scan array of retrieved SCMI powercap domains and register them
   477		 * recursively starting from the root domains.
   478		 */
   479		for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
   480			ret = scmi_powercap_register_zone(pr, spz);
   481			if (ret) {
   482				dev_err(dev,
   483					"Failed to register powercap zone %s - ret:%d\n",
   484					spz->info->name, ret);
   485				scmi_powercap_unregister_all_zones(pr);
   486				return ret;
   487			}
   488		}
   489	
   490		dev_set_drvdata(dev, pr);
   491	
   492		dev_info(dev, "Registered %d SCMI Powercap domains !\n", pr->num_zones);
   493	
 > 494		return ret;
   495	}
   496	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

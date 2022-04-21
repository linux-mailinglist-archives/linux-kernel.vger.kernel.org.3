Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468E509844
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385368AbiDUGwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385333AbiDUGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:51:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B516167F5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523564; x=1682059564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+fG3CUHT65AdYyfMv41toWaGRE9+PhXe0GQuvzbE05g=;
  b=KYAG2lf8tusE98A3lwLH4z1RkqM6x+ev8E9Y3YhRpi6jCRJz5MRwUvIL
   HW48a7TgTYwsfgcY2g2zvPtC6PqumL7k5dO1k3mxW7MBWuhN+BghUKT8f
   Mq8E7+lwEfVT3C7ZEsEuGnxV+fPv8+nv4dfqmn/rBzfYN+TLjddgCRnPf
   f7JP2nsXRCgI+ojbMdOwqxesPKkgJXZa0vOdf6Kqg08rptZNuCGYV1iN6
   jhX6FMjeKSOtAJRjH9vkPB06fN3Il23PfO7VCQG+iCfBfCQe44FAvyGJ3
   Vb6Cl9paJK4s2ochFjXDeWwIZD7MjeiPm4S9OoelePh9OZpw6kvW0Tc//
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="261857970"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="261857970"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="648006126"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2022 23:45:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQZb-00082w-Tr;
        Thu, 21 Apr 2022 06:45:51 +0000
Date:   Thu, 21 Apr 2022 14:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/acpi/x86/s2idle.c:395:13: sparse: sparse: restricted
 suspend_state_t degrades to integer
Message-ID: <202204211351.A0b3XLgO-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: fef98671194be005853cbbf51b164a3927589b64 ACPI: PM: s2idle: Move x86-specific code to the x86 directory
date:   1 year, 4 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220421/202204211351.A0b3XLgO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fef98671194be005853cbbf51b164a3927589b64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fef98671194be005853cbbf51b164a3927589b64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ drivers/ kernel// net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/x86/s2idle.c:395:13: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/acpi/x86/s2idle.c:395:33: sparse: sparse: restricted suspend_state_t degrades to integer

vim +395 drivers/acpi/x86/s2idle.c

   348	
   349	static int lps0_device_attach(struct acpi_device *adev,
   350				      const struct acpi_device_id *not_used)
   351	{
   352		union acpi_object *out_obj;
   353	
   354		if (lps0_device_handle)
   355			return 0;
   356	
   357		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
   358			return 0;
   359	
   360		if (acpi_s2idle_vendor_amd()) {
   361			guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
   362			out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
   363			rev_id = 0;
   364		} else {
   365			guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
   366			out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
   367			rev_id = 1;
   368		}
   369	
   370		/* Check if the _DSM is present and as expected. */
   371		if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
   372			acpi_handle_debug(adev->handle,
   373					  "_DSM function 0 evaluation failed\n");
   374			return 0;
   375		}
   376	
   377		lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
   378	
   379		ACPI_FREE(out_obj);
   380	
   381		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
   382				  lps0_dsm_func_mask);
   383	
   384		lps0_device_handle = adev->handle;
   385	
   386		if (acpi_s2idle_vendor_amd())
   387			lpi_device_get_constraints_amd();
   388		else
   389			lpi_device_get_constraints();
   390	
   391		/*
   392		 * Use suspend-to-idle by default if the default suspend mode was not
   393		 * set from the command line.
   394		 */
 > 395		if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
   396			mem_sleep_current = PM_SUSPEND_TO_IDLE;
   397	
   398		/*
   399		 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
   400		 * EC GPE to be enabled while suspended for certain wakeup devices to
   401		 * work, so mark it as wakeup-capable.
   402		 */
   403		acpi_ec_mark_gpe_for_wake();
   404	
   405		return 0;
   406	}
   407	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

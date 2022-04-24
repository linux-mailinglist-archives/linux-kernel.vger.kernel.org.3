Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31FF50D22B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiDXODv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiDXODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:03:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34312610
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650808844; x=1682344844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1bJCdbCXx/X69krGvVoOcv05ra4wRNfzS5w+5jMQwU4=;
  b=bsgulhFBdyt5e8BhACIIgudYb7+ERKB830sMzZb0zLQKxzCkOtFXnnku
   gnUVtEdooaALASwQpGnk2f+xbTJzPaNMvS05DWYoCtuHyjX2Eq4G8bx7/
   9fLJ1ZLU0Z1dfQngnO7e50duGdXq7UHhXgkOxc87l+sDXmYG8VPcHpu17
   Zl6VtmVDaVQ3LAinMVGXCNByctlEV5V3w0EM6OStUq0CtSF0tRGYrlyah
   8gEYTdYPFaO9dLVQ419vXm77SYUgKq+I5qonYpYCh3iGi2jS0X8Gr5h0z
   t9WZ/YE4Et3uUms5BhoaZyL5+ZKAeNfXNWY5qhGkzfxy807UdzwOkCXXz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="325521788"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="325521788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 07:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="729298658"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2022 07:00:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nicn3-0001Vb-IJ;
        Sun, 24 Apr 2022 14:00:41 +0000
Date:   Sun, 24 Apr 2022 21:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/acpi/x86/s2idle.c:395:13: sparse: sparse: restricted
 suspend_state_t degrades to integer
Message-ID: <202204242106.jwA7mA4T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22da5264abf497a10a4ed629f07f4ba28a7ed5eb
commit: fef98671194be005853cbbf51b164a3927589b64 ACPI: PM: s2idle: Move x86-specific code to the x86 directory
date:   1 year, 4 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220424/202204242106.jwA7mA4T-lkp@intel.com/config)
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

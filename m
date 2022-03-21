Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEA4E3525
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiCUX7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCUX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:59:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1751326
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647907026; x=1679443026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BWlrj7dmd06ikehsHPeKyybN3oK2riR1dqGeRHzQra8=;
  b=i4fXK040Bs5s3r6eStgHJmReZkwDF4X2peA2ZS2CjLuneWwHhbH/px4E
   nwSoV+merYuXwGoJ92KtxJeVe5Zf+QerExJh724cHQP/Upah+BrD5+GMo
   2q3Ubv1Bhn+4hEcee0WsdcBXy+i63qr8SDgsjGz5XHeMyN3+RFGN7uxcL
   RUpAyEhTPZF92SUZ2EMvs+/Pbapxmm68xVctopZ1Xk9JD/9f4ucwKqHy9
   3QWmO0POVG1UB4sN0Guamu4TSguS7gcaTw2oaOhkWcTeeHaf1SDg5wYW0
   8d07ahFnlT+uZn/m7IsCm3Q/w6zOvqoIM+1rjmSRDHVrD5cNU2nNBLr0Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257626358"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="257626358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 16:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="648758421"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 16:55:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWRrk-000IIK-QU; Mon, 21 Mar 2022 23:55:12 +0000
Date:   Tue, 22 Mar 2022 07:54:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [drm-drm-intel:drm-intel-gt-next 1210/1212]
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:275:20: error: implicit
 declaration of function 'sysfs_gt_attribute_r_max_func'
Message-ID: <202203220742.LAWCiYN8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   git://anongit.freedesktop.org/drm/drm-intel drm-intel-gt-next
head:   230523ba24bda5387637188ad56530bf6abd3f6c
commit: 56a709cf77468e3a422b0ce3d58f8c2257bac2f1 [1210/1212] drm/i915/gt: Create per-tile RPS sysfs interfaces
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220322/202203220742.LAWCiYN8-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add drm-drm-intel git://anongit.freedesktop.org/drm/drm-intel
        git fetch --no-tags drm-drm-intel drm-intel-gt-next
        git checkout 56a709cf77468e3a422b0ce3d58f8c2257bac2f1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function 'act_freq_mhz_show':
>> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:275:20: error: implicit declaration of function 'sysfs_gt_attribute_r_max_func' [-Werror=implicit-function-declaration]
     275 |  u32 actual_freq = sysfs_gt_attribute_r_max_func(dev, attr,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function 'boost_freq_mhz_store':
>> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:326:9: error: implicit declaration of function 'sysfs_gt_attribute_w_func' [-Werror=implicit-function-declaration]
     326 |  return sysfs_gt_attribute_w_func(dev, attr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function 'min_freq_mhz_show':
>> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:415:17: error: implicit declaration of function 'sysfs_gt_attribute_r_min_func' [-Werror=implicit-function-declaration]
     415 |  u32 min_freq = sysfs_gt_attribute_r_min_func(dev, attr,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/sysfs_gt_attribute_r_max_func +275 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c

   271	
   272	static ssize_t act_freq_mhz_show(struct device *dev,
   273					 struct device_attribute *attr, char *buff)
   274	{
 > 275		u32 actual_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   276							    __act_freq_mhz_show);
   277	
   278		return sysfs_emit(buff, "%u\n", actual_freq);
   279	}
   280	
   281	static u32 __cur_freq_mhz_show(struct intel_gt *gt)
   282	{
   283		return intel_rps_get_requested_frequency(&gt->rps);
   284	}
   285	
   286	static ssize_t cur_freq_mhz_show(struct device *dev,
   287					 struct device_attribute *attr, char *buff)
   288	{
   289		u32 cur_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   290							 __cur_freq_mhz_show);
   291	
   292		return sysfs_emit(buff, "%u\n", cur_freq);
   293	}
   294	
   295	static u32 __boost_freq_mhz_show(struct intel_gt *gt)
   296	{
   297		return intel_rps_get_boost_frequency(&gt->rps);
   298	}
   299	
   300	static ssize_t boost_freq_mhz_show(struct device *dev,
   301					   struct device_attribute *attr,
   302					   char *buff)
   303	{
   304		u32 boost_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   305							   __boost_freq_mhz_show);
   306	
   307		return sysfs_emit(buff, "%u\n", boost_freq);
   308	}
   309	
   310	static int __boost_freq_mhz_store(struct intel_gt *gt, u32 val)
   311	{
   312		return intel_rps_set_boost_frequency(&gt->rps, val);
   313	}
   314	
   315	static ssize_t boost_freq_mhz_store(struct device *dev,
   316					    struct device_attribute *attr,
   317					    const char *buff, size_t count)
   318	{
   319		ssize_t ret;
   320		u32 val;
   321	
   322		ret = kstrtou32(buff, 0, &val);
   323		if (ret)
   324			return ret;
   325	
 > 326		return sysfs_gt_attribute_w_func(dev, attr,
   327						 __boost_freq_mhz_store, val) ?: count;
   328	}
   329	
   330	static u32 __rp0_freq_mhz_show(struct intel_gt *gt)
   331	{
   332		return intel_rps_get_rp0_frequency(&gt->rps);
   333	}
   334	
   335	static ssize_t RP0_freq_mhz_show(struct device *dev,
   336					 struct device_attribute *attr, char *buff)
   337	{
   338		u32 rp0_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   339							     __rp0_freq_mhz_show);
   340	
   341		return sysfs_emit(buff, "%u\n", rp0_freq);
   342	}
   343	
   344	static u32 __rp1_freq_mhz_show(struct intel_gt *gt)
   345	{
   346		return intel_rps_get_rp1_frequency(&gt->rps);
   347	}
   348	
   349	static ssize_t RP1_freq_mhz_show(struct device *dev,
   350					 struct device_attribute *attr, char *buff)
   351	{
   352		u32 rp1_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   353							     __rp1_freq_mhz_show);
   354	
   355		return sysfs_emit(buff, "%u\n", rp1_freq);
   356	}
   357	
   358	static u32 __rpn_freq_mhz_show(struct intel_gt *gt)
   359	{
   360		return intel_rps_get_rpn_frequency(&gt->rps);
   361	}
   362	
   363	static ssize_t RPn_freq_mhz_show(struct device *dev,
   364					 struct device_attribute *attr, char *buff)
   365	{
   366		u32 rpn_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   367							     __rpn_freq_mhz_show);
   368	
   369		return sysfs_emit(buff, "%u\n", rpn_freq);
   370	}
   371	
   372	static u32 __max_freq_mhz_show(struct intel_gt *gt)
   373	{
   374		return intel_rps_get_max_frequency(&gt->rps);
   375	}
   376	
   377	static ssize_t max_freq_mhz_show(struct device *dev,
   378					 struct device_attribute *attr, char *buff)
   379	{
   380		u32 max_freq = sysfs_gt_attribute_r_max_func(dev, attr,
   381							     __max_freq_mhz_show);
   382	
   383		return sysfs_emit(buff, "%u\n", max_freq);
   384	}
   385	
   386	static int __set_max_freq(struct intel_gt *gt, u32 val)
   387	{
   388		return intel_rps_set_max_frequency(&gt->rps, val);
   389	}
   390	
   391	static ssize_t max_freq_mhz_store(struct device *dev,
   392					  struct device_attribute *attr,
   393					  const char *buff, size_t count)
   394	{
   395		int ret;
   396		u32 val;
   397	
   398		ret = kstrtou32(buff, 0, &val);
   399		if (ret)
   400			return ret;
   401	
   402		ret = sysfs_gt_attribute_w_func(dev, attr, __set_max_freq, val);
   403	
   404		return ret ?: count;
   405	}
   406	
   407	static u32 __min_freq_mhz_show(struct intel_gt *gt)
   408	{
   409		return intel_rps_get_min_frequency(&gt->rps);
   410	}
   411	
   412	static ssize_t min_freq_mhz_show(struct device *dev,
   413					 struct device_attribute *attr, char *buff)
   414	{
 > 415		u32 min_freq = sysfs_gt_attribute_r_min_func(dev, attr,
   416							     __min_freq_mhz_show);
   417	
   418		return sysfs_emit(buff, "%u\n", min_freq);
   419	}
   420	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

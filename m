Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A2524243
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiELCBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiELCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:01:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166A326E2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652320868; x=1683856868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9a55DOVy8CO3HZ2treHs2bO09ZwYZN7EYj3vy0S3IuU=;
  b=fgSFiH0LeDWw5ygWP+2z00r/AqrtPxu4Hx1kdzKr7K/sKu92VvFASAmZ
   BR269wzya52cYNPSfP3ri4lFsOh0+DBWtUSg1qGLYsbHImdAxq3cJ1HLq
   DRF/lq4ajZa6odeazJQzgp8XFIvSQdVsGmk+ywSntGk0uWyGl4IMfmlli
   4988/tMT706tdF9XbPajiMqpi1XInNfaXzllyOIZjt0/fJw5CxW0A3QdL
   SRzZLkJhXARC5rLPzznpQ9/+Nk5EI//QBPVr6UOFIUdSgf4cf1fyswO1c
   /aE3/wCoivY4kQXaMntmXBZgcdbSXvlZtAqH2vgXh5xZ4X318ezwBeiHF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="250389659"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="250389659"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 19:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="814721000"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2022 19:01:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noy8X-000JpS-Jc;
        Thu, 12 May 2022 02:01:05 +0000
Date:   Thu, 12 May 2022 10:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <groeck@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luigi Semenzato <semenzato@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 949/6555] mm/low-mem-notify.c:87:16:
 sparse: sparse: incorrect type in return expression (different base types)
Message-ID: <202205120909.GVWyvFOU-lkp@intel.com>
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

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: b7ec7fb624dfc8d07e722cf2e0e72ff82ebaec7b [949/6555] CHROMIUM: low-mem: Fix return type of low_mem_notify_poll
config: i386-randconfig-s001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120909.GVWyvFOU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jsarha/linux/commit/b7ec7fb624dfc8d07e722cf2e0e72ff82ebaec7b
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout b7ec7fb624dfc8d07e722cf2e0e72ff82ebaec7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/low-mem-notify.c:87:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int [assigned] ret @@
   mm/low-mem-notify.c:87:16: sparse:     expected restricted __poll_t
   mm/low-mem-notify.c:87:16: sparse:     got unsigned int [assigned] ret

vim +87 mm/low-mem-notify.c

89587e9d1c30b5 Luigi Semenzato 2014-04-03  74  
b7ec7fb624dfc8 Guenter Roeck   2018-11-01  75  static __poll_t low_mem_notify_poll(struct file *file, poll_table *wait)
89587e9d1c30b5 Luigi Semenzato 2014-04-03  76  {
89587e9d1c30b5 Luigi Semenzato 2014-04-03  77  	unsigned int ret = 0;
89587e9d1c30b5 Luigi Semenzato 2014-04-03  78  
89587e9d1c30b5 Luigi Semenzato 2014-04-03  79  	/* Update state to reflect any recent freeing. */
89587e9d1c30b5 Luigi Semenzato 2014-04-03  80  	atomic_set(&low_mem_state, is_low_mem_situation());
89587e9d1c30b5 Luigi Semenzato 2014-04-03  81  
89587e9d1c30b5 Luigi Semenzato 2014-04-03  82  	poll_wait(file, &low_mem_wait, wait);
89587e9d1c30b5 Luigi Semenzato 2014-04-03  83  
1fa6b9516423e6 Luigi Semenzato 2012-04-18  84  	if (low_mem_margin_enabled && atomic_read(&low_mem_state) != 0)
89587e9d1c30b5 Luigi Semenzato 2014-04-03  85  		ret = POLLIN;
89587e9d1c30b5 Luigi Semenzato 2014-04-03  86  
89587e9d1c30b5 Luigi Semenzato 2014-04-03 @87  	return ret;
89587e9d1c30b5 Luigi Semenzato 2014-04-03  88  }
89587e9d1c30b5 Luigi Semenzato 2014-04-03  89  

:::::: The code at line 87 was first introduced by commit
:::::: 89587e9d1c30b5f908d4bfe5f2ee0b920c156c14 CHROMIUM: Add /dev/low-mem device for low-memory notification.

:::::: TO: Luigi Semenzato <semenzato@chromium.org>
:::::: CC: Guenter Roeck <groeck@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

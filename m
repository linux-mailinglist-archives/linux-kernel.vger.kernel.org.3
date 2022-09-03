Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CF5ABD72
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiICGaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiICG36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:29:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20692CCA1;
        Fri,  2 Sep 2022 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662186596; x=1693722596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n5uDU9eTIPVXLJGf/uaHEOKAI/9grpTLNatMEbtbiLc=;
  b=PFZq2akMNvFY9zv0pFj+8iPg9dZZpWHQrWphY/a83+8Tq1VR5WP90uyu
   U1JuoH63nMBakcZVIDMl33C/b/wm9eUQTxoQE/fuZOEgvhE2WhqzAOQfF
   myMJWCQvlfppFARbmUAom8Gg9+4IKRW5GD19AlIP6FbbQ+4mahikt1rWf
   xS8SykDp1o1peV2TST726MQze8YEy4tgJ8+wKQhh8cJSsNNA891g6l5Zg
   +0I1WyrYFau+rLaJ6RgudeT7vg+1LV4DX3LtsSCI42X9QKq51Gtz4Czdy
   K+TtD7rq4sgEIDCfJXBP0iiarinWSKKfqu5c6Q2W6i3cyssUoi2x026AO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357850440"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="357850440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 23:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="755489507"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2022 23:29:54 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUMfB-0001B5-2D;
        Sat, 03 Sep 2022 06:29:53 +0000
Date:   Sat, 3 Sep 2022 14:29:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: drivers/media/i2c/ar0521.c:409:5-8: Unneeded variable: "ret". Return
 "0" on line 426
Message-ID: <202209031459.IAynxt5W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d895ec7938c431fe61a731939da76a6461bc6133
commit: dbae22e2008ee6a3acf2b7d989800eff80f0aa1f media: ar0521: fix Kconfig: VIDEO_V4L2 -> VIDEO_DEV
date:   7 weeks ago
config: s390-randconfig-c024-20220901 (https://download.01.org/0day-ci/archive/20220903/202209031459.IAynxt5W-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> drivers/media/i2c/ar0521.c:409:5-8: Unneeded variable: "ret". Return "0" on line 426

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

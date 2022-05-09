Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800935205E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiEIUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiEIUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:34:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D662D290C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652127838; x=1683663838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Af51gOxhxQLsVM2gLNKJOPeUadLNAgQ9IMJJ0mPaZuo=;
  b=ThUyAz0W1wY63Jl+LIlBWOjPejZ54kBB0CqZAXW7bOOER1lu+RSCXnDr
   6a0klNFIOcdgfzSRIOG9meaEkGQYdG+tJ4gZMrd4Po17sokn7s0tx5p8h
   F9qSm0JNSAjmqPjicnJ/K53rqSaFrnMOzvsYY5q4zRMyxzSWqlqPrMww9
   5N4m/tI2Gs142HFkaJvIsZa0tiBrOrl5KplroC+9ZP0/BYooARln07WD7
   eyDCvJKFIYnmtRw17qnBKUiZdFTlrWnp0OH3TpoCSZI6s/ecr8khvUMN7
   OMqVuOaCQlNsyPujjH9kmBGq6YWSqaUyQKiVDjqUYvjDwozhtFkPMw44B
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269298939"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="269298939"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="565262061"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2022 13:23:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no9vA-000Grp-29;
        Mon, 09 May 2022 20:23:56 +0000
Date:   Tue, 10 May 2022 04:23:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/staging/iio/resolver/ad2s1210.c:702:34: warning:
 'ad2s1210_of_match' defined but not used
Message-ID: <202205100411.pERg5Z1r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 382c7fce7005b55f0583cf5905758d2b8def803a staging: iio: ad2s1210: Add device tree table.
date:   3 years, 6 months ago
config: i386-randconfig-a002-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100411.pERg5Z1r-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=382c7fce7005b55f0583cf5905758d2b8def803a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 382c7fce7005b55f0583cf5905758d2b8def803a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/iio/resolver/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/iio/resolver/ad2s1210.c:702:34: warning: 'ad2s1210_of_match' defined but not used [-Wunused-const-variable=]
     702 | static const struct of_device_id ad2s1210_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/ad2s1210_of_match +702 drivers/staging/iio/resolver/ad2s1210.c

   701	
 > 702	static const struct of_device_id ad2s1210_of_match[] = {
   703		{ .compatible = "adi,ad2s1210", },
   704		{ }
   705	};
   706	MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
   707	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

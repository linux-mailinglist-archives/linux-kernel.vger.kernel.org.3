Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597A547A04
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiFLMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiFLMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:08:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6CB43
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655035690; x=1686571690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n9BDHuAqgbsJ+/uHqx+hTPldQ6IkE/nbYiFmh7mhMJk=;
  b=RoHq9y417nOkUG6EwjDrYfnJHHfFdV+CN7CaaPEYhkP3Ey3LDFQhI/Nl
   TsxTrPCpu6tmwDUZfakvy2OtKdDvVDJ9xfYNvd0MbCWSDzBNj5GxUBTAm
   3LP1K86Vy3Jrq4mfKu6jLaMK6sZkeFco9WEoulYRUUuYcNSr9UPftRvYK
   nPOd0e3qUSdgcyNJuiFG0BglyZDLRP1aCl0a48jxXCUf0AqOU2ysZTR9f
   vHUGHiP+ngNa1BLN1v7jcBAZBmPPntUyOAtMhSSBrXfWkZqpXkU8fOOmU
   Ua+esmQUXIrTNi+oRd6YEOH2nTqYaLXz4+FqADZgedc0HHGldoX+POU1F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="275569289"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="275569289"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 05:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="829190830"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2022 05:08:06 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0MNy-000Jtx-9m;
        Sun, 12 Jun 2022 12:08:06 +0000
Date:   Sun, 12 Jun 2022 20:07:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [drm-misc:for-linux-next 1/10] include/drm/drm_of.h:123:36: error:
 expected ';', ',' or ')' before 'const'
Message-ID: <202206122034.jCMBsDG7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   d643daaf1694b7565fbe3982b630e1c7b95f1600
commit: fc801750b197d0f00c09e01e59a7dcd240fddcb5 [1/10] drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220612/202206122034.jCMBsDG7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout fc801750b197d0f00c09e01e59a7dcd240fddcb5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_bridge.c:31:
>> include/drm/drm_of.h:115:5: warning: no previous prototype for 'drm_of_get_data_lanes_count' [-Wmissing-prototypes]
     115 | int drm_of_get_data_lanes_count(const struct device_node *endpoint,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/drm/drm_of.h:123:36: error: expected ';', ',' or ')' before 'const'
     123 |                                    const unsigned int min,
         |                                    ^~~~~


vim +123 include/drm/drm_of.h

   114	
 > 115	int drm_of_get_data_lanes_count(const struct device_node *endpoint,
   116					const unsigned int min, const unsigned int max)
   117	{
   118		return -EINVAL;
   119	}
   120	
   121	int drm_of_get_data_lanes_count_ep(const struct device_node *port,
   122					   int port_reg, int reg
 > 123					   const unsigned int min,
   124					   const unsigned int max)
   125	{
   126		return -EINVAL;
   127	}
   128	#endif
   129	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

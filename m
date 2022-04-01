Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F784EEC13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345357AbiDALOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiDALOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:14:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBD270842
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648811577; x=1680347577;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ECJbsbL5lU4hTiwJ7JIzCITNtsp+IaK7GJg06mv8z5U=;
  b=ftltDeQlhWWAwKpDdYsqBYIn0Ohtq0viDz19+6ojqywCUcRD20YJsSl1
   Ig6Fm5xC3rYZU0iHOxjigLcEWb9f5r/ZcCSJv0SsoKUSKEYCPSSU+kCQ0
   TB7pJdWQtjVkgTrzk+gre1pXLceqy6rvm+xMxUHEqgxZShvbLox/C8Hxq
   ba5thw1MSY3aymnOS0iO3QHJe0l+bJKbzBj6SIsF3xruu5snwwkea22vn
   //8Fqa+RElwTCELyeG+cQIe8XFml3sAJ9pLd+FW5adzbsSJmxHOjMRhh4
   GGazikZ51RpSHborPvcZnS1Q17nKy1efWd/bKrIvNKpcWlF8OZ54bDkRP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="240698181"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="240698181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 04:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="843220552"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2022 04:12:56 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naFD5-0001Cr-ED;
        Fri, 01 Apr 2022 11:12:55 +0000
Date:   Fri, 1 Apr 2022 19:12:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>
Subject: [drm-misc:drm-misc-next 28/38]
 drivers/gpu/drm/bridge/chipone-icn6211.c:645:3-8: No need to set .owner
 here. The core will do it.
Message-ID: <202204011947.10abPzIP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   3d7039e1e64980a5eb424373b3a5843b7d7891aa
commit: 8dde6f7452a198a870f74a38118bb1a63da7632e [28/38] drm: bridge: icn6211: Add I2C configuration support
config: arm-randconfig-c023-20220331 (https://download.01.org/0day-ci/archive/20220401/202204011947.10abPzIP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/bridge/chipone-icn6211.c:645:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716DB563F3A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiGBJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:24:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49313D0E;
        Sat,  2 Jul 2022 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656753888; x=1688289888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZvCBqILuhQc+PA91u5tYAtzmTbr5oRh9lNn3MY3bA4I=;
  b=YpHDGG90SgD1yZIRHieITDsK8LfEsxpG0+WZKHL3NvSTfb9VSalc/mKe
   YrAWDvejney0q7Yr2rTnWXuMH2dTcPpgKR1fFr4kfFrPjJYrDzLo6vFLs
   dt3O+GXpR4ax6QTs3DtYfgVvkhDVlAcPkScGIdz62eEYrkaXiMyjwWx6A
   6a2aiAMvAVNuzhpgkQdOR6MWh98hcINnMwk8eELPdyNJqDivEwv+8lgmn
   lja8y7PL2V1BqRmtR0j8XuC2snLBo0LuOgcn6SLVHJOYyEkYtPkGR+lAX
   7dzBgkHSSS/KK73u2pNl7gFIhS86Se3AHUoV8f8oypW67Owi28o2xIa86
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="262608312"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="262608312"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 02:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="541966077"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2022 02:24:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7ZMs-000F5z-81;
        Sat, 02 Jul 2022 09:24:46 +0000
Date:   Sat, 2 Jul 2022 17:23:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING:
 Unexpected indentation.
Message-ID: <202207021703.lEW6FLT1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   089866061428ec9bf67221247c936792078c41a4
commit: 4c18a890dff8d95ca234d184773910383a978d45 iio:proximity:sx9324: Add SX9324 support
date:   5 months ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.

vim +2 Documentation/ABI/testing/sysfs-bus-iio-sx9324

   > 2	Date:		November 2021

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

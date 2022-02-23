Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C04C0E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiBWIp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiBWIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:45:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D0657BB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645605923; x=1677141923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N9wNRGQb5qAzIZff6kmsco6KpmpYN4ManUXhow3yTnM=;
  b=kamE9SdXxoGpWA2y3bPUZTsCkptt4sLrbtijxHeTbPpENcQk/f9/rR3L
   nwBtrhFMpHQ+8HwtXHBR0nemjJnasU1Ac1NUzogyzcJceoNM+VeOJPQk/
   FYT6FZyRpMVtEZ+HIA0YFiXfehhnzCIKFtbfYxTu54J2Ygr/HabeDHtss
   rGV2FeYMTqdelW9LJTCD65/w/+KZ18Z8B5PV6t1UzfIQwOwotQBaX7h4K
   yJytPmFjGfZwppFDMGeon8OIpD1Xlg5e6Pt/mAuGAu3Qpc2tC6YqyGm0Y
   1dvlZgJRcGsujbBeYoBHxhV49V0rg+YGG+Q6eLqEqV86gtXFg+Q3rBQRw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252106723"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="252106723"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 00:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="706949782"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2022 00:45:21 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMnGy-0001Au-Gk; Wed, 23 Feb 2022 08:45:20 +0000
Date:   Wed, 23 Feb 2022 16:44:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matan Ziv-Av <matan@svgalib.org>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 40/40] ERROR: modpost:
 "battery_hook_register" [drivers/platform/x86/lg-laptop.ko] undefined!
Message-ID: <202202231609.ZQpgFUIn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   7e45710a8a56896d7af5c5ff4ed7cfb18573791b
commit: 7e45710a8a56896d7af5c5ff4ed7cfb18573791b [40/40] lg-laptop: Move setting of battery charge limit to common location
config: x86_64-randconfig-r035-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231609.ZQpgFUIn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=7e45710a8a56896d7af5c5ff4ed7cfb18573791b
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 7e45710a8a56896d7af5c5ff4ed7cfb18573791b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "battery_hook_register" [drivers/platform/x86/lg-laptop.ko] undefined!
>> ERROR: modpost: "battery_hook_unregister" [drivers/platform/x86/lg-laptop.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

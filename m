Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EA5A5B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiH3FYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiH3FYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:24:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A057CB55
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661837044; x=1693373044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g1oWCd5LomuIgqZLZO3xby9f/jgIqyhiEGjGnykhXQI=;
  b=FcHp+7NjQ0ys1gdeYUnEGziQEXVVy2niWK1/LTchn5GK25pvSw5ezky0
   BtJOnEZ50vT+UWu0oBhDXjSGGP73fxdv/lN1IUISK6lq68LbDgsyMiNqE
   8K38nQbhqF4ufpNhvUaUSBtrLqwn4Kc+6t6Wiu9tGr9S0WkLfG6CAMJNW
   OAN4HX7BeIuiGhit/R+FyBsiRxar1+dcOxZD9SNsV1teV2taU/GWDiVLi
   Sg5ixQJKWEJjdsYqvdK9Fg1DWtuNQluTeAEK8YhhHsZke2ezdmEVWgoAw
   6btGc9w9EwKzVNbo9S682f3DU9GSInL0CPZm63vanRZHKI5nvn9trCGNR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296359721"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="296359721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 22:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="588449603"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 22:24:02 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oStjF-0000aH-20;
        Tue, 30 Aug 2022 05:24:01 +0000
Date:   Tue, 30 Aug 2022 13:23:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 29/42]
 drivers/platform/x86/asus-wmi.c:785:30: sparse: sparse: symbol
 'kbd_rgb_mode_groups' was not declared. Should it be static?
Message-ID: <202208301336.wDYNpg1U-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   af024a39ebda58694935f420bf396b11afb0df6b
commit: e305a71cea37a64c7558b8b979f6f08f657d0c3d [29/42] platform/x86: asus-wmi: Implement TUF laptop keyboard LED modes
config: i386-randconfig-s042-20220829 (https://download.01.org/0day-ci/archive/20220830/202208301336.wDYNpg1U-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=e305a71cea37a64c7558b8b979f6f08f657d0c3d
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout e305a71cea37a64c7558b8b979f6f08f657d0c3d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/asus-wmi.c:785:30: sparse: sparse: symbol 'kbd_rgb_mode_groups' was not declared. Should it be static?
   drivers/platform/x86/asus-wmi.c:1682:33: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/platform/x86/asus-wmi.c:1682:33: sparse:     expected unsigned int [usertype] val
   drivers/platform/x86/asus-wmi.c:1682:33: sparse:     got restricted __le32 [usertype]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

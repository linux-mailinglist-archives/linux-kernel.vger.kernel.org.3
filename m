Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5764CB3A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiCCAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiCCAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:24:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4F4EF77
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267045; x=1677803045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K0G2hO8UpI4vPSLQwZ47UXmmpikHmByIV/yACdOsGkc=;
  b=fqCiBDHii0rG8blVfB/fcc9s5gAMGH4n6CR8V7vgTZZnioYJJQYjGQlP
   rnCTPI8qXhXpfruRZ+uFNrG7wJ8S7FTRKrCLUM1kJGSQlnSaREqJ41Tk/
   jydvvaHsBGWR4GSP4HNUN/tSVaBaZnKoxBfDGnzVSMVtMAhc/kt9DfbgX
   olwExGWMSjLOORqj3b6DZHA4BpKFc0KO9e28GjaxVwc+96tk3KWcdOvqc
   Kw03C7yZDeP2m4ATKEI/QVqOvW4FpO76kfoUnb+lj3wUgXE9B5RgBp46T
   kvdbEXJfZwhHCci16piHqPr8l2id8XwBBwoZmu5slD7bkDivHToSLffJD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278215423"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="278215423"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="576296320"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 16:24:02 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPZGD-00028V-Tf; Thu, 03 Mar 2022 00:24:01 +0000
Date:   Thu, 3 Mar 2022 08:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Benedict Wong <benedictwong@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Eyal Birger <eyal.birger@gmail.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-q-release
 3312/9999] net/xfrm/xfrm_interface.c:742:13: warning: no previous
 declaration for 'xfrmi_get_link_net'
Message-ID: <202203030812.b5xXlD0J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steffen,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-q-release
head:   10b2283595d8504436650acaacae25859eb24bdc
commit: 73d9837ccf12f353d7c5bdcf84ebbe6d0c3b2015 [3312/9999] UPSTREAM: xfrm: Add virtual xfrm interfaces
config: i386-randconfig-a001-20220124 (https://download.01.org/0day-ci/archive/20220303/202203030812.b5xXlD0J-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/73d9837ccf12f353d7c5bdcf84ebbe6d0c3b2015
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-q-release
        git checkout 73d9837ccf12f353d7c5bdcf84ebbe6d0c3b2015
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/xfrm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/xfrm/xfrm_interface.c:742:13: warning: no previous declaration for 'xfrmi_get_link_net' [-Wmissing-declarations]
    struct net *xfrmi_get_link_net(const struct net_device *dev)
                ^~~~~~~~~~~~~~~~~~


vim +/xfrmi_get_link_net +742 net/xfrm/xfrm_interface.c

   741	
 > 742	struct net *xfrmi_get_link_net(const struct net_device *dev)
   743	{
   744		struct xfrm_if *xi = netdev_priv(dev);
   745	
   746		return dev_net(xi->phydev);
   747	}
   748	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

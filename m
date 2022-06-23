Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D907B5587C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiFWSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiFWSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:43:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2719F3CE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656006343; x=1687542343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kruoeecJbcbp4F95d35APFVprxdw2Nf0/sR6Tvn7Ivc=;
  b=fPG7w+bkq8bwmKG0RZ0UOXIpUmGjzNTVvmdfufrpUUI9+gXWVZQimouu
   gnm9LRjCnk1EInTEAx+PXcOYC0zbWfRfRClCVfFXFdbFvtj5LR6nDMJr+
   nn769Zussdl+PWWEZ3RkT5Mjbdatw+vtocLjWAmvoHqpeXFNxyvs5vEDj
   wRKl/V9Inp0oyJBfokyOhUvY0BAr2Y5MHy6tyVa7cwL2TS3bxhLEA/oOY
   FjBOydDqU8YhMFDEjbfwVJG7jF78K569dknG4h0WnCnQXTmy/9NDy17rh
   NyQzVRzCJoCu2cux1oCUxkVl0D8V64/5oY/FRZfRbx7QQ4Cc33n1VP7Xz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342476594"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="342476594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="678165491"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 10:45:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4QtK-0002Uq-AH;
        Thu, 23 Jun 2022 17:45:18 +0000
Date:   Fri, 24 Jun 2022 01:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     marxin <mliska@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Kleen <andi@firstfloor.org>
Subject: [jirislaby:lto 4/45] kernel/static_call_inline.c:504:15: warning: no
 previous prototype for 'func_a'
Message-ID: <202206240131.GMBBDfhI-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   8047611082d70c5263114fabce8c80a4c3d251fa
commit: e99286245556c2e8709aaa23124b9a7a10fa975b [4/45] static_call: Make static call functions visible
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220624/202206240131.GMBBDfhI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=e99286245556c2e8709aaa23124b9a7a10fa975b
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout e99286245556c2e8709aaa23124b9a7a10fa975b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/static_call_inline.c:504:15: warning: no previous prototype for 'func_a' [-Wmissing-prototypes]
     504 | int __visible func_a(int x)
         |               ^~~~~~
>> kernel/static_call_inline.c:509:15: warning: no previous prototype for 'func_b' [-Wmissing-prototypes]
     509 | int __visible func_b(int x)
         |               ^~~~~~


vim +/func_a +504 kernel/static_call_inline.c

   503	
 > 504	int __visible func_a(int x)
   505	{
   506		return x+1;
   507	}
   508	
 > 509	int __visible func_b(int x)
   510	{
   511		return x+2;
   512	}
   513	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

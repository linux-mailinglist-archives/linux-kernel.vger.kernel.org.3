Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A5549C77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbiFMS7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346672AbiFMS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:58:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BBA8DDF0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655136709; x=1686672709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I/ZXmPlGnwwgMTZv+Q5kpLi7dJK/SGwRaJzAqBNjIzI=;
  b=Qz0GeJq+Z+cmY4s3mRTma5PJVdkgGYlyQNWOtuAVy9+G7KZ3/ylfa8mE
   WLT9zPYwRRbp/GDF0D4BN5Kk4eDRuniwFzfyBb9Na/Uc0CQ2fPXU3FwLJ
   Q5HlX0WaZnmcw6g1fj7jkfw8sa4Prb0X6ZkYu3SKvpfryo5WmWdCSyWBI
   vYNHSliaLMuDlCAvJNOJag3WYDuBu8hxtGVsFz0TpK9c/+Fuh6Pui5PFy
   9kReIXBYWt1Q2Nebu98dHOhHefPMvE/PfpYfaIT3VttoMyxIoEXCUaYb4
   ziwO9CbZRErLsj9yTx9oNZXxqtmfiQUe8RM+ECUbyf3pobv6SVf6AeN0E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="342302166"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="342302166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="568093065"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2022 09:10:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0meR-000Kx3-MR;
        Mon, 13 Jun 2022 16:10:51 +0000
Date:   Tue, 14 Jun 2022 00:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:bitops 6/6] arch/x86/platform/olpc/olpc-xo1-sci.c:83:63:
 warning: logical not is only applied to the left hand side of comparison
Message-ID: <202206140056.8QrXxr1C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   d8371d0e4328c4cb6fa25350bd5132f25b386672
commit: d8371d0e4328c4cb6fa25350bd5132f25b386672 [6/6] bitops: let optimize out non-atomic bitops on compile-time constants
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220614/202206140056.8QrXxr1C-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/alobakin/linux/commit/d8371d0e4328c4cb6fa25350bd5132f25b386672
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout d8371d0e4328c4cb6fa25350bd5132f25b386672
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/platform/olpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'send_ebook_state':
>> arch/x86/platform/olpc/olpc-xo1-sci.c:83:63: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]
      83 |         if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
         |                                                               ^~
   arch/x86/platform/olpc/olpc-xo1-sci.c:83:13: note: add parentheses around left hand side expression to silence this warning
      83 |         if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
   arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'setup_sci_interrupt':
   arch/x86/platform/olpc/olpc-xo1-sci.c:316:13: warning: variable 'sts' set but not used [-Wunused-but-set-variable]
     316 |         u32 sts;
         |             ^~~


vim +83 arch/x86/platform/olpc/olpc-xo1-sci.c

e1040ac693bac1 Daniel Drake 2011-06-25  72  
7bc74b3df73776 Daniel Drake 2011-06-25  73  /* Report current ebook switch state through input layer */
7bc74b3df73776 Daniel Drake 2011-06-25  74  static void send_ebook_state(void)
7bc74b3df73776 Daniel Drake 2011-06-25  75  {
7bc74b3df73776 Daniel Drake 2011-06-25  76  	unsigned char state;
7bc74b3df73776 Daniel Drake 2011-06-25  77  
7bc74b3df73776 Daniel Drake 2011-06-25  78  	if (olpc_ec_cmd(EC_READ_EB_MODE, NULL, 0, &state, 1)) {
7bc74b3df73776 Daniel Drake 2011-06-25  79  		pr_err(PFX "failed to get ebook state\n");
7bc74b3df73776 Daniel Drake 2011-06-25  80  		return;
7bc74b3df73776 Daniel Drake 2011-06-25  81  	}
7bc74b3df73776 Daniel Drake 2011-06-25  82  
d2aa37411b8e65 Daniel Drake 2012-04-12 @83  	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
d2aa37411b8e65 Daniel Drake 2012-04-12  84  		return; /* Nothing new to report. */
d2aa37411b8e65 Daniel Drake 2012-04-12  85  
7bc74b3df73776 Daniel Drake 2011-06-25  86  	input_report_switch(ebook_switch_idev, SW_TABLET_MODE, state);
7bc74b3df73776 Daniel Drake 2011-06-25  87  	input_sync(ebook_switch_idev);
d2aa37411b8e65 Daniel Drake 2012-04-12  88  	pm_wakeup_event(&ebook_switch_idev->dev, 0);
7bc74b3df73776 Daniel Drake 2011-06-25  89  }
7bc74b3df73776 Daniel Drake 2011-06-25  90  

:::::: The code at line 83 was first introduced by commit
:::::: d2aa37411b8e65d57d2c5ae36f0222274292020d x86/olpc/xo1/sci: Produce wakeup events for buttons and switches

:::::: TO: Daniel Drake <dsd@laptop.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

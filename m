Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E5578DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiGRW5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiGRW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:57:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45221EE2E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658185022; x=1689721022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YakVPWuXnSr/Q1adt+u5NCRP3Taj6eNj0pFFk3xBqJg=;
  b=oDH+NKoxnGeVX4R1ERXmJDXN63cVunRslVlRzZYhyTHStz4MbJb7+TFP
   SkpDoJmFkHG57FCONfnz2MpM5FMKwnIQlQfWwlFVuDshMbTB/+7YrkHhL
   ZEEwY8BE155l1H5RQwjftrPtU2xBwjo9qWAMksXxiVpIM04Ul7f8SY/d5
   e0q0XXd94+qvPW53LLCiO17nmlwtAZ6f62ancWZsMcYFyKxKS34JtOciP
   Vgvy1LNNDl3dovpzCM2gxm4AoEY81AzrfcLKG81zLP+D9Ckg4fPhLPPNl
   U8Je6QX3PXVsxdUESBMqZEUISeLfKtGrRN28+Fds4FQmAVuB4pldHh+Cx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283903407"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="283903407"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="739642099"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2022 15:57:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDZfg-0004pz-5e;
        Mon, 18 Jul 2022 22:57:00 +0000
Date:   Tue, 19 Jul 2022 06:56:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: timestamping.c:328:56: warning: excess elements in struct initializer
Message-ID: <202207190632.Wf35yT5y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e19f34c2887a8881084b7bb7480e9544d56b91
commit: 2214d7032479e50ff1fa7276e6efe1df08173fbf selftests/net: timestamping: support binding PHC
date:   1 year, 1 month ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   timestamping.c: In function 'main':
   timestamping.c:328:16: error: variable 'so_timestamping_get' has initializer but incomplete type
     328 |         struct so_timestamping so_timestamping_get = { 0, -1 };
         |                ^~~~~~~~~~~~~~~
>> timestamping.c:328:56: warning: excess elements in struct initializer
     328 |         struct so_timestamping so_timestamping_get = { 0, -1 };
         |                                                        ^
   timestamping.c:328:56: note: (near initialization for 'so_timestamping_get')
   timestamping.c:328:59: warning: excess elements in struct initializer
     328 |         struct so_timestamping so_timestamping_get = { 0, -1 };
         |                                                           ^
   timestamping.c:328:59: note: (near initialization for 'so_timestamping_get')
   timestamping.c:328:32: error: storage size of 'so_timestamping_get' isn't known
     328 |         struct so_timestamping so_timestamping_get = { 0, -1 };
         |                                ^~~~~~~~~~~~~~~~~~~
   timestamping.c:329:16: error: variable 'so_timestamping' has initializer but incomplete type
     329 |         struct so_timestamping so_timestamping = { 0, -1 };
         |                ^~~~~~~~~~~~~~~
   timestamping.c:329:52: warning: excess elements in struct initializer
     329 |         struct so_timestamping so_timestamping = { 0, -1 };
         |                                                    ^
   timestamping.c:329:52: note: (near initialization for 'so_timestamping')
   timestamping.c:329:55: warning: excess elements in struct initializer
     329 |         struct so_timestamping so_timestamping = { 0, -1 };
         |                                                       ^
   timestamping.c:329:55: note: (near initialization for 'so_timestamping')
   timestamping.c:329:32: error: storage size of 'so_timestamping' isn't known
     329 |         struct so_timestamping so_timestamping = { 0, -1 };
         |                                ^~~~~~~~~~~~~~~
   timestamping.c:378:50: error: 'SOF_TIMESTAMPING_BIND_PHC' undeclared (first use in this function); did you mean 'SOF_TIMESTAMPING_TX_ACK'?
     378 |                         so_timestamping.flags |= SOF_TIMESTAMPING_BIND_PHC;
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  SOF_TIMESTAMPING_TX_ACK
   timestamping.c:378:50: note: each undeclared identifier is reported only once for each function it appears in
>> timestamping.c:329:32: warning: unused variable 'so_timestamping' [-Wunused-variable]
     329 |         struct so_timestamping so_timestamping = { 0, -1 };
         |                                ^~~~~~~~~~~~~~~
>> timestamping.c:328:32: warning: unused variable 'so_timestamping_get' [-Wunused-variable]
     328 |         struct so_timestamping so_timestamping_get = { 0, -1 };
         |                                ^~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

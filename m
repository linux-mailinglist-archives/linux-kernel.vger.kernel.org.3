Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08E64B1E10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiBKGDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:03:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbiBKGDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844BC1153
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559413; x=1676095413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NAMToAsLm//yAsepY6SmMPO7LdZpsT8WKhD6kwUCsoE=;
  b=eFYkhj7SBlCO/PQtTDb+hyZPKp3DN/zYUjIP/cwmbupYRsLhEXsM/tQg
   OY8LKJwkSDYpvuHDy5TSiE0Q2e1hFJW/UPlIWO4ib08xA8NQoD//NbhHy
   dIREIHFYcE6DV6ziPRbADH5IKPdlqfTxDOO+w8/Vvk2GwOODOnP7bKgrR
   LjiyT7eaYpzvmfOdwwfmM8GlzvA+hAAIvjoh9ja/iItvqfodEmJWJiXWX
   t+SYlVBoTg+H3cxtyBoSNCCablg5/QibanXKtfLJ8ltIs0YPbUlVDOKkL
   U16Rk5F1CD1FwGzPH8PUwbG1vcARVuULhHad27ba5vDcVey1FAKQQ+7+A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249419497"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249419497"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="537552506"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2022 22:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIP1n-0004C4-2B; Fri, 11 Feb 2022 06:03:31 +0000
Date:   Fri, 11 Feb 2022 14:02:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 13/35] ld:
 fs/cifs/file.o:undefined reference to `netfs_invalidatepage'
Message-ID: <202202111320.3RVjwLgi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: fc3202013b39db4b5188e871431e6650d819129d [13/35] netfs: Provide invalidatepage and releasepage calls
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220211/202202111320.3RVjwLgi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/fc3202013b39db4b5188e871431e6650d819129d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout fc3202013b39db4b5188e871431e6650d819129d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: fs/cifs/file.o:(.rodata+0x288): undefined reference to `netfs_invalidatepage'
>> ld: fs/cifs/file.o:(.rodata+0x290): undefined reference to `netfs_releasepage'
   ld: fs/cifs/file.o:(.rodata+0x348): undefined reference to `netfs_invalidatepage'
   ld: fs/cifs/file.o:(.rodata+0x350): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

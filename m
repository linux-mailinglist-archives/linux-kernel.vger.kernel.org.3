Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B465AFA71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIGDLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIGDLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:11:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F384EE2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662520262; x=1694056262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AymFsAjlJTw3ZlsoyqRCEN2+vuWcpnL9wZiecOO6QIM=;
  b=hUz7N+DcCOBgKXHwJnJ6B7mCw6wEjPn7215lgM0adkmQVOQfSnzYdc10
   mCj7IBPqGJL6mSILiiBFrT7g6fCvON0PQkTX+zX3qZ+M+yQ4z4WxLMNO8
   ptlXmirFgVbUs/tr4gbzNhZ1P4YopcZQTEUJ8RBQaZrXgXqCfvVMfb1WR
   F+h9759zhD+9G8TSF1uxNth7vwbTRrGdL4sxaMAQ1NO9t999nROlC1kmp
   wvd3qkIbskLJvb86GQv/3/8PHA4HZWF4Z6csdCBJPFS2VfNIWKSRW9V1I
   TEm2qW+9cqu0qHH9pfQHFVqbgweR2oiOrNAJrT5kWP3n6sDSsx7bO6tfI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297550398"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="297550398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 20:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="756606747"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2022 20:10:59 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVlSs-00061P-2x;
        Wed, 07 Sep 2022 03:10:58 +0000
Date:   Wed, 7 Sep 2022 11:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [ammarfaizi2-block:kdave/linux/for-next 107/120] ERROR: modpost:
 "balance_dirty_pages_ratelimited_flags" [fs/btrfs/btrfs.ko] undefined!
Message-ID: <202209071127.oM1Ev8D4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kdave/linux/for-next
head:   0e7fbd5972c021740bb9443c9680145a2627729f
commit: 145103680cd0f5fcd2162c89f89f2746c4198d85 [107/120] btrfs: make balance_dirty_pages nowait compatible
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220907/202209071127.oM1Ev8D4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/145103680cd0f5fcd2162c89f89f2746c4198d85
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kdave/linux/for-next
        git checkout 145103680cd0f5fcd2162c89f89f2746c4198d85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "balance_dirty_pages_ratelimited_flags" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

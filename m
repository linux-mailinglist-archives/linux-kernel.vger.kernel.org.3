Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2A516C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383943AbiEBI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiEBI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:57:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB857B38
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651481670; x=1683017670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I1Kokh7PAKPHoJWxBRQz7RioS+StlKTVIA22eUQ9K+Q=;
  b=CbLiuSdmlrq6f75Xg9qciVGKjzxX5+gFPJn/l6/uYh1jjwkDmQXeugov
   XVl28YlJZy9qXNi9v5v2qnTGmXaAhe+n7Ju0w2RuSedVOYlf2MPJ6Tlrr
   aX/RKuzkYVdA1DFqJzGONCoV2L5ggVJYyJ+8raxWt8lkPy57XbUpfR2ew
   2AUZpLIiLZJlWjT4a5g3BnUWDR1GIosc0IB32YJVh+xrAVpEAC8R+4NmB
   CPrRdaKh09Z4BKF9QOQLaUWFT5vLVP+Hi9og3C2czpm2/IjJRjs91lLfU
   3qjNYelZIa9r11pThXEHH68nX4fksWPG3Yd/pmtwXVs+IlpX9IKdREawS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="353588615"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="353588615"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 01:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515991940"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 01:54:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlRp5-0009QV-P5;
        Mon, 02 May 2022 08:54:27 +0000
Date:   Mon, 2 May 2022 16:53:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [tip:master 18/29] vmlinux.o: warning: objtool:
 do_user_addr_fault+0xac: unreachable instruction
Message-ID: <202205021646.AwOPfinU-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   aea1ae1ab93e60b266453b008238fbc5f0c65865
commit: ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3 [18/29] Merge objtool/core into tip/master
config: x86_64-randconfig-a002-20220502 (https://download.01.org/0day-ci/archive/20220502/202205021646.AwOPfinU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip master
        git checkout ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: do_user_addr_fault+0xac: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

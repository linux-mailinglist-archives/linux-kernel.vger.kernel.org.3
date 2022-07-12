Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A41572228
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGLSGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiGLSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:06:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BD3A9E7B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657649190; x=1689185190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oxM7i46Yu/woW8rLhZi0IvHogzSBiQQtRqt+Ji4uiH4=;
  b=nlw6HnpZsp6Ti8M2XfgLMJJdHsxjhc3B984nYastwwbdS53i6XlNGMsG
   pbBf9DC+p3Vuz9MqtB9ceCx9M0WKN7S31xxQkNX0ufC0bUHX4QmIvzlac
   suGVxETfLytrc+M/k5PYqpZfkRHEOraJV+XCFFBPkxp8m7crYOeYU3Iub
   F6h2tkeeAoVM3yoJwXn8mojLrzcuMiLjZcviXaS4vK2f6uAM0saTCKt1W
   nJFpnQina6RA5xqpgd3Tq9GzpbDJ6kZMYNT1bI4YX3zPuRZqb7xgxV43m
   TpOQ+BOEoW4BE5+jNhCIm+lQWYZwKRgvxnWcI465t1vciLr/kgHVIhUNS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265419766"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265419766"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 11:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="627987365"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2022 11:06:29 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBKHE-0002Yd-Er;
        Tue, 12 Jul 2022 18:06:28 +0000
Date:   Wed, 13 Jul 2022 02:05:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [martinetd:9p-next 11/11] net/9p/trans_fd.c:275:12: warning: unused
 variable 'failme'
Message-ID: <202207130248.PanFct3N-lkp@intel.com>
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

tree:   https://github.com/martinetd/linux.git 9p-next
head:   c249fb4f91931b9f010849134e95d33e388c375b
commit: c249fb4f91931b9f010849134e95d33e388c375b [11/11] 9p: roll p9_tag_remove into p9_req_put
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220713/202207130248.PanFct3N-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/martinetd/linux/commit/c249fb4f91931b9f010849134e95d33e388c375b
        git remote add martinetd https://github.com/martinetd/linux.git
        git fetch --no-tags martinetd 9p-next
        git checkout c249fb4f91931b9f010849134e95d33e388c375b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/9p/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/9p/trans_fd.c:275:12: warning: unused variable 'failme' [-Wunused-variable]
   static int failme;
              ^
   1 warning generated.


vim +/failme +275 net/9p/trans_fd.c

   268	
   269	/**
   270	 * p9_read_work - called when there is some data to be read from a transport
   271	 * @work: container of work to be done
   272	 *
   273	 */
   274	
 > 275	static int failme;
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

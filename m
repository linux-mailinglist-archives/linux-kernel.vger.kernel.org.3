Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2695A3B53
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 06:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiH1ECk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 00:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH1ECh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 00:02:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C773CBE6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661659356; x=1693195356;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FR/u5lcm476YZSGLivO5H2yhP3aL9f2MCcBl5AMyPyw=;
  b=Bxmn/ADy8Kyazi/rJP8xVR2yI5+hSVr8xQhSUfujgOe7WHn3tdUw9i8H
   mbaN4AqNdt6pv/W7rnaNJ9ncPtXYXduju8jFRnoFcw0SiDODriEanFbhC
   cVpvSikJOlKwrq5I+QEmKSYfuL3cAwsItYsrBJa1IaVkAt2ekcBkw3nyB
   oz7BspJWv5B9feec2d9zJlHdSbXIt2Yep+t2HQR63qk+5jgnNYTS0ft9l
   ttTmAIlVNYn49I4IiEAByj/jNxdjfzZMgFIwIa5BgbUmUXqDTsOU6I0HI
   FSu1bb024bOpVUuklk1MdZr+zqxOt6KtpXp6qA5xkayw4Mno5ckgamZjb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="381012309"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="381012309"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 21:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="939186516"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2022 21:02:33 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS9VJ-0000m7-0j;
        Sun, 28 Aug 2022 04:02:33 +0000
Date:   Sun, 28 Aug 2022 12:02:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>
Subject: [ammarfaizi2-block:herbert/cryptodev-2.6/master 34/64] ERROR:
 modpost: "aspeed_register_hace_hash_algs"
 [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
Message-ID: <202208281149.MsLVjPVH-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block herbert/cryptodev-2.6/master
head:   a9a98d49da52c5bf63cd8bbc1f33b52edec2e9c9
commit: 108713a713c7e4b7d07e6cd9b808503d5bb7089b [34/64] crypto: aspeed - Add HACE hash driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220828/202208281149.MsLVjPVH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/108713a713c7e4b7d07e6cd9b808503d5bb7089b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block herbert/cryptodev-2.6/master
        git checkout 108713a713c7e4b7d07e6cd9b808503d5bb7089b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "aspeed_register_hace_hash_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>> ERROR: modpost: "aspeed_unregister_hace_hash_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

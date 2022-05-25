Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071EF53425E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbiEYRq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiEYRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:46:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA75F9E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500781; x=1685036781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XaAdaYRmEX4q3+5JloUL5heNfATKBvuMIhBlEAf54yk=;
  b=UYyLRu93ZqH6ZMld31rA9g+pmG5f4tFkcBPFfycTa8duBJKw+O2eoAb6
   zDK3pbVta0UsOe186yWhuSyDD0qzA8NZM6vO1JGJvP/RC20AUfoD6gH0t
   mjnnQf8PuLYy/9LwHiV+luPYZs1rbD79xEvFdHGNQAMopIegWaKLO3WQo
   GHfe4HqtGZZrUXDLEaIP1/7midd/ZWBjOq5r4R4RUMYSmxJI/634C0Irb
   Oq9jT1taWZF5qvcUPyRdaA6ChPSroGfdb5jeJbKxtK53OYMiBt6USsRAl
   /3545/5CFpTpHtG7MpDu1KlyYXSUXpgxrdTgIdCsJHJqgGBmNZ3BrkP7Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="360278540"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360278540"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630449881"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2022 10:33:03 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntusY-0003C0-J7;
        Wed, 25 May 2022 17:33:02 +0000
Date:   Thu, 26 May 2022 01:32:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tzungbi-chrome-platform:dev 25/25] ERROR: modpost:
 "cros_kunit_ec_xfer_mock_addx"
 [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
Message-ID: <202205260106.UjRGjFFM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git dev
head:   c8065f6d478990cfc385d1d579972a75fc29605b
commit: c8065f6d478990cfc385d1d579972a75fc29605b [25/25] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_query_all()
config: arm64-randconfig-r006-20220524 (https://download.01.org/0day-ci/archive/20220526/202205260106.UjRGjFFM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git/commit/?id=c8065f6d478990cfc385d1d579972a75fc29605b
        git remote add tzungbi-chrome-platform https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git
        git fetch --no-tags tzungbi-chrome-platform dev
        git checkout c8065f6d478990cfc385d1d579972a75fc29605b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "cros_kunit_ec_xfer_mock_addx" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
>> ERROR: modpost: "cros_kunit_ec_xfer_mock_next" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
>> ERROR: modpost: "cros_kunit_ec_xfer_mock_add" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
>> ERROR: modpost: "cros_kunit_reset" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
>> ERROR: modpost: "cros_kunit_ec_xfer_mock" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

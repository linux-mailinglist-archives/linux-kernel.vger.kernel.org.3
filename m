Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A453716D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiE2Oyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiE2Oys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:54:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640F93476
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653836087; x=1685372087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g42OSt55RshNZX376pV48g4FOU4+F/GIqEJhU5EeFCg=;
  b=G5uP6jWMBl4M54OjwK8LLNZtApVZlk1bH20RamPZ0d/sOGTZWL5ErhYb
   8RNOI5L6XJ9Mfvtm32Mn9YuQ7hrztwKl3L8LWiYuTqGZ61kGmkHoXupj0
   HJNC66wJIajqdSrige19UkuwkbwttSc/3wYfVK1Jc6O/jmQHz3BwBdlOF
   k8h9APLPfcMmD8Pi8/X8M/zLWznPv3O7XqXe3OtXAO80JiGdt3FP+nSEV
   avAzrqkDxuyapb135saIOqj3m5Ai6t/yR+G0K9KJRwcsepzLhPrJhe79c
   EEzfqKLG3zSmS5803Epd6hkrRRAUS4+4Own6BYkz80ba2nyU0NsubdYZ5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="255296869"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="255296869"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 07:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="632300781"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2022 07:54:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvKJZ-00015C-6f;
        Sun, 29 May 2022 14:54:45 +0000
Date:   Sun, 29 May 2022 22:54:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Lee <ryan.lee.analog@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: ld.lld: error: assignment to symbol init_pg_end does not converge
Message-ID: <202205292206.HGk4JbY2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   664a393a2663a0f62fc1b18157ccae33dcdbb8c8
commit: b58581136770569d2ee4300b10c7c0d76bb86250 ASoC: max98396: add amplifier driver
date:   5 weeks ago
config: arm64-randconfig-r011-20220529 (https://download.01.org/0day-ci/archive/20220529/202205292206.HGk4JbY2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b58581136770569d2ee4300b10c7c0d76bb86250
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b58581136770569d2ee4300b10c7c0d76bb86250
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: assignment to symbol init_pg_end does not converge

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

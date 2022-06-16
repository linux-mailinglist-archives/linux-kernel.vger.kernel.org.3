Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC754E669
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377695AbiFPPwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiFPPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:52:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5783F43486
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655394726; x=1686930726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NpEvmHyeuNluAYqysIICIwtsPIGGLugLs7OjcXvDWpc=;
  b=neos5QkVG7yENS6y0teXSMZshY7JpHomoLXJUslBnhiwjCrSeRcZKJ3e
   xWo6uPA7ghBn9OkkdbA0Tbc4GpRtYbenQ7ii7tJCMIQzrOL7fWvuZikf4
   6XJ4/V4fVPvDDRmMmKYtZ0qQm1DMCp+mpKkxIuwqEmRanJLtGfqkAF31B
   wq6jcVO1UvDVYrdUQ/rFKZTDWAZl6/xFJeumKPFMU6m2JV6kgHZbYTHJj
   hiCXESQj9iykdWwcAeXtQsCL2yculD/TBa1Lo8vNSYzZJhNFJet6iLIXt
   Z0BE0w+jM6rbdXqWHAkuTrgcHkflulEnAFW6Ng4YKB6eUMnCS8OzTBIsc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276854341"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="276854341"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 08:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="589699889"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 08:52:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1rmu-000OW3-Jp;
        Thu, 16 Jun 2022 15:52:04 +0000
Date:   Thu, 16 Jun 2022 23:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .Level2InterruptVector.text VMA
 [0000000000000180,0000000000000193] overlaps section .data VMA
 [0000000000000000,00000000001a3bf7]
Message-ID: <202206162308.Ynhq4vSU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30306f6194cadcc29c77f6ddcd416a75bf5c0232
commit: c20e1117d9aa22c558646a1060ddd1dd042fb107 xtensa: add kernel ABI selection to Kconfig
date:   3 months ago
config: xtensa-randconfig-c023-20220616 (https://download.01.org/0day-ci/archive/20220616/202206162308.Ynhq4vSU-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c20e1117d9aa22c558646a1060ddd1dd042fb107
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c20e1117d9aa22c558646a1060ddd1dd042fb107
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .Level2InterruptVector.text VMA [0000000000000180,0000000000000193] overlaps section .data VMA [0000000000000000,00000000001a3bf7]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

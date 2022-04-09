Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE52C4FAAFE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiDIVkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiDIVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 17:40:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758626F7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649540304; x=1681076304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YlRobrTQ9cB5hUfMBRyvcvPet5xvdKlMzi8YSEKYzeM=;
  b=O2MliSDQD8uy2OlfTGiLVNH0T8BLkeva55IbY+YzmBkm+0waZsizquIY
   468S0Y4YXVST/biKwzmN0Bh1VoAudtiIXiLWozPv3SK/9xmOpJAiT/M33
   PobBwwKDJQj4eSYytCyW71QvjHe0THNdwCabzOKdICW772eLpWzuw/oAs
   MsBPVvEe9LIiLfk/qlkmUxkjM+cNZo7/dLnyJsp53Bv5q88O6iaYkEe9L
   8/kV7jD2Cs78f5Mf1nf/VKKnGlEtsxXMgv0YHQjvqo6olbVJioQJZPkKB
   vCsPdNvqx8TL+BYXhKntjqZMpwXUGYFM7KX05A2O1kYE6DZxS+yUhvmlD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="262092362"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="262092362"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 14:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="698842415"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2022 14:38:23 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndImk-0000Pz-OU;
        Sat, 09 Apr 2022 21:38:22 +0000
Date:   Sun, 10 Apr 2022 05:37:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:arm64-head-refactor-v3 20/31] ld.lld: error: undefined symbol:
 kaslr_init
Message-ID: <202204100546.UPgpZlI9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-head-refactor-v3
head:   9100077933636313b1b15d23cb9cc068a40d838d
commit: 47f4cfe71f69abd40ca9e64dab211434c00edb6c [20/31] arm64: head: relocate kernel only a single time if KASLR is enabled
config: arm64-randconfig-r021-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100546.UPgpZlI9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=47f4cfe71f69abd40ca9e64dab211434c00edb6c
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-head-refactor-v3
        git checkout 47f4cfe71f69abd40ca9e64dab211434c00edb6c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: kaslr_init
   >>> referenced by setup.c:316 (arch/arm64/kernel/setup.c:316)
   >>>               kernel/setup.o:(setup_arch) in archive arch/arm64/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

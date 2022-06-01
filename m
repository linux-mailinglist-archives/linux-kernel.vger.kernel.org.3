Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8653AF4D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiFAVki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiFAVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:40:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1702F398
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654119630; x=1685655630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3POCBbwqOjARhBc3ZqI5ZMr/1qxmHrTJpsMiys9Z118=;
  b=nLAVwlTkuOtwaZgkRT1WyDG2Ho9E/BR0mYDoL4t8GPBBP/IfupgamFVK
   fk13nt3seYw+cdQTSDSB6DGE8ReCKBeYBdTsg6gu0Op5byFmjAepspSz7
   0tLHNbci6hSSWtxZHkG+4fF+VXXQ9k5yxdZIU8i52FfCdIAzbjjSKjF46
   gklel3m050eQYGFbRkesPRUFAAsX3iDp3HdWvzgaTj/b5v9ihYSUMmH+M
   ra0C6DsJ0pNTBoGNmeT1OY+w3zwhJKtUGGZswey+1xTtcr0LQNW54u2b0
   R6PrOpvEyVqGXWF1sJ4TrIg3ImhEcJDZ2idgyI29z1NkgddRGgFsOw4+o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="273309239"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="273309239"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 14:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="552517538"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2022 14:40:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwW4k-0004Qw-Jk;
        Wed, 01 Jun 2022 21:40:22 +0000
Date:   Thu, 2 Jun 2022 05:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d14ba417]
Message-ID: <202206020537.Ffmlkawd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   700170bf6b4d773e328fa54ebb70ba444007c702
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   4 weeks ago
config: xtensa-randconfig-r031-20220531 (https://download.01.org/0day-ci/archive/20220602/202206020537.Ffmlkawd-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d14ba417]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

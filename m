Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF155B468
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiFZWey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFZWew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:34:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1242DE1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656282892; x=1687818892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JArio3EgAAd7o/bVeCA6B5SEJWYJbcjeN/79MCc9Ag4=;
  b=GaFpySWDfLoFgQFtXEXGcESO7/mgWtTiZJ6lsumzil3xScw/a7+jLnJC
   OJoURZL+/p7ym2flY6ahkD1b/IYske3FDJOxQuKzejpUjDYprE5/Je0ch
   yrtskUwKgAcg26HrMQjjGzj4e8SjQBt1nYxVl8sC0RqffQUElN4x15G+W
   Q0bCS+jqLvzo1Wl5oJ+lvQwb4iAHOKbaEduaJLyCO6yXv/n6fkCO3bI5i
   JWwEL98u8+Af0HfGEycyDgpSDFfCI/lQDRhzh8r/l/rHNKZnmvo2WORZU
   Dwa7S3Y+4hLt2lZkMbk7U+VdbiDEldHQQaiRItFhIEnDKwYPCqCVUiPpW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280078123"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="280078123"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 15:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="594041357"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2022 15:34:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5aqA-0007u3-N1;
        Sun, 26 Jun 2022 22:34:50 +0000
Date:   Mon, 27 Jun 2022 06:34:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 49/54] ERROR: modpost: "__divdi3"
 [drivers/misc/habanalabs/habanalabs.ko] undefined!
Message-ID: <202206270618.UyWHF3FD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   46d258b93c9e6795f366c8b5159b33cfeb7d3bd8
commit: bb6edeab4c9679a00b7bb85fb20fb0a11e015509 [49/54] habanalabs: add gaudi2 asic-specific code
config: riscv-randconfig-r032-20220626
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=bb6edeab4c9679a00b7bb85fb20fb0a11e015509
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout bb6edeab4c9679a00b7bb85fb20fb0a11e015509
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/misc/habanalabs/habanalabs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

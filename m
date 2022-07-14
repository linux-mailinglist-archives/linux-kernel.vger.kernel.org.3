Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B45757C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiGNWly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbiGNWlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:41:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFCE6EE85
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657838509; x=1689374509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=arBDwEgc+Jlz/Dr0C/Q+E6/8AvlYSZ56uMlzXBp70ZM=;
  b=bgZZ49Me9NaUpH6LJyRLsUAczLBI/56JoBUM9ehf2VnwNj527PcqoV91
   YoF3pngpW4ppP/FAGzbj5nYjwK56/WyYRQCJCIGpx2uDoq420u+29mol4
   8yglAcCOVKfnWTuAOHmQpgmbRZlUYz4PGLyhmV9UcIZ2SxzNnAz2Jb8W8
   vwH8Fr7TKebC9sLaXv98/xF8gmb000el40qHjwP7R9lDt7cdzM3HK+Cxf
   oRZ3yNJqr7eI81aWywZWWFHmrT5ovZMzwMa+oBspE/ZxooGX1AdSerwmW
   JZ33ENJ5Ujx5YGNNBqA/3j/jJuYhYvp2lqFAdC2D/OlPYubLjBLptASlZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286783735"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286783735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663958795"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 15:41:48 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC7Wl-0001EY-Dg;
        Thu, 14 Jul 2022 22:41:47 +0000
Date:   Fri, 15 Jul 2022 06:40:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:lkdtm 2/3] drivers/misc/lkdtm/lkdtm.o: warning: objtool:
 bad .discard.retpoline_safe entry
Message-ID: <202207150619.JN2TT9Qo-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git lkdtm
head:   91b11c81a070d7a1c75c467ccf6703b01cf78cfb
commit: 26fe5d8405b16b3153bdb867dda090256a561b80 [2/3] lkdtm: Disable return thunks in rodata.c
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220715/202207150619.JN2TT9Qo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=26fe5d8405b16b3153bdb867dda090256a561b80
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe lkdtm
        git checkout 26fe5d8405b16b3153bdb867dda090256a561b80
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/lkdtm/lkdtm.o: warning: objtool: bad .discard.retpoline_safe entry

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

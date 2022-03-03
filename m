Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8577F4CC3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiCCRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiCCRby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:31:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD419E0B6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646328667; x=1677864667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zRZLUIX8uEVckJ5UY6Uq1vgqvXkSt2grLaFVF7VRPDg=;
  b=SH6qBpy6dddB3Gzm3l5WPheDppRVTWsoFOiJskSYQDFxxj+Cd/Vb4g87
   z6+TdSl8rnTYIcdIJFhEr650glZt8pRHCxLKqvvnmATDdZs5fNb/+72eF
   nfMUCxASgqbQ/VWoc9073djb7zMHXCoyUGwcAtx25rGdHazB/GpOwrj1A
   y87kP39qxFPPAZyvieOz1eY2wv4d1CqkBhgB8WTGXxVekILWfFJ0kPvxe
   TJbuHlA1su9095fzVzekXU5CK4773qR9UgGOqybZZFnCUzqZAcYzDh8Oz
   d381y3a4ycoGnciw6Eiuwz0ZWpkJVUrItjnCFcGOlN2JBY0AvgWdvA1TI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="233706049"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="233706049"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642195802"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 09:31:05 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPpI8-0000mV-BM; Thu, 03 Mar 2022 17:31:04 +0000
Date:   Fri, 4 Mar 2022 01:30:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: /tmp/ccc6Wvsr.s: Warning: relax hint unrecognized instruction: line
 8743.
Message-ID: <202203040124.0tu5hdNT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5859a2b1991101d6b978f3feb5325dad39421f29
commit: d86ba831656611872e4939b895503ddac63d8196 sched: Don't make LATENCYTOP select SCHED_DEBUG
date:   11 months ago
config: nds32-randconfig-r026-20220303 (https://download.01.org/0day-ci/archive/20220304/202203040124.0tu5hdNT-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d86ba831656611872e4939b895503ddac63d8196
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d86ba831656611872e4939b895503ddac63d8196
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   /tmp/ccc6Wvsr.s: Assembler messages:
>> /tmp/ccc6Wvsr.s: Warning: relax hint unrecognized instruction: line 8743.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

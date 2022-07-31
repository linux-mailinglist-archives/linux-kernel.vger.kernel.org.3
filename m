Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25723585E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiGaIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGaIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:12:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653B764F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659255119; x=1690791119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nMRwbMAi7X7I4fErnrYTv8ljV5jaXU8URnoanTQeRIg=;
  b=gwlpekm0o88pU/JfY30z06km1xZQ0qc1vrP1SqZU8NOpWW5068EstTlK
   o/5aXm+ELLOB49LBPWp07gqXALFyEZYuT6Ji1t4YRkFz3dlgAIbga0eEl
   Q94uWq5rusGjX4sUvrPh2+CEvmgEF1YB9QbRBm0MwqxvLq+9mqte0xHSs
   7yvFGDogWh+xDMrD1R6g/jT7phEzCgrk8tXXDJpE16foNtsegIzzW58AI
   OSsuxh3pS4FIJ5WhGL92Ew5+757wZF3BogV5rAHgYjqs02DkFjWsdbeJp
   o3Z1dd3JQtYisUmt0wnuxcuhD+vnfpFq9SVZ+7QhknyS80lxGdg3h5uWH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="287734634"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="287734634"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 01:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="669718660"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2022 01:11:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI43I-000Dtv-37;
        Sun, 31 Jul 2022 08:11:56 +0000
Date:   Sun, 31 Jul 2022 16:11:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 55/57]
 /tmp/ccGJD37f.s:28: Error: junk `(pcpu_hot+16)' after expression
Message-ID: <202207311623.Z9xI24Nc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   f6f6bdabacc1d7c5fc82f3e0b1c1f80185332dc4
commit: a7dde031ed574ce9d7eb18f8d737fdee06edd4d8 [55/57] x86/ftrace: Make it call depth tracking aware
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220731/202207311623.Z9xI24Nc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a7dde031ed574ce9d7eb18f8d737fdee06edd4d8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout a7dde031ed574ce9d7eb18f8d737fdee06edd4d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /tmp/ccGJD37f.s: Assembler messages:
>> /tmp/ccGJD37f.s:28: Error: junk `(pcpu_hot+16)' after expression

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

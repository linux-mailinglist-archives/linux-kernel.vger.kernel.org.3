Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4960B524244
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiELCBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiELCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:01:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318C36E3A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652320868; x=1683856868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GsRj3Tw/Y+iM4xxRr6AIFhOLcxZVs59DJKNOXzVPb2I=;
  b=hm3BhYLDbtQEDhTAUvhyLW94cvXzub+6kmdMHK6Hp11NQE1zIyQ7yLPF
   vc703LLk4YM5hh4VwS9R/sreU+l9KAifJ4+jM8jBhXzkKYn4Ot6ixm4Tk
   JYkhJ1dDe95xq+lSb4mGtypP/2QrSf58wJG6WSh9KnvMGI88iyncQ7gl5
   tJ3WUQvfWWOXJuL3PWThmt11njtmTU3sZQQ6OGst0iZvdzbUJ2RXcx/hd
   LDWRrDXR7gKVLuRSQkWz+VMjmvwmFuFMbMYUzbU8NXNXHCHAAU0b1TOxY
   7PeJdcZsQbLXYscyH2OFZ0OUkhSMVxss5bwTdlz3X6bYRQSFasB98rv5p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249757355"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249757355"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 19:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="895595043"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2022 19:01:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noy8X-000JpQ-Ii;
        Thu, 12 May 2022 02:01:05 +0000
Date:   Thu, 12 May 2022 10:00:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 146/150]
 kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable
 instruction
Message-ID: <202205120956.qLpGQurX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   305e905f70311e1b49cc730931a19c3e364f4d8c
commit: 45dc9d706619a6814e4063d5431483f94badb5a1 [146/150] x86: Add straight-line-speculation mitigation
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120956.qLpGQurX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/45dc9d706619a6814e4063d5431483f94badb5a1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 45dc9d706619a6814e4063d5431483f94badb5a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable instruction
--
>> mm/madvise.o: warning: objtool: madvise_behavior()+0x69: unreachable instruction
--
>> kernel/bpf/btf.o: warning: objtool: __btf_resolve_size()+0x72: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

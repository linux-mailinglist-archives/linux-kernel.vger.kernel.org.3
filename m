Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A751905E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiECVng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiECVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:43:31 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72244163B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=CfopeFe3H/A8vPpMT7xJVWvUlDJ21LoFetMt2Pp0qZk=;
  b=tVl8QzDU3BFWzU130gwr0KR1kCeRWZBVhtrBl1qLpnnpsMpAsJfIG5Jc
   +wwqnXuX9AUIrH9oSJ+Hyl9PwGS3PzZRej+8kOw4uepdEUViPYzYgu1dy
   0Y/I3oPQW8olJMBR9pnLQeA9mYduZ+6U3F7WG24A2e02MFr8VE8edz08B
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,196,1647298800"; 
   d="scan'208";a="13113821"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 23:39:55 +0200
Date:   Tue, 3 May 2022 23:39:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: [asahilinux:bits/130-cpufreq 3/4] drivers/cpufreq/apple-soc-cpufreq.c:279:54-55:
 attr: first occurrence line 284, second occurrence line 291 (fwd)
Message-ID: <alpine.DEB.2.22.394.2205032339181.2886@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two initializations of the attr field.

julia

---------- Forwarded message ----------
Date: Tue, 3 May 2022 19:37:32 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [asahilinux:bits/130-cpufreq 3/4]
    drivers/cpufreq/apple-soc-cpufreq.c:279:54-55: attr: first occurrence line
    284, second occurrence line 291

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: linux-kernel@vger.kernel.org
TO: Hector Martin <marcan@marcan.st>

tree:   https://github.com/AsahiLinux/linux bits/130-cpufreq
head:   b7105141d60ddab11c03955ae5389fc7f2a369da
commit: 3580ed2b7ae9f66539990a47a90aa71308dab079 [3/4] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
:::::: branch date: 20 hours ago
:::::: commit date: 20 hours ago
config: arm64-randconfig-c023-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031934.CchZIQh3-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


cocci warnings: (new ones prefixed by >>)
>> drivers/cpufreq/apple-soc-cpufreq.c:279:54-55: attr: first occurrence line 284, second occurrence line 291

vim +279 drivers/cpufreq/apple-soc-cpufreq.c

3580ed2b7ae9f66 Hector Martin 2022-02-15  278
3580ed2b7ae9f66 Hector Martin 2022-02-15 @279  static struct cpufreq_driver apple_soc_cpufreq_driver = {
3580ed2b7ae9f66 Hector Martin 2022-02-15  280  	.name		= "apple-cpufreq",
3580ed2b7ae9f66 Hector Martin 2022-02-15  281  	.flags		= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
3580ed2b7ae9f66 Hector Martin 2022-02-15  282  			  CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
3580ed2b7ae9f66 Hector Martin 2022-02-15  283  	.verify		= cpufreq_generic_frequency_table_verify,
3580ed2b7ae9f66 Hector Martin 2022-02-15 @284  	.attr		= cpufreq_generic_attr,
3580ed2b7ae9f66 Hector Martin 2022-02-15  285  	.get		= apple_soc_cpufreq_get_rate,
3580ed2b7ae9f66 Hector Martin 2022-02-15  286  	.init		= apple_soc_cpufreq_init,
3580ed2b7ae9f66 Hector Martin 2022-02-15  287  	.exit		= apple_soc_cpufreq_exit,
3580ed2b7ae9f66 Hector Martin 2022-02-15  288  	.target_index	= apple_soc_cpufreq_set_target,
3580ed2b7ae9f66 Hector Martin 2022-02-15  289  	.fast_switch	= apple_soc_cpufreq_fast_switch,
3580ed2b7ae9f66 Hector Martin 2022-02-15  290  	.register_em	= cpufreq_register_em_with_opp,
3580ed2b7ae9f66 Hector Martin 2022-02-15 @291  	.attr		= apple_soc_cpufreq_hw_attr,
3580ed2b7ae9f66 Hector Martin 2022-02-15  292  };
3580ed2b7ae9f66 Hector Martin 2022-02-15  293

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

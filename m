Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7444E6A37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245478AbiCXVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiCXVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:25:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B87523D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648157036; x=1679693036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TFVmmE68w5PAlm1eCk6jW8LJhCaTqd9/hJZYjLamrY4=;
  b=ZFEBkdm4svlyFNsO91M7XbqHvMMopFC39A9D5UleN47m15yTjSIcqGDt
   wV03xoFlZGOqO9FGI622xeB2CnOsms6dfPmoWj2KZXrXn1srexGGL1w2P
   VyQC6/o1GUMlGwLN+7E/kP9i5u+t4qCLLDYAF6Uc76W73jADfZLmKMAZk
   aUIDCgf+wG3ZLbmLNg/r3UJn/hs/h4DLwsmAX+HcewtEvrTIeqFX39UdJ
   Mp3suNgfM7gY8ejcCcpPG62a54BWjL1kHp5SrzGNPhDnme9AuorhPssBj
   rsE2rWQHZAU/K2jui7lEoW/rHdoPjA2KlNf1BGDFO0C7ydfqc4YLoslpu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="239096510"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="239096510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 14:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="501551845"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2022 14:23:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXUvy-000LSJ-GJ; Thu, 24 Mar 2022 21:23:54 +0000
Date:   Fri, 25 Mar 2022 05:23:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuri Nudelman <ynudelman@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [RFC PATCH ogabbay] habanalabs: hl_ts_behavior can be static
Message-ID: <20220324212311.GA31334@d379d0dc8a82>
References: <202203250539.2vJ8t5I0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203250539.2vJ8t5I0-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/misc/habanalabs/common/memory.c:2137:28: warning: symbol 'hl_ts_behavior' was not declared. Should it be static?

Fixes: 079c2434d6e8 ("habanalabs: convert ts to use unified memory manager")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/misc/habanalabs/common/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index a9bf1a5f4a867..003f0f145c090 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2134,7 +2134,7 @@ static int hl_ts_alloc_buf(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
 	return -ENOMEM;
 }
 
-struct hl_mmap_mem_buf_ops hl_ts_behavior = {
+static struct hl_mmap_mem_buf_ops hl_ts_behavior = {
 	.mmap = hl_ts_mmap,
 	.alloc = hl_ts_alloc_buf,
 	.release = ts_buff_release,

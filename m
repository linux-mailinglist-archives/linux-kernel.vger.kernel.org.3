Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44D57865E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiGRP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiGRP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:28:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813E29833;
        Mon, 18 Jul 2022 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658158103; x=1689694103;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oBAC0uBsnllVtRcBgr6VIc30v+nLQVx0Zviwvr2nGSc=;
  b=dJ2Ethx/oAki115zzUr/I4LgRI/ty99EGqXEjcUUce8kv/HZsDa3A1MU
   V4iFXECQiuwIfMv/bLJoN2fUNEQi398I3jbqaDbI2pbzwpuAW3etyv2Dn
   ptGg8e2JZ363nhWJuvp79ym4/ITwr0waVEWfaZLuXLKxBKfbg8Ox7hVdY
   TmAXfl/tcbttVyfwBwiS/NIOzhfU9F9nKXfYl/8MIfv9gzCc1jS7EY1Ir
   7gMDybwVM84J/qJOgjc8HWk3od0O2ByYYWyWUFw7Q0CI3eowOt8bqL8XJ
   ZmkGY30bVQkMALMiA3YHm8lKlnhvFmeZsxezFRpdzEIFsyXGEHcNfLyBY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="347938715"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="347938715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 08:28:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="773776175"
Received: from jwconnol-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.102.92])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 08:28:21 -0700
Message-ID: <2a240c21041b5ac03b9dd3502b2f15fead96c341.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select:Unneeded semicolon
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 08:28:20 -0700
In-Reply-To: <20220718124907.7254-1-gaoxin@cdjrlc.com>
References: <20220718124907.7254-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 20:49 +0800, Xin Gao wrote:
> Unneeded semicolon
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
Thanks, I will add to PULL request.

> ---
>  tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/hfi-events.c
> b/tools/power/x86/intel-speed-select/hfi-events.c
> index 761375062505..f0ed69721308 100644
> --- a/tools/power/x86/intel-speed-select/hfi-events.c
> +++ b/tools/power/x86/intel-speed-select/hfi-events.c
> @@ -144,7 +144,7 @@ static int family_handler(struct nl_msg *msg,
> void *arg)
>                         continue;
>                 res->id = nla_get_u32(tb2[CTRL_ATTR_MCAST_GRP_ID]);
>                 break;
> -       };
> +       }
>  
>         return 0;
>  }


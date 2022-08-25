Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95C85A11F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiHYNX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbiHYNX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:23:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01CAA4DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661433806; x=1692969806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LO3mEZSh95GcI+TJnv4VjREZQLaJ80zWeeGmVQtCKV8=;
  b=mSfSWIwR1GY3AIu9Uyg/8alpMxPXLRcZxSzPFEWRLRTL7UR3v2wmWmrD
   878PJEiWsvWaiY6JnRXc7eKApsznKHAR8MUpZMLCV4cWpdTIMLbXL4CmG
   EVIUuECrUPIeE0cUiOsT/S3IKj8vTQ/jQg+sfCZS+610LkjUpsFM1sYVJ
   n8PbwL4+sgjewDa/uOndk4j5h2TFuRn1iAK8a9w8mr3jHba4PvwGBRiz2
   IyVYgFfpE4F6Wx1epGfl7d+ARgCqmrueo8RQdzqt312pIVFzi5qB5vBc1
   7PNQT+0wy2GuGuj/Oz5M6bHLwAYyMtyCTaSp5ERIo2J5bcV06Q4R16Raq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="380526934"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="380526934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="699454421"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2022 06:23:25 -0700
Received: from [10.252.208.112] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DC738580AE3;
        Thu, 25 Aug 2022 06:23:24 -0700 (PDT)
Message-ID: <e5466ae3-98c9-1e9e-3ddb-bdb0245b6b5c@linux.intel.com>
Date:   Thu, 25 Aug 2022 09:23:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/2] perf docs: Update the documentation for the save_type
 filter
Content-Language: en-US
To:     acme@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, Peter Zijlstra <peterz@infradead.org>
References: <20220816125612.2042397-1-kan.liang@linux.intel.com>
 <20220816125612.2042397-2-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220816125612.2042397-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

The kernel change has been merged into the tip perf/urgent branch.

Do you have any comments for the patch?
If it's OK for you, could you please pull this patch?

Thanks,
Kan

On 2022-08-16 8:56 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Update the documentation to reflect the kernel changes.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 099817ef5150..d5c57ac1ee0a 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -397,6 +397,9 @@ following filters are defined:
>  	- abort_tx: only when the target is a hardware transaction abort
>  	- cond: conditional branches
>  	- save_type: save branch type during sampling in case binary is not available later
> +		     For the platforms with Intel Arch LBR support (12th-Gen+ client or
> +		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
> +		     when the taken branch stack sampling is enabled.
>  
>  +
>  The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.

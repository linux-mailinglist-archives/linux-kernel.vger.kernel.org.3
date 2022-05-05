Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2B51C622
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382700AbiEERfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358276AbiEERfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:35:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95A4EDF3;
        Thu,  5 May 2022 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651771883; x=1683307883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5kviwjMy7qZmSa1Ad5Bhw2k+DZaCLblOJWtCR3UovUo=;
  b=UduVA7x7d0ZML/4rlUnsu8xDIzwzcSQsa9d9/w9BL+anWhyCi+GO3lyh
   W8rTPk5Fy/1htG65vqmJ2UH75ty4CYXcATRhUQVSz3CH5dLpRN9UhWKwb
   mr+oz5ZZ2sgqHk9wfUjnrF9W/WzfgssCHr56S9Yt8/oXy8Jw31O8tUERU
   JbEVySDhcIs/7o9d5kQKzXMu9Fs2HzCft5KDkAGPhMFU/xHaHT/UmSvD5
   q+NeWPhK5eJvcSCSBL4ACru0KfI0U0lxyN3P4FOtFUuMq2BhKTFBWxHY9
   r5GH2zC6y+CYhFZeWtUZsETNCbFOXTnird+mz7UI4kkMxMHxvE+3GqkFp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265787838"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="265787838"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:31:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="694766930"
Received: from evegaag-mobl1.amr.corp.intel.com (HELO [10.209.187.127]) ([10.209.187.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:31:21 -0700
Message-ID: <a29146f2-271b-8471-f846-15f0f50e614d@intel.com>
Date:   Thu, 5 May 2022 10:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/sgx: simplify the return expression of sgx_drv_init()
Content-Language: en-US
To:     cgel.zte@gmail.com, jarkko@kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220505021659.54210-1-chi.minghao@zte.com.cn>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220505021659.54210-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 19:16, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Folks, I'd really encourage you to spend your time elsewhere.  These
"cleanup" or "simplify" patches as a whole have high rates of bugs.  I
don't trust them.  Plus, they don't really make the code easier to
understand.


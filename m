Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D667257BC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiGTQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGTQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:56:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B232E13D48
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658336182; x=1689872182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Woc6UWDq2+BRcc4CzKLRhpy3mY4MRvHDNut4tWLTCSk=;
  b=KaAWBFuyL+cCz/E578jNO+5ccTjJ2XHALYh7aUt4vaHyqDUOTcRoda8H
   kBIFmRUbxWa93nf+d1xmy/9LjxaptY5bV7hFFv9xCox7jlxqHVvDDaDLP
   RRiXHe0zAnYMnSV0Xs1sZnOk4Gus8ZMQ3/y6vOya6WoxRv1JGoDMGS2vi
   t4ApII4Wjbo8kg0RjgX8PE1tQrb9HgolZiYukudWYUZ72vKAzEFU2PNcO
   Wb5XsQyGwIgtL/xat3/kPpIKqZ9IwBSOlrCw4oxEp6yW5OIpTkaJv5GuO
   9Dx8nJQYwMhdf9YaiPOCGfPqUcvQqtdRUMV5YdfmZV9NdG6zZxXL7i35f
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="373131210"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="373131210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:56:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="625740815"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.23.226]) ([10.213.23.226])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:56:18 -0700
Message-ID: <d8e59a7f-5eab-3c1b-c8d0-f16e07d63f18@intel.com>
Date:   Wed, 20 Jul 2022 18:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [Intel-gfx] [PATCH] drm/i915/selftests: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, daniel@ffwll.ch
Cc:     michal.winiarski@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        zhou1615@umn.edu
References: <20220716040520.31676-1-wangborong@cdjrlc.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220716040520.31676-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.2022 06:05, Jason Wang wrote:
> Fix the double `wait' typo in comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/gpu/drm/i915/selftests/i915_request.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
> index c56a0c2cd2f7..ec05f578a698 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -971,7 +971,7 @@ static struct i915_vma *empty_batch(struct drm_i915_private *i915)
>   	if (err)
>   		goto err;
>   
> -	/* Force the wait wait now to avoid including it in the benchmark */
> +	/* Force the wait now to avoid including it in the benchmark */
>   	err = i915_vma_sync(vma);
>   	if (err)
>   		goto err_pin;

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

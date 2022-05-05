Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95F51BC37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353617AbiEEJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353861AbiEEJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:36:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34496C0E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651743159; x=1683279159;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JX2aXgs0DY5hqhZ8ebKIttwLrY/s9wjmlu8j1YvvEw4=;
  b=OE4m6P10CViW9yauNZAbD79ucHUmW9tfaeC5ZtakkDtUnCEIR862HVXh
   jQMMTVOE4aRiSrPGwYBkK39a1P5WFml7GYGPj4xOi2Yv89CaG9inhJVQB
   sIDElApz9IcEi51o0Bd7XmLr7Y0EJNE4HHQprLGBJuWUg8xkkJDnP2wDw
   kqzOoGBliM3BnAwmMMnPDLfJ+wsFwI/8xLRrvwkWCpOmlQQLllQbCm3B0
   CB5/uXNaV16N8+0jv+1lEcIstmkvnnglDATP4BtVx35obcbehBwV6FGis
   7Fw1wipAI3+Vn4dimExuKRwqxjxp19JDsZWAqy1kjycYkNTRkoCwv1SFZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="331043052"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="331043052"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:32:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="585235218"
Received: from mstepka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.134.211])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:32:34 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     cgel.zte@gmail.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drm/i915: simplify the return expression of
 i915_driver_open()
In-Reply-To: <20220505021625.54146-1-chi.minghao@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220505021625.54146-1-chi.minghao@zte.com.cn>
Date:   Thu, 05 May 2022 12:32:30 +0300
Message-ID: <87zgjwl3yp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 May 2022, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Simplify the return expression.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

No, I don't want this. Please stop sending these return expression
"simplifications". The cocci script to do this was removed in commit
b784c7707502 ("coccinnelle: Remove ptr_ret script") specifically to stop
these changes. Please read the commit message for that.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/i915_driver.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index 09de45d3e274..d11a7445909a 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -977,13 +977,8 @@ static void i915_driver_release(struct drm_device *dev)
>  static int i915_driver_open(struct drm_device *dev, struct drm_file *file)
>  {
>  	struct drm_i915_private *i915 = to_i915(dev);
> -	int ret;
>  
> -	ret = i915_gem_open(i915, file);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return i915_gem_open(i915, file);
>  }
>  
>  /**

-- 
Jani Nikula, Intel Open Source Graphics Center

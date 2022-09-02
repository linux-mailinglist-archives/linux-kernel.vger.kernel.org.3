Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063E5AB52F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiIBPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiIBPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:30:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A6D27FC1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662131400; x=1693667400;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wWMpqvCncpQ0igL6EgTNw46yovYs+LC364xY615QjDA=;
  b=hCg7yooMb2ZSV5NRfnTatRuSQeOoIY63AV8y7NpUnMlGa/Um4LwKGmoj
   4U5pRoZV/tzshSIw6DNr8YNqKx5dG6llnlfP0CIloXncn3QSYIfoPpStR
   xu3l7WzkT0zUbXqzglAzXVCw6g9EhBkGhv7cHVNFYhSOHD1lnbET1FBlA
   J5pEqyoJSzSjwZSx+DNq+UJ8ut07kIGpuhtB3qusSkzB5b6e5AICAMq4y
   11/ooKZv79ZaOckgYWevRQs/z9McXvjk5jUPRa/AAe4yD8D3gUK3dJhFg
   yy/20H44udLBU29Diq9b5c24cBx7lM0kAexPRXCvqHiG+BE1kx7w9PWhP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="297285571"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="297285571"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 08:10:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="642937799"
Received: from svandene-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 08:09:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     cgel.zte@gmail.com, joonas.lahtinen@linux.intel.com
Cc:     tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        Zeal Robot <zealci@zte.com.cn>,
        zhang songyi <zhang.songyi@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/i915: Remove the unneeded result variables
In-Reply-To: <87bkrxddgu.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220902092027.320738-1-zhang.songyi@zte.com.cn>
 <87bkrxddgu.fsf@intel.com>
Date:   Fri, 02 Sep 2022 18:09:46 +0300
Message-ID: <878rn1dd8l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Sep 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Fri, 02 Sep 2022, cgel.zte@gmail.com wrote:
>> From: zhang songyi <zhang.songyi@zte.com.cn>
>>
>> Return the mul_u32_fixed16() and div_fixed16() directly instead of
>>  redundant variables.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
>
> NAK.

And to explain this rude reply to our friendly community:

There's never *any* response to my review comments from
cgel.zte@gmail.com, so I can't be bothered to write anything more than
just "NAK".


>
>
> BR,
> Jani.
>
>
>> ---
>>  drivers/gpu/drm/i915/intel_pm.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
>> index 210c1f78cc90..a6757ed9081a 100644
>> --- a/drivers/gpu/drm/i915/intel_pm.c
>> +++ b/drivers/gpu/drm/i915/intel_pm.c
>> @@ -5272,7 +5272,6 @@ skl_wm_method2(u32 pixel_rate, u32 pipe_htotal, u32 latency,
>>  	       uint_fixed_16_16_t plane_blocks_per_line)
>>  {
>>  	u32 wm_intermediate_val;
>> -	uint_fixed_16_16_t ret;
>>  
>>  	if (latency == 0)
>>  		return FP_16_16_MAX;
>> @@ -5280,8 +5279,8 @@ skl_wm_method2(u32 pixel_rate, u32 pipe_htotal, u32 latency,
>>  	wm_intermediate_val = latency * pixel_rate;
>>  	wm_intermediate_val = DIV_ROUND_UP(wm_intermediate_val,
>>  					   pipe_htotal * 1000);
>> -	ret = mul_u32_fixed16(wm_intermediate_val, plane_blocks_per_line);
>> -	return ret;
>> +
>> +	return mul_u32_fixed16(wm_intermediate_val, plane_blocks_per_line);
>>  }
>>  
>>  static uint_fixed_16_16_t
>> @@ -5290,7 +5289,6 @@ intel_get_linetime_us(const struct intel_crtc_state *crtc_state)
>>  	struct drm_i915_private *dev_priv = to_i915(crtc_state->uapi.crtc->dev);
>>  	u32 pixel_rate;
>>  	u32 crtc_htotal;
>> -	uint_fixed_16_16_t linetime_us;
>>  
>>  	if (!crtc_state->hw.active)
>>  		return u32_to_fixed16(0);
>> @@ -5301,9 +5299,8 @@ intel_get_linetime_us(const struct intel_crtc_state *crtc_state)
>>  		return u32_to_fixed16(0);
>>  
>>  	crtc_htotal = crtc_state->hw.pipe_mode.crtc_htotal;
>> -	linetime_us = div_fixed16(crtc_htotal * 1000, pixel_rate);
>>  
>> -	return linetime_us;
>> +	return div_fixed16(crtc_htotal * 1000, pixel_rate);
>>  }
>>  
>>  static int

-- 
Jani Nikula, Intel Open Source Graphics Center

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D05596C96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiHQKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:07:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5E152DD9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660730826; x=1692266826;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VY9HmC06/GiqH+NWWRi/loTPdaF13nBoTTrKrW/3CaY=;
  b=SY01SDr+k59QGO2aKkSgthiyZjokYFcMpFD9TzQTFcp0QM71Rlm17afB
   cIRYwmsWnfbApP0GSvQA9wL7znZunzOQS0z/iLfLisX4MIG1X8UyOAa6P
   GXoDfFUnrVZCV4yxZkveKtyIY9gH+gfeHnKOoID2TH7FaeftTO+S5VllD
   tiQ8Nb1noLNciAV/aaWUJpBSo95RbxhpqgRvobhePYCADshP9MWH4lTAR
   NCZbi57K44nkO0gsebUKgip/6bzuvFKE6eqoqN1wSx1mrYjn47c8Rbvdp
   uvxqxXgYLTPu6RqVXl2IWQYBq5k748LY4ePUzSIcB4t55ao70/hbJ6Tij
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="292451537"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="292451537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:07:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667548356"
Received: from sbammi-mobl.amr.corp.intel.com (HELO localhost) ([10.252.49.167])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:07:03 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bo Liu <liubo03@inspur.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] drm/i915: Fix all occurences of the "the the" typo
In-Reply-To: <20220816094919.5419-1-liubo03@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220816094919.5419-1-liubo03@inspur.com>
Date:   Wed, 17 Aug 2022 13:07:01 +0300
Message-ID: <87h72bp4je.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022, Bo Liu <liubo03@inspur.com> wrote:
> There is an unexpected word "the" in the file i915_irq.c,
> fix it.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Thanks for the patch, pushed to drm-intel-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/i915_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index 73cebc6aa650..783a6ca41a61 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -65,7 +65,7 @@
>  
>  /*
>   * Interrupt statistic for PMU. Increments the counter only if the
> - * interrupt originated from the the GPU so interrupts from a device which
> + * interrupt originated from the GPU so interrupts from a device which
>   * shares the interrupt line are not accounted.
>   */
>  static inline void pmu_irq_stats(struct drm_i915_private *i915,

-- 
Jani Nikula, Intel Open Source Graphics Center

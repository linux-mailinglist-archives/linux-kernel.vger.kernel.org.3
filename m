Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD35956D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiHPJoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiHPJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:43:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7790A5FAC5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660640001; x=1692176001;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=K6Og00L1IjRsIWgGWRQD8kVwArgaWlic4/wfGISF5fQ=;
  b=jBBY9h3HC15yJVNSxYeo82/9v9hvsDpam31ynIJN+coH5eThUNaCxtiT
   EKLKTjz3qF/F7Yqu7BS13MyUTgEVN7zNNBTwoegxJLzBlnemIxs5xne/P
   cnUzs5riBzNYuJbYQ3YJDP4sQBxusbHZ+WAvXRItUzbEGCnoFYh8XiJGr
   sfqAYfIdEncvfo+/WdE3Sq9e1zx0ZAX43laTANv9l3kcXHoN/QZdwDcj7
   cX3JNC2uUHutseRJXkOHCpEPo/olmqs6qe4Hvi816fPoOvW3KDo2YGBLn
   pNmRWjWlBBN9I4EPTIpfnGOJvzbT4wUTBkmBHo12R5q/g0Zv1848zTplb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378456011"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378456011"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:53:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="583220366"
Received: from kinzelba-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.194])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:53:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bo Liu <liubo03@inspur.com>, airlied@linux.ie, daniel@ffwll.ch,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, linus.walleij@linaro.org,
        thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] drm: Fix all occurences of the "the the" typo
In-Reply-To: <20220816083759.4382-1-liubo03@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220816083759.4382-1-liubo03@inspur.com>
Date:   Tue, 16 Aug 2022 11:53:14 +0300
Message-ID: <87edxgr2md.fsf@intel.com>
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

On Tue, 16 Aug 2022, Bo Liu <liubo03@inspur.com> wrote:
> There are double "the" in messages in file drm_dp_helper.c,
> i915_irq.c and panel-novatek-nt35510.c, fix it.

Please split to three patches.

BR,
Jani.

>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c       | 2 +-
>  drivers/gpu/drm/i915/i915_irq.c               | 2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt35510.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index e5bab236b3ae..32b295003f49 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
>  
>  /*
>   * Calculate the length of the i2c transfer in usec, assuming
> - * the i2c bus speed is as specified. Gives the the "worst"
> + * the i2c bus speed is as specified. Gives the "worst"
>   * case estimate, ie. successful while as long as possible.
>   * Doesn't account the "MOT" bit, and instead assumes each
>   * message includes a START, ADDRESS and STOP. Neither does it
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
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> index 40ea41b0a5dd..4085822f619a 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> @@ -231,7 +231,7 @@ struct nt35510_config {
>  	 * bits 0..2 in the lower nibble controls HCK, the booster clock
>  	 * frequency, the values are the same as for PCK in @bt1ctr.
>  	 * bits 4..5 in the upper nibble controls BTH, the boosting
> -	 * amplification for the the step-up circuit.
> +	 * amplification for the step-up circuit.
>  	 * 0 = AVDD + VDDB
>  	 * 1 = AVDD - AVEE
>  	 * 2 = AVDD - AVEE + VDDB

-- 
Jani Nikula, Intel Open Source Graphics Center

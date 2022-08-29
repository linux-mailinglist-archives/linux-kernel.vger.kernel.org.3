Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899EE5A4F65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiH2Ogz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiH2Ogr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:36:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A034F923C6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661783805; x=1693319805;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+4TOCeNd5iz1aL0fhEmhVh+hpLbLwO+LY5ZaMMmawU0=;
  b=VaVmqPbo/KCkuB1nVybCb68IHiMitTHYpmAiV7qiBQBn0XH6UY2tb7k0
   zN6qFYx125HlEHGoJedIo+mNXdncfW6SNf72JQErVpL1bM5u137qvVED3
   ocqYGgqDXGsfYX6jL5E2+F4xgAANjYb+2FZrIM+wnrkUQ6iROftvsgSCQ
   5fKP8IydD5NTRqQxTLa/aDgkZolMBr/5GuvsR2jTcnFuEQBPX0rGMqznF
   l/eAY/NSV1nry9DOsao47W6tU2Ls5Rx88AU87PP2NBwfeFxOQscVwLo+q
   ML+SjrA2jBNxib8ALeJBLu6d+PzKnbwRrjAQ4Anou9zqJoTe1vO+PqE8H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275306188"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="275306188"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:14:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="939591027"
Received: from idecesar-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.198])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:14:13 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     wangjianli <wangjianli@cdjrlc.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: Re: [PATCH] drm/i915: fix repeated words in comments
In-Reply-To: <20220823141639.13053-1-wangjianli@cdjrlc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220823141639.13053-1-wangjianli@cdjrlc.com>
Date:   Mon, 29 Aug 2022 17:14:02 +0300
Message-ID: <87y1v7dtn9.fsf@intel.com>
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

On Tue, 23 Aug 2022, wangjianli <wangjianli@cdjrlc.com> wrote:
>  Delete the redundant word 'the'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Already fixed by commit 78f48aa6f50b ("drm/i915/irq: Fix a "the the"
typo").

What is this sudden influx of patches fixing repeated words everywhere?

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

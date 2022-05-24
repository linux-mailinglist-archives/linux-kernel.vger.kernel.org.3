Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516F532877
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiEXLDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiEXLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:03:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F85D74DE7;
        Tue, 24 May 2022 04:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653390217; x=1684926217;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CntG2zT79s+rUqc/RwF4HmNc6O2cBy1aTPUYDsYRjjE=;
  b=dh2PDazC+Hias72hL+YjkQm+4NV8DToFrS9UKRxKmiS3wgYrkk72n1tB
   4HB9DvustuCf75leTsWV2XTHhp/g+hpBKnjrdGuwzenebYvPq94XzybWQ
   s1zPvooRPuxUqQc58hHj1Cq7cjoBqvpzVDjfb98Wbo4j8xSw5I9hLE9wb
   tRHKJV2SdjpVuqjKnF7vHEArIBNa7kuAcpq7eJf2rKGc5fr5CAZ5dQyk1
   VdQKcyihYFN9IuqXbLDzGRljMC7A+9nwHXaUA/KRi9xsK8iRezZJCDrWe
   y61FScKe9PRfstwWtCrQcDW0AHHOXQVMLSQa0AVm+V4d3ZYUIquxtL5Bu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273611125"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273611125"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 04:03:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="745175110"
Received: from zychseba-mobl.ger.corp.intel.com (HELO localhost) ([10.249.136.104])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 04:03:33 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: fix typos in comments
In-Reply-To: <20220521111145.81697-90-Julia.Lawall@inria.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220521111145.81697-90-Julia.Lawall@inria.fr>
Date:   Tue, 24 May 2022 14:03:29 +0300
Message-ID: <87ee0jw5tq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> Spelling mistakes (triple letters) in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks, pushed to drm-intel-next.

BR,
Jani.

>
> ---
>  drivers/gpu/drm/i915/display/intel_color.c           |    2 +-
>  drivers/gpu/drm/i915/display/intel_pps.c             |    2 +-
>  drivers/gpu/drm/i915/gt/intel_execlists_submission.c |    2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc_log.c           |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
> index 34128c9c635c..a27ce874a9e8 100644
> --- a/drivers/gpu/drm/i915/display/intel_color.c
> +++ b/drivers/gpu/drm/i915/display/intel_color.c
> @@ -1638,7 +1638,7 @@ static u32 icl_gamma_mode(const struct intel_crtc_state *crtc_state)
>  	/*
>  	 * Enable 10bit gamma for D13
>  	 * ToDo: Extend to Logarithmic Gamma once the new UAPI
> -	 * is acccepted and implemented by a userspace consumer
> +	 * is accepted and implemented by a userspace consumer
>  	 */
>  	else if (DISPLAY_VER(i915) >= 13)
>  		gamma_mode |= GAMMA_MODE_MODE_10BIT;
> diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
> index 5a598dd06039..4bc0563dde92 100644
> --- a/drivers/gpu/drm/i915/display/intel_pps.c
> +++ b/drivers/gpu/drm/i915/display/intel_pps.c
> @@ -509,7 +509,7 @@ static void wait_panel_power_cycle(struct intel_dp *intel_dp)
>  
>  	drm_dbg_kms(&i915->drm, "Wait for panel power cycle\n");
>  
> -	/* take the difference of currrent time and panel power off time
> +	/* take the difference of current time and panel power off time
>  	 * and then make panel wait for t11_t12 if needed. */
>  	panel_power_on_time = ktime_get_boottime();
>  	panel_power_off_duration = ktime_ms_delta(panel_power_on_time, intel_dp->pps.panel_power_off_time);
> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> index 86f7a9ac1c39..aa0d2bbbbcc4 100644
> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> @@ -1350,7 +1350,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
>  			 * submission. If we don't cancel the timer now,
>  			 * we will see that the timer has expired and
>  			 * reschedule the tasklet; continually until the
> -			 * next context switch or other preeemption event.
> +			 * next context switch or other preemption event.
>  			 *
>  			 * Since we have decided to reschedule based on
>  			 * consumption of this timeslice, if we submit the
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> index 78d2989fe917..02311ad90264 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> @@ -588,7 +588,7 @@ int intel_guc_log_relay_open(struct intel_guc_log *log)
>  	/*
>  	 * We require SSE 4.1 for fast reads from the GuC log buffer and
>  	 * it should be present on the chipsets supporting GuC based
> -	 * submisssions.
> +	 * submissions.
>  	 */
>  	if (!i915_has_memcpy_from_wc()) {
>  		ret = -ENXIO;
>

-- 
Jani Nikula, Intel Open Source Graphics Center

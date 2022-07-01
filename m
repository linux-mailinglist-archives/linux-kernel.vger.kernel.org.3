Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBB563CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiGAXwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGAXwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:52:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0263AA4E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656719540; x=1688255540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fz2wiKfFmrVcH55ZKmrhExo8xdAIBvOdZGwrzWkYW40=;
  b=Z1lFLPcHycSeKYmr6KE5pMGaZeV5Q8r2AVuS052Vc8xeBrNbPXzSLNl0
   XD1dPInR/bNeBThbRjP2CWNhw9VUc8Ett6a8Hj+WrIjM2zhdu95OCOLYl
   iIXHQ4mAdhuNiRSTYmF2+CIPsWp/YAACBRvHqT0bHEuSuPrUpmQZjl7+p
   FS+7mj/cdTbabvhdzI5xeXxLqxjS78xp4LCBVdFQm8KsMhiM1MKGHAa+p
   5FbG9ys2P8rpMc+JJWGun8B7H7aitjK47R+Fu+59Qfqz9jMgHr0xZ5xYi
   nGdu+foCyOxVkKJqEtZL/4u74Wx25MV4EJDdENLlV+d8GK577MrxhC3xh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="271539616"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="271539616"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 16:52:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="566504290"
Received: from mdroper-desk1.fm.intel.com (HELO mdroper-desk1.amr.corp.intel.com) ([10.1.27.134])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 16:52:19 -0700
Date:   Fri, 1 Jul 2022 16:52:17 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, jose.souza@intel.com,
        jouni.hogander@intel.com, gwan-gyeong.mun@intel.com,
        ville.syrjala@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: clean up comments
Message-ID: <Yr+IsQxHuq/SzPZa@mdroper-desk1.amr.corp.intel.com>
References: <20220701203236.1871668-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701203236.1871668-1-trix@redhat.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:32:36PM -0400, Tom Rix wrote:
> spelling changes
> resoluition -> resolution
> dont        -> don't
> commmit     -> commit
> Invalidade  -> Invalidate
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

and applied to drm-intel-next.  Thanks for the patch.


Matt

> ---
>  drivers/gpu/drm/i915/display/intel_psr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 7d61c55184e5..e6a870641cd2 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -555,7 +555,7 @@ static void hsw_activate_psr2(struct intel_dp *intel_dp)
>  		/*
>  		 * TODO: 7 lines of IO_BUFFER_WAKE and FAST_WAKE are default
>  		 * values from BSpec. In order to setting an optimal power
> -		 * consumption, lower than 4k resoluition mode needs to decrese
> +		 * consumption, lower than 4k resolution mode needs to decrease
>  		 * IO_BUFFER_WAKE and FAST_WAKE. And higher than 4K resolution
>  		 * mode needs to increase IO_BUFFER_WAKE and FAST_WAKE.
>  		 */
> @@ -959,7 +959,7 @@ void intel_psr_compute_config(struct intel_dp *intel_dp,
>  	int psr_setup_time;
>  
>  	/*
> -	 * Current PSR panels dont work reliably with VRR enabled
> +	 * Current PSR panels don't work reliably with VRR enabled
>  	 * So if VRR is enabled, do not enable PSR.
>  	 */
>  	if (crtc_state->vrr.enable)
> @@ -1664,7 +1664,7 @@ static void intel_psr2_sel_fetch_pipe_alignment(const struct intel_crtc_state *c
>   *
>   * Plane scaling and rotation is not supported by selective fetch and both
>   * properties can change without a modeset, so need to be check at every
> - * atomic commmit.
> + * atomic commit.
>   */
>  static bool psr2_sel_fetch_plane_state_supported(const struct intel_plane_state *plane_state)
>  {
> @@ -2203,7 +2203,7 @@ static void _psr_invalidate_handle(struct intel_dp *intel_dp)
>  }
>  
>  /**
> - * intel_psr_invalidate - Invalidade PSR
> + * intel_psr_invalidate - Invalidate PSR
>   * @dev_priv: i915 device
>   * @frontbuffer_bits: frontbuffer plane tracking bits
>   * @origin: which operation caused the invalidate
> -- 
> 2.27.0
> 

-- 
Matt Roper
Graphics Software Engineer
VTT-OSGC Platform Enablement
Intel Corporation

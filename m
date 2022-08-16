Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F25958B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiHPKo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiHPKoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:44:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04887F0765
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644210; x=1692180210;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QbCT1sLbylKU8NArDQzZ1P96rD3BVMmOXRpXN7woAJk=;
  b=LhKw8/G9CzzBQSjFLcbQ4XcfRs9N2AtkvGoZIDL6fORFIfGSw4a8xJw/
   NTJDcZjaD9Dm3q97YZ70r6RLt9tO+H5K1jxSl/rGNTCqd2ifAVAwBSew2
   1BiAWJdCSlSGc4vTfuftM+yPlERI+4a+oqxdJInBym9aHsvvu0cpYT+OU
   AqbkOLuotgpbWbyVY42DbpjYrwJgK44T4+wYyx8fYmlkYanohGN42H2qO
   scXfkx5BHifw3HwYcQeM3ovmDkpIo8L5t2A8u1ln/xVaarFpw2I8c2DDR
   oLioG/vknxkw2GTQtVIobT3zmhYDjUFwYdg659V3vcS4uwv0J7KPlWsfQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290930980"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290930980"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:03:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667044414"
Received: from kinzelba-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.194])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:03:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH 3/3] i915-pmu: Add extra check NULL
In-Reply-To: <20220816092525.37670-1-arefev@swemel.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220816092525.37670-1-arefev@swemel.ru>
Date:   Tue, 16 Aug 2022 13:03:24 +0300
Message-ID: <878rnoqzdf.fsf@intel.com>
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

On Tue, 16 Aug 2022, Denis Arefev <arefev@swemel.ru> wrote:
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

The subject prefix should be something along the lines of
"drm/i915/pmu".

The subject is misleading; there are no functional changes here, just
whitespace changes. I'm guessing you intended to send something else?

Finally, the commit message is primarily for describing why the change
is being made, not to advertize organizations or tools.


BR,
Jani.


>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 34a7f0ef1f67..33db49ffac3d 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -704,8 +704,7 @@ static void i915_pmu_disable(struct perf_event *event)
>  		 * Decrement the reference count and clear the enabled
>  		 * bitmask when the last listener on an event goes away.
>  		 */
> -		if(engine != NULL)
> -		{
> +		if (engine != NULL) {
>  		        if (--engine->pmu.enable_count[sample] == 0)
>  			        engine->pmu.enable &= ~BIT(sample);
>  		}

-- 
Jani Nikula, Intel Open Source Graphics Center

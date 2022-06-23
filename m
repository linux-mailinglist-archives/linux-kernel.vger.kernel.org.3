Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC25582D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiFWRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiFWRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:18:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A789B550
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656003624; x=1687539624;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=J9s/LpFILeLPTlseYxUrJteIVRlhiZdWHoHvHoBnIYU=;
  b=gc7Wx7vCmeJZE0/Wb6nF63L3okTIW8USO6hva5J5G1MY0STnW3VqVguP
   KtWwrAwcPEifNqPp57Zqw/gSIzuqR0xztpQ/P9YytI1eOqDJzL5gG40V/
   rYDxZzJZi7VO/sf26np0Ij83r5OhD7TCLfdvfGCmDPoLBAYnyG1Ll7iQV
   15fl5DQnllCAY6e1M85VVZ9zAP81FvqXQAMOsg4gcMxifXc0R44KXJYAm
   HXqfNgUV7Zj1giGl+EdzpEPUFH9B0dwCUQ5PrzvX87t6boWP32FrJqjDp
   DfCiqJrrPIXIPtMfoOZd3uUv5ngkSuEZGPT2RCVCNh96xm9SzP766QpQn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279544659"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="279544659"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:00:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="834723685"
Received: from anefedov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.38.20])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:00:15 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: Re: [PATCH] GPU: drm: i915: drop unexpected word 'for' in comments
In-Reply-To: <20220623101113.28470-1-jiangjian@cdjrlc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220623101113.28470-1-jiangjian@cdjrlc.com>
Date:   Thu, 23 Jun 2022 20:00:11 +0300
Message-ID: <871qvfnwmc.fsf@intel.com>
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

On Thu, 23 Jun 2022, Jiang Jian <jiangjian@cdjrlc.com> wrote:
> there is an unexpected word 'for' in the comments that need to be dropped

While it's also unexpected, it's really *duplicated* word.

> file - drivers/gpu/drm/i915/i915_reg.h
> line - 2537
>
>  * Please check the detailed lore in the commit message for for experimental
>
> changed to:
>
>  * Please check the detailed lore in the commit message for experimental
>

The above is just duplication of the patch itself, and completely
unnecessary.

The patch subject prefix should be something like "drm/i915:" or
"drm/i915/reg:".

Pro-tip for figuring out good guesses of what the subject prefix should
be:

$ git log --since={5-year} --no-merges --pretty=format:%s -- drivers/gpu/drm/i915/i915_reg.h | sed 's/:.*//' | sort | uniq -c | sort -rn | head
    312 drm/i915
    113 drm/i915/icl
     57 drm/i915/tgl
     26 drm/i915/cnl
     25 drm/i915/display
     22 drm/i915/dg2
     16 drm/i915/psr
     14 drm/i915/gt
     14 drm/i915/adl_p
     12 drm/i915/dg1

The patch itself is fine, but I'm nitpicking on the commit message
because I've seen lots of patches like this, with the same kind of stuff
in the commit messages.

BR,
Jani.


> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/gpu/drm/i915/i915_reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
> index 616164fa2e32..738c020396af 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -2534,7 +2534,7 @@
>   * HDMI/DP bits are g4x+
>   *
>   * WARNING: Bspec for hpd status bits on gen4 seems to be completely confused.
> - * Please check the detailed lore in the commit message for for experimental
> + * Please check the detailed lore in the commit message for experimental
>   * evidence.
>   */
>  /* Bspec says GM45 should match G4X/VLV/CHV, but reality disagrees */

-- 
Jani Nikula, Intel Open Source Graphics Center

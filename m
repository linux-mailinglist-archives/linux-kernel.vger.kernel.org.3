Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98B0554364
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351788AbiFVGxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351767AbiFVGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:53:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736ADAE56
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655880789; x=1687416789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ABLekP1DeJgDEsR/LSwop4OZSr2BAo0sZd/g3m629qA=;
  b=jlwr/PO1toXzJjzNVWRYJXuBxgaHFXjyfB53TZI1Kt5BvC9KvmQzpoFh
   GD8fDp1wYlDzQYZ99Jr12zrmd4LyK5BOb20InCVa+Jphi13xJcar68HLC
   Q+J1S5hqMylAAwobA75BXMUG8AVPtOJz/j+2A5CeGr/5UtrbHFYUs4RV7
   CKJJ1K5U86CEOtx5a7qQRS+n82aeR2l/sCJuC8W2mwgAFxOcOg/OLTjQu
   X/xQ89ydGz7yuZ5KTWw2Qj9MqNKSsvXvJSbWaVn8XKgqalsA1r36PzbM6
   jQYn7q+lr0VYgQTOJ7GwFb/YAhz9JsebS3IsM0X8SAN1PpHrY5dD+hCtZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277881741"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="277881741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 23:53:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="615039874"
Received: from ebrazil-mobl1.amr.corp.intel.com (HELO [10.213.200.60]) ([10.213.200.60])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 23:53:06 -0700
Message-ID: <529b043a-e6af-cd1c-c6b8-a7778c2799d0@linux.intel.com>
Date:   Wed, 22 Jun 2022 07:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/i915: Fix spelling typo in comment
Content-Language: en-US
To:     1064094935@qq.com, Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <tencent_7B226C4A9BC2B5EEB37B70C188B5015D290A@qq.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <tencent_7B226C4A9BC2B5EEB37B70C188B5015D290A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/06/2022 08:08, 1064094935@qq.com wrote:
> From: pengfuyuan <pengfuyuan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_tiling.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> index 80ac0db1ae8c..85518b28cd72 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> @@ -114,7 +114,7 @@ u32 i915_gem_fence_alignment(struct drm_i915_private *i915, u32 size,
>   	return i915_gem_fence_size(i915, size, tiling, stride);
>   }
>   
> -/* Check pitch constriants for all chips & tiling formats */
> +/* Check pitch constraints for all chips & tiling formats */
>   static bool
>   i915_tiling_ok(struct drm_i915_gem_object *obj,
>   	       unsigned int tiling, unsigned int stride)

Merged to drm-intel-gt-next - thanks for the patch!

Regards,

Tvrtko

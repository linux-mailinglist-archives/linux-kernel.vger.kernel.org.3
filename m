Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E811357CB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiGUNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiGUNI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:08:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80413FAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658408911; x=1689944911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uKZEJQsehXBmfegRTdLkR14GGknjRcpexMkOtCqVKw=;
  b=T84lUyfWQXsSdUGWypow4aThvKTaEZHEm1txrWW3vkiliE5dZycEgJFt
   ybSOFDIL96k5Rrf0tJ+h/7U1t3EQofE+5bYFUkIhcsKzV9PgzwEbxeQAK
   mSacQ8iJhcFIitxhDQYQWElb0TVOeui89XroOo1sAfUKpR7nAMH6B1lak
   ivTjA2v1vdcy3Snth6oYtVVAWsUtdotV3kaK8ghLx97gTrp08oKUzy4rO
   P0CuMpHDH/dTTXkVDLx5SZet1cFg/eAauda4jr0mb5sbBHp4fQ9pbGdHF
   kH3Jms5A3uW3ruOI87ywSgtya/YROhEbzA96nx7DbGmnKCm1X3RKaiCmR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="373340071"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="373340071"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:08:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="656735336"
Received: from mstrobel-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.210.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:08:26 -0700
Date:   Thu, 21 Jul 2022 15:08:20 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        John.C.Harrison@intel.com, matthew.d.roper@intel.com,
        matthew.brost@intel.com, andi.shyti@linux.intel.com,
        zhou1615@umn.edu, michal.winiarski@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/selftests: Fix comment typo
Message-ID: <YtlPxPZ/BWATWL1J@alfio.lan>
References: <20220716040520.31676-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716040520.31676-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Sat, Jul 16, 2022 at 12:05:20PM +0800, Jason Wang wrote:
> Fix the double `wait' typo in comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Few warnings for this patch:

 1. you missed Rodrigo's r-b tag.
 2. please add a counter to your patch, this would be [PATCH v2]
 3. please add a changelog, as this is a single patch, do it
    after the '---'

No need to resend, just keep the three notes in mind for your
next patches. Anyway, thanks for the fix and as I am at it:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

> ---
>  drivers/gpu/drm/i915/selftests/i915_request.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
> index c56a0c2cd2f7..ec05f578a698 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -971,7 +971,7 @@ static struct i915_vma *empty_batch(struct drm_i915_private *i915)
>  	if (err)
>  		goto err;
>  
> -	/* Force the wait wait now to avoid including it in the benchmark */
> +	/* Force the wait now to avoid including it in the benchmark */
>  	err = i915_vma_sync(vma);
>  	if (err)
>  		goto err_pin;
> -- 
> 2.35.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D25515A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiFTKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbiFTKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:18:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06F65E0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655720337; x=1687256337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JsWiswkBl1LCE3i/DlPLr6VjhNxX61sq9DYEGWHKL+s=;
  b=goSonvSnVbw5lx78nBKQFqnpTUK/AFQ/XubCF/Oynl7vCDDTpKkwbXdk
   xGWFPHWxL6TIxCh9TfOR2oXJ5sz7ZcVBa6KU6aGAyP0jLcU1203NI2xtj
   nSkMmDhK0u95f9CnmI3sYP0bNp8sQ10tpWk1Exb2X76GKMWk8JYWhLFzD
   hnNFvZ8jDzRTpmbLMmVd5v2q/5wam9n8MHxpCrzrFxW0mpE5NDnCDXNL2
   pXUyPUeCULDQKqq7eGlGigCD0SugNIVudyTkPJ8xosRoaL4Vacs+mWlR0
   blBjfSf0V07hZ/nuzq6YvyTZey0dSGYb//Fd58D60HrqiPYarNUzx13oC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280588793"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280588793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:18:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643050863"
Received: from malikhan-mobl1.amr.corp.intel.com (HELO [10.212.127.6]) ([10.212.127.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:18:54 -0700
Message-ID: <7a2028c6-8ed6-1fc4-3abf-b13f7254cdee@linux.intel.com>
Date:   Mon, 20 Jun 2022 11:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/i915/gem: remove unused assignments
Content-Language: en-US
To:     zys.zljxml@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     bob.beckett@collabora.com, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, katrinzhou <katrinzhou@tencent.com>
References: <20220620100216.1791284-1-zys.zljxml@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220620100216.1791284-1-zys.zljxml@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/2022 11:02, zys.zljxml@gmail.com wrote:
> From: katrinzhou <katrinzhou@tencent.com>
> 
> The variable ret is reassigned and the value EINVAL is never used.
> Thus, remove the unused assignments.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Signed-off-by: katrinzhou <katrinzhou@tencent.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index ab4c5ab28e4d..d5ef5243673a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -931,8 +931,6 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
>   		break;
>   
>   	case I915_CONTEXT_PARAM_PERSISTENCE:
> -		if (args->size)
> -			ret = -EINVAL;
>   		ret = proto_context_set_persistence(fpriv->dev_priv, pc,
>   						    args->value);

AFAICT fix should end up with code like this:

if (args->size)
	ret = -EINVAL;
else
	ret = proto_context_set_persistence(...)
break;


Alternatively move args->size checking into 
proto_context_set_persistence to align with set_persistence().

Regards,

Tvrtko

>   		break;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA80554337
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiFVGwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349964AbiFVGwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:52:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7E36311
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655880725; x=1687416725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PUxZggHUb5jqg71YxkHmht0hN2RJ1lJ8tmffI9xIefw=;
  b=Ldy/VG4H1fdKWJXZCx3kJriKxcSPH87oFnlDTCfbMVmKhoegPbYwlXda
   Y+vi3LaFUH61AD4JJ+ybMvx/XDKMErt4dHufCupfw1H0oCcO9Lg9UurTW
   naj53SoCrHE1cnptbCANhOSW2JADr8hc1GL+3MaabKSz17BVzQx3e6bU9
   m+5SsRaObU6xbZ9lr3vka76iXwtazSFSDh/12DtIvaIpmSOxiixESoa0R
   A1ORDot3dEWjJDtBNnGANRUYBGa7wnexeO10Z22Q7gOXyrxArjptvDNkp
   KWpf3CU+1z54fVc9+pJameG620GD30v3BwE2eEwcpjyMDEtT6JhBrt5XK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269052056"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="269052056"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 23:52:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="615039403"
Received: from ebrazil-mobl1.amr.corp.intel.com (HELO [10.213.200.60]) ([10.213.200.60])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 23:52:02 -0700
Message-ID: <136dd37c-128a-714e-993f-65a119b7003b@linux.intel.com>
Date:   Wed, 22 Jun 2022 07:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/i915/gem: remove unused assignments
Content-Language: en-US
To:     Katrin Jo <zys.zljxml@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>, bob.beckett@collabora.com,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        katrinzhou <katrinzhou@tencent.com>
References: <20220620100216.1791284-1-zys.zljxml@gmail.com>
 <7a2028c6-8ed6-1fc4-3abf-b13f7254cdee@linux.intel.com>
 <CAOaDN_T_ZVCfhmbqd1AJnt3vhTuxnGhKsxG2fjjF8-u4wXOBcg@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAOaDN_T_ZVCfhmbqd1AJnt3vhTuxnGhKsxG2fjjF8-u4wXOBcg@mail.gmail.com>
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


On 21/06/2022 03:26, Katrin Jo wrote:
> On Mon, Jun 20, 2022 at 6:19 PM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> On 20/06/2022 11:02, zys.zljxml@gmail.com wrote:
>>> From: katrinzhou <katrinzhou@tencent.com>
>>>
>>> The variable ret is reassigned and the value EINVAL is never used.
>>> Thus, remove the unused assignments.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
>>> Signed-off-by: katrinzhou <katrinzhou@tencent.com>
>>> ---
>>>    drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>>> index ab4c5ab28e4d..d5ef5243673a 100644
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>>> @@ -931,8 +931,6 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
>>>                break;
>>>
>>>        case I915_CONTEXT_PARAM_PERSISTENCE:
>>> -             if (args->size)
>>> -                     ret = -EINVAL;
>>>                ret = proto_context_set_persistence(fpriv->dev_priv, pc,
>>>                                                    args->value);
>>
>> AFAICT fix should end up with code like this:
>>
>> if (args->size)
>>          ret = -EINVAL;
>> else
>>          ret = proto_context_set_persistence(...)
>> break;
>>
>>
>> Alternatively move args->size checking into
>> proto_context_set_persistence to align with set_persistence().
>>
>> Regards,
>>
>> Tvrtko
>>
>>>                break;
> 
> Thanks for reviewing! I sent the V2 patch, modified according to your
> suggestion.

I have merged the v2 to drm-intel-gt-next - thanks for the fix!

Regards,

Tvrtko

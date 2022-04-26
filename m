Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5525108DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353907AbiDZTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbiDZTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:22:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1A64707
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:19:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 107061F41A32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651000777;
        bh=MAjmFdqWA+Hrdq60ZeCd3OrHWgUw+ka1jffl+aLkF04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U4W2g9y7THG9R7VpouQpRZ1L82hltGgjoux1qoqVpBWDvEKw5qIoSP2j+H1YBzZhO
         ajW6m+pKYyUK5uiuxPYKz0kDo37QsSYOOJWi3EFXYrWLChEvM0nf/qSL+UtYcDmuOJ
         wlPd5Ug6Rz8EAjED5i4Q/JYdJshiM4/jxmJXIxKQlM7jfIq8pnSPOIs4b8aTAr9gZG
         Uzd5vqUAw1Q3dxHbDVHnsOiVRxrXva/iLl63V3hAlfXaZfixLYs22KPDys3kYej46X
         ZvX5cUqrh08vjhCXLT2q0VOVVNGlEBPtpzmD9bVGp6jY3b3Bt6ynrakUp6liIoZ8lj
         omDh51dXTmefA==
Message-ID: <780fa818-292c-a313-6006-0af0730c2743@collabora.com>
Date:   Tue, 26 Apr 2022 20:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PULL] gvt-next
Content-Language: en-US
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>
References: <c5cf6773-e7a2-8ba8-4cde-0bb14007bc6b@intel.com>
 <20220426155318.GQ2125828@nvidia.com>
 <e245c195-fdb0-32c4-dcfb-8ff49bc3a63c@intel.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <e245c195-fdb0-32c4-dcfb-8ff49bc3a63c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/04/2022 17:58, Wang, Zhi A wrote:
> On 4/26/22 3:53 PM, Jason Gunthorpe wrote:
>> On Tue, Apr 26, 2022 at 07:58:59AM +0000, Wang, Zhi A wrote:
>>> Hi folks:
>>>
>>> Here is the pull of gvt-next which fixs the compilation error when i915 debug
>>> is open after the GVT-g refactor patches.
>>>
>>> Thanks so much for the efforts.
>>>
>>> Thanks,
>>> Zhi.
>>>
>>> The following changes since commit 2917f53113be3b7a0f374e02cebe6d6b749366b5:
>>>
>>>    vfio/mdev: Remove mdev drvdata (2022-04-21 07:36:56 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/intel/gvt-linux tags/gvt-next-2022-04-26
>>>
>>> for you to fetch changes up to 2da299cee780ea797b3f72558687868072cf5eb5:
>>>
>>>    drm/i915/gvt: Add missing export of symbols. (2022-04-25 18:03:04 -0400)
>>>
>>> gvt-next-2022-04-26
>>>
>>> - Add two missing exports of symbols when i915 debug is enabled.
>>>
>>> Zhi Wang (1):
>>>        drm/i915/gvt: Add missing export of symbols.
>>>
>>>   drivers/gpu/drm/i915/intel_gvt.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> This still has another compile problem:
>>
>> ERROR: modpost: "intel_runtime_pm_put" [vmlinux] is a static EXPORT_SYMBOL_GPL
>>
>> Because:
>>
>> #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_RUNTIME_PM)
>> void intel_runtime_pm_put(struct intel_runtime_pm *rpm, intel_wakeref_t wref);
>> #else
>> static inline void
>> intel_runtime_pm_put(struct intel_runtime_pm *rpm, intel_wakeref_t wref)
>> {
>>          intel_runtime_pm_put_unchecked(rpm);
>> }
>> #endif
>>
>> Looks like it happens if CONFIG_DRM_I915_DEBUG_RUNTIME_PM=n
>>
>> I think you probably want to #ifdef the export in the same way:
>>
>> --- a/drivers/gpu/drm/i915/intel_gvt.c
>> +++ b/drivers/gpu/drm/i915/intel_gvt.c
>> @@ -309,7 +309,9 @@ EXPORT_SYMBOL_NS_GPL(__intel_context_do_pin, I915_GVT);
>>   EXPORT_SYMBOL_NS_GPL(__intel_context_do_unpin, I915_GVT);
>>   EXPORT_SYMBOL_NS_GPL(intel_ring_begin, I915_GVT);
>>   EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_get, I915_GVT);
>> +#if IS_ENABLED(CONFIG_DRM_I915_DEBUG_RUNTIME_PM)
>>   EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_put, I915_GVT);
>> +#endif
> Sigh. That's tricky. Let me prepare another one.

Also the following compile error:

drivers/gpu/drm/i915/gvt/handlers.c:75:6: error: no previous prototype 
for ‘intel_gvt_match_device’ [-Werror=missing-prototypes]

    75 | bool intel_gvt_match_device(struct intel_gvt *gvt,

       |      ^~~~~~~~~~~~~~~~~~~~~~


it was removed from a header. The implementation should now be made static

>>   EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_put_unchecked, I915_GVT);
>>   EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_for_reg, I915_GVT);
>>   EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_get, I915_GVT);
>>
>> Jason
>>
> 

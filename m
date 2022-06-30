Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33A85612E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiF3HCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiF3HCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:02:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30C35DED;
        Thu, 30 Jun 2022 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656572519; x=1688108519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AeHi61WsIJAmFsEU0j7KjinoFRAELD1Z5s+ZxYgSLyY=;
  b=B12RwlGLfYmRZ+bDaxNHye+mWPcBYJplpNBX5W+z9M1C7eJGM9MG+Uib
   JzR2j8scoqtpoJhAv+EpbOky1f3/FuzujYK2Bjr/cK7mlS/8eXD6jMFxQ
   dP5ardu6SIP4eCF5RkVevQeHfpUmuViSNzxslSk54HLG3IKi7P9UJo8QW
   sC7z3vdnyzB1eyXQ5CKtVwlFBjWIQuS0fsAbpKmYNlHCeAhbSLxXU+DrI
   +T6GnQZmsSdE3Sanlawy0e08ROFNEp50XS+iX0c93XE89gbkZq8ujwXRf
   L0d9dzszckKjU0Z2lxRWdSdqm24qu6PCjSsv7WFkhL1E80PIQaHVS2Zb4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="271032833"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="271032833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:01:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647761832"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.251.217.92]) ([10.251.217.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:01:49 -0700
Message-ID: <83341d51-6c63-4b37-2f02-b3f305930308@linux.intel.com>
Date:   Thu, 30 Jun 2022 09:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] Fix: SYNCOBJ TIMELINE Test failed.
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        jie1zhan <jesse.zhang@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
References: <20220629060236.3283445-1-jesse.zhang@amd.com>
 <8499b1f1-cd39-5cb4-9fac-735e68393556@amd.com>
From:   "Das, Nirmoy" <nirmoy.das@linux.intel.com>
In-Reply-To: <8499b1f1-cd39-5cb4-9fac-735e68393556@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/29/2022 11:12 AM, Christian König wrote:
> Am 29.06.22 um 08:02 schrieb jie1zhan:
>>   The issue cause by the commit :
>>
>> 721255b527(drm/syncobj: flatten dma_fence_chains on transfer).
>>
>> Because it use the point of dma_fence incorrectly
>>
>> Correct the point of dma_fence by fence array
>
> Well that patch is just utterly nonsense as far as I can see.
>
>>
>> Signed-off-by: jie1zhan <jesse.zhang@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Reviewed-by: Nirmoy Das <nirmoy.das@linux.intel.com>
>
> I have strong doubts that Nirmoy has reviewed this and I certainly 
> haven't reviewed it.


I haven't  reviewed this either.


Nirmoy

>
> Christian.
>
>> ---
>>   drivers/gpu/drm/drm_syncobj.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c 
>> b/drivers/gpu/drm/drm_syncobj.c
>> index 7e48dcd1bee4..d5db818f1c76 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -887,7 +887,7 @@ static int drm_syncobj_flatten_chain(struct 
>> dma_fence **f)
>>           goto free_fences;
>>         dma_fence_put(*f);
>> -    *f = &array->base;
>> +    *f = array->fences[0];
>>       return 0;
>>     free_fences:
>

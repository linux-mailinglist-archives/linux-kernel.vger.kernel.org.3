Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3A4EE839
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiDAGdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiDAGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:33:23 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D55F27F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:31:33 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 1 Apr 2022
 14:31:33 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 1 Apr
 2022 14:31:31 +0800
Message-ID: <fd790dd5-7759-fefa-465c-f4317a8f6e52@meizu.com>
Date:   Fri, 1 Apr 2022 14:31:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/vcn: remove Unneeded semicolon
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1648706190-4596-1-git-send-email-baihaowen@meizu.com>
 <2a2b1f76-7e9b-9561-e190-16d808eb5399@molgen.mpg.de>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <2a2b1f76-7e9b-9561-e190-16d808eb5399@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/1/22 1:54 PM, Paul Menzel 写道:
> Dear Haowen,
>
>
> Thank you for your patch.
>
> Am 31.03.22 um 07:56 schrieb Haowen Bai:
>
> In the commit message summary, please use:
>
> Remove unneeded semicolon
>
>> report by coccicheck:
>> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon
>>
>> fixed c543dcb ("drm/amdgpu/vcn: Add VCN ras error query support")
>
> Please use
>
> Fixes: …
>
> and a commit hash length of 12 characters. (`scripts/checkpatch.pl …` should tell you about this.)
>
>
> Kind regards,
>
> Paul
>
>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 3e1de8c..17d44be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -1948,7 +1948,7 @@ static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
>>           break;
>>       default:
>>           break;
>> -    };
>> +    }
>>         if (poison_stat)
>>           dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
hi, Paul Menzel
Thank you for your detail point which I have first known.

-- 
Haowen Bai


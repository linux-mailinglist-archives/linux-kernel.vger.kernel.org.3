Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04B35933C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiHORCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiHORCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:02:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1E27CC4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:02:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f192so7083628pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kVI9j3DYdqBdWkziBWW1kk/pn2Ueg4C4jZV3ff8Htjw=;
        b=gZqQLXqcl92oRRJt+5e5u2qjisa8kzB6aZhxd9PIhqUmCxltZj383GoU8Cz3j8Tk4c
         vN3dentoCQF+MRI0FvyRZDu3ppO1yOn+l9OA8GhHnGrLqRWgaIjY5eBqJDZC13icn8hw
         +JAwQvLxC0EWZOG74h3jwKTqvyhuQAgdTqTQO3xsOZuG6xc4trx06//kNQR1Qf0Ld1Qt
         tKFvpd6kAwyjbVJ8t5yuX1bSinVtAAjspK7Ilp9HakXaNORZYJnsYGPk0LyRyExCiuIq
         zgLrz1HmdPJhISBHvYLb3Ttimvk0hFUuuNhLGuw8c59leJyeKyuYyxmeeXGhUtcLAc0k
         0nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kVI9j3DYdqBdWkziBWW1kk/pn2Ueg4C4jZV3ff8Htjw=;
        b=bPuOGX//T9oWqzYnJWxJUTISlSYWsZw4l2j/s9OZ/ayqrvSckwnar0FoM2YlNjdXbO
         vRSw3knbpmfh1KD6LrzlbIpKvl6ZlaVNQrsBJwoqQXJxUXWYj4Fcad4T2NDJd3kZMJT8
         Srjhh54/2H89bJesaPO2COiMbbOP3ecHUNkDs6D3Ae51Jd3wfpsUySWLWyf8AzUoIkHG
         4vCi4ljsGB2JOYjSn/P03FfYuLunWqbagp7JnRzhSHfmz/Xyn3g8nbFPRODp7faWTHBN
         mMcXAh99gAIFtP4T7UrpHdKKS5s/IMPt3kOQzkc36v7RL7tfp1tYe3SpVhFrK2DxrJg7
         6lSw==
X-Gm-Message-State: ACgBeo21CGVR1p67RULtIlT+2YooO8j/Ma9w4mbW94j6Ac7SaPCNon1r
        N4XoPCWo22eNjoOVILRy8GE=
X-Google-Smtp-Source: AA6agR5RZ22iqECqURoT+vxzrH03J8Q9Bvu9e6PkSFwJuTLDiJCN3IdbpLDIa0y8FwM7EIYwWL+bEw==
X-Received: by 2002:aa7:88d1:0:b0:52e:f8e:aab5 with SMTP id k17-20020aa788d1000000b0052e0f8eaab5mr17090966pff.63.1660582921848;
        Mon, 15 Aug 2022 10:02:01 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.138])
        by smtp.gmail.com with ESMTPSA id l20-20020a17090b079400b001f89383d587sm4767063pjz.56.2022.08.15.10.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 10:02:01 -0700 (PDT)
Message-ID: <1e720378-8398-3e4a-5a77-e34b2fec58fd@gmail.com>
Date:   Mon, 15 Aug 2022 23:01:49 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH linux-next] drm/amdgpu/vcn: Remove unused assignment in
 vcn_v4_0_stop
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     "Dong, Ruijing" <Ruijing.Dong@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Jiang, Sonny" <Sonny.Jiang@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20220815070056.10816-1-khalid.masum.92@gmail.com>
 <SJ1PR12MB61944B1D53330D5E9531158695689@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <86088c17-585c-4a53-312d-ef339b824538@gmail.com> <YvpwVh359EMGa5kO@kroah.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <YvpwVh359EMGa5kO@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 22:12, Greg KH wrote:
> On Mon, Aug 15, 2022 at 09:11:18PM +0600, Khalid Masum wrote:
>> On 8/15/22 20:15, Dong, Ruijing wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Sorry, which "r" value was overwritten?  I didn't see the point of making this change.
>>>
>>> Thanks
>>> Ruijing
>>>
>>> -----Original Message-----
>>> From: Khalid Masum <khalid.masum.92@gmail.com>
>>> Sent: Monday, August 15, 2022 3:01 AM
>>> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; linux-kernel-mentees@lists.linuxfoundation.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Zhu, James <James.Zhu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Wan Jiabing <wanjiabing@vivo.com>; Liu, Leo <Leo.Liu@amd.com>; Khalid Masum <khalid.masum.92@gmail.com>
>>> Subject: [PATCH linux-next] drm/amdgpu/vcn: Remove unused assignment in vcn_v4_0_stop
>>>
>>> The value assigned from vcn_v4_0_stop_dbg_mode to r is overwritten before it can be used. Remove this assignment.
>>>
>>> Addresses-Coverity: 1504988 ("Unused value")
>>> Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
>>> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> index ca14c3ef742e..80b8a2c66b36 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> @@ -1154,7 +1154,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
>>>                   fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>>>
>>>                   if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>> -                       r = vcn_v4_0_stop_dpg_mode(adev, i);
>>> +                       vcn_v4_0_stop_dpg_mode(adev, i);
>>>                           continue;
>>>                   }
>>>
>>> --
>>> 2.37.1
>>>
>>
>> After value is overwritten soon right after the diff.
>>
>> See:
>> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>
>> static int vcn_v4_0_stop(struct amdgpu_device *adev)
>> {
>>          volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>> ...
>>
>>          for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>                  fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>>                  fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>>
>>                  if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>                          r = vcn_v4_0_stop_dpg_mode(adev, i);
>>                          continue;
>>                  }
>>
>>                  /* wait for vcn idle */
>>                  r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS,
>> UVD_STATUS__IDLE, 0x7);
>>
>> Here, any value assigned to r is overwritten before it could
>> be used. So the assignment in the true branch of the if statement
>> here can be removed.
> 
> Why not fix vcn_v4_0_stop_dpg_mode() to not return anything, as it does
> not, and then remove this assignment as well, which would fix up
> everything at once to be more obvious what is happening and why.

That makes sense. I shall send a v2 this way. Thanks for your suggestion.

> 
> thanks,
> 
> greg k-h

thanks,
   -- Khalid Masum


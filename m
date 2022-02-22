Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F24BF664
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiBVKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBVKq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:46:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16282DF08;
        Tue, 22 Feb 2022 02:46:32 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f11so11047542ljq.11;
        Tue, 22 Feb 2022 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iabqwLRHm/0Z6nOkM33Y0js7aZKJwfXcVsR9drxTBpI=;
        b=Wvvk4dYJGf5Y8/8AlZicv/dhMGLGNFdMJpU3wenpSJZw/ybyjG3nx9inX0NopTAr9b
         hki9SqFotR4DokiJbsxi3yGsFbnL/zXxiDg/fRjfzRxiszEbWkFKpYheubiSHqOaxP34
         rjOvLBDn9kWi79ogs4Zh8W6upcZAtRRWT4N5DEvXeccq1jr0fRCdDH4AhV3jc6YMVzYY
         6IEqUC1xQpeJJXazlibsxRAUbsunJcLJ+Q8OZRSlkEt2s3SOTVvGTqVfVXppSIfJi21t
         hGpypFfvt3zGUuu9KQLV5peGeZ7tki5MqV+SxDeCYQ79bdLGMFynXY4YZv5rFu2cevD6
         iV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iabqwLRHm/0Z6nOkM33Y0js7aZKJwfXcVsR9drxTBpI=;
        b=cZWsUQrpeNMJ/5tY5f6YHyGGkTaVS7erzwy/JEYzin03ru86tPNOwOPBlXiPWEzusl
         XO46VVjeDABvAfnItk1UzTkZYJxR6+tlfcCKn3itIH6CmyN6yLM51XGgkOGScwWhyfsB
         6Z04ThtISuQ59WxM/X/zYrZROkg5+g/VHNHhN1/5CUArD4YSv7h6Wl3SGVIM3umhV2aO
         cKdBwXATBkfInR4eT+QsE9SqE3hioj1kRM3x0Z/9dqptzWIUOr2nU+nXsmTDO79q9q8L
         NjuylXIVok8HemGRscKxpwUHWZGkvyNuMlcif0IX9QsZFkpQDEZNWI4Lvqpvpm2N+03T
         TF2A==
X-Gm-Message-State: AOAM533BHA/D1cKZ1sOIF1Pwyb1qMDo8wldJNRoptG7vS6hUSvILWOd4
        FvPkePefuIjUyeOloBLq+7I=
X-Google-Smtp-Source: ABdhPJwZ1McSWpt8xE8JSzJ7PFSX/UI6DWDglB8xl7blNXCItqUCMFWL3e68OUp80Bgn508refVPUw==
X-Received: by 2002:a2e:980f:0:b0:246:3fb6:816b with SMTP id a15-20020a2e980f000000b002463fb6816bmr6085199ljj.242.1645526790359;
        Tue, 22 Feb 2022 02:46:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id w10sm1599556ljd.101.2022.02.22.02.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 02:46:29 -0800 (PST)
Message-ID: <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
Date:   Tue, 22 Feb 2022 13:46:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
 <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
 <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.02.2022 11:27, Mikko Perttunen пишет:
> On 2/21/22 22:10, Dmitry Osipenko wrote:
>> 21.02.2022 14:44, Mikko Perttunen пишет:
>>> On 2/19/22 20:54, Dmitry Osipenko wrote:
>>>> 19.02.2022 21:49, Dmitry Osipenko пишет:
>>>>> 18.02.2022 14:39, Mikko Perttunen пишет:
>>>>>> +static int vic_get_streamid_offset(struct tegra_drm_client *client)
>>>>>> +{
>>>>>> +    struct vic *vic = to_vic(client);
>>>>>> +    int err;
>>>>>> +
>>>>>> +    err = vic_load_firmware(vic);
>>>>>
>>>>> You can't invoke vic_load_firmware() while RPM is suspended. Either
>>>>> replace this with RPM get/put or do something else.
>>>
>>> Why not, I'm not seeing any HW accesses in vic_load_firmware? Although
>>> it looks like it might race with the vic_load_firmware call in
>>> vic_runtime_resume which probably needs to be fixed.
>>
>> It was not clear from the function's name that h/w is untouched, I read
>> "load" as "upload" and then looked at vic_runtime_resume(). I'd rename
>> vic_load_firmware() to vic_prepare_firmware_image().
>>
>> And yes, technically lock is needed.
> 
> Yep, I'll consider renaming it.

Looking at this all again, I'd suggest to change:

int get_streamid_offset(client)

to:

int get_streamid_offset(client, *offset)

and bail out if get_streamid_offset() returns error. It's never okay to
ignore errors.

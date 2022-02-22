Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25A4BF6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiBVLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:02:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F13123F;
        Tue, 22 Feb 2022 03:02:11 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j7so23981745lfu.6;
        Tue, 22 Feb 2022 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FEr1dmlBfqy5sXD3HLj/KlzbzoUju1Ng5vIhD2tYoCk=;
        b=hnSpJ/7MqXwGc38P5+/jVdY1t3pGZ2iHpclQ2/+v/rF/L2k4WCOAfMLf8/cccWVb1C
         s1vLWucOsp+uZ0Bzd4TlXCRx9udMGJ08XL8FouAPYYkxmfIlHGSP1KWHcCfcEWxkNBuy
         Q3YoOinDU0DsmWtZQ48CEp8uj3Lr+ooVWavekiL43/3ULiDOnJ19mI2kqxEmNn+CcmVh
         /3gZzTSQUW/NUOqiXMTWEIPQVdx5V95gysF/bdIyuvwZ6SVJWVJsY0dHBCQE7A1BvRJI
         9ZHPKHCa2oi+73iL8iBqRZ1O/1juwfISS3bKQe4uqFwKWpqi+PRj19RntWVziCX4T/oy
         D4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FEr1dmlBfqy5sXD3HLj/KlzbzoUju1Ng5vIhD2tYoCk=;
        b=RZTJS9Xi4e6scWKT+423vjhIIIhpqaP/xTxoLLpDhAE6aLGE2IxmlpYFeMVYSyq0BX
         wA9X1VBDYC9q821zxe7kGpaLdHB22WHoJL6F5z8B0Y8H025bwAWzI50RR8d7XNlJd7q/
         JUa+j4tMLgqloGZqfEFAeh2ni9mccVrJL86M0JPDfkC0nh079okYu4MknuIjTzIvJ7LP
         st9mgeLP7tH+GK8sMfq5kW2uzsGnrNzHjx3o3NlDz6veMrbT3eXtfiojjN9XYnq317ze
         gVh7iPnfOuSTSVc0QfqF8pKLNVVXfFjkrLrXccofUNryEzwRNk2uF0Y+0Lxu5kbhYSJl
         ZJVg==
X-Gm-Message-State: AOAM532nxfi0y/dloZFs9YxwBpiGs0FpRFVB9wdyeDxBLkiJf/oB3ZeO
        EAtWkIIO+6CsQTm4THrPAQ5CfTN5mio=
X-Google-Smtp-Source: ABdhPJynaoI+/XmYPUSX1yz2BgAVDgkX9V5kPsQkAvgnbnw1gWNWYK5gRqWCmMUOwD33fRqB/rj21A==
X-Received: by 2002:a05:6512:3748:b0:443:c3f0:6691 with SMTP id a8-20020a056512374800b00443c3f06691mr12238118lfs.603.1645527730316;
        Tue, 22 Feb 2022 03:02:10 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id t1sm1360167lfr.8.2022.02.22.03.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 03:02:09 -0800 (PST)
Message-ID: <3b0b8b41-ddf0-3b83-5edd-8768393ad201@gmail.com>
Date:   Tue, 22 Feb 2022 14:02:08 +0300
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
 <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
 <b947e0b2-a78d-bacf-0d78-b5d57e821e6e@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <b947e0b2-a78d-bacf-0d78-b5d57e821e6e@kapsi.fi>
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

22.02.2022 13:54, Mikko Perttunen пишет:
> On 2/22/22 12:46, Dmitry Osipenko wrote:
>> 22.02.2022 11:27, Mikko Perttunen пишет:
>>> On 2/21/22 22:10, Dmitry Osipenko wrote:
>>>> 21.02.2022 14:44, Mikko Perttunen пишет:
>>>>> On 2/19/22 20:54, Dmitry Osipenko wrote:
>>>>>> 19.02.2022 21:49, Dmitry Osipenko пишет:
>>>>>>> 18.02.2022 14:39, Mikko Perttunen пишет:
>>>>>>>> +static int vic_get_streamid_offset(struct tegra_drm_client
>>>>>>>> *client)
>>>>>>>> +{
>>>>>>>> +    struct vic *vic = to_vic(client);
>>>>>>>> +    int err;
>>>>>>>> +
>>>>>>>> +    err = vic_load_firmware(vic);
>>>>>>>
>>>>>>> You can't invoke vic_load_firmware() while RPM is suspended. Either
>>>>>>> replace this with RPM get/put or do something else.
>>>>>
>>>>> Why not, I'm not seeing any HW accesses in vic_load_firmware? Although
>>>>> it looks like it might race with the vic_load_firmware call in
>>>>> vic_runtime_resume which probably needs to be fixed.
>>>>
>>>> It was not clear from the function's name that h/w is untouched, I read
>>>> "load" as "upload" and then looked at vic_runtime_resume(). I'd rename
>>>> vic_load_firmware() to vic_prepare_firmware_image().
>>>>
>>>> And yes, technically lock is needed.
>>>
>>> Yep, I'll consider renaming it.
>>
>> Looking at this all again, I'd suggest to change:
>>
>> int get_streamid_offset(client)
>>
>> to:
>>
>> int get_streamid_offset(client, *offset)
>>
>> and bail out if get_streamid_offset() returns error. It's never okay to
>> ignore errors.
> 
> Sure, seems reasonable. We'll still need some error code to indicate
> that context isolation isn't available for the engine and continue on in
> that case but that's better than just ignoring all of them.

Yes, check for -EOPNOTSUPP and skip it.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412BE55E6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbiF1PV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiF1PV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:21:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014132EE0;
        Tue, 28 Jun 2022 08:21:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso13062514pjk.0;
        Tue, 28 Jun 2022 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zDPpePt6CeKE4jRJhPC/US5+QOggpwLxdGTuenyEguM=;
        b=qKiq7D8HvPbea819MTA57dhnc7TaWUbn0cxkogrbuDdJT0ITkJcBAO4ojiijS9CPpu
         HA6VbP8zuKTQAHXjrvY1vPf569vhOKa0N5dN891YQ+D2v0jW6mf8eBurobPsOuptRAIo
         mj5kW67WN0LAj/wPlm8UNf8z8gRRqfOBEL1MOQ8wCraZNd/Ny7hIcshH2aliGCFcC4kB
         SVQuDgrJdHJlEfAVtZsm7AnqQpFSwltF5cwr/qHvnIh6tbPkSGwrC4ytOL8eGzKfQnzo
         aeDODXQTgdfVGZ+3RiztIhI40QADRN0LBQpIys1vNCd/7nRYra5LFgKRjc70TDbWR1tm
         xFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zDPpePt6CeKE4jRJhPC/US5+QOggpwLxdGTuenyEguM=;
        b=hMi5tHn9jV2918F7+uvoYFXKyG4idzYKkuLBua9kmJdIhKmDF089v1CcMtHTezMX9V
         WIf8DvjUFqCrKymCoV8lyxhmPdqfgAMTGawvKWqIhG3Qlp1m9O3WcFZ69RKtifg2JIIN
         lQEEm+0mLWB60hfj8oLMOg5UML72X0SxWQktDe40u4X6K3WztbzGIZZeEAKv91rmNZs3
         Qhf79P0escuHEmrH1LJblDyxzgAxHJdQ+psQm6H+D0rsl6kv+EoDNzEDto8yiTN0eY7h
         vfj1pF+cLP3UUdwrDWTVbjBsyetNFTEDw+rrSc6bqJ6P1xiv1+DdrLSOUWdKkIP9YjQd
         9U6Q==
X-Gm-Message-State: AJIora/Hwv/7tQ20aGigoYchKTwmlTyU+7LQCzxWaOV+/Os1rkhoAVzj
        mgsJ+EFpHGal8rJzwmNgN22Y7CUPAEc=
X-Google-Smtp-Source: AGRyM1sQbPe5xKOzDFAPg+mYwOyvB61ITglWnHqLG1kExdO/SOcjVZZkr68emVbP11LnQttklJ8qTg==
X-Received: by 2002:a17:90a:410a:b0:1ec:7fc8:6d15 with SMTP id u10-20020a17090a410a00b001ec7fc86d15mr139705pjf.236.1656429684953;
        Tue, 28 Jun 2022 08:21:24 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b001674f2e1c3asm9586152pls.74.2022.06.28.08.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:21:24 -0700 (PDT)
Message-ID: <d0559a60-a4c1-19a9-39c5-18a5e2e460ca@gmail.com>
Date:   Wed, 29 Jun 2022 00:21:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] HID: amd_sfh: Ignore uninitialized device
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220626081339.7243-1-akihiko.odaki@gmail.com>
 <b17f4e85-8a35-65ab-34de-0978bdc4cfea@amd.com>
 <8c95e3d7-cff6-c56e-e197-fdd0911d81aa@gmail.com>
 <3ff059d8-2d89-6ea1-209b-3c8855561acb@amd.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <3ff059d8-2d89-6ea1-209b-3c8855561acb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2022/06/29 0:14, Limonciello, Mario wrote:
> On 6/28/2022 10:11, Akihiko Odaki wrote:
>> On 2022/06/28 23:42, Limonciello, Mario wrote:
>>> On 6/26/2022 03:13, Akihiko Odaki wrote:
>>>> Lenovo ThinkPad C13 Yoga has AMD Sensor Fusion Hub, but it is not used
>>>> because Chrome OS EC Sensor Hub is used instead. The system therefore
>>>> never loads the firmware for MP2 and MP2 does not work. It results in
>>>> AMD_P2C_MSG3 register to have -1 as its value.
>>>>
>>>> Without this change, the driver interprets the value as it supports all
>>>> sensor types and exposes them, which confuses a userspace program,
>>>> iio-sensor-proxy, and makes it to use the non-functioning sensors
>>>> instead of functioning sensors exposed via Chrome OS EC Sensor Hub.
>>>>
>>>> Check the version bits included in AMD_P2C_MSG3 register and ignore the
>>>> device if all of the bits are set.
>>>>
>>>
>>> Have you already confirmed this failure happens in 5.19-rc1 or later 
>>> as well?  I would think that b5d7f43e97dabfa04a4be5ff027ce7da119332be 
>>> should have fixed it.
>>
>> Yes. I confirmed it with 78ca55889a549a9a194c6ec666836329b774ab6d.
>>
> 
> Thanks for confirming.
> 
>> b5d7f43e97dabfa04a4be5ff027ce7da119332be deals with the case where it 
>> advertises v2 but it doesn't in my case.
> 
> In your case it actually goes down the v1 ops path then right?

Yes, but I doubt even that is correct in this case. I guess the v1 
protocol would have a value 1 for acs in mp2_select_ops(), but it is 15 
in this case. It would be nice if you confirm that hypothesis.

Regards,
Akihiko Odaki

> 
> Basavaraj - is discovery unique to v2?  Or does it also exist for v1?
> If it also exists for v1 I think that's a cleaner solution.
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
>>>> ---
>>>>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c 
>>>> b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>>>> index dadc491bbf6b..4137e5da77ad 100644
>>>> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>>>> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>>>> @@ -271,6 +271,8 @@ static void mp2_select_ops(struct amd_mp2_dev 
>>>> *privdata)
>>>>       case V2_STATUS:
>>>>           privdata->mp2_ops = &amd_sfh_ops_v2;
>>>>           break;
>>>> +    case 15:
>>>> +        break;
>>>>       default:
>>>>           privdata->mp2_ops = &amd_sfh_ops;
>>>>           break;
>>>> @@ -317,6 +319,8 @@ static int amd_mp2_pci_probe(struct pci_dev 
>>>> *pdev, const struct pci_device_id *i
>>>>           return -ENOMEM;
>>>>       mp2_select_ops(privdata);
>>>> +    if (!privdata->mp2_ops)
>>>> +        return -ENODEV;
>>>>       rc = amd_sfh_irq_init(privdata);
>>>>       if (rc) {
>>>
>>
> 


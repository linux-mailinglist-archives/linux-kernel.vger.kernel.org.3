Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA34F22A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiDEFp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiDEFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:45:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04798340E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:44:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j8so9994854pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 22:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LTGszWw0LQHjXPz9j0i9y0VywPVU6bUFiHI/ZnFZLEY=;
        b=LDOc6/pBGmBnSVnCrhAbJJvjXFcXVkznBKd3B0lboUELwjzCR8FkhkHfwZxSOc1QiO
         gLZexCbYEasQqcdEWZZtwVfDFDnspepq+Ygr+WeRTXljbgEywAcWi+Zhu/NXWNj6dkx9
         CdxlAV+vCZ5eOazCyuJ6CPlvB5yStMNC0tJ9GvvDbHQEH6skKw26YuM/Dbkq+OLExq+Y
         Vsu4A85cwsBwiqJCBNqNsyNKWu6oxtosOKmNK33Kqp1xoGZamkHpPiZVlXKEZipMyjY1
         Vr1em+PY90nyKGcTCPrXIb+Gn0B2e3cl0cb3zmnkztunD330Cr/1c/pKSiHyWmxFQJHb
         FmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LTGszWw0LQHjXPz9j0i9y0VywPVU6bUFiHI/ZnFZLEY=;
        b=KVamqAPXVDieYrWJd/zmbXbvFxbedOPJWk0pm3HcObrVLPMhlp6JEaIIvmdudRuF97
         8wtyUAzaGp2mv1h4iWfdxebb8B9RSeGoPJ1f1eVZUik5q1PMBSDm36QoFXyp8lZwT1r2
         YH1f78OINtMTQ4MX0eiBOjs3CORjo1GlyL6mCzhM91GikdkHyXUJzi4BOE86gJCv2GrF
         Qowrgu6eMpHi5Mme1u5TEDY6M8jy5YWdGrIHblUaIXlzefkntl1ssn/oRf+MVjupNdsj
         et45V3DDvmMjxTRltb0wG1vKAWQJ8c26mAYcUw1JF2hWfSQIxzVPLAL2lEGwLnbzBpZ9
         thBw==
X-Gm-Message-State: AOAM533nTJKLGKjf97w2kOySYPizWR8owXzJwHI9qSyaE57iOwJJDv3M
        OPALkT1retD8UGAw3ngjMQ2QHiRiUqI=
X-Google-Smtp-Source: ABdhPJzY4J7Qs+0O+4UZC3AJL/k0yAkGEsiu6kn7Qs/c2LwL66bIP4r+PtbdI0W40Ehd8UqNJ7QiZw==
X-Received: by 2002:a17:902:7887:b0:156:788a:56d1 with SMTP id q7-20020a170902788700b00156788a56d1mr1869856pll.110.1649137439413;
        Mon, 04 Apr 2022 22:43:59 -0700 (PDT)
Received: from [192.168.66.3] ([157.82.194.15])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm14054920pfu.56.2022.04.04.22.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 22:43:58 -0700 (PDT)
Message-ID: <e04a5a51-10cb-3015-2e3e-44a6f6348d06@gmail.com>
Date:   Tue, 5 Apr 2022 14:43:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <CABXOdTe9u_DW=NZM1-J120Gu1gibDy8SsgHP3bJwwLsE_iuLAQ@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CABXOdTe9u_DW=NZM1-J120Gu1gibDy8SsgHP3bJwwLsE_iuLAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/05 10:57, Guenter Roeck wrote:
> On Sun, Apr 3, 2022 at 9:11 PM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>>
>> The EC driver may not be initialized when cros_typec_probe is called,
>> particulary when CONFIG_CROS_EC_CHARDEV=m.
>>
> 
> Does this cause a crash ? If so, do you have a crash log ?

It indeed caused a crash but I don't have a log because I couldn't get a 
serial console. Adding dev_error calls revealed ec_dev in 
cros_typec_probe can be NULL if CONFIG_CROS_EC_CHARDEV=m.

> 
> Reason for asking is that I saw the following crash, and it would be
> good to know if the problem is the same.

This is just a guess, but I don't think it is unlikely.

The call trace indicates it dereferenced a NULL pointer in 
cros_ec_command, which is directly called by cros_typec_probe.

At the source level, cros_ec_command is directly called just once in 
cros_typec_probe, which dereferences typec->ec. typec->ec is however 
already used by cros_typec_get_cmd_version so it would never trigger a 
NULL dereference. Therefore, the crash should have happened in an 
inlined function.

cros_ec_command is called by cros_typec_get_cmd_version and 
cros_ec_check_features. cros_ec_check_features, which dereferenced NULL 
on my laptop, is called twice and unlikely to be inlined. 
cros_typec_get_cmd_version is called only once and is more likely to be 
inlined and thus the cause of the Oops in your crash. (By the way, the 
possibility of inlining would also make comparing call traces 
meaningless due to compiler/kernel version variances.)

This is just a guess anyway so you may disassemble your kernel build to 
know if it is same or not, which I think should be straightforward enough.

Regards,
Akihiko Odaki

> 
> <1>[    6.651137] #PF: error_code(0x0002) - not-present page
> <6>[    6.651139] PGD 0 P4D 0
> <4>[    6.651143] Oops: 0002 [#1] PREEMPT SMP NOPTI
> <4>[    6.651146] CPU: 0 PID: 1656 Comm: udevd Tainted: G     U
>      5.4.163-17384-g99ca1c60d20c #1
> <4>[    6.651147] Hardware name: HP Lantis/Lantis, BIOS
> Google_Lantis.13606.204.0 05/26/2021
> <4>[    6.651152] RIP: 0010:mutex_lock+0x2b/0x3c
> ...
> <4>[    6.651174] Call Trace:
> <4>[    6.651180]  cros_ec_cmd_xfer+0x22/0xc1
> <4>[    6.651183]  cros_ec_cmd_xfer_status+0x19/0x59
> <4>[    6.651185]  cros_ec_command+0x82/0xc3
> <4>[    6.651189]  cros_typec_probe+0x8a/0x5a2 [cros_ec_typec]
> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> 
> Not sure if this is the best solution, but I don't know a better one.
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 
>> ---
>>   drivers/platform/chrome/cros_ec_typec.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>> index 4bd2752c0823..7cb2e35c4ded 100644
>> --- a/drivers/platform/chrome/cros_ec_typec.c
>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>> @@ -1084,6 +1084,9 @@ static int cros_typec_probe(struct platform_device *pdev)
>>          }
>>
>>          ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
>> +       if (!ec_dev)
>> +               return -EPROBE_DEFER;
>> +
>>          typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
>>          typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
>>
>> --
>> 2.35.1
>>


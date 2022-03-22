Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671C54E426C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiCVPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiCVPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:00:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBE21E0A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:59:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p8so18354755pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IepTlBuHR+SAb5h03gTcfvlJ5IvGp0rMxG8cXCwldQs=;
        b=ge6XZRTUFMm7Lw5XV2A6gTN45bAVZhYA3XyojJPKeCP+BanFPRiREWgxLM89cvinby
         G4LIkJv0s8vIhkxPsFzqmSIGzQZEC3OPVzu0nvZ3NP4CkICx+D5ylaqnDEqD+d8XsZMP
         fZDFwcFlHgQ0l1WHLPuS4RKplwWR0/TpomWITY6xbEzLq6mQr2gOb00c4hRtbBFSAlmf
         kqnwKkhSoWmmmruKk5ah5M3NOwdkSU/Ruub1NXU1ZmmQ+5xdzjyZRZxo8JdqWFQZCwbn
         p8n0th2BC6ev/fMYEAipp1UoXKvvoowWZhhWNfQGvwDyuqEK43CCr6zN8qMqYqWx1dSb
         Gmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IepTlBuHR+SAb5h03gTcfvlJ5IvGp0rMxG8cXCwldQs=;
        b=qTB0SJ/fscKxP3P9mUL5kYubDSPOWmEKGewzq3f6PMS7Q3mDsrg74lbmJ65v4Kdm6f
         AhjjQJXK3SjxRLSkdl3krmYJKeoMiKqsrGlcRdYdLeHYAYwV0NywPG/NRXJhYzlwfXVL
         w9dbWdS0feAV9LXEpQe8fzbMhJt3YTGlkv8/9DtwHEqy4JG9b0UKkeiM7KMqCaoHqzfW
         q08hjFUOD02CIhz9MhTLn1BMls+5AsRDB9VjYiQIqP8yoaVuTb+jzV8HH76EjD82iWMj
         psGHNIZPNWR/wWs4LZKsCxYojOt2V186W+xKSsbhDKYmkJwIglyOnOJm5l62Xf1D7dIL
         OB6Q==
X-Gm-Message-State: AOAM530swOVHHFm698M0/gJt7TD/Njyr0tnWMLaqwW9SMeflML2CLdXJ
        TIpV0DYedMz+TznyX+tur7o=
X-Google-Smtp-Source: ABdhPJz3sK/PKvcu/GPrKaFwy32bd5HeM9MUPsEgSpZZkX+dcjPKcEHa4azDB/RFfCon/zye8hXsJA==
X-Received: by 2002:a63:1620:0:b0:375:948e:65bf with SMTP id w32-20020a631620000000b00375948e65bfmr22587716pgl.49.1647961146674;
        Tue, 22 Mar 2022 07:59:06 -0700 (PDT)
Received: from [192.168.225.67] ([157.49.254.255])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00125100b004fab9b19dcasm3149992pfi.163.2022.03.22.07.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 07:59:05 -0700 (PDT)
Message-ID: <745be03a-2ef6-f59e-2f05-6e9858c133fd@gmail.com>
Date:   Tue, 22 Mar 2022 20:29:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] staging: rtl8712: Fix CamelCase warnings
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220318101440.13887-1-skumark1902@gmail.com>
 <YjRswrHu0JUm9331@kroah.com> <3a85ae64-00c1-6483-f1d7-c12abdd3ff3a@gmail.com>
 <1786742.atdPhlSkOF@leap> <YjmzlGZJaBxLljq2@kroah.com>
From:   Sathish Kumar <skumark1902@gmail.com>
In-Reply-To: <YjmzlGZJaBxLljq2@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/22 5:01 pm, Greg KH wrote:
> On Tue, Mar 22, 2022 at 11:42:21AM +0100, Fabio M. De Francesco wrote:
>> On martedì 22 marzo 2022 05:30:29 CET Sathish Kumar wrote:
>>> On 18/03/22 4:58 pm, Greg KH wrote:
>>>> On Fri, Mar 18, 2022 at 03:44:40PM +0530, Sathish Kumar wrote:
>>>>> This patch fixes the checkpatch.pl warnings like:
>>>>> CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
>>>>> +   u8 blnEnableRxFF0Filter;
>>>>>
>>>>> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>       - Remove the "bln" prefix
>>>>> ---
>>>>>    drivers/staging/rtl8712/drv_types.h   | 2 +-
>>>>>    drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
>>>>>    drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
>>>>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> [...]
>>>>>
>>>>>    	do {
>>>>>    		msleep(100);
>>>>> -	} while (adapter->blnEnableRxFF0Filter == 1);
>>>>> +	} while (adapter->enable_rx_ff0_filter == 1);
>>>> Ah, that's funny.  It's amazing it works at all and that the compiler
>>>> doesn't optimize this away.  This isn't a good pattern to use in kernel
>>> Do you mean the following code is not a good pattern in kernel?
>>> do {
>>> msleep();
>>> } while(condition);
>> Exactly, this is not a pattern that works as you expect :)
>>
>> I was waiting for Greg to detail something more about this subject but,
>> since it looks like he has no time yet to respond, I'll try to interpret
>> his words.
>>
>> (@Greg, please forgive me if I saying something different from what you
>> intended to convey :)).
>>
>> The reason why this pattern does not work as expected is too long to be
>> explained here. However, I think that Greg is suggesting to you to research
>> and use what are called "Condition variables".
> Kind of.  The problem is that "condition" here is just looking at a
> random variable.  There is no sort of assurance that the variable will
> actually change or that that compiler even has to read from memory for
> it.  It could cache the value the first time it is read and then never
> update it for the whole loop logic.
>
> Please read Documentation/memory-barriers.txt for how to fix this all up
> and do it properly.
>
> Again, it's amazing that the current code even works at all.  So maybe
> it doesn't!  :)
>
> thansks,
>
> greg k-h

Thank you Greg and Fabio for your inputs. Will check and fix this up.

Regards,

Sathish


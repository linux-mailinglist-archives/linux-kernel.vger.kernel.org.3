Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953E4D8F37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiCNWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiCNWD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:03:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D61BE0;
        Mon, 14 Mar 2022 15:02:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y22so21868272eds.2;
        Mon, 14 Mar 2022 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vt8iM9U7s6FXQoqzpmttJcw/8Lujfl4H2Ez3oc36erU=;
        b=RpPFND2NXPVAxUhUxus0zI2b/gYpKTwvCTUJ2WuJT4N/F0jIP0tWl2jk78O++fqy92
         TGU9YacYn512Jzhed+Z/vU0gpiP45rwA2b3c4ms6S1nWV8r8Anrka2VXmw0qs4RUq6gg
         xmpUAeyjttWqFC/QeOawTL81IAtGMGBRgFEime6o80sQccgZAbvX+OImng/bxB+b0DOC
         5fBL3Psw4SoCPSXJJa5CVBoznfW0VnrFtLQf4sPVH8gbfasaIBoU4DYZW4dhp6RTMMZE
         pqW+sRrOiojMdAcYCBBOAllLTN9PRtLQmosKK3uF0p25Ct/+T0erHSgQwgl13bCB5Lt3
         i6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vt8iM9U7s6FXQoqzpmttJcw/8Lujfl4H2Ez3oc36erU=;
        b=4kIzxmvd1BSwRX+thfbeZgkrQUQBozTGCv0QC2T1qMESbhU0hp8SnDSUJ9NFkhpFgR
         C4PPC5qB/s2B72A/zF65PZHLwNV5uXukLNf0l/LFYN7h1A5DXAcfDNM3hS65D1cZGvEV
         /PTZ+D6YlDzUA7GukwcFIHIONftL5WeLofxfk67B+gjXG4eg9WrtnKaidMRUYpdN0sdz
         P+4zJpQWERCk4ym3eyS/OeJUSt9LZekNk9Mch9sjnF9ACrIDmlLPXtw9yuJWBL2H0anj
         /x5wHPiUcOi451Fg17b9sie9skC37/XI4KhR22Eq07vZtW6S2YxtIfsDT99GGYkTRiEG
         2nlA==
X-Gm-Message-State: AOAM531f9YxDGOXhi6xC5Jq3YEoW53KN3aQ06cZxIkhK27mceu/2MRwx
        rYJqUxWcIzDevTJlvgO2iMM=
X-Google-Smtp-Source: ABdhPJyfPFDXoq8h2P7bLU3Jq3Z4+MCLyvvcj6UYI+tq8JRLdG2zuD7PbFs7xHUOJHh18M1PS26OVg==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr22923203edt.186.1647295364657;
        Mon, 14 Mar 2022 15:02:44 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bcb5:5a00:21ff:806c:601e:d937? (dynamic-2a01-0c23-bcb5-5a00-21ff-806c-601e-d937.c23.pool.telefonica.de. [2a01:c23:bcb5:5a00:21ff:806c:601e:d937])
        by smtp.googlemail.com with ESMTPSA id y13-20020a1709060a8d00b006dabeaf86c7sm7295571ejf.137.2022.03.14.15.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 15:02:44 -0700 (PDT)
Message-ID: <ece53010-b7ed-6b12-1baa-08505537854d@gmail.com>
Date:   Mon, 14 Mar 2022 23:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mmc: core: Improve fallback to speed modes if eMMC HS200
 fails
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        linux-kernel@vger.kernel.org
References: <20220303164522.129583-1-ulf.hansson@linaro.org>
 <CAPDyKFod3LdfRRgVfdASqgSBAXqJnGkdKMM9qKnAYcfUQptF_g@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAPDyKFod3LdfRRgVfdASqgSBAXqJnGkdKMM9qKnAYcfUQptF_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 14.03.2022 11:54, Ulf Hansson wrote:
> On Thu, 3 Mar 2022 at 17:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> In the error path of mmc_select_hs200() we are trying our best to restore
>> the card/host into a valid state. This makes sense, especially if we
>> encounter a simple switch error (-EBADMSG). However, rather than then
>> continue with using the legacy speed mode, let's try the other better speed
>> modes first. Additionally, let's update the card->mmc_avail_type to avoid
>> us from trying a broken HS200 mode again.
>>
>> In an Amlogic S905W based TV box where the switch to HS200 mode fails for
>> the eMMC, this allows us to use the eMMC in DDR mode in favor of the legacy
>> mode, which greatly improves the performance.
>>
>> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Heiner, does this solve your problems? Can you perhaps run some tests
> at your side to see how it works for you?
> 

Tested-by: Heiner Kallweit <hkallweit1@gmail.com>

> Kind regards
> Uffe
> 
Heiner

>> ---
>>  drivers/mmc/core/mmc.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 141f851c9f58..6e7db45cb8e0 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1518,13 +1518,23 @@ static int mmc_select_timing(struct mmc_card *card)
>>         if (!mmc_can_ext_csd(card))
>>                 goto bus_speed;
>>
>> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
>> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>>                 err = mmc_select_hs400es(card);
>> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>> +               goto out;
>> +       }
>> +
>> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
>>                 err = mmc_select_hs200(card);
>> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>> +               if (err == -EBADMSG)
>> +                       card->mmc_avail_type &= ~EXT_CSD_CARD_TYPE_HS200;
>> +               else
>> +                       goto out;
>> +       }
>> +
>> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>>                 err = mmc_select_hs(card);
>>
>> +out:
>>         if (err && err != -EBADMSG)
>>                 return err;
>>
>> --
>> 2.25.1
>>


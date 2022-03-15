Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F294DA603
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352537AbiCOXKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiCOXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:10:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C0F3BA4E;
        Tue, 15 Mar 2022 16:09:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so487745wmf.0;
        Tue, 15 Mar 2022 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NDxeJbMELpkB0S650ke8FX0JhjXboLEVtYjcfZSkP5A=;
        b=NA7/uARo+bkXEOd0lPiQc1Zn+x/IdLkcUS3zHaMxZTcihOPZPRSoxoo1TicoCa8aSO
         35L0x42Tg9coDof1uiqBYJVLhnoXNdjgy3g2R0bJYIBGdrU1QLuqKONAOjdO1RxjNTju
         8pHRv7ZUAsbubaAjal5yK/dzULtFNJluas1nGd5KZT6Hn0ZXhYhVGMWyxhBWkWKY+RkP
         2Rn/k6Rk1srfuZVhlpJTkEIObgfxczxRj5VxQ5txmzlHaBapZ7hRfdLGaSpya7QzhQrk
         9XNNLhDr/FCDBWHtEs/zdhHmFJCRhDe64QmhmmvEhbJf/MkiOc500wfoX2yPwpbjY2Rx
         XRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NDxeJbMELpkB0S650ke8FX0JhjXboLEVtYjcfZSkP5A=;
        b=5DDp6SdeKM2PQkbYjiZdxveQWTf1MiPd5VwRHd1IQCreEm0digQdObH1tYDlrequyI
         VXkYYWXfav+kyXUWico5RvrQmgN1wZb4ubNovoLFLl4BYjOK1haWugOJha6c6hA1KCoh
         xpVpf5XYoDW3HVGrZqWXUo61l/THEOvo8+EaMEXdkD+yGP+UMBbbFfndz1ruZbNFT14Y
         tHtp8qe/okqX8sc1aOLvVHbMAj00JWMZOPK4DHSICEG07Pvz1tMK2eNeLO9pX7JqAppS
         lQBt8OgLK808GPLSN9BY+baXE7W3XFZQ+e4X5vGlr6Bd4EB+XilSIfRuUT187U3YO3c/
         la2A==
X-Gm-Message-State: AOAM530fPiV/109kXc1EEonubtrFZZLche0wmnjxGSpetVe0bFkodsUn
        1U7cOJ4BekHbrT1Wp4TaNMcy+0jhE81aYw==
X-Google-Smtp-Source: ABdhPJz84ds+bVUwZunt36TBvu7IcZ2YPD3wPYKLtuRe7Z/jRuHsOZItSVf/L/z95pxaGUsYFRboSQ==
X-Received: by 2002:a7b:c1d3:0:b0:38c:5b15:de91 with SMTP id a19-20020a7bc1d3000000b0038c5b15de91mr2055624wmj.40.1647385759075;
        Tue, 15 Mar 2022 16:09:19 -0700 (PDT)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id l1-20020a05600c4f0100b00387369f380bsm3819005wmq.41.2022.03.15.16.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 16:09:18 -0700 (PDT)
Message-ID: <9e2ac011-72e8-977c-00c9-5fa862a4e5f6@gmail.com>
Date:   Tue, 15 Mar 2022 23:09:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
 <20220315224645.ytcf7y7awc3q2y6j@pali>
 <5ea0e154-e06e-32b4-be86-f38ce07b8bec@gmail.com>
 <20220315230753.6xymu77uirjbnn3u@pali>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20220315230753.6xymu77uirjbnn3u@pali>
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

On 15/03/2022 23:07, Pali Rohár wrote:
> On Tuesday 15 March 2022 23:00:14 Colin King (gmail) wrote:
>> On 15/03/2022 22:46, Pali Rohár wrote:
>>> On Tuesday 15 March 2022 22:37:00 Colin Ian King wrote:
>>>> There are several spelling mistakes in comments, function names
>>>> and literal strings. Fix these.
>>>
>>> I do not think that there are mistakes.
>>>
>>> Please look at page 29 of the official bq24150 datasheet:
>>> https://www.ti.com/lit/ds/symlink/bq24150.pdf
>>
>> Looks like TI are redefining the spelling in the language :-)
> 
> Well, that could be truth, or maybe it just means something different.
> It is about 10 years ago and I do not remember more details about it.
> Anyway, in any case register name is vender and kernel code should match
> official register naming for which driver was written...

I'm fine with that. Apologies for the noise.

> 
>>>
>>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>>> ---
>>>>    drivers/power/supply/bq2415x_charger.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
>>>> index 5724001e66b9..b35700071966 100644
>>>> --- a/drivers/power/supply/bq2415x_charger.c
>>>> +++ b/drivers/power/supply/bq2415x_charger.c
>>>> @@ -71,7 +71,7 @@
>>>>    #define BQ2415X_BIT_OTG_PL		1
>>>>    #define BQ2415X_BIT_OTG_EN		0
>>>> -/* vender register */
>>>> +/* vendor register */
>>>>    #define BQ2415X_MASK_VENDER		(BIT(5)|BIT(6)|BIT(7))
>>>>    #define BQ2415X_SHIFT_VENDER		5
>>>>    #define BQ2415X_MASK_PN			(BIT(3)|BIT(4))
>>>> @@ -491,8 +491,8 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
>>>>    	return -1;
>>>>    }
>>>> -/* return chip vender code */
>>>> -static int bq2415x_get_vender_code(struct bq2415x_device *bq)
>>>> +/* return chip vendor code */
>>>> +static int bq2415x_get_vendor_code(struct bq2415x_device *bq)
>>>>    {
>>>>    	int ret;
>>>> @@ -1501,9 +1501,9 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
>>>>    		sprintf(revstr, "1.%d", ret);
>>>>    	bq->model = kasprintf(GFP_KERNEL,
>>>> -				"chip %s, revision %s, vender code %.3d",
>>>> +				"chip %s, revision %s, vendor code %.3d",
>>>>    				bq2415x_chip_name[chip], revstr,
>>>> -				bq2415x_get_vender_code(bq));
>>>> +				bq2415x_get_vendor_code(bq));
>>>>    	if (!bq->model) {
>>>>    		dev_err(bq->dev, "failed to allocate model name\n");
>>>>    		return -ENOMEM;
>>>> -- 
>>>> 2.35.1
>>>>
>>


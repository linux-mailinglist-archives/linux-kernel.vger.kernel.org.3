Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93157946A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiGSHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiGSHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:41:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05381DA46
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:41:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n18so23375669lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pow3Bvq1QnIMbABTn4g+l1ECYFTe6DuApp72EHRRsis=;
        b=MC4ZNpu5Fx0FBu0jaBATWNQPFRcyiOES1z83LivlcgeGA7JyA/vFhMW+wjd8+c9AWZ
         q5XXorB216ENCofihsTllOBSyurDez7q5kp1sYuDfhFUA6fa6HJTI0MykumqXk+w1CcM
         FpVVQE4gCLU8iRvx4XmC2j35lX53KE7gzWNW6PIblK1/voeGqs069cShuqtUGCgxe738
         k2znSRHeGenGhpqbhD82UpCyXLyjVXe1w/sp19kF3NzEFbh1hEca5jAyp5H8v/PDfyrY
         vrn5qrokEnYvtSSqamjNjwya31K6/cbDGCAVqeYpAOCUNe6VJsHBn3EJib+Nt8jJw0JO
         WloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pow3Bvq1QnIMbABTn4g+l1ECYFTe6DuApp72EHRRsis=;
        b=b4sliEiVxboK05jXgThVg1Za3GZDWCwO+eHywBWNpGoPEGTDIHQe19G142LiITZL6q
         By0wmp1eelHgb2Cv8/g195ESw9DIfaLRE4Q3iPbQyCTwG8mxT9SALcLLFxAAk+16eQL0
         PU+llO/B8ypu/dzz8LQYbIhrxRu7xe6jW7lBvb9ozMkcpfUIN3ZG9nDkA10nGBcPuecy
         ojiH0qbUJa5+8aDEXlpJpAuTypcDUwkBcGJcPuwy9io/o3/ahyfiDZJ8FXlLb3nHenJ6
         YElNCTacnwk2rOPBwqEsDZEXzrtyFCscTG4TsAJKV4B5/507HiNPZoCBPezkuV+95Uur
         KEJw==
X-Gm-Message-State: AJIora+kpU0NzsgYoEgzVD/biYVsdVc7SQIWPeXjCSr/LatmoJpFBvOx
        eDR0GLtrjeW4XBl2fpNo+c6gMw==
X-Google-Smtp-Source: AGRyM1sWz8Ev6wrovXjFB97kjohahEQG/Ckmt7jJEhzbahAoyI2p/S4WSqNZmZ5rRo/Nq4CAcM6dbQ==
X-Received: by 2002:a05:6512:2096:b0:48a:1edc:956 with SMTP id t22-20020a056512209600b0048a1edc0956mr11063833lfr.365.1658216489019;
        Tue, 19 Jul 2022 00:41:29 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id x26-20020a19e01a000000b0047f8fd27402sm3061693lfg.146.2022.07.19.00.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:41:28 -0700 (PDT)
Message-ID: <4a6e1a6a-78aa-62a9-1df0-4c707a1a8ec9@linaro.org>
Date:   Tue, 19 Jul 2022 09:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: leds: class-multicolor: reference class
 directly in multi-led node
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ChiaEn Wu <peterwu.pub@gmail.com>
References: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqK--sXnVCm1cQPP5-_URzYjANdA1UBvUVF6zdanrscrkQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqK--sXnVCm1cQPP5-_URzYjANdA1UBvUVF6zdanrscrkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 17:22, Rob Herring wrote:
> On Fri, Jun 24, 2022 at 5:21 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The leds/common.yaml is referenced directly in each LED node, which
>> leads to people doing the same with leds/leds-class-multicolor.yaml.
>> This is not correct because leds-class-multicolor.yaml defined multi-led
>> property and its children.  Some schemas implemented this incorrect.
>>
>> Rework this to match same behavior common.yaml, so expect the multi-led
>> node to reference the leds-class-multicolor.yaml.  Fixing allows to add
>> unevaluatedProperties:false.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> This will conflict with any new users of leds-class-multicolor, e.g.:
>> https://lore.kernel.org/all/20220623115631.22209-4-peterwu.pub@gmail.com/
>>
>> The new users should be updated to match the usage introduced here.
>> ---
>>  .../leds/cznic,turris-omnia-leds.yaml         |  2 ++
>>  .../bindings/leds/leds-class-multicolor.yaml  | 32 +++++++++----------
>>  .../devicetree/bindings/leds/leds-lp50xx.yaml |  2 ++
>>  .../bindings/leds/leds-pwm-multicolor.yaml    |  5 ++-
>>  .../bindings/leds/leds-qcom-lpg.yaml          |  2 ++
>>  5 files changed, 24 insertions(+), 19 deletions(-)
> 
> Looks like this introduced a new warning:
> 

I'll fix it.


Best regards,
Krzysztof

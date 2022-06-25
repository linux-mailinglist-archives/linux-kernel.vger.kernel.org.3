Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1C55AC39
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiFYT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiFYT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:58:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605A6170
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 12:58:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so7815279edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6OYSGRWE6FiNYEJq4CnoTkXsE+VZfA15rUqtVgbhIaM=;
        b=pI9zO9494ah2JfX794h4yCpf3NSPANue/0Oj68Ks/XZG1Pa1gD0fmd5n0kAkT64bha
         ZUINPjhPAk8L8QQyR7p26pAPWFnXGLcD0Jfa0gVYuhTnbx22TCS/8bF/sEtG4RG4EEty
         Xd5Hzph1eggOtuK4tUg6//XPa2po/nu/Ok9Qhs3BJAMDS+Djj6AAXXwZR/4e6NPhZUbg
         yRu+OAZRYnO8INkVa6uDQsMyO0Yhx5Ih9j4Nl7UlCmkE3E2tlS/leXrnW0TVNpLFuERJ
         XkX8PGW1egQ10tdmuFgdXKxhg10I4BfI/dX+CR241pY4KvhInus8putiCrRRfJzp/gST
         fr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6OYSGRWE6FiNYEJq4CnoTkXsE+VZfA15rUqtVgbhIaM=;
        b=luFbUh0dWl6RirHR7E6rRmrs2G+qRBnOduOxlMBMN0pyCMF9WailREzU6tMrhomA5R
         JMIih9FsKb7/CS7iaLasnPDrnjv4NNvuRkrpXegW2OhlIaKN9vDFJXH81MKIN9ngfNRg
         gzY6T4UUCvcla8CAW5gjTwtzb/oUIOcHli4iRL3i1EhOkbpD2xX5zHFsKcTjWKZEqIob
         NP4XG7MK3dXMwjBOh04UconCp2KJT/Ne5k/CVZ2+LM6xzMWbX0IMm/qvZjXxdziyLAlG
         7yS4/zhqL+SXm54FIwrGycTphCQAAo8I7aD5Jn1O1Nlh4y65K+3sq7noctE+NdXeMbMb
         KCSQ==
X-Gm-Message-State: AJIora8t2I24/jFTDGcRx8Jqh5CFBazxJp5WaZwD4JB96O0cXVbpeMdu
        dT5EIzRmK1zppkigfd2CBGKVwA==
X-Google-Smtp-Source: AGRyM1vPCotBygRwDE42Qng9nZ0Zryg+aZrbL44lLPrBOHgnnnMslwk52LUPs3mmcexth6LAcd1Rew==
X-Received: by 2002:aa7:c486:0:b0:435:5d50:ab39 with SMTP id m6-20020aa7c486000000b004355d50ab39mr7004006edq.104.1656187090221;
        Sat, 25 Jun 2022 12:58:10 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709063ec300b0072629cbf1efsm2943546ejj.119.2022.06.25.12.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 12:58:09 -0700 (PDT)
Message-ID: <89b6a40b-eb6b-eba5-78c3-6b5f35bed717@linaro.org>
Date:   Sat, 25 Jun 2022 21:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
 <ZVVZDR.R2QT2GMTT9WS1@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZVVZDR.R2QT2GMTT9WS1@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 20:40, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le ven., juin 24 2022 at 19:07:39 +0200, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> a écrit :
>> gpio-keys children do not use unit addresses.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> See: 
>> https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
>> ---
>>  arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
>>  arch/mips/boot/dts/ingenic/gcw0.dts           | 31 
>> +++++++++----------
>>  arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
>>  arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
>>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
>>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
>>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
>>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
>>  .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
>>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
>>  10 files changed, 37 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts 
>> b/arch/mips/boot/dts/img/pistachio_marduk.dts
>> index a8708783f04b..a8da2f992b1a 100644
>> --- a/arch/mips/boot/dts/img/pistachio_marduk.dts
>> +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
>> @@ -59,12 +59,12 @@ led-1 {
>>
>>  	keys {
>>  		compatible = "gpio-keys";
>> -		button@1 {
>> +		button-1 {
>>  			label = "Button 1";
>>  			linux,code = <0x101>; /* BTN_1 */
>>  			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
>>  		};
>> -		button@2 {
>> +		button-2 {
>>  			label = "Button 2";
>>  			linux,code = <0x102>; /* BTN_2 */
>>  			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
>> diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts 
>> b/arch/mips/boot/dts/ingenic/gcw0.dts
>> index 4abb0318416c..5d33f26fd28c 100644
>> --- a/arch/mips/boot/dts/ingenic/gcw0.dts
>> +++ b/arch/mips/boot/dts/ingenic/gcw0.dts
>> @@ -130,89 +130,86 @@ backlight: backlight {
>>
>>  	gpio-keys {
>>  		compatible = "gpio-keys";
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
> 
> Are you sure you can remove these?

Yes, from DT spec point of view, DT bindings and Linux implementation.
However this particular change was not tested, except building.

> 
> Looking at paragraph 2.3.5 of the DT spec, I would think they have to 
> stay (although with #address-cells = <0>).

The paragraph 2.3.5 says nothing about regular properties (which can be
also child nodes). It says about children of a bus, right? It's not
related here, it's not a bus.

Second, why exactly this one gpio-keys node is different than all other
gpio-keys everywhere and than bindings? Why this one has to be
incompatible/wrong according to bindings (which do not allow
address-cells and nodes with unit addresses)?


Best regards,
Krzysztof

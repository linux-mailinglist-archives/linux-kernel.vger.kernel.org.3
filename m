Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718350D241
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiDXOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbiDXOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:33:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3B617B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:30:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id el3so10855573edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t+cFAdULg2hxlZvpL8mkzZTJUv6nL4wjsFN6y1hgc60=;
        b=kIF8xCGrdnFF/XqcVlc6s4kC6K77erAVfHofi8ozMEg05dnYENDavy4NkKFKSc0Q1U
         4c9xuk8zEFVPonGkld9PDg+F1bw8e9AFPi+eO5BD27m+ZMpnfflE6sVMsi/aI9dxlsD6
         UaXeDgZkHCqSHf8gq8mScRrKG46blsX+Crw3/5cR1Q7J2BUk5ppWwxOmgE7W/28F2fx3
         i0/WYN5vVqZ4Ax00gOb58lfU7mmHt3xU98W49RZNRio+kO5s8bDNwXQQ/DP7WGP/Jd1z
         Hsc9yKvhjj16NmSjW/+1VRkYmqQ1rB1i2lLpB3p5W5i6PW9pRciEQ5QeU5CjJ+RmIzX9
         nVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t+cFAdULg2hxlZvpL8mkzZTJUv6nL4wjsFN6y1hgc60=;
        b=VQ6kWXb6t+OcZlcIbb7BnfYyNhTE7do7HSiETz4keEQKds3v6khPfvEXVAEBnEb/by
         wAcQiM6u5WmpQHoUb602PP6G5wcoKNlEIPLxpdIry00x9lbHYYpg2FsW1jfSpS4LzPR9
         pmk2fTbhDgac3ot2sG9hYuKO03y3KNa1EgCQWh9OlxTq0C17p88cWS4jWi8QdbQgWc+9
         loTssv2JN9Y8qHTw2ll5AWd4Q9ZB9AVgsQIG7pgLFPFJ4sioXlxUh0smxB8dKm46RuUi
         rNCdpMs1qEwnHVtW94uUkDkNHPncp52ANmEujVUw5fzORcIvJ7YwvdjPRqAwgb5Gtxlf
         S9Mg==
X-Gm-Message-State: AOAM53064pDdNMpzdlGyeKh7y4MFE6WEw7UpVvSNPcOY2uX1mPpJtVCP
        K7380gjKsZ/Ay8au+xMYNapUPw==
X-Google-Smtp-Source: ABdhPJziQDp0bSnyNdDldXqRA1oudD2LgKNlgAYkmoWx/OmfU3A29d1hMrX9VLFgL6qNVy1ZMH1f4g==
X-Received: by 2002:a05:6402:d0a:b0:421:10e6:2ecc with SMTP id eb10-20020a0564020d0a00b0042110e62eccmr14690714edb.329.1650810616878;
        Sun, 24 Apr 2022 07:30:16 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl7-20020a17090775c700b006f38e51ec81sm520413ejc.129.2022.04.24.07.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 07:30:16 -0700 (PDT)
Message-ID: <5b00db5b-b179-af0f-71e4-e940c6a41018@linaro.org>
Date:   Sun, 24 Apr 2022 16:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220418125630.2342538-1-gengcixi@gmail.com>
 <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
 <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org>
 <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
 <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org>
 <CAF12kFsxqdYERwhjC3tq9bNqzWS3P6Sb7VPCwHmQ=StF28Q-+A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFsxqdYERwhjC3tq9bNqzWS3P6Sb7VPCwHmQ=StF28Q-+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 16:22, Cixi Geng wrote:
>>>>
>>>> Neither here nor later you did not answer the question - why do you need
>>>> such complex construction, instead of adding syscon to the clock controller?
>>>>
>>>> Let me paste again my concerns:
>>>>
>>>>   You have nodes with reg but without unit address ("rpll"). These nodes
>>>>   are modeled as children but they are not children - it's a workaround
>>>>   for exposing syscon, isn't it? The sc9863a looks like broken design,
>>>>   so please do not duplicate it here.
>>>>
>>>> IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
>>>> Because of this you need to create complex ways to get the regmap for
>>>> the clock controller... Why not making it simple? Clock controller with
>>>> syscon?
>>>
>>> I find the history discuss about the sp9863 clock[1] and last
>>> ums512-clk dt-bindings patch[2] which from chunyan.
>>> please refer to the reasons below.
>>>
>>> These clocks are at the same register range with global registers.
>>> the registers shared with more than one devices  which  basically
>>> are multimedia devices. You may noticed that these are all gate
>>> clocks which are in the global registers  ranges and are used to
>>> controll the enable status of some devices or some part of devices.
>>>
>>> [1] https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=FTe5S7CzAHC5mahXBH2fJm7mXS7Xys1Q@mail.gmail.com/#r
>>> [2] https://lore.kernel.org/all/163425295208.1688384.11023187625793114662@swboyd.mtv.corp.google.com/#r
>>
>> Which looks like discussion about different bindings. You had there a
>> clock controller and additional clock device using "sprd,syscon". Why
>> the rpll is a subdevice and not a part of clock controller. The same as
>> all other clocks coming from that clock-controller, right? What is so
>> special about rpll that is is a separate device, not part of the clock
>> controller? It's the same address space, isn't it?
> The hardware spec design these clocks are not belonged to the syscon,
> the phandle is only used to get virtual  map address for clocks which
> have the same phsical address base with one syscon.(I don't know the
> historical reason for this design) It also can wroten a clock sperated from
> syscon by add the reg which same as syscon. but will lead to a duplicate
> mapping--one is from the clock,and one is from syscon. which make difficulty
>  in analyzing some panic problems.

I don't understand still. You said that they do not belong to same
address space, right? But the sprd,ums512-apahb-gate in this patch or
mentioned rpll
(https://elixir.bootlin.com/linux/v5.18-rc3/source/arch/arm64/boot/dts/sprd/sharkl3.dtsi#L106)
does not reference any other address space. It's entire address space is
the same as address space of glbregs.

So if it does not belong to the same address space, where is this space
defined?

Best regards,
Krzysztof

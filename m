Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA850DBE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiDYJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiDYJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:03:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FC186C8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:00:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so5134289ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w3IxbLwGG5AOreFgCaa2xIIUFHyNEgC4AZtZjxOzrog=;
        b=t6e/aV7+adIXldn+lDhrKWw3VnVedpv9hCrz6tFIISVjzmysEbe5zTjdbRTb7bm3Ia
         HWNa9xDFWcmvf7H4BNoMSRtMo/QRFj8Q83a48zgJ4sJOfqXfbKK91PVjn4b/Nhd6cpNS
         6+fw/Uxhcw9GcgMXrK7ceLBui8w7jq3YpdqV/RgPnCjRuPBlcvnb+BIlHga4Cz2VxszA
         U2wxzlrMMXgguJvgiQ/IByjwIHbo4jkeEP0BM3UBYBgmrCRad+wRwkZ/IR8V4GVA3/dD
         krbZu0cTCm3qrP2aA+15+0pTP01kT9lpXl7VQYgjuTCwTDn5zkdE/cxe95bRhpWp5LYg
         3luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w3IxbLwGG5AOreFgCaa2xIIUFHyNEgC4AZtZjxOzrog=;
        b=kfrHlb/mwt9T1XLHRoHcj5GbmghXr5wd+YS2iaZdADIo4O4DMZXrYP29MVSHU234Nt
         t4Eay4FsCfxMRQnhOK+MVji8silP2zRcQyuORpWaKW89NhGVwAspfe2arJBv+rCZKh88
         cXhaXEjiVnD4S6pNsQxKMgz2n9SeoaGNW/OQH0XLZP7iEbT0e/24ZpI5JSB3SKp1xEiQ
         4bC/EOaHa3s8HkoEm2MDSe+GyE2avV/PO0Qf6Gm7KQCK99h6LWjrdHswOV+AA3uKdmHg
         XO/DWafpy1ATQra0YFwGTa2mtHXO9/7uwApoM2J0SMqEkIgF4krQItp7vugl7ELdPCJp
         i5Ag==
X-Gm-Message-State: AOAM531akhdAwPBhMeIMtHbJmPZ5yMqiMPDIi4SRHs1X6vK4DX8Kn+76
        DSUydcT3kWjmvNdKQyA6xhMhJA==
X-Google-Smtp-Source: ABdhPJzdbNg2b9AX+OMDJh3C6SX9WPbUhIqKlPOP8EHiK7RMRR8j+81XqbqyspeHGmnaUkmKKwBXMQ==
X-Received: by 2002:a17:906:9746:b0:6e0:5c9a:1a20 with SMTP id o6-20020a170906974600b006e05c9a1a20mr15830210ejy.714.1650877212608;
        Mon, 25 Apr 2022 02:00:12 -0700 (PDT)
Received: from [192.168.0.241] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b0042121aee887sm4087663edb.77.2022.04.25.02.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 02:00:12 -0700 (PDT)
Message-ID: <0423e827-9592-ce6f-74ca-111a099a263f@linaro.org>
Date:   Mon, 25 Apr 2022 11:00:11 +0200
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
 <5b00db5b-b179-af0f-71e4-e940c6a41018@linaro.org>
 <CAF12kFt=L7CV5RDBViPSNb9Y_Te4JJ-TZrx2N+w_P2px7_FemQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFt=L7CV5RDBViPSNb9Y_Te4JJ-TZrx2N+w_P2px7_FemQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 17:12, Cixi Geng wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年4月24日周日 22:30写道：
>>
>> On 24/04/2022 16:22, Cixi Geng wrote:
>>>>>>
>>>>>> Neither here nor later you did not answer the question - why do you need
>>>>>> such complex construction, instead of adding syscon to the clock controller?
>>>>>>
>>>>>> Let me paste again my concerns:
>>>>>>
>>>>>>   You have nodes with reg but without unit address ("rpll"). These nodes
>>>>>>   are modeled as children but they are not children - it's a workaround
>>>>>>   for exposing syscon, isn't it? The sc9863a looks like broken design,
>>>>>>   so please do not duplicate it here.
>>>>>>
>>>>>> IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
>>>>>> Because of this you need to create complex ways to get the regmap for
>>>>>> the clock controller... Why not making it simple? Clock controller with
>>>>>> syscon?
>>>>>
>>>>> I find the history discuss about the sp9863 clock[1] and last
>>>>> ums512-clk dt-bindings patch[2] which from chunyan.
>>>>> please refer to the reasons below.
>>>>>
>>>>> These clocks are at the same register range with global registers.
>>>>> the registers shared with more than one devices  which  basically
>>>>> are multimedia devices. You may noticed that these are all gate
>>>>> clocks which are in the global registers  ranges and are used to
>>>>> controll the enable status of some devices or some part of devices.
>>>>>
>>>>> [1] https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=FTe5S7CzAHC5mahXBH2fJm7mXS7Xys1Q@mail.gmail.com/#r
>>>>> [2] https://lore.kernel.org/all/163425295208.1688384.11023187625793114662@swboyd.mtv.corp.google.com/#r
>>>>
>>>> Which looks like discussion about different bindings. You had there a
>>>> clock controller and additional clock device using "sprd,syscon". Why
>>>> the rpll is a subdevice and not a part of clock controller. The same as
>>>> all other clocks coming from that clock-controller, right? What is so
>>>> special about rpll that is is a separate device, not part of the clock
>>>> controller? It's the same address space, isn't it?
>>> The hardware spec design these clocks are not belonged to the syscon,
>>> the phandle is only used to get virtual  map address for clocks which
>>> have the same phsical address base with one syscon.(I don't know the
>>> historical reason for this design) It also can wroten a clock sperated from
>>> syscon by add the reg which same as syscon. but will lead to a duplicate
>>> mapping--one is from the clock,and one is from syscon. which make difficulty
>>>  in analyzing some panic problems.
>>
>> I don't understand still. You said that they do not belong to same
>> address space, right? But the sprd,ums512-apahb-gate in this patch or
>> mentioned rpll
>> (https://elixir.bootlin.com/linux/v5.18-rc3/source/arch/arm64/boot/dts/sprd/sharkl3.dtsi#L106)
>> does not reference any other address space. It's entire address space is
>> the same as address space of glbregs.
> Maybe I didn't describe clearly, what I said is these clocks isn't the
> syscom sub-clock.
> from chunyan's explain:
>  they  are at the same register range with global registers. in
> originally we put them
> directly onto the bus indeed when submitting the patches for SC9863A
> clocks last year,
> and it had a private property named 'sprd,syscon' which could provide
> regmap for these clocks.
> after follow Rob's suggetion we make them a child of the syscon. these
> are all gate clocks which
> are in the global registers ranges and are used to controll the enable
> status of some devices
> or some part of devices.

You need to help me here with the naming. What is "global registers"
range? Let's focus on sharkl3.dtsi and syscon@4035c000 with "rpll".

You have a clock controller @4035c000, which provides several clocks,
right? Then you have a rpll also @4035c000, so the register range is the
same. The register range is the same, isn't it?

I still don't see the answer to my question - why do you need a child
device for one clock if this looks like part of the clock-controller?

Best regards,
Krzysztof

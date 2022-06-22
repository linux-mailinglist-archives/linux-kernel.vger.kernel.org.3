Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAE554DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiFVOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358813AbiFVOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:44:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA11AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:44:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pk21so11629601ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RYwfVfzefAqNKZVKQvEbtCq+rTse+HGi+t512K/5paI=;
        b=h9aeHOCNsP48s1f9UZgl/sF7ri8jSbgNzUu1SbJeScku1cP8iyLMogSd4BLRSacMOw
         s6DTFMmVjqExbxKYaHGY2zgriJLt83x/RHSsxSjlKdBeDh9U8GvPWILy0IA5uKjWm+3a
         280ZLXcFqCZXTha793RLkTyulDrO5j7T2KbFPnko1DQxf+o8nkZdV0hExyBZHB4UaM2d
         nOJ/Rv+2Ldw+3Eik7vMCp2+HC6otkJhsNi+/PRjAOC3XbCjtnotWq7XCamdkg2otDk1r
         X84F/7jdyOaZ3gjHtrTIjpIscfu+4Pp5cWkLegzAX0wmJa+dTDleCPHMXFcb3kAUTqBb
         9XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RYwfVfzefAqNKZVKQvEbtCq+rTse+HGi+t512K/5paI=;
        b=8F2PrYPOqTeTq+glG1QNKGMUY8rEqKm0JqA4D4CQy/1kPGhKx5RT0dLKPcmwBm/Q0n
         qRiYQ4KOZZK7cUJ7F0ycmR+QWiJw59wp7rNh6QmOV3zOxoTmvJrvC/v89EsHW0tNaRUs
         OWkiHtKCeX7eMLcPz+B2HVPCzE01PU6ws9a7CDKRZWuFW62ZBQ9kVGYZ95X9UaVUlEyV
         XHz/WUjD3DraYAjRXdakJ6qJ5uvHLDB9iKjCINNRmjnSD19wYBdi9+G/FMB02NWa6t6S
         T9XW84QuuZSizNDYRsUIGvGsjaG+f+Q0UHYS7ncgXjmtFQXHvanVxbvvYVgJm6OoRiL9
         J4ng==
X-Gm-Message-State: AJIora9fa6RmCHHWMu6cTUeIEkjoR+4Bti2pZYwiJGDGJEREcbyemgSL
        w4Oka9FNm5WP4rcUZGu2bvKq9Q==
X-Google-Smtp-Source: AGRyM1t2cmVsqdR/E0vWWjOrjyMeXenoOBMJTlmkjA4NoZ8yBMWEQ07KErXLMvZgRfN6RBzLCLVDfA==
X-Received: by 2002:a17:907:980a:b0:722:f4a7:e00 with SMTP id ji10-20020a170907980a00b00722f4a70e00mr2325769ejc.114.1655909068742;
        Wed, 22 Jun 2022 07:44:28 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063a5700b0070efa110afcsm9210203ejf.83.2022.06.22.07.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:44:28 -0700 (PDT)
Message-ID: <6f5606be-5b6a-23f5-1fb3-b4964f8166b4@linaro.org>
Date:   Wed, 22 Jun 2022 16:44:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
 <79443fb4-5c09-a33f-594d-71ac93cc0317@linaro.org>
 <YrE84tLOpJtzrNW4@builder.lan>
 <9a31a488-f4fe-33f5-84e7-fe4509769d7c@linaro.org> <YrKNNQ2h6I8aseiW@ripper>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrKNNQ2h6I8aseiW@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 05:32, Bjorn Andersson wrote:
>>>>
>>>
>>> It's an interesting question, but I don't think it's possible to change
>>> the rate of this clock from one board to another.
>>>
>>> So I think it's best to keep this in the .dtsi, to avoid unnecessary
>>> duplication.
>>
>> It does not matter whether the frequency can be changed or not. This is
>> the same on almost every SoC and the same comments appear every time -
>> the clock is a property of the board, not of the SoC, so it should be in
>> the board DTSI. To avoid the duplication you can indeed keep here most
>> of the clock properties, but the frequency must be in board DTS.
>>
> 
> I find this to be a rather strict interpretation of "board specific",
> but I'm okay with it.

Yes, it is quite strict, but in the long term helps - people explicitly
need to enable/fill properties in new board DTSes, which hopefully will
trigger some thinking - "do I really have 385 MHz XO clock"?

Although here it might not really important, but that approach is useful
for all other cases, including aliases and buses. And one day, such
clear design will help new guys doing new hardware bring-up and they
will say: "I will start my new DTS board on some examples from mainline". :)

Best regards,
Krzysztof

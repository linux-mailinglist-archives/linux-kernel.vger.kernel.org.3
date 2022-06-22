Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5759F554DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357661AbiFVOsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiFVOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:48:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2FB366A0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:48:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e2so13317139edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6G/ojy09xOD7Yk10IXx6XAWZEdv4ioy60C9A76FQFHw=;
        b=gKFpOXoSswiKIyETZbbHGlP9RrX21keBgH0q9ZFLlbnXXmwv7IUyaEO8iocTlDUICb
         kkombdr/22igQ8TePP03v7ChHNF9hrIHYxajnVCZr9YTL+wDCR+yTIs/b55QN8cU3xRW
         5h4pypYGVa4zSqpky06UAiHlVBdfnHx23M3X7bd8V5oAbmoV/5j4QRqFRg57nVMGRbsw
         KR8lKuQC+dxkLzcuyFIigB/6x4aLNOiOMXH/qYJqysP2O5ATwfkvG+zefEU27Y+k4sTc
         WtMK9l2C4nGNNHh3bWTJkP+pIvtwAmi9IQkhPq40It2C1D224GloOSMrA+FGXCmYC1/A
         d++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6G/ojy09xOD7Yk10IXx6XAWZEdv4ioy60C9A76FQFHw=;
        b=CM9U+HLwTtoGckgyqG+ZgEgUsvoHqTdXSo3Uofw6ypYX54tYUK1r7KXZWfLjcRempY
         XEezlwZomHoa3YhOx7Wy3aq+UjB6i4aIdpWYz6/PhI3lCy5rM/5yA75PoO6kyBKziupj
         0vvEb3xwSoX05U8g7u1F79/MpdAbnbR2UO2DTEf31sQ9YTjjmCHx3vrBr/u7E2cUVafE
         98BoCjX1mGzd1uzgxFI0L+CHoOIy2jeBaOtOZOdv1d2CsZFR0o89yk1ncnBgeDkPGB6I
         +X/2SNHg/JSfwPALIjSdOdelHzMD1hvwEKdA7uWqn5pK2smPYB+YgOs2A15nxHctBTzq
         yHPQ==
X-Gm-Message-State: AJIora/ntdYD7PrrZE2V/GTX/gSys/707CHtQGNfMAjb5Hx2kR7oJemO
        swiVZ/lw6yIOZIv1DV/anO4ApQ==
X-Google-Smtp-Source: AGRyM1tepXVn3qZDFiUKLwEMJAiZepWcMEUbpTD17FAIjwRJXcma8VPMvtQzh93nwAj98NOdU0r3pg==
X-Received: by 2002:aa7:c2cf:0:b0:435:6576:b7c0 with SMTP id m15-20020aa7c2cf000000b004356576b7c0mr4537554edp.18.1655909299272;
        Wed, 22 Jun 2022 07:48:19 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id sb6-20020a1709076d8600b0070aaad0a173sm9385739ejc.192.2022.06.22.07.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:48:18 -0700 (PDT)
Message-ID: <b2c9faf0-95a8-772f-c211-f1599b35f8f8@linaro.org>
Date:   Wed, 22 Jun 2022 16:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
 <YrMccQXwsz/zC/gl@hovoldconsulting.com>
 <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
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

On 22/06/2022 16:36, Konrad Dybcio wrote:
> 
> 
> On 22.06.2022 15:43, Johan Hovold wrote:
>> On Wed, Jun 22, 2022 at 02:33:02PM +0200, Konrad Dybcio wrote:
>>> On 22.06.2022 06:12, Bjorn Andersson wrote:
>>
>>>> +&qup2_i2c5 {
>>>> +	clock-frequency = <400000>;
>>>> +
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
>>>> +
>>>> +	status = "okay";
>>>> +
>>> I think all device DTs generally have 'status = "okay"' at the beginning. Should we change that?
>>>
>>
>> No, quite the opposite, status go at the end.
> Then all other device DTs should be updated, as in dts/qcom/
> everybody keeps it first in non-SoC/PMIC files.

The word "should" is a bit too much here, but I agree, we can update all
of them to match one, chosen approach.

However the location for "status" property is more important for the
definition of nodes in DTSI, because it's the least important piece
there and also kind of expected - here go properties + I disable it. For
me this is more important.

For node redefinition in DTS, I see benefits in two approaches:
1. Let me first enable the node and then configure it.
2. Let me configure the node and enable it.

Best regards,
Krzysztof

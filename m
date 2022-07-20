Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455857BBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiGTQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiGTQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:46:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19254050
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:46:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o12so21807266ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eW32Y7kHOoyCzchouD8dBLTcqgbgXS4BmFC/O4Lg30M=;
        b=nyqku3a3HLHK+70E+Y8GEosypIROvWnmFa/2I+30KlBVuuce+jbXYBdjw1HU1XIQYo
         IASGUJ/GmK9MfrIUqi2Oh5EQ/YEDzyYpX908dTmykKAamIkU3klTz2s2TFVdqR2IT3YN
         /KJzjooCKdFzBCrI8VTgCbCnkHc1VRMVVG75oZbZnR5scYqfChufd0b2rdf+wlEVUZFK
         JhjQVarnP0hpatl07I5UhhBwKnn7bI69wb+IzXsdaE9M1Nz5gtKhHBlK9XShN9r/ofrj
         YnppJW+jXsoT58Jw1VLWlxyIfbVQ64Wfvo8ik+zs6lX86yaaUpwltp5KtzpHaD6hmMas
         EdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eW32Y7kHOoyCzchouD8dBLTcqgbgXS4BmFC/O4Lg30M=;
        b=SsVcD5AJGfSqmOHZBgQ5aYf5wPEYtewyyTFu1nKH0dHAyjajHUYkkFSbDDw4YcDtxH
         D9FfRdofH58zYaIs2rmzbqI2l7yXVeNW9X3EmNzJ9Gaj/pv/D2i/ZF90g/UXnN3gEqA2
         Qtaxh4TXAbX1n+97rhRBRvNlr4tU8/8BId+fbOpz9jmstsXJs6gU9aRekMTCqwmB+3TZ
         6B9w1hxYkPfHZbUXWAihDBa9KD7uQKJ+ieih3DXfISP9NvtE7NBYXAtVXwu0Hdk6euB7
         lC/QWcZuxrdo9f1uIRVgTu6g9WKMqVNNNZsCgi+D4Ld2vWkLWJ7IK+gRSHmVqEIs4Oxm
         fWEg==
X-Gm-Message-State: AJIora+TGQHlpxrfxem2WaNsw4S/IPenwiLJmyHPFBaXW96O7VChpO2d
        W9SO/Hk4f2w+lQqyKMtiq2LC+w==
X-Google-Smtp-Source: AGRyM1urk9m4eQiadowgrMKnFWZPaGdClLxR5kV7tNRV7fT6yqR9omQX/92QK4itmaBnZ/RRFFCbKQ==
X-Received: by 2002:a05:651c:1207:b0:25d:4eba:e247 with SMTP id i7-20020a05651c120700b0025d4ebae247mr16601237lja.100.1658335591868;
        Wed, 20 Jul 2022 09:46:31 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h28-20020a0565123c9c00b00489da512f5asm3915996lfv.86.2022.07.20.09.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:46:31 -0700 (PDT)
Message-ID: <e0f6eede-9f6d-48d2-3a0a-e294cbe55eca@linaro.org>
Date:   Wed, 20 Jul 2022 18:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: arm: qcom: Document additional sku6 for
 sc7180 pazquel
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220720073755.1.Ifab936517646b3876dd31b6e9b1b58a858529e57@changeid>
 <4cc6a276-4cbe-506a-6425-677c56469645@linaro.org>
 <CAD=FV=WP22g2ZhyeGeYJcGtQTBeKjinxQRCXicHxeVh-ziC8iA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WP22g2ZhyeGeYJcGtQTBeKjinxQRCXicHxeVh-ziC8iA@mail.gmail.com>
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

On 20/07/2022 17:07, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 20, 2022 at 12:46 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/07/2022 09:38, Yunlong Jia wrote:
>>> The difference between sku6 and sku4 is that there is no esim
>>>
>>> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 4dd18fbf20b6..aebeefdab27f 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -410,6 +410,7 @@ properties:
>>>        - description: Google Pazquel with LTE and Parade (newest rev)
>>>          items:
>>>            - const: google,pazquel-sku4
>>> +          - const: google,pazquel-sku6
>>
>> This looks wrong, did you test it?
> 
> Why do you think it's wrong? This patch is adding a second compatible
> string to an existing dts. 

Because it was sent after a patch adding sku6+sku4+sc7180, but the order
here is different.

However for some reason it was not part of a patchset which makes it
total mess and even less possible to understand.

> The only difference between SKU4 and SKU6
> is that one of them has the eSIM component stuffed and the other one
> doesn't. This need not be represented in the dts since the eSIM is
> automatically detected, but it was still stuffed as a SKU strapping so
> the factory could tell whether the missing eSIM was an error or
> intentional.
> 
> This is just like the SKU0 vs. SKU2 difference.
> 
> Other than the fact that this should be together in one series with
> the dts patch:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I don't agree. With last DTS patch this is a wrong binding (or wrong
DTS) therefore I must NAK it.

Please do not upstream stuff in some different way, like sending
bindings and DTS separate.

Best regards,
Krzysztof

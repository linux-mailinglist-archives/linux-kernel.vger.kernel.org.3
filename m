Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1584FA827
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbiDINUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiDINUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:20:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF93CFE0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:18:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so22320866ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TIvV9HUS6U5uZnee53C8qefZW/ieHFeAYqZWIX5PS5Y=;
        b=SzRXWvWDjWrGNzjafa7OdZ7o4vH48igNd7Ks1ce5EJ7N6I4dXV5MDU1qtLQ2jzFovL
         ITZxvtYVCEWld541IVMPomLfM7UzhLXw82SzeUPQnhw4WGEsRDV9ynC/d7wOvDiSXJL1
         6jWU5rE5JqUyBNCOGagVZAOxv/7xgYkhbgIhc2wsa+5ndvp2bQHfNZvryIrFBmfygBKi
         zkwOQ21EPtH3azxG3YsXTBM08W7eBDA/ho0x6AFGZtYQlBQMuR6pbVJOwTW4c/OXpzke
         X8yuVBwVlsTBhY50urMq1+Js4wjTcDwbXW3/4yv9CApFeW+n0Qmc7RDDK1Eyym7GsGeQ
         LrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TIvV9HUS6U5uZnee53C8qefZW/ieHFeAYqZWIX5PS5Y=;
        b=mZXroiEBhY/oNzxuS/MSFvFClYD8jnV5AYHL4Su2Tf1S8GAU/9e0NqqcLgpnyy6g7a
         vpIXuYSCVT7BUhMvN5ziwyG+PUtWsFqseYNz5TCD8lIzK6tTJJJajcZ1w3cf85q3K00I
         n0ahhR2rLV01+iL6Og1YBwLD6D5McQZQ38gGO1oAFhFwnQMqxwsXDaQ6sANmq+FpUPDa
         hQbj025SEMJ+SUHUUQ00xhQH1vrInqwvAx81oOE0iei4w8v5MfRonzdwqlC7aJZdjwEM
         y9N6sBNthZVL+wxNSnW3IxSB9VwdcHRtsb+J7EJufhqqQcpNWQldmbYYlpsu9ug2UjJw
         58hg==
X-Gm-Message-State: AOAM530XwWrpArQtdCXfBmpjYJPDyhnEcUkwOwDhqFC8jMSeDuztDxUs
        mviHRq0/UHMhfDSsfXl6mtdn7g==
X-Google-Smtp-Source: ABdhPJyMTC2qnmHi/0NCn+YqVeHeFQKswOIEzO1b2qZlKMPsJ8Q1z+DgYVKcFcBzrX/UfC7asrFiuw==
X-Received: by 2002:a17:906:d924:b0:6e8:6a04:c1bc with SMTP id rn4-20020a170906d92400b006e86a04c1bcmr4257899ejb.720.1649510304986;
        Sat, 09 Apr 2022 06:18:24 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id sh31-20020a1709076e9f00b006e8289e5836sm3550229ejc.117.2022.04.09.06.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:18:24 -0700 (PDT)
Message-ID: <99a97b0f-19a5-136d-9160-c9fde6f3548c@linaro.org>
Date:   Sat, 9 Apr 2022 15:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
 <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
 <B9FD64FE-82B0-4DC2-B4C3-BE266DAB28A0@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <B9FD64FE-82B0-4DC2-B4C3-BE266DAB28A0@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:09, H. Nikolaus Schaller wrote:
> 
> 
>> Am 09.04.2022 um 13:26 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>> jz4780-nemc needs to be compatible to simple-mfd as well or we get
>>>
>>> arch/mips/boot/dts/ingenic/ci20.dtb: memory-controller@13410000: compatible: 'oneOf' conditional failed, one must be fixed:
>>> 	['ingenic,jz4780-nemc', 'simple-mfd'] is too long
>>> 	'ingenic,jz4725b-nemc' was expected
>>> 	'ingenic,jz4740-nemc' was expected
>>> 	From schema: Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml    | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>> index 24f9e19820282..3b1116588de3d 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>> @@ -17,7 +17,7 @@ properties:
>>>     oneOf:
>>>       - enum:
>>>           - 
>>> -          - ingenic,jz4780-nemc
>>> +          - [ , simple-mfd ]
>>
>> This is not correct representation. If you really need simple-mfd, then
>> this should be a separate item below oneOf.
> 
> Well, it is valid YAML syntax and seems to be accepted by dtbscheck.

It's not how we code it. Please do not introduce inconsistent - even if
valid - blocks.

> 
>> The true question is whether you need simple-mfd. Isn't the binding (and
>> the driver) expected to instantiate its children?
> 
> I had expected that but current ingenic,jz4780-nemc code doesn't.

Paul provided good reason for the simple-mfd. Use this one instead of dt
check warning. DT check warning means nothing, does not bring the actual
answer to "why", because it is artificial tool. The answer to "why" is
in what Paul wrote.

Best regards,
Krzysztof

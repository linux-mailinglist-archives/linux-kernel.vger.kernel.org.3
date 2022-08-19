Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD580599CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349163AbiHSNJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348696AbiHSNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:09:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FAC6BD60
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:09:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s9so4478915ljs.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qtEXJInjg9AFO4KrF4iF5IYDoud9mgq+2joPRuKRKwQ=;
        b=zSosWE6Fk9lzdU5AiO5w3sspobz6PAzipoaeARXLjett4QPv1/ghHJMksJJr8o81SK
         pOFcXKNj+Yz0PALhWgRf2AbPUWoN0MPPNwfiItkbD2DxAofGkzyFcihZroUSX+X33mlh
         +OKBJuld2cAJFQUAD2L2Kf8kmG7M3CDQr7+lrd6BaR1BSZi0BTwXAMeKnfvha1QUGUv8
         swZp9RQDOY1U01rzZ7mrmDUZXgXCeRkR0mz3NWFMu3c3W3t5ZWxg8quhO66D2riljfmb
         gG64EmtvV7aKPlwqJedJon7zQ/U1Z3hh+oS3UOU4/13hcSV9g3q3Gw9cLmk1ebAXxFbK
         acoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qtEXJInjg9AFO4KrF4iF5IYDoud9mgq+2joPRuKRKwQ=;
        b=kPLTJV5r6bQobPIIQAZvPAmDs3RChx/0zgx/DIQnbQGmeE7AqZ6IEies8B2ugFCxQo
         i8BDuKwc5SVfmUjV35fmFeVAfT4Zg89qu0jgIMReHvRZRXFj4iytphRUDiAPPodKibgW
         ktKhpVP+kILD+xKsnHxECijgF/uuItLTWs608emU5wbcQDjOs7hC4q9y857pP7eHclpM
         NholxGUxILoG1N8DZCFPCZSy3zAdcc8cWxJQ7EDZ6FnRIeQKSpuqkzlAEUkQ0XboqFV0
         kTZdIigNhwoJ7cvrhWVG78GUGYp9n044BoAioukhMlAaQaX7TxUnk3NH4SF7y6+BEjwM
         ab+w==
X-Gm-Message-State: ACgBeo0E8PA9Uk5GtzQxc9D9dfIPk3iYQCPfJKGdvNUXQmj/Qa+QNJWc
        Ryea/guBO3fgB/XO8/u4tOu+1w==
X-Google-Smtp-Source: AA6agR6m/i2xLG4QBLSt4m/5F9loCr2QITqu6PDI/uMHTHktKw6yWdG3PvaU+TivoW57d0NlvhS9lg==
X-Received: by 2002:a2e:9348:0:b0:261:890d:b19c with SMTP id m8-20020a2e9348000000b00261890db19cmr2088492ljh.441.1660914548297;
        Fri, 19 Aug 2022 06:09:08 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id b18-20020a05651c033200b002618dae9fe8sm609476ljp.73.2022.08.19.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 06:09:07 -0700 (PDT)
Message-ID: <4ff71939-d366-4949-755b-f251168c9aa7@linaro.org>
Date:   Fri, 19 Aug 2022 16:09:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-2-povik+lin@cutebit.org>
 <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
 <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
In-Reply-To: <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
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

On 19/08/2022 16:08, Krzysztof Kozlowski wrote:
> On 19/08/2022 15:58, Martin Povišer wrote:
>>
>>> On 19. 8. 2022, at 14:54, Martin Povišer <povik+lin@cutebit.org> wrote:
>>>
>>> Add binding schema for MCA I2S transceiver found on Apple M1 and other
>>> chips.
>>>
>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>>> ---
>>> .../devicetree/bindings/sound/apple,mca.yaml  | 131 ++++++++++++++++++
>>> 1 file changed, 131 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/sound/apple,mca.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/apple,mca.yaml b/Documentation/devicetree/bindings/sound/apple,mca.yaml
>>> new file mode 100644
>>> index 000000000000..7b4f348c2be3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/apple,mca.yaml
>>> @@ -0,0 +1,131 @@
>>
>>
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - apple,t8103-mca
>>> +          - apple,t6000-mca
>>
>> Since it was brought up last time but I didn’t respond: the
>> nonalphabetical order is as the chips were introduced (and
>> matches other schemas).
> 
> Sure, just keep that order for future compatibles as well - so always
> put them according to verifiable time of market introduction...
> 
> This is very poor reason, instead of alphabetical order. Even worse
> reason is repeating wrong pattern just because someone else did it.

Ah, and the alphabetical order has clear advantage - reduces conflicts.
"Time" has clear disadvantage - increases conflicts.

So switch to alphabetical order.

Best regards,
Krzysztof

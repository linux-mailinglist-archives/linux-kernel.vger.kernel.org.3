Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0294F0158
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiDBMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiDBMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:09:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB28016E23A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:07:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so7643198wrg.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=tWegABcqL32JHQCEXG4tw1Wn/lH2n3sQgzMVGFju1Cs=;
        b=HwCMC7Fs6Qb2QuSS8MU8sCLzdNl7szuWzkPtuaSXnBrOLarJ3PbGvfeLwluwcvbANo
         wMeuL2E4kruh+TfEEIyAO+P/tPVOsdKkwv0GKef9xJBdpCY3yYVDyE1L8lIFXocAkmWa
         9tjAMMQNnX6hwP430p/DwN6j1VFyaC5J7U5KynJLlBn3Pf723UmxBlrhB4ow3rWX6mMh
         +ZII1a4q5/NtTYGYtPV9dvMLGJmizPNEygoNv47iawEG30LTay2GZbInsZdsPB2iXvxe
         MrqKuRrDzDCh5aOQzqtKvbTf1qy5mz+QD1+tajr1b/TCD2rcWcluptG0Z591lj3JrUUI
         YShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=tWegABcqL32JHQCEXG4tw1Wn/lH2n3sQgzMVGFju1Cs=;
        b=LKoBCQhEHqsbFQP52LfHR+6qyjCvYh0xjDnywLD3euOs6a9ObLyS69v2Gte5w6YPjf
         WHZWiDRC0/WsY8NOPCygDzVcXziB2ZaRGTVtEysYS/2ihPxH3GWaC6/+vgd5E7VwnBQv
         URMHxHRgSQtbcgSBSerTdzAT5jIDNyU9SJM2gL+gsxxZUscN7GcXCNBKCvnrIYqU9gX8
         hrUxrl0Zu5DX/dOP+qKEyADakH98tIklAM0+bkBd5/EARinySuptvjQD/esOgkM0gcE2
         tsekhypt4+BETPt0KbD1OvTjRLuNYxsoTVf1Dck+3CLtWvTPRxBivzt8nf+0vvZRwf0q
         yu5A==
X-Gm-Message-State: AOAM533pzfTic6dAzdFCadGAJ2dzrF4uAa23GPi5hRhCK3O5YqZuF182
        tzTBs3gHonvaYUNPz8iRbLsdXg==
X-Google-Smtp-Source: ABdhPJzPZitI3n3ThcnCdyRgnFmVRxYn14MRQvub5AGIgjbCh1t8vEmzIgc5aZBv+SEfIpvDoJTA7g==
X-Received: by 2002:a5d:6dae:0:b0:205:dfbd:789f with SMTP id u14-20020a5d6dae000000b00205dfbd789fmr10672074wrs.142.1648901248486;
        Sat, 02 Apr 2022 05:07:28 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0038e44e316c1sm6356644wmq.6.2022.04.02.05.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 05:07:28 -0700 (PDT)
Message-ID: <d092ede9-df92-9b34-d2d0-5da043e11679@linaro.org>
Date:   Sat, 2 Apr 2022 14:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 28/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzk+dt@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-29-clabbe@baylibre.com>
 <30305936-4b69-e1ce-44c2-0d1d113b460e@linaro.org>
In-Reply-To: <30305936-4b69-e1ce-44c2-0d1d113b460e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 13:53, Krzysztof Kozlowski wrote:
> On 01/04/2022 22:17, Corentin Labbe wrote:
>> The latest addition to the rockchip crypto driver need to update the
>> driver bindings.
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>> ---
>>  .../crypto/rockchip,rk3288-crypto.yaml        | 68 +++++++++++++++++--
>>  1 file changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>> index 66db671118c3..e6c00bc8bebf 100644
>> --- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>> @@ -11,8 +11,18 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - rockchip,rk3288-crypto
>> +    oneOf:
>> +      - description: crypto IP present on RK3288 SoCs
>> +        items:
>> +          - const: rockchip,rk3288-crypto
>> +      - description: crypto IP present on RK3328 SoCs
> 
> These two comments are not helping, so this should be just enum.
> 
>> +        items:
>> +          - const: rockchip,rk3328-crypto
>> +      - description: crypto IPs present on RK3399. crypto0 is the first IP with
>> +                     RSA support, crypto1 is the second IP without RSA.
> 
> The second part of this comment is helpful, first not. You have chosen
> enum in your first patch, so just extend it with comments. Additionally
> indexing does not scale. What if next generation reverses it and crypto0
> does not have RSA and crypto1 has?

Actually let me re-think this. Is programming model (registers?) same
between crypto0 and crypto1? If yes, this should be same compatible and
add a dedicated property "rockchip,rsa"?

I looked at your driver and you modeled it as main and sub devices. I
wonder why - are there some dependencies? It would be helpful to have
such information here in commit msg as well. Your commit #26 says that
only difference is the RSA.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3351FA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiEIKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiEIKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:48:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F5239DB6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:42:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j6so25924470ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Tzmc8wnZSs3kaLgnggedsJSFk2LO/Nmg9rBj5r4ux8=;
        b=WGMooZUa6j8KkU69lShmqD1ymL72xwWNXs3nodalP0erTsGOvMWwwYlpvkfH88kCxT
         0E8YX1Y8qiBuf+/rBk0+GJSTXF4omE/91WD5LJkr+PvXlkfHyQsDlxfi0okhln9IpJqD
         KrAZFM6qgMNFC0njfHmHs9zDX1UdTGXpgkhojXf4lsgtIc6vSsp851y0Jm+QuhQ0Wmi9
         Rw4mtHZsbsDJ15qVnpdTJUMfDa9Fv2M2CD3A5zcyze3Ld1rxH+U6YqggkNOytsjeUp4L
         QiWxMaXka+DZ6JYAWG3tn5oudbxE7kOyJyTVgROVW9mhNxBOnZCxjVyoNPVQOrHSiCJM
         Khgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Tzmc8wnZSs3kaLgnggedsJSFk2LO/Nmg9rBj5r4ux8=;
        b=2azJ4AE8qIwzBtLXZZYDCPgkELyVVjd0sXtEIhTuDyWw2XzMIDT3Nb51yzd8O/A3Vt
         Lndjdt1p7Or+Voe03P/tzuY4l0/Tw+Q4+n3cqEdedIFx2oiT5ZEOTrRXBN/VkyFa99C5
         eZBl0eV8/y3h5Y8zBxrAdUxFjtxnS5wC5yddJUzjTM2Uiz9d5TnMaGV6FFk2rqoX4RYA
         SGUtAkxKaeYuBDYBAwFlCeygrvStzzutm47Hr5hrCe3m33vSJCyc6yntjnhniR/V5JLx
         aQY183Jn13eZaj4IJuDECNbHhwDBl5hgADlpNT3pYxsx6Igr/zotRgGR+Xs9HF+8LQW8
         6o6A==
X-Gm-Message-State: AOAM530ijkNeoN7tS/3SDNVzjcrWbRV8yIIuJG+fEnw92znk+4S6Q1og
        t6mSnXaX75h4zggSHTJLlQFg2A==
X-Google-Smtp-Source: ABdhPJyu2S2O+OMAKWn+Ou31zi5Crs68RqyrtMBL3634D7gSQVjyX9dDSoVFxbdUCHfECEtlVve5Fw==
X-Received: by 2002:a17:906:7315:b0:6f4:c84f:9eab with SMTP id di21-20020a170906731500b006f4c84f9eabmr13171153ejc.759.1652092895893;
        Mon, 09 May 2022 03:41:35 -0700 (PDT)
Received: from [192.168.0.243] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z22-20020a50f156000000b0042617ba63c3sm6137747edl.77.2022.05.09.03.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:41:35 -0700 (PDT)
Message-ID: <ea94f18d-3172-98bb-0892-a98236a08018@linaro.org>
Date:   Mon, 9 May 2022 12:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU
 compatible
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
 <20220508202544.501981-2-frattaroli.nicolas@gmail.com>
 <422bf3bc-7787-97dd-6ab4-7570e5ce2ed8@linaro.org>
 <3594222.Ivq9XVSPaC@archbook>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3594222.Ivq9XVSPaC@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 11:24, Nicolas Frattaroli wrote:
> On Montag, 9. Mai 2022 09:25:23 CEST Krzysztof Kozlowski wrote:
>> On 08/05/2022 22:25, Nicolas Frattaroli wrote:
>>> The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
>>> encoding. This patch adds a compatible for it, and also allows
>>> the bindings to only come with a vepu interrupt.
>>>
>>> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>>> index bacb60a34989..4045f107ca4e 100644
>>> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>>> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>>> @@ -22,6 +22,7 @@ properties:
>>>            - rockchip,rk3288-vpu
>>>            - rockchip,rk3328-vpu
>>>            - rockchip,rk3399-vpu
>>> +          - rockchip,rk3568-vepu
>>>            - rockchip,px30-vpu
>>>        - items:
>>>            - const: rockchip,rk3188-vpu
>>> @@ -40,6 +41,7 @@ properties:
>>>    interrupt-names:
>>>      oneOf:
>>>        - const: vdpu
>>> +      - const: vepu
>>
>> This should be enum (for both lines above) and you should add
>> allOf:if:then with a constraints which variant can have which interrupts.
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> So something like this?
> 
>   interrupt-names:
>     oneOf:
>       - enum:
>          - vdpu
>          - vepu
>       - items:
>           - const: vepu
>           - const: vdpu

Yes

> 
> What's the difference between a list of consts and an enum here?
> I'm not very familiar with dt-schema, my apologies.

The effect is the same, just oneOf is a bit more complicated way to
describe it.

> 
> Also, since I don't know which of the other variants can have
> the encoding interrupt and this wasn't brought up until now, I think
> my solution will be to have a check for -vepu in the compatible and in
> that case require that only the vepu interrupt is present, if that's
> alright with you.

If you meant by adding a "if" case for only rockchip,rk3568-vepu, it's ok.

Best regards,
Krzysztof

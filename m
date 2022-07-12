Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89AB571F58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiGLPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiGLPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:32:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84085C08D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:32:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu42so14632704lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0q9Gvx7Z0ksjLoxHmNPJnvLZ0oMYX7lpjYwHt0sE3fY=;
        b=w1mXmlabNp7dsC4bzvKsmcIcHQmEvT2/nTr4wV3astV6R7wsM/Y3KEWDhi8VGGY/4s
         evwhRNKn/n0u+ioYAxtYWQSMyMQR2xMgDdKdgH+zyl4XHQQaYXUafRl/igGum8KnxsG5
         Pt1Q4ShK3MiGycJtVvPYflF7Rag6Pz8XRrM0SZY7EWlZ7Ks7Zs1X1FLPrrGOtn6DwERU
         XhxKezmuU0jd+dr+K12auSGEtfanVThQaTPMebB2f9cpXatHPG79i/5S4JNyZinVdfxU
         DxYgKiFJ8vsP4q4Gutn5FkxUva0K9ImgORxRgBBvLTPxd8pYoaYw4zwVabVpbG+4Y7es
         IxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0q9Gvx7Z0ksjLoxHmNPJnvLZ0oMYX7lpjYwHt0sE3fY=;
        b=cvw32Bub07040ICBhoyByO00d3LMKYJ1RusBrgXjituu44BkIJzXB7t8/Wgvncjjh2
         BWBPU9u6vAzag6hGQ28yRB113SqNDT8pPBAptXn6jWWsS6QFxmnyDF/gfzGXE+MM72qE
         tYSXdnqlY7c3kasqowGoYyBUZ9L7g7M+u1bCRdr9yOXXCn6OUx5dlX/DJjvgO4W+dPo/
         KHBR1A+c73VKIZ0CaUGVbKzNr4KrUTFb0UQZt6ajybYc6vd4lSqx2/FTZ6r4LKCgKSvj
         dVG/vx0zvIS6ypDAvPIHF9tTjTIn56mpcCCC0GfpIzxL9BaFH/e67TdtfPAAVAnBSuIE
         TxUw==
X-Gm-Message-State: AJIora8mreSZUYz8cmdf6vMie5OrHAvwKp2aIWmIVM96HWKDsqQd+Atj
        2dBb0KZn1C1ZHvJycBEGXey1pw==
X-Google-Smtp-Source: AGRyM1u9OoXz2cnj7jxSe/4JrF0ANDFELXJh2uu8x0qBIeg/tFjLu0qZuQHQLJznN8oGVOZnqiE6QA==
X-Received: by 2002:a19:6754:0:b0:489:c7ff:10e1 with SMTP id e20-20020a196754000000b00489c7ff10e1mr12485200lfj.585.1657639968769;
        Tue, 12 Jul 2022 08:32:48 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b00478a311d399sm2249135lfo.0.2022.07.12.08.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:32:48 -0700 (PDT)
Message-ID: <47aa4fbc-9cf4-7ac3-2fb4-2135a7703212@linaro.org>
Date:   Tue, 12 Jul 2022 17:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/6] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
 <20220630134835.592521-6-tommaso.merciai@amarulasolutions.com>
 <20220711093659.mf7i4uqtrejtfong@uno.localdomain>
 <20220712152538.jh4ufxik7icllox6@uno.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712152538.jh4ufxik7icllox6@uno.localdomain>
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

On 12/07/2022 17:25, Jacopo Mondi wrote:
> Hi Krzysztof
>    could you have a look at the below question ?

Sorry, there was a bunch of quoted text without end. When you reply
under quote, please remove the rest of the quote. None of us have a lot
of time to waste on scrolling emails...

> 
> If no need to resend from Tommaso I think the series could be
> collected for v5.20.
> 
> On Mon, Jul 11, 2022 at 11:37:05AM +0200, Jacopo Mondi wrote:
>> Hi Tommaso, Krzysztof,
>>
>>    This has been reviewed by Krzysztof already, so I guess it's fine,
>> but let me ask anyway
>>
>> On Thu, Jun 30, 2022 at 03:48:34PM +0200, Tommaso Merciai wrote:
>>> Add documentation of device tree in YAML schema for the OV5693
>>> CMOS image sensor from Omnivision
>>>
>>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>> Changes since v1:
>>>  - Fix allOf position as suggested by Krzysztof
>>>  - Remove port description as suggested by Krzysztof
>>>  - Fix EOF as suggested by Krzysztof
>>>
>>> Changes since v2:
>>>  - Fix commit body as suggested by Krzysztof
>>>
>>> Changes since v3:
>>>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
>>>
>>> Changes since v4:
>>>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
>>>
>>>  .../bindings/media/i2c/ovti,ov5693.yaml       | 106 ++++++++++++++++++
>>>  MAINTAINERS                                   |   1 +
>>>  2 files changed, 107 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>> new file mode 100644
>>> index 000000000000..b83c9fc04023
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>> @@ -0,0 +1,106 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (c) 2022 Amarulasolutions
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Omnivision OV5693 CMOS Sensor
>>> +
>>> +maintainers:
>>> +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>>> +
>>> +description: |
>>> +  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
>>> +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
>>> +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
>>> +  Serial Camera Control Bus (SCCB) interface.
>>> +
>>> +  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
>>> +  The sensor output is available via CSI-2 serial data output (up to 2-lane).
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/media/video-interface-devices.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ovti,ov5693
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    description:
>>> +      System input clock (aka XVCLK). From 6 to 27 MHz.
>>> +    maxItems: 1
>>> +
>>> +  dovdd-supply:
>>> +    description:
>>> +      Digital I/O voltage supply, 1.8V.
>>> +
>>> +  avdd-supply:
>>> +    description:
>>> +      Analog voltage supply, 2.8V.
>>> +
>>> +  dvdd-supply:
>>> +    description:
>>> +      Digital core voltage supply, 1.2V.
>>> +
>>> +  reset-gpios:
>>> +    description:
>>> +      The phandle and specifier for the GPIO that controls sensor reset.
>>> +      This corresponds to the hardware pin XSHUTDN which is physically
>>> +      active low.
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - dovdd-supply
>>> +  - avdd-supply
>>> +  - dvdd-supply
>>
>> Should supplies be made mandatory ? Sensors are often powered by fixed
>> rails. Do we want DTS writers to create "fixed-regulators" for all of
>> them ? The fact the regulator framework creates dummies if there's no
>> entry in .dts for a regulator makes me think it's fine to have them
>> optional, but I understand how Linux works should not be an indication
>> of how a bindings should look like.
>>
> 
> This question ^ :)

My generic answer for generic devices would be - if resource is
physically required (one need to connect the wire), I would say it
should be also required in the bindings. This also forces driver
developer to think about these resources and might result on
portable/better code.

However your point is correct that it might create many "fake"
regulators, because pretty often these are fixed on the board and not
controllable. Therefore I am fine with not requiring them - to adjust
the bindings to real life cases.

Best regards,
Krzysztof

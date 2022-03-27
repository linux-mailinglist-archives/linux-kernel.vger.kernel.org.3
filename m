Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B34E89BB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiC0Tcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiC0Tcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:32:32 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC063403F0;
        Sun, 27 Mar 2022 12:30:52 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id a1so17432960wrh.10;
        Sun, 27 Mar 2022 12:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oDwBb4EBdk3r4Q2S2CBoQkv3TN3dzVfRBaGMfKsjK2w=;
        b=naCXnBJBAx1T+AFt9LK6RejoC58GiXPiGJeV+jk+4tdk/ZdyI9dP2D5pBwHUe/4Iea
         9TZkTejTwYLIXXcqjztzsYpjDDqGInwmrRFwZ8jrk670s0tHYzCVy1O10Vs+QJqA93d3
         R8+DukUS+wx3f0vHT6Hz6oCYkghLCm9J3AvNF+ELNTM6P7yNnu96x5PC2THw5QfthWZ0
         3hG6OyBhJWIt6OPXWq/Tyfs/j7CP6e4TBxECmfmYP+p7ZTceCyYys+lkAiYb8BbM/2/i
         myhd4Y2L2uSswLiOBNrB9ixKKCpqc1PEOZSOHrKoCatCXf6q1fh0z/dlfSEQeVeLN3so
         SsQg==
X-Gm-Message-State: AOAM531rO0rJ9uJ7QQYURJRWkTwLy6dboHF9UC7ZsdMUmJNQrV4IwwXq
        uvWrey6z3L1KUUaV/wSC30U=
X-Google-Smtp-Source: ABdhPJzz+5SfFj0YJWjnS9ioUf8a+WgCadG7x+fKNlYI5KOkGRrI2hNy6Z08Vr9mvrAte7oIqCT79A==
X-Received: by 2002:a5d:688a:0:b0:204:6e3:f937 with SMTP id h10-20020a5d688a000000b0020406e3f937mr18538474wru.90.1648409451435;
        Sun, 27 Mar 2022 12:30:51 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm12119882wrd.5.2022.03.27.12.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:30:50 -0700 (PDT)
Message-ID: <6d69f9cd-d4e3-8327-9c60-3cb0b1d3f70e@kernel.org>
Date:   Sun, 27 Mar 2022 21:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 03/12] dt-bindings: pinctrl: add i.MXRT1170 pinctrl
 Documentation
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-4-Mr.Bossman075@gmail.com>
 <2af35b48-c49d-3a76-256b-c31d2650ed39@kernel.org>
 <8ce4ea34-f389-6eff-2e5b-0f23641df219@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <8ce4ea34-f389-6eff-2e5b-0f23641df219@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2022 21:14, Jesse Taube wrote:
> 
> 
> On 3/27/22 15:08, Krzysztof Kozlowski wrote:
>> On 26/03/2022 15:43, Jesse Taube wrote:
>>> Add i.MXRT1170 pinctrl binding Documentation
>>>
>>> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>>> ---
>>>   .../bindings/pinctrl/fsl,imxrt1170.yaml       | 77 +++++++++++++++++++
>>>   1 file changed, 77 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
>>> new file mode 100644
>>> index 000000000000..2e880b3e537c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
>>> @@ -0,0 +1,77 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/fsl,imxrt1170.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Freescale i.MXRT1170 IOMUX Controller
>>> +
>>> +maintainers:
>>> +  - Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> +  - Jesse Taube <Mr.Bossman075@gmail.com>
>>> +
>>> +description:
>>> +  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
>>> +  for common binding part and usage.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: fsl,imxrt1170-iomuxc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +# Client device subnode's properties
>>> +patternProperties:
>>> +  'grp$':
>>> +    type: object
>>> +    description:
>>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>>> +      Client device subnodes use below standard properties.
>>> +
>>> +    properties:
>>> +      fsl,pins:
>>> +        description:
>>> +          each entry consists of 6 integers and represents the mux and config
>>> +          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
>>> +          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
>>> +          be found in <arch/arm/boot/dts/imxrt1170-pinfunc.h>. The last
>>> +          integer CONFIG is the pad setting value like pull-up on this pin. Please
>>> +          refer to i.MXRT1170 Reference Manual for detailed CONFIG settings.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +        items:
>>> +          items:
>>> +            - description: |
>>> +                "mux_reg" indicates the offset of mux register.
>>> +            - description: |
>>> +                "conf_reg" indicates the offset of pad configuration register.
>>> +            - description: |
>>> +                "input_reg" indicates the offset of select input register.
>>> +            - description: |
>>> +                "mux_val" indicates the mux value to be applied.
>>> +            - description: |
>>> +                "input_val" indicates the select input value to be applied.
>>> +            - description: |
>>> +                "pad_setting" indicates the pad configuration value to be applied.
>>> +    required:
>>> +      - fsl,pins
>>> +
>>> +    additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>
>> You miss pinctrl.yaml, why?
> In the file name? Because I forgot for the fsl,imxrt1050.yaml, I can 
> change for both files.
>>

No, you miss here inclusion of pinctrl.yaml schema.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7854E898C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiC0TKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiC0TK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:10:29 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828C1D31B;
        Sun, 27 Mar 2022 12:08:50 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id x34so14653761ede.8;
        Sun, 27 Mar 2022 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jUX78lxvMhu0M5hNIDoB8Kg/eiFv9MlQM3djepFHqE4=;
        b=ssFQUTwbwIJfKXPj8c/xcGsRDNqy9LSZ6WkBweVpNVa7hhtnM12pr+XBIIQr0lBmEt
         CLxSoBucIkKB8ZO/q4Ld0IjB+xdlNSmh/Ckhsrq61SlTc1vJne89MEy/rj9M4slTRzr+
         QVa3aWkC2Mb0Cuu7unJaWDxv15xl8yZKLZxynD8lvvYMU+BPi1eEwmXzEDvx8OgyZNYl
         Kb5kfPKJdRxxchP8N0iUwx2WqzxW14SOXVTTgQHXUrSzrDk9yMWVAq3l7iVBs4HHSShj
         VQ1Zc5a7K8mQO8+9S6gYql+85jJD9QcAtIWIf4ax70qNf/Max/IqjXlmRt0Z5ZPbe6Cf
         S5gw==
X-Gm-Message-State: AOAM533p0cTQcSENtA4LbNB447jL/iAFISVeRKVyeyGAKlD61kpt5v07
        h8eQ5saRpvSBwtrwPjkisPM=
X-Google-Smtp-Source: ABdhPJyADU3wjgi1DFJ66YNFP/7n9r9cu4JjVI7yN4NV0e+nct/LrFTjhJY+VmBQ7LWMUgYFQ5bqVg==
X-Received: by 2002:a05:6402:51d2:b0:419:7d2e:9d0 with SMTP id r18-20020a05640251d200b004197d2e09d0mr11725718edd.82.1648408128446;
        Sun, 27 Mar 2022 12:08:48 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id ji15-20020a170907980f00b006df87edf6ebsm4934312ejc.154.2022.03.27.12.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:08:48 -0700 (PDT)
Message-ID: <2af35b48-c49d-3a76-256b-c31d2650ed39@kernel.org>
Date:   Sun, 27 Mar 2022 21:08:46 +0200
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-4-Mr.Bossman075@gmail.com>
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

On 26/03/2022 15:43, Jesse Taube wrote:
> Add i.MXRT1170 pinctrl binding Documentation
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  .../bindings/pinctrl/fsl,imxrt1170.yaml       | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
> new file mode 100644
> index 000000000000..2e880b3e537c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/fsl,imxrt1170.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MXRT1170 IOMUX Controller
> +
> +maintainers:
> +  - Giulio Benetti <giulio.benetti@benettiengineering.com>
> +  - Jesse Taube <Mr.Bossman075@gmail.com>
> +
> +description:
> +  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
> +  for common binding part and usage.
> +
> +properties:
> +  compatible:
> +    const: fsl,imxrt1170-iomuxc
> +
> +  reg:
> +    maxItems: 1
> +
> +# Client device subnode's properties
> +patternProperties:
> +  'grp$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      fsl,pins:
> +        description:
> +          each entry consists of 6 integers and represents the mux and config
> +          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
> +          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
> +          be found in <arch/arm/boot/dts/imxrt1170-pinfunc.h>. The last
> +          integer CONFIG is the pad setting value like pull-up on this pin. Please
> +          refer to i.MXRT1170 Reference Manual for detailed CONFIG settings.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        items:
> +          items:
> +            - description: |
> +                "mux_reg" indicates the offset of mux register.
> +            - description: |
> +                "conf_reg" indicates the offset of pad configuration register.
> +            - description: |
> +                "input_reg" indicates the offset of select input register.
> +            - description: |
> +                "mux_val" indicates the mux value to be applied.
> +            - description: |
> +                "input_val" indicates the select input value to be applied.
> +            - description: |
> +                "pad_setting" indicates the pad configuration value to be applied.
> +    required:
> +      - fsl,pins
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg

You miss pinctrl.yaml, why?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iomuxc: iomuxc@400e8000 {
> +        compatible = "fsl,imxrt1170-iomuxc";
> +        reg = <0x400e8000 0x4000>;
> +        pinctrl_lpuart1: lpuart1grp {
> +            fsl,pins =
> +              <0x16C 0x3B0 0x620 0x0 0x0  0xf1>,
> +              <0x170 0x3B4 0x61C 0x0 0x0	0xf1>;
> +        };
> +    };


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE26B4C66F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiB1KO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiB1KOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:14:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308B3F88A;
        Mon, 28 Feb 2022 02:13:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p4so5366448wmg.1;
        Mon, 28 Feb 2022 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iHjNxJBcliVXwUGTUuDrqJ48gN0ghqxi7GbNzI66nDg=;
        b=B5yHEZ8nfvEze7BcpERA6IwTFyTFlXmEnHPj+qeY8Lr7ulvVFeEYomuTTmUnFkQZ4S
         GbFdZ0I8BjI/gZ5NapYDLIPu/wShTItEkdLmz4MTEqBS0be7b2HpmiJgUaGNpftl6wdA
         PLzQPyHLWR5q46ZkNawG0iDOUGMkCn1AjXA1GtHgRpGhzdu6ePw3dkcfTU4T/D7Yo0Pg
         zbLoHBwJGXQtVjBqY6+oNS2i0XouHcl7q18ZdaMXDMyl9cVF35+SIHBeTd5N9kdHibfH
         MgWz4ISkniTdGART+3Wxtjvs9S0G9QnFrEf8vD9qj6WsS9imSA87YlfPvSH4ts8trSy1
         UcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iHjNxJBcliVXwUGTUuDrqJ48gN0ghqxi7GbNzI66nDg=;
        b=HcFIVGHHZzbg9ZV9ffUGU2CRkVdphR8GhBrDH4EOpUHV0xgrm31/bjMAKa6MwGIlpU
         Y29smiCHgDcfEaSeX01sIZqHh241w6OddqZofFkA+GWgIN9zcvl8Bq1X3q/JQu4GvR8h
         VEYFXJfUMCXxsCX0DPittoaB91JTmxmx7dU2uiOb6vrf6816fMju4nWwMvgbg+W4t9kM
         /+6kiHwX4oV2ML+Zhe9nM8qFWME73xzstyg23IQJZUcGMzlZlTH5NU1N7lL9ETJBTmOz
         Wo+3Kj5IOnI3+ZcVhvVjONLp0Vs8GIMc/4iidCX59gIvdZSLaBsa20Uw3ezKW3UvbjQh
         DL4w==
X-Gm-Message-State: AOAM530tkdNop0CUlRXgc5ZnLdYdNNvl+GCYI3RWmrs9TenXnYz0JLel
        QS3Q+Tr7yPpYrEbE7hdzCsBcekavizPPgA==
X-Google-Smtp-Source: ABdhPJyGje3sKsCaHr2cgj08/7Go8LtXdFkBrvBDBbspnQWl1pFUFer6mzofM1fgi2HmJq6bZgkuNA==
X-Received: by 2002:a05:600c:4e13:b0:37c:fd8e:28d7 with SMTP id b19-20020a05600c4e1300b0037cfd8e28d7mr13048794wmq.51.1646043222543;
        Mon, 28 Feb 2022 02:13:42 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm10578772wmj.34.2022.02.28.02.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 02:13:42 -0800 (PST)
Message-ID: <8a95a9fb-fede-b2e4-d616-e03c9e6778c8@gmail.com>
Date:   Mon, 28 Feb 2022 11:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
 <20220216113131.13145-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220216113131.13145-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 16/02/2022 12:31, Tinghan Shen wrote:
> Extend driving support for I2C pins on SoC mt8195.
> This property is already documented in mediatek,mt8183-pinctrl.yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Will you take this one through your tree or shall I take it. In the latter case 
I'd need an Acked-by from you.

Regards,
Matthias

> ---
>   .../bindings/pinctrl/pinctrl-mt8195.yaml      | 35 +++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> index 8299662c2c09..c5b755514c46 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> @@ -98,6 +98,32 @@ patternProperties:
>             drive-strength:
>               enum: [2, 4, 6, 8, 10, 12, 14, 16]
>   
> +          mediatek,drive-strength-adv:
> +            description: |
> +              Describe the specific driving setup property.
> +              For I2C pins, the existing generic driving setup can only support
> +              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
> +              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
> +              driving setup, the existing generic setup will be disabled.
> +              The specific driving setup is controlled by E1E0EN.
> +              When E1=0/E0=0, the strength is 0.125mA.
> +              When E1=0/E0=1, the strength is 0.25mA.
> +              When E1=1/E0=0, the strength is 0.5mA.
> +              When E1=1/E0=1, the strength is 1mA.
> +              EN is used to enable or disable the specific driving setup.
> +              Valid arguments are described as below:
> +              0: (E1, E0, EN) = (0, 0, 0)
> +              1: (E1, E0, EN) = (0, 0, 1)
> +              2: (E1, E0, EN) = (0, 1, 0)
> +              3: (E1, E0, EN) = (0, 1, 1)
> +              4: (E1, E0, EN) = (1, 0, 0)
> +              5: (E1, E0, EN) = (1, 0, 1)
> +              6: (E1, E0, EN) = (1, 1, 0)
> +              7: (E1, E0, EN) = (1, 1, 1)
> +              So the valid arguments are from 0 to 7.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
>             bias-pull-down:
>               oneOf:
>                 - type: boolean
> @@ -270,4 +296,13 @@ examples:
>             bias-pull-down;
>           };
>         };
> +
> +      i2c0-pins {
> +        pins {
> +          pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> +                   <PINMUX_GPIO9__FUNC_SCL0>;
> +          bias-disable;
> +          mediatek,drive-strength-adv = <7>;
> +        };
> +      };
>       };

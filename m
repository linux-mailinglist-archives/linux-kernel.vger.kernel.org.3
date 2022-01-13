Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0648DBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiAMQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiAMQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:32:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDF1C061574;
        Thu, 13 Jan 2022 08:32:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so11133936wra.6;
        Thu, 13 Jan 2022 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=stJa+t6N7piCO/G9WOrqhozs1aIJeDJMCX2Hc5YW/E4=;
        b=maMcAzeBBfspfDIjpKaMxzI5mlxkmJd8BsYGLHKd274zOBEBxERbjDYCCSm9t9mFer
         e0nC3OgbAcstei0ExP0dOqEC7bu6xECBBLdA0IkDM7cGVmVju9N4skvu+h6UucLMkjiC
         FvpdQoFAMnxg5oCt2BtBBoosRZEqZDascNyUYCx3KUjy0ZFEgKXIPouUbRsBRYeDLgsu
         EusPagXiugBX2ZQTjLlNzbGdkhmyvUh+JCE3WYj4/pjyTFEZ6KrmkAKoO0uBafcGfqN8
         a4Gyb8NH3RCzdDHK9+06EMolyGzt0xnndvHQrsK8PZrF0X8D8y8wBtFEhtvlOzRgIywF
         33qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=stJa+t6N7piCO/G9WOrqhozs1aIJeDJMCX2Hc5YW/E4=;
        b=P0PyOCwfQktAvkIuLsh/59vp9gMyezADY+Ijp2DbNKKZPPslZgaeUyrIdQM4395YTy
         1YjWH663y+eIeOAI4i4lubI8SokZ27lirAEwTjD1qLtHMWEF0UwIUyyvUuj4bVaEBPqS
         TB+EpRQdToYCABAwhMapTHpRx5Fu77Ym6ACt8n7pWVjwTjMUDmtXyCbfK0zMfaK29Onr
         LsHurb5COqjfql+2zJZkwf5uyJNa7wx2SbT/8PUO36khqxZFcUDEi//iYW6f6eWNW2in
         Q45b4cygLswvRB3uauGXLpMiUSEIFlwt4g4yTnjYnmawFhHlKQSnN/jqDqv6JwUGhuPB
         +gPQ==
X-Gm-Message-State: AOAM5330/f2BW/WuC4mDz7usgTEB0LpkLq12EsdS3wXDOv/QF4uDAWzi
        /PcAuaBGHHc0NEXAZ63zF1pkz3Gg+vo=
X-Google-Smtp-Source: ABdhPJzJBCLgIXVpW2ER0o2F54q3owOxB0C/KPwuwCJi9K//QZFSw+IEmYjjLP1k4kYswRx5CQH2kw==
X-Received: by 2002:adf:d08b:: with SMTP id y11mr4616297wrh.384.1642091519264;
        Thu, 13 Jan 2022 08:31:59 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id y17sm2880846wrr.84.2022.01.13.08.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 08:31:58 -0800 (PST)
Message-ID: <18f7a647-6153-6d38-dff1-727b9592b01e@gmail.com>
Date:   Thu, 13 Jan 2022 17:31:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v9 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
 <20220112114724.1953-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220112114724.1953-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dopping Maciej, Paolo and Sean Christopherson]

On 12/01/2022 12:47, Tinghan Shen wrote:
> Extend driving support for I2C pins on SoC mt8195.
> This property is already documented in mediatek,mt8183-pinctrl.yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks good to me. Linus please let me know when you are queuing this patch and 
I'll take the rest of the series. Another option is, that you provide an 
Acked-by and I can take the whole set through my branch.

Regards,
Matthias

> ---
>   .../bindings/pinctrl/pinctrl-mt8195.yaml      | 35 +++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> index 328ea59c5466..4db4899af6b1 100644
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
>               description: |
>                 For pull down type is normal, it don't need add RSEL & R1R0 define
> @@ -268,4 +294,13 @@ examples:
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
> 

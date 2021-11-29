Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F35646228C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhK2UyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:54:24 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33339 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhK2UwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:52:24 -0500
Received: by mail-oi1-f172.google.com with SMTP id q25so37050431oiw.0;
        Mon, 29 Nov 2021 12:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZNph4+nLG3s0XlUMVuAzCDU9rcaGJDmDcxOJITe0GjY=;
        b=0U9UDU8jN+MVm+Bz9SB0JmVuUewoWTnEhunO0u5JHodvK5/v6tbzcsMjGpY+GqfUmG
         E8LoTwMGPC2fa05vzJuwHdcRjmKLafK3DtA7s/ZAHkF0MbfymKhTwSu5B9AUMrzCJSWX
         ZwLR4jkN2BlPOA+BFO6ktuQEO2Nsi6UoECVFjNzirnJKxVdSSjs7O4bBbRiMW1NBzuPN
         NT4tgU8jK8dBlH6h6b4vwnYI4emfV2kld8K2Goy3gVTKmfRuqUINixpA/reDXsMlcARY
         w48/+TmCtFxbZB+gkJyZdu7INFZlmCPpFdb4gnB1t3bv37PwRwfGod5iHU6YBPhxh1uJ
         US4w==
X-Gm-Message-State: AOAM530W0gKVYDFnyLexdl+WOPFgw9Vrttdkld0vI1r9qOvTpjMgFozQ
        O/Kn2glH82+R6YJgsroOAA==
X-Google-Smtp-Source: ABdhPJwT3B6TI/5a0xH9vrNH72Lyd7Bc/Y7eD6XKuCz7+HRGjZ5aeoQs14hPa+69gExI92L6SFpsTg==
X-Received: by 2002:a05:6808:20a6:: with SMTP id s38mr409343oiw.152.1638218945629;
        Mon, 29 Nov 2021 12:49:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w9sm2408322oov.46.2021.11.29.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:49:04 -0800 (PST)
Received: (nullmailer pid 584170 invoked by uid 1000);
        Mon, 29 Nov 2021 20:49:03 -0000
Date:   Mon, 29 Nov 2021 14:49:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: use pinctrl.yaml
Message-ID: <YaU8v9WwVzDKbFa2@robh.at.kernel.org>
References: <20211110165720.30242-1-zajec5@gmail.com>
 <20211110165720.30242-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211110165720.30242-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 17:57:20 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Also fix some examples to avoid warnings like:
> brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: 'pin-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml | 3 +++
>  .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml     | 1 +
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml        | 3 +++
>  .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml          | 3 +++
>  .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml          | 3 +++
>  .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml          | 3 +++
>  .../devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml | 3 +++
>  .../bindings/pinctrl/brcm,bcm63268-pinctrl.yaml           | 3 +++
>  .../devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml       | 3 ++-
>  .../devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml    | 7 +++++--
>  .../devicetree/bindings/pinctrl/cirrus,lochnagar.yaml     | 3 +++
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml        | 3 +++
>  .../devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml   | 3 +++
>  .../devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml   | 3 +++
>  .../devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml   | 3 +++
>  .../devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml   | 3 +++
>  .../devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml  | 3 +++
>  .../devicetree/bindings/pinctrl/ingenic,pinctrl.yaml      | 8 ++++----
>  .../devicetree/bindings/pinctrl/intel,lgm-io.yaml         | 3 +++
>  .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml         | 3 +++
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml         | 3 +++
>  .../bindings/pinctrl/mediatek,mt6797-pinctrl.yaml         | 3 +++
>  .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml         | 3 +++
>  .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml         | 3 +++
>  .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml         | 3 +++
>  .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml       | 3 +++
>  .../devicetree/bindings/pinctrl/pinctrl-mt8195.yaml       | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml | 3 +++
>  .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml          | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml | 1 +
>  .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml  | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml | 1 +
>  .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml   | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml  | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml  | 1 +
>  .../devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml  | 1 +
>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml  | 3 +++
>  .../devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml  | 1 +
>  .../devicetree/bindings/pinctrl/qcom,tlmm-common.yaml     | 3 +++
>  .../devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/renesas,pfc.yaml          | 3 +++
>  .../devicetree/bindings/pinctrl/renesas,rza1-ports.yaml   | 3 +++
>  .../devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml | 3 +++
>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml           | 3 +++
>  .../devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml | 3 +++
>  .../devicetree/bindings/pinctrl/rockchip,pinctrl.yaml     | 3 +++
>  .../bindings/pinctrl/socionext,uniphier-pinctrl.yaml      | 6 +++---
>  .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml     | 3 +++
>  .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml        | 5 ++++-
>  .../devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml    | 3 +++
>  .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml  | 3 +++
>  58 files changed, 165 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

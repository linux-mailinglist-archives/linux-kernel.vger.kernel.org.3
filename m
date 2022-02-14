Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22D4B4F43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352421AbiBNLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:45:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353084AbiBNLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:43:30 -0500
X-Greylist: delayed 2169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 03:35:27 PST
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFFB5F49;
        Mon, 14 Feb 2022 03:35:27 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nJZ4E-00080o-TO; Mon, 14 Feb 2022 11:58:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 06/15] dt-bindings: pwm: rockchip: include generic pwm schema
Date:   Mon, 14 Feb 2022 11:58:49 +0100
Message-ID: <2270696.mDkAqzPR1c@diego>
In-Reply-To: <20220214081605.161394-6-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com> <20220214081605.161394-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Februar 2022, 09:15:56 CET schrieb Krzysztof Kozlowski:
> Include generic pwm.yaml schema, which enforces PWM node naming and
> brings pwm-cells requirement.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml | 74 ++++++++++---------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> index 81a54a4e8e3e..a336ff9364a9 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> @@ -51,42 +51,44 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - "#pwm-cells"
> -
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - rockchip,rk3328-pwm
> -          - rockchip,rv1108-pwm
> -
> -then:
> -  properties:
> -    clocks:
> -      items:
> -        - description: Used to derive the functional clock for the device.
> -        - description: Used as the APB bus clock.
> -
> -    clock-names:
> -      items:
> -        - const: pwm
> -        - const: pclk
> -
> -  required:
> -    - clocks
> -    - clock-names
> -
> -else:
> -  properties:
> -    clocks:
> -      maxItems: 1
> -      description:
> -        Used both to derive the functional clock
> -        for the device and as the bus clock.
> -
> -  required:
> -    - clocks
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3328-pwm
> +              - rockchip,rv1108-pwm
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Used to derive the functional clock for the device.
> +            - description: Used as the APB bus clock.
> +
> +        clock-names:
> +          items:
> +            - const: pwm
> +            - const: pclk
> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +          description:
> +            Used both to derive the functional clock
> +            for the device and as the bus clock.
> +
> +      required:
> +        - clocks
>  
>  additionalProperties: false
>  
> 





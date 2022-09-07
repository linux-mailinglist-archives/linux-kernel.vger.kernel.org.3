Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6F5B0E71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIGUqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIGUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:46:00 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E05B07D7;
        Wed,  7 Sep 2022 13:45:58 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id z22-20020a056830129600b0063711f456ceso11052308otp.7;
        Wed, 07 Sep 2022 13:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=upXcPuQ+AymjlAP813ikt1+Dlj+izCoKBqGmw9TwiEA=;
        b=ioGn23m1vUF13Ijm00z0vCu0kZlQlab0TClekr1AlKsHeHmPSPBJBRr2DIXR7nGvJS
         SoukVpgX9MgrQ0DadbHLy4B98LODLMO1v3BIOcElrT+Nl94OCrtpokeeIy3Qc1gHTklr
         rXxE8vFXyeRpenjwV8VmOiVZuJejoaaa37fUkq6UQO3U8QFMt/DRnL6nJ+UPkRZcRzNw
         b98lUT1iQeGKNF8Lcj9q2490S4Qfd3VHwyBgcqDE7f86qpQFPNNFSuT/jcQwXDfRQ0Mg
         aikdcYF7dudpDXhcbiglHtJfmd+a2T+LVtiy8ZONppt+S8NMIzfXxjoIO15ftM2yvlc5
         1VQQ==
X-Gm-Message-State: ACgBeo35aXJG4uNzrfsc6lBH5Fkcf1YBEslUhnhesfOriKYWO9sOGwqq
        1UcVtPfX2z5QCXgzlqgGf5hs5zPIag==
X-Google-Smtp-Source: AA6agR7XOBU/6/O2TwW9lBjbS8h05cyYcmFka/myRzOWQ4uhgMLB77hg5WkWiwvPbKFR5xw241HTpg==
X-Received: by 2002:a05:6830:4386:b0:637:3636:e29f with SMTP id s6-20020a056830438600b006373636e29fmr2072794otv.294.1662583558179;
        Wed, 07 Sep 2022 13:45:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y2-20020a4ae7c2000000b0042859bebfebsm5410539oov.45.2022.09.07.13.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:45:57 -0700 (PDT)
Received: (nullmailer pid 312607 invoked by uid 1000);
        Wed, 07 Sep 2022 20:45:56 -0000
Date:   Wed, 7 Sep 2022 15:45:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: update bindings for MT7986 SoC
Message-ID: <20220907204556.GA307930-robh@kernel.org>
References: <20220902024719.31943-1-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902024719.31943-1-chui-hao.chiu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:47:19AM +0800, Peter Chiu wrote:
> Add wifi pins in the description and set groups to string-array to support
> multiple groups in a node.
> 
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
>  .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 48 +++++++++++--------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> index 4eadea55df10..b08a0a8076e0 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> @@ -117,6 +117,10 @@ patternProperties:
>            "i2s"             "audio"     62, 63, 64, 65
>            "switch_int"      "eth"       66
>            "mdc_mdio"        "eth"       67
> +          "wf_2g"           "wifi"      74, 75, 76, 77, 78, 79, 80, 81, 82, 83
> +          "wf_5g"           "wifi"      91, 92, 93, 94, 95, 96, 97, 98, 99, 100
> +          "wf_dbdc"         "wifi"      74, 75, 76, 77, 78, 79, 80, 81, 82, 83,
> +                                        84, 85
>  
>          $ref: "/schemas/pinctrl/pinmux-node.yaml"
>          properties:
> @@ -234,7 +238,9 @@ patternProperties:
>              then:
>                properties:
>                  groups:
> -                  enum: [wf_2g, wf_5g, wf_dbdc]
> +                  $ref: /schemas/types.yaml#/definitions/string-array

'groups' already has a type. You can redefine it here.

> +                  items:
> +                    enum: [wf_2g, wf_5g, wf_dbdc]
>        '.*conf.*':
>          type: object
>          additionalProperties: false
> @@ -248,25 +254,27 @@ patternProperties:
>                An array of strings. Each string contains the name of a pin.
>                There is no PIN 41 to PIN 65 above on mt7686b, you can only use
>                those pins on mt7986a.
> -            enum: [SYS_WATCHDOG, WF2G_LED, WF5G_LED, I2C_SCL, I2C_SDA, GPIO_0,
> -                   GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5, GPIO_6, GPIO_7,
> -                   GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13, GPIO_14,
> -                   GPIO_15, PWM0, PWM1, SPI0_CLK, SPI0_MOSI, SPI0_MISO, SPI0_CS,
> -                   SPI0_HOLD, SPI0_WP, SPI1_CLK, SPI1_MOSI, SPI1_MISO, SPI1_CS,
> -                   SPI2_CLK, SPI2_MOSI, SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP,
> -                   UART0_RXD, UART0_TXD, PCIE_PERESET_N, UART1_RXD, UART1_TXD,
> -                   UART1_CTS, UART1_RTS, UART2_RXD, UART2_TXD, UART2_CTS,
> -                   UART2_RTS, EMMC_DATA_0, EMMC_DATA_1, EMMC_DATA_2,
> -                   EMMC_DATA_3, EMMC_DATA_4, EMMC_DATA_5, EMMC_DATA_6,
> -                   EMMC_DATA_7, EMMC_CMD, EMMC_CK, EMMC_DSL, EMMC_RSTB, PCM_DTX,
> -                   PCM_DRX, PCM_CLK, PCM_FS, MT7531_INT, SMI_MDC, SMI_MDIO,
> -                   WF0_DIG_RESETB, WF0_CBA_RESETB, WF0_XO_REQ, WF0_TOP_CLK,
> -                   WF0_TOP_DATA, WF0_HB1, WF0_HB2, WF0_HB3, WF0_HB4, WF0_HB0,
> -                   WF0_HB0_B, WF0_HB5, WF0_HB6, WF0_HB7, WF0_HB8, WF0_HB9,
> -                   WF0_HB10, WF1_DIG_RESETB, WF1_CBA_RESETB, WF1_XO_REQ,
> -                   WF1_TOP_CLK, WF1_TOP_DATA, WF1_HB1, WF1_HB2, WF1_HB3,
> -                   WF1_HB4, WF1_HB0, WF1_HB0_B, WF1_HB5, WF1_HB6, WF1_HB7,
> -                   WF1_HB8]
> +            $ref: /schemas/types.yaml#/definitions/string-array
> +            items:

Same for 'pins'.

> +              enum: [SYS_WATCHDOG, WF2G_LED, WF5G_LED, I2C_SCL, I2C_SDA, GPIO_0,
> +                     GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5, GPIO_6, GPIO_7,
> +                     GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13, GPIO_14,
> +                     GPIO_15, PWM0, PWM1, SPI0_CLK, SPI0_MOSI, SPI0_MISO, SPI0_CS,
> +                     SPI0_HOLD, SPI0_WP, SPI1_CLK, SPI1_MOSI, SPI1_MISO, SPI1_CS,
> +                     SPI2_CLK, SPI2_MOSI, SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP,
> +                     UART0_RXD, UART0_TXD, PCIE_PERESET_N, UART1_RXD, UART1_TXD,
> +                     UART1_CTS, UART1_RTS, UART2_RXD, UART2_TXD, UART2_CTS,
> +                     UART2_RTS, EMMC_DATA_0, EMMC_DATA_1, EMMC_DATA_2,
> +                     EMMC_DATA_3, EMMC_DATA_4, EMMC_DATA_5, EMMC_DATA_6,
> +                     EMMC_DATA_7, EMMC_CMD, EMMC_CK, EMMC_DSL, EMMC_RSTB, PCM_DTX,
> +                     PCM_DRX, PCM_CLK, PCM_FS, MT7531_INT, SMI_MDC, SMI_MDIO,
> +                     WF0_DIG_RESETB, WF0_CBA_RESETB, WF0_XO_REQ, WF0_TOP_CLK,
> +                     WF0_TOP_DATA, WF0_HB1, WF0_HB2, WF0_HB3, WF0_HB4, WF0_HB0,
> +                     WF0_HB0_B, WF0_HB5, WF0_HB6, WF0_HB7, WF0_HB8, WF0_HB9,
> +                     WF0_HB10, WF1_DIG_RESETB, WF1_CBA_RESETB, WF1_XO_REQ,
> +                     WF1_TOP_CLK, WF1_TOP_DATA, WF1_HB1, WF1_HB2, WF1_HB3,
> +                     WF1_HB4, WF1_HB0, WF1_HB0_B, WF1_HB5, WF1_HB6, WF1_HB7,
> +                     WF1_HB8]
>  
>            bias-disable: true
>  
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

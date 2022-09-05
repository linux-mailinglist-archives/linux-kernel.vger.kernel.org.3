Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93C5AD355
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiIEM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiIEM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:56:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A3C20BDF;
        Mon,  5 Sep 2022 05:56:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z21so1217881edi.1;
        Mon, 05 Sep 2022 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0gAThCdrASz4i29I8aFP1pjqTtXlCGbHPk559uSsFRM=;
        b=CiK72N0wBCG658QIKiEwIGfl85vMH9/yIlnXeWYA+FAdOycP2NbxES2Ukgh1m/NEZ/
         Y3yAIyYvuD8CmBREErPwXBCXjUSvaYx+TY/6n0yYb4LmSS0UkCS/y1LgMqmkTbfg/AK6
         eR9AClrdsu+GX/u65+a7h8Ibd/V3WM327RKa5jSXWkNj9axn7JIe9Yop6PdQPlrafmif
         nD9zZOJb1K9j1xVEC9FQ6/CLop4m7KP+Q4ITj3Cap93f2M6rvpl2pnp+RIsKGU8PqI52
         ewPuvC++pY5V01Py870ABd/oQhyHCgWP53WUkdh22XcZn4X1Uaoh3JrHiRp9MRXAzSdD
         pjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0gAThCdrASz4i29I8aFP1pjqTtXlCGbHPk559uSsFRM=;
        b=MpmX5BVtyiC1yaD4NX7kkaUhRcSukgkpDrS35zps2QvwjiVWJWkS1r0cbzgCRr4DTK
         RTfnRyw/VaFZ5HIwn5QHXATWlZd0axaTQSCCRpAXLc8JCQdmQR1yj/7BvqiVwm6MT39S
         IusTleeH4mWwfCvmrCpLmnp9UGE5PChECkw614leUkDMBd1RKOTanlmjYPAqZXHskCk3
         GhxQt0RNzZp7kszqeLX9q+yGDH3G8MCCrmaeZFaBSQV+ArNWvK3qCGYrnOZMxbpW8u1K
         35tmAdRgWzp4xHQdlwnA3yeTABuNBUTfStKVvT+IkQ2xhy252Y1PU6gtjeuDYQl/nrMw
         +JBQ==
X-Gm-Message-State: ACgBeo1gU7vNY0vrHk/O+Q7WeDKn53kpU5FpDOWVol6+GiYy/OSCh7dS
        nQ0NtqVSHdg9Qd3tOoDOoMCVEX2l7Iw=
X-Google-Smtp-Source: AA6agR7tHQz8yCPykbig7EMDbh8yZ3Z9bpq/JAYy6xdettSljo2LZv2RuRhZyy77J133ZIugYLeqZQ==
X-Received: by 2002:aa7:c74c:0:b0:44e:a7b9:d5c9 with SMTP id c12-20020aa7c74c000000b0044ea7b9d5c9mr1764250eds.19.1662382588386;
        Mon, 05 Sep 2022 05:56:28 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s5-20020aa7cb05000000b0044e9e5ce396sm1109481edt.95.2022.09.05.05.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 05:56:27 -0700 (PDT)
Message-ID: <d314d734-eb9e-1767-6186-b12460eea604@gmail.com>
Date:   Mon, 5 Sep 2022 14:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] dt-bindings: pinctrl: update bindings for MT7986 SoC
Content-Language: en-US
To:     Peter Chiu <chui-hao.chiu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <20220902024719.31943-1-chui-hao.chiu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220902024719.31943-1-chui-hao.chiu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2022 04:47, Peter Chiu wrote:
> Add wifi pins in the description and set groups to string-array to support
> multiple groups in a node.
> 
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 48 +++++++++++--------
>   1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> index 4eadea55df10..b08a0a8076e0 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> @@ -117,6 +117,10 @@ patternProperties:
>             "i2s"             "audio"     62, 63, 64, 65
>             "switch_int"      "eth"       66
>             "mdc_mdio"        "eth"       67
> +          "wf_2g"           "wifi"      74, 75, 76, 77, 78, 79, 80, 81, 82, 83
> +          "wf_5g"           "wifi"      91, 92, 93, 94, 95, 96, 97, 98, 99, 100
> +          "wf_dbdc"         "wifi"      74, 75, 76, 77, 78, 79, 80, 81, 82, 83,
> +                                        84, 85
>   
>           $ref: "/schemas/pinctrl/pinmux-node.yaml"
>           properties:
> @@ -234,7 +238,9 @@ patternProperties:
>               then:
>                 properties:
>                   groups:
> -                  enum: [wf_2g, wf_5g, wf_dbdc]
> +                  $ref: /schemas/types.yaml#/definitions/string-array
> +                  items:
> +                    enum: [wf_2g, wf_5g, wf_dbdc]
>         '.*conf.*':
>           type: object
>           additionalProperties: false
> @@ -248,25 +254,27 @@ patternProperties:
>                 An array of strings. Each string contains the name of a pin.
>                 There is no PIN 41 to PIN 65 above on mt7686b, you can only use
>                 those pins on mt7986a.
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
>             bias-disable: true
>   

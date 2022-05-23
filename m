Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB5530C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiEWJBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiEWJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:01:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBF43EF1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:01:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u30so24383321lfm.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fYCNzd5DZy9e/CqtLhmUm9AQGXVd0bR6NXYTSVtz10Q=;
        b=tcOPeifid63AxtGOEwUuOCh3+d9GSGk3wioI874kER3GgGNBqrV3zfBI7ONuNNfbo8
         Q73mPLV0mpOokTTYaYs54OZ9LcS3wULB9HEbQaTP6LN6I/P7pX5moARyVOwijRX/FE+L
         G2Q4c7lSkcAUSsQEU7lopuTEenP/1oRjNBMP0oXHI8uW7/Ux+5w8jq5qI7G7nQvxS8ZI
         H88FjxD/65ysDCp6c9KmwguVTtayn/JRxHTDiXLPksBNWTE/sn4M1FQR8FOlgxpCoJNT
         CcyYuXhSB38KIyJC+24EDDwviFl+mp0sCxkJvSKwndzLb6GQA3cDtbdHehMINZQfnG9l
         DOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYCNzd5DZy9e/CqtLhmUm9AQGXVd0bR6NXYTSVtz10Q=;
        b=05RScVU49c9F+Klc1ATSJ2LEpZXW9ItPgOCyP2DkSeGCNDlkL0bCnnQuYliT3aQjyX
         emu/qjOzMuDYVJ0QW5BHjvy8wghy9AHYcp2074nIeMq3KfZrM/mI9GmAGMuK036v1U72
         vZwD82kzTatMH5ugMK/W0Q//z0/zj/gkD9Gkeze/mMQPrPHUnjkyvPrQxw2YE2AUvRek
         7zDxlPtl3O3MVyjus6nE1SJYb2azQ/AUBflJSHK2QznxNqUbIoOM2zA9qrj3poBL4+y1
         Usu8k1tKHDre1iPDUNK6EDJjDnE/DXmodcgpn0nbrM0K3U0HeiW9zOuImXEMe4HoHnmt
         78HQ==
X-Gm-Message-State: AOAM533BaGA3hbSz3f4QiXE2SGht2D3V7LlPlHn0C6D0Sj7i1YT3TAM1
        MRZtJshK02+N1XzAYQBlym0jJw==
X-Google-Smtp-Source: ABdhPJzHHP/+WcFU3Js4/bOYcbZttzRgNemubLuXS7gmbHa8Ppa37s0pp4mI7+q4phqBf5ol2YkDfg==
X-Received: by 2002:a05:6512:3c84:b0:478:19f2:bc2e with SMTP id h4-20020a0565123c8400b0047819f2bc2emr12055162lfv.324.1653296499290;
        Mon, 23 May 2022 02:01:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q1-20020ac25fc1000000b0047255d210eesm1863280lfg.29.2022.05.23.02.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:01:38 -0700 (PDT)
Message-ID: <86cd6a37-70ad-3a90-bc8a-dcd8b41f1175@linaro.org>
Date:   Mon, 23 May 2022 11:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 11/19] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-12-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-12-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Add binding document and device tree binding
> constants for Nuvoton BMC NPCM8XX reset controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/reset/nuvoton,npcm-reset.txt     |  17 ++-
>  .../dt-bindings/reset/nuvoton,npcm8xx-reset.h | 124 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> index cb1613092ee7..b7eb8615b68b 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> @@ -1,14 +1,15 @@
>  Nuvoton NPCM Reset controller
>  
>  Required properties:
> -- compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
> +- compatible : "nuvoton,npcm750-reset" for Poleg NPCM7XX BMC.
> +               "nuvoton,npcm845-reset" for Arbel NPCM8XX BMC.
>  - reg : specifies physical base address and size of the register.
>  - #reset-cells: must be set to 2
>  - syscon: a phandle to access GCR registers.
>  
>  Optional property:
>  - nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
> -  NPCM7xx contain four software reset that represent numbers 1 to 4.
> +  NPCM7xx and NPCM8xx contain four software reset that represent numbers 1 to 4.
>  
>    If 'nuvoton,sw-reset-number' is not specified software reset is disabled.
>  
> @@ -32,3 +33,15 @@ example:
>          };
>  
>  The index could be found in <dt-bindings/reset/nuvoton,npcm7xx-reset.h>.
> +
> +Specifying reset lines connected to IP NPCM8XX modules
> +======================================================

No need to document consumers. Just mention the header.

> +example:
> +
> +        spi0: spi@..... {
> +                ...
> +                resets = <&rstc NPCM8XX_RESET_IPSRST2 NPCM8XX_RESET_PSPI1>;
> +                ...
> +        };
> +
> +The index could be found in <dt-bindings/reset/nuvoton,npcm8xx-reset.h>.
> diff --git a/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> new file mode 100644
> index 000000000000..4b832a0fd1dd
> --- /dev/null
> +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

> +// Copyright (c) 2022 Nuvoton Technology corporation.
> +
> +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
> +#define _DT_BINDINGS_NPCM8XX_RESET_H
> +
> +#define NPCM8XX_RESET_IPSRST1		0x20
> +#define NPCM8XX_RESET_IPSRST2		0x24
> +#define NPCM8XX_RESET_IPSRST3		0x34
> +#define NPCM8XX_RESET_IPSRST4		0x74

What are these? All IDs should be incremental, decimal and start from 0.

> +
> +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
> +#define NPCM8XX_RESET_GDMA0		3

IDs start from 0 and do not have holes.


> +#define NPCM8XX_RESET_UDC1		5
> +#define NPCM8XX_RESET_GMAC3		6
> +#define NPCM8XX_RESET_UART_2_3		7
> +#define NPCM8XX_RESET_UDC2		8
> +#define NPCM8XX_RESET_PECI		9
> +#define NPCM8XX_RESET_AES		10
> +#define NPCM8XX_RESET_UART_0_1		11
> +#define NPCM8XX_RESET_MC		12
> +#define NPCM8XX_RESET_SMB2		13
> +#define NPCM8XX_RESET_SMB3		14
> +#define NPCM8XX_RESET_SMB4		15
> +#define NPCM8XX_RESET_SMB5		16
> +#define NPCM8XX_RESET_PWM_M0		18
> +#define NPCM8XX_RESET_TIMER_0_4		19
> +#define NPCM8XX_RESET_TIMER_5_9		20
> +#define NPCM8XX_RESET_GMAC4		21
> +#define NPCM8XX_RESET_UDC4		22
> +#define NPCM8XX_RESET_UDC5		23
> +#define NPCM8XX_RESET_UDC6		24
> +#define NPCM8XX_RESET_UDC3		25
> +#define NPCM8XX_RESET_ADC		27
> +#define NPCM8XX_RESET_SMB6		28
> +#define NPCM8XX_RESET_SMB7		29
> +#define NPCM8XX_RESET_SMB0		30
> +#define NPCM8XX_RESET_SMB1		31
> +
> +/* Reset lines on IP2 reset module (NPCM8XX_RESET_IPSRST2) */
> +#define NPCM8XX_RESET_MFT0		0
> +#define NPCM8XX_RESET_MFT1		1
> +#define NPCM8XX_RESET_MFT2		2
> +#define NPCM8XX_RESET_MFT3		3
> +#define NPCM8XX_RESET_MFT4		4
> +#define NPCM8XX_RESET_MFT5		5
> +#define NPCM8XX_RESET_MFT6		6
> +#define NPCM8XX_RESET_MFT7		7
> +#define NPCM8XX_RESET_MMC		8
> +#define NPCM8XX_RESET_GFX_SYS		10
> +#define NPCM8XX_RESET_AHB_PCIBRG	11
> +#define NPCM8XX_RESET_VDMA		12
> +#define NPCM8XX_RESET_ECE		13
> +#define NPCM8XX_RESET_VCD		14
> +#define NPCM8XX_RESET_VIRUART1		16
> +#define NPCM8XX_RESET_VIRUART2		17
> +#define NPCM8XX_RESET_SIOX1		18
> +#define NPCM8XX_RESET_SIOX2		19
> +#define NPCM8XX_RESET_BT		20
> +#define NPCM8XX_RESET_3DES		21
> +#define NPCM8XX_RESET_PSPI2		23
> +#define NPCM8XX_RESET_GMAC2		25
> +#define NPCM8XX_RESET_USBH1		26
> +#define NPCM8XX_RESET_GMAC1		28
> +#define NPCM8XX_RESET_CP1		31
> +
> +/* Reset lines on IP3 reset module (NPCM8XX_RESET_IPSRST3) */
> +#define NPCM8XX_RESET_PWM_M1		0
> +#define NPCM8XX_RESET_SMB12		1
> +#define NPCM8XX_RESET_SPIX		2
> +#define NPCM8XX_RESET_SMB13		3
> +#define NPCM8XX_RESET_UDC0		4
> +#define NPCM8XX_RESET_UDC7		5
> +#define NPCM8XX_RESET_UDC8		6
> +#define NPCM8XX_RESET_UDC9		7
> +#define NPCM8XX_RESET_USBHUB		8
> +#define NPCM8XX_RESET_PCI_MAILBOX	9
> +#define NPCM8XX_RESET_GDMA1		10
> +#define NPCM8XX_RESET_GDMA2		11
> +#define NPCM8XX_RESET_SMB14		12
> +#define NPCM8XX_RESET_SHA		13
> +#define NPCM8XX_RESET_SEC_ECC		14
> +#define NPCM8XX_RESET_PCIE_RC		15
> +#define NPCM8XX_RESET_TIMER_10_14	16
> +#define NPCM8XX_RESET_RNG		17
> +#define NPCM8XX_RESET_SMB15		18
> +#define NPCM8XX_RESET_SMB8		19
> +#define NPCM8XX_RESET_SMB9		20
> +#define NPCM8XX_RESET_SMB10		21
> +#define NPCM8XX_RESET_SMB11		22
> +#define NPCM8XX_RESET_ESPI		23
> +#define NPCM8XX_RESET_USB_PHY_1		24
> +#define NPCM8XX_RESET_USB_PHY_2		25
> +


Best regards,
Krzysztof

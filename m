Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C086C550A87
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiFSMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiFSML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:11:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F9DFF5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:11:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gl15so16322608ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LXtHu+WmKe/B+Jenv3JS6I7UJdcvW4l/57HkN5jkG/E=;
        b=PFGWDfSmTZqllQbv0OyEqVrcIkXlXTB2/7LoSQSGLEpW5i8azV07nix9S/j7bUd6m2
         afWCLA2StC3+eLDwUkgDglLrczYOAxTRwcCxdBinEf1T7tBYzqIZTcry72ITwGQLwKbR
         +5Ts1NpfLQlxfMXoOcFyfo7SBxddgDRDm0e87Ix9qaHF25Ny6J/upwztpDi2Nh3Ubsht
         sx7lY4n4iosRrHZrJkE3nuJy7TkZDGcob0XY57s8vRz9uTwPvujH1tuhEb1z93aI5OnP
         aqcZdNBaLoZ8xwcY0JEmydzrca6xgk0lG/A808nR9cFQEMMUhmMkpL0ELkr2l6EhTL34
         pHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LXtHu+WmKe/B+Jenv3JS6I7UJdcvW4l/57HkN5jkG/E=;
        b=NUTUH0VbqcweqMgSoVSYYWDv7bugwsJ/EL8ka3dsk4t3OHpk1FTfi8I8ZKO0OtIT3e
         zQ/pWSZBYbkujKDa4m5Pel/7w2y36mhfaQnSdjF6VZH+HNVJT3iPLdm0SYRe7Q+k+Mvk
         JlShA7gRlQBaFXabCZG8BGv309puEQlaYpXpWRzVYSRpdwflLdcLZHalBMNjwYxcq3Qh
         y6opNxf0Ome7ARYHi6pTyl48XAceGi0o8kcSrvx/LvD+YJ9qCZG7U1hZewsv0BpT1Khe
         qfqFYH5iLqrPJLFuxtksWjZ5es8zN0/20oBXXAv9oTgk+Z5Yyaq+6A70oYzRMsb/fzC+
         5lyw==
X-Gm-Message-State: AJIora8RME81UmglV4HlwJ44Hyy74RXHVRjbGifnyQApe8v/N5ItsFy7
        ryuQJZgeyoEPx8y6M0pjI6okuA==
X-Google-Smtp-Source: AGRyM1uG+PuErMAkaEo90qS9M2upNFHsa8Bcj+5LXtlWfhBGMg5qJoUykz+gZaY6engmOnI9dCwIkw==
X-Received: by 2002:a17:907:7f0e:b0:722:a7e9:6f7f with SMTP id qf14-20020a1709077f0e00b00722a7e96f7fmr2699714ejc.228.1655640716378;
        Sun, 19 Jun 2022 05:11:56 -0700 (PDT)
Received: from [192.168.0.206] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b006fe9209a9edsm4504865ejg.128.2022.06.19.05.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:11:55 -0700 (PDT)
Message-ID: <b83e3100-edd6-4f91-75e0-8a87447d8a4c@linaro.org>
Date:   Sun, 19 Jun 2022 14:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS
 PHY binding
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
References: <20220618092201.3837791-1-victor.liu@nxp.com>
 <20220618092201.3837791-2-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220618092201.3837791-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2022 11:22, Liu Ying wrote:
> This patch adds bindings for Mixel LVDS PHY found on
> Freescale i.MX8qm SoC.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bindings/phy/mixel,lvds-phy.yaml          | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> new file mode 100644
> index 000000000000..de964ffb9356
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mixel,lvds-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mixel LVDS PHY for Freescale i.MX8qm SoC

If Mixel is a vendor, it needs it's vendor prefix documented and used in
compatible. Filename should match compatible. If it is not a vendor,
then filename should be "fsl,imx8qm-lvds-phy.yaml"

> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The Mixel LVDS PHY IP block is found on Freescale i.MX8qm SoC.
> +  It converts two groups of four 7/10 bits of CMOS data into two
> +  groups of four data lanes of LVDS data streams. A phase-locked
> +  transmit clock is transmitted in parallel with each group of
> +  data streams over a fifth LVDS link. Every cycle of the transmit
> +  clock, 56/80 bits of input data are sampled and transmitted
> +  through the two groups of LVDS data streams. Together with the
> +  transmit clocks, the two groups of LVDS data streams form two
> +  LVDS channels.
> +
> +  The Mixel LVDS PHY found on Freescale i.MX8qm SoC is controlled
> +  by Control and Status Registers(CSR) module in the SoC. The CSR
> +  module, as a system controller, contains the PHY's registers.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qm-lvds-phy
> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      Cell allows setting the LVDS channel index of the PHY.
> +      Index 0 is for LVDS channel0 and index 1 is for LVDS channel1.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: phy_ref

Maybe just skip the clock-names, it's not bringing anything useful,
unless you expect some more clocks to be documented later? (but in such
case question would be why they are not documented now)

> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    phy {
> +        compatible = "fsl,imx8qm-lvds-phy";
> +        #phy-cells = <1>;
> +        clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
> +        clock-names = "phy_ref";
> +        power-domains = <&pd IMX_SC_R_LVDS_0>;
> +    };


Best regards,
Krzysztof

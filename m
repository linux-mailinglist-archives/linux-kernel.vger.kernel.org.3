Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5E59D7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350534AbiHWJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350048AbiHWJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:27:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAA91D11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:37:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l21so12840274ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+aSY9Y33CDXgz04lbF3PqxrBUx68k/v5JOdwfPTNsck=;
        b=QkuAXN+U7cnhI883/vPgSeyqlE+WERE888alAVsSQAP6K76e4Lq6scqjW5YP5gY4Zv
         gVD8rvePqRyUWnq08fWShX0UKGdz+64B0i1RmzOIMHquRKO34P4KjKVA1eQgbCOvET5c
         XLxKuXdMN7i7FrPlNniRLvaqe2MWHiMxe1+cKHpfOkn+zWrbYLoyoNUBJsvd/NsQRIxV
         0PAJTxFQYRRA1GjSzaLlvTMnfy5dlgNal0BIxfiprXMoLEB+392bMAYUtrZkZdjn3QD4
         aRNoqblddkQYhPC/kwhTpB8oFZ8tZvUr4aA/AJhU5tY5FrlelbEHmPwxWc2JqMxLkFl+
         3slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+aSY9Y33CDXgz04lbF3PqxrBUx68k/v5JOdwfPTNsck=;
        b=mc79AlqMUF+5Eq3hyyKc6K1MzQzqF9G4n5rCg4KGFQZcVGL0xeFWij/9hTr/fnXiL3
         h7dkCRP1h/Jp9tHb23VWnUAF5vH+gnAri0pY0p6S8xPDSMAZ4k0gDrVvRYkhIBJT8o47
         IWSWsPCaporjTtCRP8MjfoOGHUS9u64UNWYUHPlv73JVBw0PP0fFKExduhB3WoMZWIxi
         TGVUFU9Rk7NLoHaZ3gpXPrvDhYhwPSsuCeicKzzkzQ3BGN4ZvxPTEP9d1j9EzhcmwM6N
         CQtiTISUbmSy/+uxXfD3sCRpuNDWJPFwm0IH9gX8tR2R75SuMaSiNilr9O836V6V5yyS
         Gyhg==
X-Gm-Message-State: ACgBeo37wm7IuXPI+GwXXMsitXvurfEDSKfyzcPzUD3ToBGE4veikOHr
        Y12aRqeSvsr4EadYqINkLX5sqw==
X-Google-Smtp-Source: AA6agR4tz09nxCgU4KECChD6CEX8ta0EVwvv34zu7NRW9WZuo44ysLqMs2v/JFtkNU1OgDp8eiWwiw==
X-Received: by 2002:a2e:9d06:0:b0:261:d208:7475 with SMTP id t6-20020a2e9d06000000b00261d2087475mr1683044lji.113.1661243791045;
        Tue, 23 Aug 2022 01:36:31 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id p18-20020a2eb992000000b00261ca006158sm1243319ljp.54.2022.08.23.01.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:36:30 -0700 (PDT)
Message-ID: <ee93aa8a-d704-9d67-ad33-c81654c90ca2@linaro.org>
Date:   Tue, 23 Aug 2022 11:36:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220823060052.3921849-1-colin.foster@in-advantage.com>
 <20220823060052.3921849-2-colin.foster@in-advantage.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823060052.3921849-2-colin.foster@in-advantage.com>
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

On 23/08/2022 09:00, Colin Foster wrote:
> Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> 
> Additionally, add the file to MAINTAINERS since the original file didn't
> exist.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  .../bindings/phy/phy-ocelot-serdes.txt        | 43 -------------
>  .../bindings/phy/phy-ocelot-serdes.yaml       | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 62 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml

Filename based on compatible, so
mscc,vsc7514-serdes.yaml

> 


> diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> new file mode 100644
> index 000000000000..0666974d886a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-ocelot-serdes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsemi Ocelot SerDes muxing driver

s/driver//

Bindings are for hardware, not for Linux drivers.

> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - UNGLinuxDriver@microchip.com
> +
> +description: |
> +  On Microsemi Ocelot, there is a handful of registers in HSIO address
> +  space for setting up the SerDes to switch port muxing.
> +
> +  A SerDes X can be "muxed" to work with switch port Y or Z for example.
> +  One specific SerDes can also be used as a PCIe interface.
> +
> +  Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
> +
> +  There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> +  half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
> +  10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> +
> +  Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> +  QSGMII.
> +
> +  This is a child of the HSIO syscon ("mscc,ocelot-hsio", see
> +  Documentation/devicetree/bindings/mips/mscc.txt) on the Microsemi Ocelot.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mscc,vsc7514-serdes

Missing blank line

> +  "#phy-cells":
> +    const: 2
> +    description: |
> +      from the generic phy bindings, must be 2. 

Skip first sentence, it's obvious.

The first number
> +      defines the input port to use for a given SerDes macro. The
> +      second defines the macro to use. They are defined in
> +      dt-bindings/phy/phy-ocelot-serdes.h
> +
> +required:
> +  - compatible
> +  - "#phy-cells"

Missing additionalProperties: false

Base your YAML on example-schema.

> +
> +examlpes:

Typo.


> +  - |
> +    serdes: serdes {
> +      compatible = "mscc,vsc7514-serdes";
> +      #phy-cells = <2>;
> +    };
> +
> +    ethernet {
> +      port1 {
> +        phy-handle = <&phy_foo>;
> +        /* Link SERDES1G_5 to port1 */
> +        phys = <&serdes 1 SERDES1G_5>;
> +      };
> +    };

Skip consumer examples in provider bindings. They're obvious.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 714fd8b45e5a..10dd3c6ad6ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13481,6 +13481,7 @@ M:	UNGLinuxDriver@microchip.com
>  L:	linux-mips@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/mips/mscc.txt
> +F:	Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>  F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>  F:	arch/mips/boot/dts/mscc/


Best regards,
Krzysztof

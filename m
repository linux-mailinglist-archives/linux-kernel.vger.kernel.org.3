Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9A5403B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbiFGQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:28:07 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0A6FD08;
        Tue,  7 Jun 2022 09:28:05 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id s1so14628664ilj.0;
        Tue, 07 Jun 2022 09:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJJwYN1VfKqgVWKD0IpgG7bRQAEoKMtsqU/1F4Wmxh4=;
        b=CvD5XVh0AVxPR1OiGd9u/fO/IVEtFT2DAlv9vO/DsvwEGA5ae+LADF4DF/5C56kM5P
         4du1N3P5Klc9Mmqzf3y6gOmCZePYpU5AzdAis/30AXLbVPrdV+RedM0jWuB7bvq29/VM
         lmOkMd76KHRXQjnAzd+kdD9VrcZi12TKogATHf7AnadZEQhZv5VxV7QHVYJKiZbT3mki
         tp+9vXJTHpov85cdaFMfoghcieQ6Q9KGjIV+nXMW1YTwKeCt+DXxHLCQpH8OTglmtjYp
         BkVE5sybMmzXGI0vtEX6scNx3TA/HzA7CZvO/7gzgX+NI8+Ns4qNKEMwz/fdKf+/6lHG
         kSiQ==
X-Gm-Message-State: AOAM530/FPMQRRhwcFvvL//IrR3Y8EgpXLJ6SQX2xd77YeJxghn5VUa4
        mEqBnwobR/5dux1gZmqOFvzFmORBmQ==
X-Google-Smtp-Source: ABdhPJxTsJKeIilth8jXKd6qGmrIMpw9gTF3BynFLwUwOL+p5rVBPDcrt8uvKahyBzu4PaUosGFYXg==
X-Received: by 2002:a05:6e02:1647:b0:2d3:c43c:1cd1 with SMTP id v7-20020a056e02164700b002d3c43c1cd1mr17542303ilu.148.1654619283292;
        Tue, 07 Jun 2022 09:28:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r2-20020a92d982000000b002d11397f4f9sm7480105iln.74.2022.06.07.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:28:02 -0700 (PDT)
Received: (nullmailer pid 3383826 invoked by uid 1000);
        Tue, 07 Jun 2022 16:28:01 -0000
Date:   Tue, 7 Jun 2022 10:28:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: arm: freescale: Switch fsl,scu to yaml
Message-ID: <20220607162801.GA3370683-robh@kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-2-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607105951.1821519-2-abel.vesa@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:59:42PM +0300, Abel Vesa wrote:
> This patch actually addds the fsl,scu.yaml which is only for the
> main SCU node. The child nodes schemas will be split in different
> yaml files. The old txt file will be removed only after all the
> child nodes have been properly switch to yaml.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu.yaml       | 185 ++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml

Looks like an MFD, move to bindings/mfd/. Likewise for all the child 
nodes, move them to appropriate provider directories.

> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
> new file mode 100644
> index 000000000000..56728cfaa2e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
> @@ -0,0 +1,185 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX System Controller Firmware (SCFW)
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +
> +description: System Controller Device Node
> +  The System Controller Firmware (SCFW) is a low-level system function
> +  which runs on a dedicated Cortex-M core to provide power, clock, and
> +  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> +  (QM, QP), and i.MX8QX (QXP, DX).
> +  The AP communicates with the SC using a multi-ported MU module found
> +  in the LSIO subsystem. The current definition of this MU module provides
> +  5 remote AP connections to the SC to support up to 5 execution environments
> +  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
> +  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
> +  using the MSI bus.
> +  Each mu which supports general interrupt should have an alias correctly
> +  numbered in "aliases" node.
> +  e.g.
> +  aliases {
> +         mu1 = &lsio_mu1;
> +  };
> +
> +properties:
> +  $nodename:
> +    const: 'scu'

blank line between each DT property. Here and throughout the series.

> +  compatible:
> +    const: fsl,imx-scu
> +  clock-controller:
> +    description: |
> +      Clock controller node that provides the clocks controlled by the SCU
> +  imx8qx-pd:

power-controller:

> +    description: |
> +      Power domains controller node that provides the power domains
> +      controlled by the SCU
> +  imx8qx-ocotp:
> +    description: |
> +      OCOTP controller node provided by the SCU
> +  iomuxc:

pinctrl:

> +    description: |
> +      IOMUX controller provided by the SCU
> +  pinctrl:
> +    description: |
> +      Pin controller provided by the SCU
> +  scu-key:

keys:

> +    description: |
> +      Keys provided by the SCU
> +  thermal-sensor:
> +    description: |
> +      Thermal sensor provided by the SCU
> +  rtc:
> +    description: |
> +      RTC controller provided by the SCU
> +  watchdog:
> +    description: |
> +      Watchdog controller provided by the SCU
> +  mbox-names:

Sort properties before child nodes.

> +    description:
> +      include "gip3" if want to support general MU interrupt.
> +    minItems: 1
> +    maxItems: 10
> +  mboxes:
> +    description: |
> +      List of phandle of 4 MU channels for tx, 4 MU channels for
> +      rx, and 1 optional MU channel for general interrupt.
> +      All MU channels must be in the same MU instance.
> +      Cross instances are not allowed. The MU instance can only
> +      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> +      to make sure use the one which is not conflict with other
> +      execution environments. e.g. ATF.
> +      Note:
> +      Channel 0 must be "tx0" or "rx0".
> +      Channel 1 must be "tx1" or "rx1".
> +      Channel 2 must be "tx2" or "rx2".
> +      Channel 3 must be "tx3" or "rx3".
> +      General interrupt rx channel must be "gip3".
> +      e.g.
> +      mboxes = <&lsio_mu1 0 0
> +              &lsio_mu1 0 1
> +              &lsio_mu1 0 2
> +              &lsio_mu1 0 3
> +              &lsio_mu1 1 0
> +              &lsio_mu1 1 1
> +              &lsio_mu1 1 2
> +              &lsio_mu1 1 3
> +              &lsio_mu1 3 3>;
> +      See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +      for detailed mailbox binding.

The specific mailbox provider is technically outside the scope of this 
binding.

> +    minItems: 1
> +    maxItems: 10
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - mbox-names
> +  - mboxes
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +
> +    aliases {
> +           mu1 = &lsio_mu1;

Not a standard alias. Drop.

> +    };
> +    lsio_mu1: mailbox@5d1c0000 {
> +           reg = <0x5d1c0000 0x10000>;
> +           #mbox-cells = <2>;
> +    };

No need to show providers in examples.

> +    firmware {
> +           scu {
> +                   compatible = "fsl,imx-scu";
> +                   mbox-names = "tx0", "tx1", "tx2", "tx3",
> +                                "rx0", "rx1", "rx2", "rx3",
> +                                "gip3";
> +                   mboxes = <&lsio_mu1 0 0
> +                            &lsio_mu1 0 1
> +                            &lsio_mu1 0 2
> +                            &lsio_mu1 0 3
> +                            &lsio_mu1 1 0
> +                            &lsio_mu1 1 1
> +                            &lsio_mu1 1 2
> +                            &lsio_mu1 1 3
> +                            &lsio_mu1 3 3>;
> +                   clock-controller {
> +                            compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> +                            #clock-cells = <2>;
> +                   };
> +                   iomuxc {
> +                            compatible = "fsl,imx8qxp-iomuxc";
> +
> +                            pinctrl_lpuart0: lpuart0grp {
> +                                   fsl,pins = <
> +                                           IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
> +                                           IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
> +                                   >;
> +                            };
> +                   };
> +                   imx8qx-ocotp {
> +                            compatible = "fsl,imx8qxp-scu-ocotp";
> +                            #address-cells = <1>;
> +                            #size-cells = <1>;
> +
> +                            fec_mac0: mac@2c4 {
> +                                   reg = <0x2c4 6>;
> +                            };
> +                   };
> +                   pd: imx8qx-pd {
> +                            compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> +                            #power-domain-cells = <1>;
> +                   };
> +                   rtc {
> +                            compatible = "fsl,imx8qxp-sc-rtc";
> +                   };
> +                   scu-key {
> +                            compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
> +                            linux,keycodes = <KEY_POWER>;
> +                   };
> +                   watchdog {
> +                            compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> +                            timeout-sec = <60>;
> +                   };
> +                   thermal-sensor {
> +                            compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +                            #thermal-sensor-cells = <1>;
> +                   };
> +            };
> +    };

> +    serial@5a060000 {
> +            reg = <0x5a060000 0x1000>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_lpuart0>;
> +            clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
> +            clock-names = "ipg";
> +            power-domains = <&pd IMX_SC_R_UART_0>;
> +    };

Drop this too.

> -- 
> 2.34.3
> 
> 

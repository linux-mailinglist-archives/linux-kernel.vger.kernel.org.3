Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6658D5597CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiFXKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiFXKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:25:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B367B35A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:25:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lw20so3788301ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CHttmF3yGSGx+TZUTVwg9kv22SlC4meEkXeiN/iN2v8=;
        b=z7ATTMHw/uFuGMTH0cx/WUmez2cGoKvXN2RGic2tU6NQONge6izMZ6WAYMGWzduOWp
         JWDhKgDR/MVsJX+70XppIMM4wZ8+AiIDjk7CAUxgScaYttqFNk+esnEw4Jrakkpc7EPx
         v+5iwZ1jeuDfshxkaPQsByIECd1PIFX5RcvumpAa/nm6sZVxk2gHoCqnlZtKYpxWBmDS
         0iYf4QHhB4e5m6l54EuFC7W3UOueSP8Lhln71JGbUMb8ORvik3KJQQaZZz7xhnwU9sgm
         koPcWq7QohPq+EMTtzEUQaYx4TNywITpEwUqkucd7Mr6j+hvtSE07ltE1eC8hgyUcwy+
         M/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CHttmF3yGSGx+TZUTVwg9kv22SlC4meEkXeiN/iN2v8=;
        b=HNi/l/Y22XUG8Gze5GSH0uAhWsNmItS4eq5j8EKz0YopAVyMbcHC5m/WFAMEPxbd6f
         gILvpRyx6g38MucGliYJOFtR3Imy3iajH5/qXDNauxlHwicfSwBLD9tH9mrxZnPlz7bT
         FkGWbMhhdfdBy8rJUdBzgJHhDvVpMKuK+H5FmL58agpCTysed2s30/xD/AUVX8BQ8zaF
         syEivdm1osr8EoBya6iUiPH+faEV0bVMdA8bnB79lqNgV1Zzylhfc+nwFQv4tHQfUtJz
         l6j1k1lbjERM34FKYdmDunw7ybOTSd5QGKZ0uVtrNo8NmGJc0JOcDkMgoLc4WQtWkhAS
         vqnw==
X-Gm-Message-State: AJIora+S/zgsdNKb1pKTdzY0UIc+j2yH7cjqet3Ya2x0EyhbUDGdtqkI
        jmmi640Izuhj8TxdH/rNTIc/LQ==
X-Google-Smtp-Source: AGRyM1tJuZF3QgXNIjmCTm5JxpaOyY6m5vZGMqLZG9V/JEZvRn/GC7cwsOcwhASPRcGnwcf/5J5bBw==
X-Received: by 2002:a17:906:7288:b0:722:da04:da51 with SMTP id b8-20020a170906728800b00722da04da51mr12547124ejl.316.1656066347402;
        Fri, 24 Jun 2022 03:25:47 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906d20d00b00726298147b1sm851210ejz.161.2022.06.24.03.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:25:46 -0700 (PDT)
Message-ID: <b653d7af-f846-abb2-d260-3ce615b070a4@linaro.org>
Date:   Fri, 24 Jun 2022 12:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 10/14] dt-bindings: firmware: Add fsl,scu yaml file
Content-Language: en-US
To:     Viorel Suman <viorel.suman@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
 <20220616164303.790379-11-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-11-viorel.suman@nxp.com>
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

On 16/06/2022 18:42, Viorel Suman wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch adds the
> fsl,scu.yaml in the firmware bindings folder. This one is only for
> the main SCU node. The old txt file will be removed only after all
> the child nodes have been properly switch to yaml.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,scu.yaml | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> new file mode 100644
> index 000000000000..a28f729bfadb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX System Controller Firmware (SCFW)
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
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
> +
> +properties:
> +  $nodename:
> +    const: 'scu'

Why enforcing node name? Second point is that node names should be
generic, so I wonder what "SCU" exactly means and whether it is generic?

> +
> +  compatible:
> +    const: fsl,imx-scu
> +
> +  clock-controller:
> +    description: |
> +      $ref: /schemas/clock/fsl,scu-clk.yaml

That's not a valid syntax. ref is not part of description

> +      Clock controller node that provides the clocks controlled by the SCU
> +
> +  imx8qx-ocotp:
> +    description: |
> +      $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
> +      OCOTP controller node provided by the SCU
> +
> +  keys:
> +    description: |
> +      $ref: /schemas/input/fsl,scu-key.yaml
> +      Keys provided by the SCU
> +
> +  mboxes:
> +    description: |
> +      $ref: /schemas/mailbox/fsl,mu.yaml
> +      List of phandle of 4 MU channels for tx, 4 MU channels for
> +      rx, and 1 optional MU channel for general interrupt.
> +      All MU channels must be in the same MU instance.
> +      Cross instances are not allowed. The MU instance can only
> +      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> +      to make sure use the one which is not conflict with other
> +      execution environments. e.g. ATF.
> +    minItems: 1
> +    maxItems: 10
> +
> +  mbox-names:
> +    description:
> +      include "gip3" if want to support general MU interrupt.
> +    minItems: 1
> +    maxItems: 10
> +
> +  pinctrl:
> +    description: |
> +      $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
> +      Pin controller provided by the SCU
> +
> +  power-controller:
> +    description: |
> +      $ref: /schemas/power/fsl,scu-pd.yaml
> +      Power domains controller node that provides the power domains
> +      controlled by the SCU
> +
> +  rtc:
> +    description: |
> +      $ref: /schemas/rtc/fsl,scu-rtc.yaml
> +      RTC controller provided by the SCU
> +
> +  thermal-sensor:
> +    description: |
> +      $ref: /schemas/thermal/fsl,scu-thermal.yaml
> +      Thermal sensor provided by the SCU
> +
> +  watchdog:
> +    description: |
> +      $ref: /schemas/watchdog/fsl,scu-wdt.yaml
> +      Watchdog controller provided by the SCU
> +
> +required:
> +  - compatible
> +  - mbox-names
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +
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
> +
> +                   clock-controller {
> +                            compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> +                            #clock-cells = <2>;
> +                   };
> +
> +                   pinctrl {
> +                            compatible = "fsl,imx8qxp-iomuxc";
> +
> +                            pinctrl_lpuart0: lpuart0grp {
> +                                   fsl,pins = <
> +                                           IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
> +                                           IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
> +                                   >;
> +                            };
> +                   };
> +
> +                   imx8qx-ocotp {
> +                            compatible = "fsl,imx8qxp-scu-ocotp";
> +                            #address-cells = <1>;
> +                            #size-cells = <1>;
> +
> +                            fec_mac0: mac@2c4 {
> +                                   reg = <0x2c4 6>;
> +                            };
> +                   };
> +
> +                   power-controller {
> +                            compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> +                            #power-domain-cells = <1>;
> +                   };
> +
> +                   rtc {
> +                            compatible = "fsl,imx8qxp-sc-rtc";
> +                   };
> +
> +                   keys {
> +                            compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
> +                            linux,keycodes = <KEY_POWER>;
> +                   };
> +
> +                   watchdog {
> +                            compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> +                            timeout-sec = <60>;
> +                   };
> +
> +                   thermal-sensor {
> +                            compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +                            #thermal-sensor-cells = <1>;
> +                   };
> +            };
> +    };


Best regards,
Krzysztof

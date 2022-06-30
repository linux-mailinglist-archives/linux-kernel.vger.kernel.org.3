Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16801561B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiF3Nop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiF3Noe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:44:34 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A5C33;
        Thu, 30 Jun 2022 06:44:33 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id s17so19155043iob.7;
        Thu, 30 Jun 2022 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xkaDeguk/vAh7fZoNsnfPgjTXEqH1vG9SFfSqdGWsdo=;
        b=jjv+Cx+GFDDysRZ0a9+x+UxhWuAs0BhNMyjI9dV6s1wnyyH2cI+Rk3aBEkZhZP6cyx
         P4S8zbbzft6j1epU2xb363KFZ418B24KyMs641k3qZ6bjQI9YFB/dSGQ8fXizAALtgJb
         s4OJ2m/5g0RjYZfFDCzzi0HGB5zDjib1sHZUfzd0FrYZVP47xSCEJRDodijxFURKutbd
         BeOJniT1vsYE6limpOQk5qErB8SKX8hQeP8X4QvEw7M+50i9N4wUcQFINzI2cS3LJRK1
         6vIuDJ0ePFldkbzVDcTjFsCouHO0So16O6HyOWCWBVnneuMw6AYUyKlDxJ/PAIfoC6Nz
         7qpQ==
X-Gm-Message-State: AJIora/miF8x+mKpUrfdbDdFqnfnXU+sNwIBg1EkfJjZk0R1TLsdMled
        7aEpOyGuMijEneFQZnHgJw==
X-Google-Smtp-Source: AGRyM1ud0WT54zZ+DVBN/LgOSAZQPc3ntO7BFWOdr8VOmASioJLnmeI0c5fdiRUpPzIa44Si1v2XdA==
X-Received: by 2002:a5d:898b:0:b0:668:f53d:757d with SMTP id m11-20020a5d898b000000b00668f53d757dmr4561006iol.12.1656596672728;
        Thu, 30 Jun 2022 06:44:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b002d79f619517sm8101234ilq.26.2022.06.30.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:44:32 -0700 (PDT)
Received: (nullmailer pid 2569458 invoked by uid 1000);
        Thu, 30 Jun 2022 13:44:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-watchdog@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, linux-rtc@vger.kernel.org,
        linux-input@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220629164414.301813-10-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com> <20220629164414.301813-10-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH v6 09/14] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Thu, 30 Jun 2022 07:44:25 -0600
Message-Id: <1656596665.763392.2569457.nullmailer@robh.at.kernel.org>
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

On Wed, 29 Jun 2022 19:44:09 +0300, Viorel Suman (OSS) wrote:
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
>  .../devicetree/bindings/firmware/fsl,scu.yaml | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/firmware/fsl,scu.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/fsl,scu.example.dtb: system-controller: clock-controller: False schema does not allow {'compatible': ['fsl,imx8qxp-clk', 'fsl,scu-clk'], '#clock-cells': [[2]]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/fsl,scu.example.dtb: system-controller: pinctrl: False schema does not allow {'compatible': ['fsl,imx8qxp-iomuxc'], 'lpuart0grp': {'fsl,pins': [[111, 0, 100663328, 112, 0, 100663328]]}}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
Documentation/devicetree/bindings/firmware/fsl,scu.example.dtb:0:0: /example-0/firmware/system-controller/clock-controller: failed to match any schema with compatible: ['fsl,imx8qxp-clk', 'fsl,scu-clk']
Documentation/devicetree/bindings/firmware/fsl,scu.example.dtb:0:0: /example-0/firmware/system-controller/clock-controller: failed to match any schema with compatible: ['fsl,imx8qxp-clk', 'fsl,scu-clk']
Documentation/devicetree/bindings/firmware/fsl,scu.example.dtb:0:0: /example-0/firmware/system-controller/pinctrl: failed to match any schema with compatible: ['fsl,imx8qxp-iomuxc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


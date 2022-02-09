Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA34AFCEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiBITIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:08:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBITIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:08:19 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6585C050CCB;
        Wed,  9 Feb 2022 11:08:10 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id v67so3467374oie.9;
        Wed, 09 Feb 2022 11:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZhzyL7iIsfqojNUVkETC0UZ5IL+vMOwPA5/nkXJGWro=;
        b=txUHSrPbTcB+gc4CCz4OeOZ4zPXCbGAP3hnbnzbpAARgZI7CZCmhJf5ZIlTBpJAPPy
         ovqYBgY861sDLXgGM5CH2lBcOw9veDW4GGnlnzR205vuftI9+fmZbdUcJ37bNFh31F2P
         Zq3jPwKUH7NcqKE7M5KYjmudh3MyfEVAbyFqkopspNnCLzhUNVbIpipYHOERhgHlub8A
         G5VIaEldmYyFFSBM56vjYk7cYPmPxT4hyqYBwP4R4wRRrnMxeowB4ZG1t4YDFRwSlx6U
         cveMyI2Fetw36nrRLuvBv3+nvIMIxmtBQwFPJQRJ1Vca1ojFziRmu5xf+eWyO0fdLT3o
         Vkww==
X-Gm-Message-State: AOAM531PEjvwRsFv8LbSG1G3H57+O9DKLEVELum2BDLMxglm0HfZJ3A3
        bCdr1rfC/uFg7ijBk9qWsmDABAx/BQ==
X-Google-Smtp-Source: ABdhPJyy846C2b5ZTD9QWirBvx6xeA+PBp30vDQqUmINa5tr5IpsfK6YfF4hk16FGOKABUsDCz9ITA==
X-Received: by 2002:aca:43c3:: with SMTP id q186mr1587165oia.128.1644433629049;
        Wed, 09 Feb 2022 11:07:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g10sm6827172otn.65.2022.02.09.11.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:07:07 -0800 (PST)
Received: (nullmailer pid 705933 invoked by uid 1000);
        Wed, 09 Feb 2022 19:07:06 -0000
Date:   Wed, 9 Feb 2022 13:07:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     ulf.hansson@linaro.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        tony.huang@sunplus.com, wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Message-ID: <YgQQ2nJa12xblXBX@robh.at.kernel.org>
References: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
 <f8b89f9981e17c023ce530afedb1f2b599edec0f.1644398657.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b89f9981e17c023ce530afedb1f2b599edec0f.1644398657.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 06:41:06PM +0800, Tony Huang wrote:
> Add mmc yaml file for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v3:
>  - combine sdcard and eMMC into one driver.
> 
>  .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 76 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> new file mode 100644
> index 0000000..8f44d13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sunplus MMC controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-emmc
> +      - sunplus,sp7021-sdhci

Why are these still different? Looking at the driver, it seems the 
settings are the same for both. And for clock speeds, we have properties 
to control them as they can be board specific.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc0: mmc@9c003b00 {
> +        compatible = "sunplus,sp7021-emmc";
> +        reg = <0x9c003b00 0x180>;
> +        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 0x4e>;
> +        resets = <&rstc 0x3e>;
> +        bus-width = <8>;
> +        max-frequency = <52000000>;
> +        non-removable;
> +        disable-wp;
> +        cap-mmc-highspeed;
> +        mmc-ddr-3_3v;
> +        no-sdio;
> +        no-sd;
> +    };
> +
> +    mmc1: mmc@9c003e80 {
> +       compatible = "sunplus,sp7021-sdhci";
> +       reg = <0x9c003e80 0x280>;
> +       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clkc 0x4f>;
> +       resets = <&rstc 0x3f>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
> +       max-frequency = <52000000>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7..cb46a55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS MMC DRIVER
> +M:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +M:	Li-hao Kuo <lhjeff911@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/sunplu-mmc.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 

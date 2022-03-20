Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF54E1B52
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiCTLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCTLnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:43:16 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F638BF1;
        Sun, 20 Mar 2022 04:41:51 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id k10so1276814edj.2;
        Sun, 20 Mar 2022 04:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pToxZLA9n09njUTlQ6yAnOP6dWA8izLb5aIRt0a25NY=;
        b=npWhfOC/TXdzG1jDJ0Pf40rflD3T0zMp/XTjyaCgnTBgLf6xMFPqa0IrW6IqX1GrBr
         jMLJa8EMzDFVGvDqb+dsdiHdVdYPJeddt5sHIszFQ4OHRQPwzAy1FqJC0sVpQYQNECBI
         JpM8EZIe4JBkLege3+kVbNM4s9sYvEgcf+PkuiVxY0KBePO0ZXePNjy/w4iG42CI/k2H
         k3L/P4kB/lgOQjxmDw0zvS19Akp0tOFBwCu7mZ6EIYuvw3YnlHwAQv1X7AoeeF79WhEt
         sJQmWFXDX50G5tsOvNKBEqa7hOZrSfqxOOvUsBjJnu6IHINJpvkujSe5axs+CAJ8Fs7c
         e36A==
X-Gm-Message-State: AOAM533JNw13FDGYQ2AKKDkUD+8RGerFkZ8JJXipdfyx0iumTgBYZyMX
        MJcghL6qVF7grnJa7JsTd/Y=
X-Google-Smtp-Source: ABdhPJz3exzGbAupnzoyNEoKcd1UHRnHQh+ogzLgHco4Wng2wJCsmJzRLaC9s9Yvm++nuGkJfNxp2A==
X-Received: by 2002:aa7:d904:0:b0:418:d53b:4662 with SMTP id a4-20020aa7d904000000b00418d53b4662mr18712676edr.217.1647776509787;
        Sun, 20 Mar 2022 04:41:49 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm7062643eda.2.2022.03.20.04.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 04:41:49 -0700 (PDT)
Message-ID: <c78aa9fa-8001-2c48-7a25-1f44f9952c9b@kernel.org>
Date:   Sun, 20 Mar 2022 12:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, lhjeff911@gmail.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <27dba330ec0c1cd7edbcec53083f78169713a42e.1647652688.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <27dba330ec0c1cd7edbcec53083f78169713a42e.1647652688.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2022 02:50, Tony Huang wrote:
> Add mmc yaml file for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v4:
>  - Addressed comments from Ulf Hansson.
> 
>  .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 79 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> new file mode 100644
> index 0000000..13ed07c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sunplus MMC controller

s/sunplus/Sunplus/

> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"

allOf below maintainers,

> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,mmc-v1
> +      - sunplus,mmc-v2

How did this happen? Versions of blocks are usually discouraged, unless
you have clear specification,. The previous discussion did not end with
"add v1 and v2".

Do you have clear documentation/specification of these blocks? If no,
please use SoC compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1

maxItems

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
> +        compatible = "sunplus,mmc-v2";
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
> +       compatible = "sunplus,mmc-v1";
> +       reg = <0x9c003e80 0x280>;
> +       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clkc 0x4f>;
> +       resets = <&rstc 0x3f>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
> +       max-frequency = <52000000>;
> +       disable-wp;
> +       cap-sd-highspeed;
> +       no-sdio;
> +       no-mmc;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7..2d91431 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS MMC DRIVER
> +M:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +M: Li-hao Kuo <lhjeff911@gmail.com>

Wrong indentation.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml

Wrong file name.

> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>


Best regards,
Krzysztof

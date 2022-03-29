Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427304EB23A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbiC2Qvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiC2Qvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:51:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB762467D9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:50:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so36340216ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3W39tC2e+e4XlENh3geReI/CxfG4scvOcsFNszfM2k4=;
        b=ySG+mixvItTpHny21aTnBnKz+TP6aGDVpHG5nZS5Rd0Tb52jAYKdBGgZaJDE0/8bXr
         FkmjdkptNzOvdefZvgAiIdDYcCPwMYf0P0BP0klpKVeoZ/zZoyVfbtIeq+3Cp7kgRKSE
         Pads40KqXEJvZ1Hx5Ul05VMlYoDrtSoRRWKhAcbP1qpGnKpZXO/HrsXV//iT6zsmogoE
         sARUk5j21HdviVg9F+ARHjnDqn5JBLx0/Ry/Mn0QGJnnBUToAQyri++1kLyz9x7ZGjEJ
         XmVJMXt234cCaIHxx0EHLEcC8TTMZmyiiiljhTLMewQQBEw1kVdyCyfXBaLZzam+cr18
         BsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3W39tC2e+e4XlENh3geReI/CxfG4scvOcsFNszfM2k4=;
        b=q6B1xThuhfbIPqFbpt4bSK9k3v9l0P+h2orkHqa+bHu5RbfIPJV5eGNzSkFYTU2CLE
         f5rdDaqe0Otm6GnJc86te0bKKo2FoYtQFebHaACszPa1nyrPjjnodrGak27VZpXTmeu6
         VcAa1m10uDnXOzMsuw/ybxIxVRFqlTFVUXYCWln3cGq9ki6YAL1ykb2k4LVWEHopFABc
         HLD43c37fWFHmBVeagSHRbNVWsqSVQf0HFtl+RV6QF2sBeyzij83C15nmmILUHitfkt5
         TXQqgbv5HqosPKJiT0wI1c2LxgHKF6XlR6LUUt6jUIXZP1skDkNt9kJJgBxUlzfG1wAa
         kL4g==
X-Gm-Message-State: AOAM532EdE0bGz7cTgP4IoEeuXoMlknZN2xKdg3B/mnx98nBg4qf9jcO
        MfAxSfAtgk8mrEDNuz9iym/jMgWMllzG88x2
X-Google-Smtp-Source: ABdhPJyv5/j1KLCPW2EGMkODOgQaFZJ8INemE/1yDu/Q4K7LSfV1gStbxYZglireUgGSfjH+MeW7Pg==
X-Received: by 2002:a17:907:7f8b:b0:6e0:612b:38fd with SMTP id qk11-20020a1709077f8b00b006e0612b38fdmr35710600ejc.552.1648572604849;
        Tue, 29 Mar 2022 09:50:04 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7237928ejk.119.2022.03.29.09.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 09:50:04 -0700 (PDT)
Message-ID: <85ed0e5b-0c6f-aea0-ea89-522591d85420@linaro.org>
Date:   Tue, 29 Mar 2022 18:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, lhjeff911@gmail.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com, lh.kuo@sunplus.com
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
 <abd34a74bf56e04050868c63d030552a9af210f4.1648551070.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <abd34a74bf56e04050868c63d030552a9af210f4.1648551070.git.tonyhuang.sunplus@gmail.com>
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

On 29/03/2022 16:42, Tony Huang wrote:
> Add mmc yaml file for Sunplus SP7021

s/mmc/MMC/
s/yaml/YAML/
And a full stop.

Please rebase your changes on recent Linux kernel, because you skip
Cc-ing me all the time, so I assume you have some old Maintainers file.

> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v5:
>  - Addressed comments from Krzysztof.
> 
>  .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> new file mode 100644
> index 0000000..92537d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus MMC Controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  max-frequency: true

I think you do not need this.

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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7..42498b2 100644
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
> +F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml

I pointed this already for your v4.

> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>


Best regards,
Krzysztof

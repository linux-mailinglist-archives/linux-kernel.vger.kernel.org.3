Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0015A7825
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiHaHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiHaHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:52:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59CFC4818
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:51:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq23so18802247lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bfcnRsKGvRT6TTwAlGJlUWU/9O4FOy0WoLOf2X0EH3k=;
        b=lKQ0/feYpq72sXN4Lw9J2cr6nWlfcZAyQqisi49l5qkR1zRtMc/gf2Sx9yHrZsQKJC
         dK1u5cbF7BgUVMMvNLeb1byAxC+vlrIZJ5mrA+olHXD3oJWD7T8r+PSXhZLFAVzlA/Eu
         l+CTg26sz25aDte4pWMwYvQ/5ZwRQA2dff917oOz+pb3KiL4yuvgRGN0+m0P+AXdE2WC
         OJqWxR+jq2zZHpcX1Dv6uKom8bLAQXsf/dAUUumpEFwBZAvFBaS+Bm5usHF/8K35SW3j
         /814aaYhpvGjTNwjjS0/bwxFCoy3ioMCT0P9uOpF+9gQbnFfFqTqxKxsJTnvTqvtYd+A
         ZOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bfcnRsKGvRT6TTwAlGJlUWU/9O4FOy0WoLOf2X0EH3k=;
        b=q5fj4gLFpKbiU/yYCvasrvukr6MFjRCC5fE4FHjdl4ClYdZRLwIqSv2DIjDMtQ7j75
         NQ6ayARU6CIYr+XPBKDJDsZ4uI0xAKh3Pt5//q+Xu6lyTxN/aVdDjTjtT/a5g3vhOpGQ
         Xm88pPR9xMa5jOUbgTGeSpGnGrOCsX17LmNCR5P4yu2b40/BTaeCtXD6a+9Ami7dbtbn
         RNK0qK6edx/cGe1rDAZR5ESjXAvMbX/5voaX4UXQ4LpyTioaqMEFhpqGdpF0G8mbnbGN
         2+UqrYF4Dnrlma6O2q5yhl3qRzRi6yaAYW2c39PU337w+/Apm+wXfJQFso0kY0AzonO9
         ywBA==
X-Gm-Message-State: ACgBeo3B2wBUtB/1jEV9RZYqLQuLoOw1enEvXpLZ8nqAhuEGCDp7YrJd
        WEXmZuCL5q0wMbgSq4l2Zm6wRg==
X-Google-Smtp-Source: AA6agR4iy1PV1AtURDtvEeghCC5XUb3OMhnD+A53SyXi/rOIFpc5JyYZndFAC2jcrd9knfu+sNmSug==
X-Received: by 2002:a05:6512:1155:b0:48a:fb9a:32d8 with SMTP id m21-20020a056512115500b0048afb9a32d8mr8995472lfg.672.1661932287396;
        Wed, 31 Aug 2022 00:51:27 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512201100b0049490b3bb46sm117362lfb.36.2022.08.31.00.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 00:51:26 -0700 (PDT)
Message-ID: <26b5442a-5224-4252-f141-e85b33fa4f53@linaro.org>
Date:   Wed, 31 Aug 2022 10:51:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
 syscon
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
 <20220831074923.3085937-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831074923.3085937-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 10:49, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
> new file mode 100644
> index 000000000000..90c5e354f86c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml

Filename: fsl,imx93-syscon.yaml

> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NXP i.MX9 Platforms System Controller bindings

s/bindings//

> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

You miss here select.

> +properties:
> +  compatible:
> +    oneOf:

Drop oneOf, unless you already have patch adding something more?

> +      - items:
> +          - enum:
> +              - fsl,imx93-aonmix-ns-syscfg
> +              - fsl,imx93-wakeupmix-syscfg
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg


Best regards,
Krzysztof

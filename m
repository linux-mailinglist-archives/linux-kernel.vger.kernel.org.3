Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2018358FE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiHKOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiHKOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:35:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC460691
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:35:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f20so25772128lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HWMkKiacAbXjZCW+QJBi//SaWZp5PUOfX91uKaY6Quw=;
        b=i08qZIzkDjlyMcEr83N9FdfpC7GXHP6+EAQH9CtohrVz0PE4/DYz+HbJF6+LZ3OQIV
         MvSB2dyiTOB38WYENrugl//eOxaesLxw10GSd0Rzkyud9fZGIvTGxlI4j/0ARTg35+CF
         nRhGxbVs0Utcs5+ly4R5O0+DmJqex9tBlT1mlNKP/5KmIFb+0Ta0Y5+4/hHIaiChMOcn
         /JZHk5KN32SFnEPaQyeEMwVbh2n+jd4C841xw9CJkMGAw5fkK6n0rr5UNVig++coSbzM
         jOUP7k5TMRyYH6wDC/ndyXyaZzFBINGZYyHtNJW9gBcvcqCVmOMmpWtrGb2O0zlCkgpI
         pEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HWMkKiacAbXjZCW+QJBi//SaWZp5PUOfX91uKaY6Quw=;
        b=oblAkvyG4qbJG95iKZiDQevKho1uGvjErdGkCKu0jKy//rV2SUu6q3RmjDK5z8vJ7i
         3SQXzLnePhFoiNs8Q+uDY9JUT8zmIrO2ZNA+6+Lxyb0nkvF6q9YoEZntpAKlLzcAPH6H
         Au/TJBCaSHwgYX99G3xaAZ2pHhYt+fUsHy9JioJ8ykE5WHl0rbxHUEygnFeTixqki7z+
         oeT8Vl0vpdEoiLDE2AqtI9vXbsNrIH2xuc2dVt9lTbBAXeaowTwWRSX3R7kpPXx9JVM2
         kacav+7d5HuB0WTyPrQ+pfG4RLFUcOK7C4W7ndSb6KjY7tFKCvZ2zmj04wgeTqIZylcQ
         4lYg==
X-Gm-Message-State: ACgBeo1sNcGqZqGXfbkxHRNd1q2xAnzBO3C0+km0F5FqjJLnbDDr1/4Z
        Bsudc/zs6QA3et+PgIaRRY9bzg==
X-Google-Smtp-Source: AA6agR6ax8Cjk2ujPg8qHxbuGs/UavTCyEJl64W43pl6T6CSD61e92QRzGzWgHg0T6+nr2YLakjgxQ==
X-Received: by 2002:a05:6512:3048:b0:48b:745:621c with SMTP id b8-20020a056512304800b0048b0745621cmr10507626lfb.620.1660228537208;
        Thu, 11 Aug 2022 07:35:37 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e8806000000b0025e6fbf4a07sm857710ljh.7.2022.08.11.07.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:35:36 -0700 (PDT)
Message-ID: <db3020ef-7321-e171-b5bc-9c1795c2cced@linaro.org>
Date:   Thu, 11 Aug 2022 17:35:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio driver
 bindings
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
References: <20220811124135.95299-1-shenwei.wang@nxp.com>
 <20220811124135.95299-2-shenwei.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811124135.95299-2-shenwei.wang@nxp.com>
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

On 11/08/2022 15:41, Shenwei Wang wrote:
> Add binding document for the imx scu gpio driver.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  .../bindings/gpio/fsl,imx-sc-gpio.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
> new file mode 100644
> index 000000000000..a1b024cddc97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/fsl,imx-sc-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO driver over IMX SCU firmware API
> +
> +maintainers:
> +  - Shenwei Wang <shenwei.wang@nxp.com>
> +
> +description: |
> +  This module provides the standard interface to control the
> +  resource pins in SCU domain on i.MX8 platforms.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qxp-sc-gpio

Now the filename does not match compatible. Use the same compatible as
filename.

Best regards,
Krzysztof

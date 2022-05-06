Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF351D184
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381554AbiEFGjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381727AbiEFGji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:39:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CB65433
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:35:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j6so12557440ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zz4s19IuKfTWspT91aKEXLuSU6HR0U4j58MbscydUyU=;
        b=MpmLl/FtCbjUVWWOH3llKMB/0jTnJdXFpLOuz1NzKYZELDFAR9Xh/FalVKBEYIUcj8
         CACUx8NQWsVVgEElfDul2cFjZbosb7XV6mowGltvFtdK1CdmrnnwanchRL4tWtBZ4Pnn
         7kQbGKoPCklmKAIKKCGt/HoJW6qU+u1hEF44R6aAPk/tIec0iI3f7TZfYDAWMR/zqjRd
         1Zf+UpVFmMc4n92cWQpMXUE6yjE7TjOgxbU80BtRK2Nr6aUl/5WqfQX+vQHhsC3e9og1
         H8+DZhmu+ZC7BWdR1tsnWwt1WCOxmgwuUIZdcf2IwE/jHT8Tk4MtHLk5T3i9WIiFsu62
         UxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zz4s19IuKfTWspT91aKEXLuSU6HR0U4j58MbscydUyU=;
        b=qXpUdgZYM+wlmjQJIAs/oj6DhgjiInoIj1UMT8w4vP7vpfkJX2mRJ25loWjUzs+ecW
         cgL6JtxRxjoW6VJJ1A/3G4VpFLfMXPMUfdAzR4nCBN7CK6dN1GtwU89ugJ0YpXpUlD9g
         ctuqUglcTAjLnlSNlT9ohoxkIJoSSQiIbfH7XzCdtBSDb+B7OFGmCN03NDARXbKoqFCh
         vYZFgk15oBSeNq4s1j260wwMolb+E5CNPBALrUgZRYN35/1nVxJk3sYSQzhx1JO7at+m
         J+wL2u9F36AcIc0bXXm94dg1tzKTfiJJDkCo5yi4zUi480GD43U347xx+jK+DxCgMTL4
         3pkA==
X-Gm-Message-State: AOAM532pOoFmIRRdXWeWiFWr6xdirkp3UX9Jch75zdm8YIyqLN06qNGy
        xkkJA/0V7cXEzDxuYfzoxJaCRw==
X-Google-Smtp-Source: ABdhPJziYnBgutJZ7XtcuUasNPQfiJkESED3cSKWySTy25i3Vl6K281X4oN9Lcg38owtVMyfOlqcQA==
X-Received: by 2002:a17:907:7ea8:b0:6f5:941:cba9 with SMTP id qb40-20020a1709077ea800b006f50941cba9mr1546089ejc.213.1651818953535;
        Thu, 05 May 2022 23:35:53 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cy14-20020a0564021c8e00b0042617ba638asm1833255edb.20.2022.05.05.23.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 23:35:53 -0700 (PDT)
Message-ID: <550cd907-be2a-4e90-350c-fbc3bdc03728@linaro.org>
Date:   Fri, 6 May 2022 08:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v14 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <cover.1651805790.git.qinjian@cqplus1.com>
 <56fb5e9a35a901f15d8e9721385c7e916c181377.1651805790.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <56fb5e9a35a901f15d8e9721385c7e916c181377.1651805790.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 05:23, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> new file mode 100644
> index 000000000..f26d8b213
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/sunplus,sp7021-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 SoC Interrupt Controller Device Tree Bindings

Remove "Device Tree Bindings". This applies to all bindings patches, not
only to one.


Best regards,
Krzysztof

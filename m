Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890B512BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiD1Ggp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiD1Ggn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:36:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A076973A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:33:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so7537691ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rozerKyB/C5qipfTZh/u0vAMNYveH4wCpbPpnEpmk5I=;
        b=jID8SkbjZdvNaCihTEHL+AMMFHP8eC2RUy+QYH0Cg2l71tQhaM/iWrNs7C5o3qDqxn
         bTv0i80aWbxxhIhvo6sNhYWidErZNyr0Bl/0H3H3TrZU28SyaXVryV8u/yrRMoz2f1iU
         O+WdtZPfP1+TyhT74jiQXnp8JZ1SQiklm9FxMG4QOoFPLPYoDBWtJ72jj9V+PormGVKK
         22OZ/GCpaIrPvsQFU6ORR2C5qmbnmsDRkTPfYDmdhXKnzVpx30c+TMcFv8mxeNvQ6xqe
         FGR9qcp8WNEBl9yAS7LyYOGBXZoQVziny4iH/LB/EpP0ut8Z+PNGfSYBVmUhSAcctIri
         SYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rozerKyB/C5qipfTZh/u0vAMNYveH4wCpbPpnEpmk5I=;
        b=s7cLJXeVZPjRCCptL0N9zjulGordZmVc4z6NEnKfWwdPE1MyASIQ5V7Wj6Mutj06Jh
         5sTUNhJ6us1bZ+lKyuAqOLAE9pbg0i0Wk+SLRKkLHH5RsHtvaTgbg5YlUoKJQcn3fMHI
         T+54ecOV263Swwg8cDzz12ZxyGZd5/aqQQA7pu9z6KBua4YlYuS3klLOgkYQJSvAPqLH
         Oa7HY8VNyXJhQlL8B25ai3m1l/eNpP8w5EUjF1YIKFXID56qzvlz09bv1rW5qrPmH9KS
         GuYS6ISuaGRuBPmoB9S4S3aW0JhRo+nPIaio1QnS4VdO+VAoM1UaLorahnoeR8OAxqGw
         qNqQ==
X-Gm-Message-State: AOAM530L4jamCxudSfmaHTCn391bdn9hr4DUsVSlQrjb4p8lZlK7s1le
        EmS+RFftH4y34WdSk6e9EtaeHg==
X-Google-Smtp-Source: ABdhPJx80NdRMCudydCbEj21NDTT0qWVklkeluJPZzk7stNXaL45hh7VHzsiVKCWV2mZ3JL3lXSYaA==
X-Received: by 2002:a17:907:6d83:b0:6f3:adf4:9817 with SMTP id sb3-20020a1709076d8300b006f3adf49817mr12821838ejc.491.1651127607580;
        Wed, 27 Apr 2022 23:33:27 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7cb08000000b0042617ba638csm966354edt.22.2022.04.27.23.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:33:26 -0700 (PDT)
Message-ID: <fc26c920-2eb1-3324-227d-d347304002d2@linaro.org>
Date:   Thu, 28 Apr 2022 08:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT v2 02/11] dt-bindings: soc: grf: add
 pcie30-{phy,pipe}-grf
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220426132139.26761-1-linux@fw-web.de>
 <20220426132139.26761-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426132139.26761-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 15:21, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatibles for PCIe v3 General Register Files.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> ---
> changes in v2:
> - add soc-part to pcie3-phy-grf
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 3be3cfd52f7b..4564ff0bfd7a 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -14,6 +14,9 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - rockchip,rk3568-pcie3-phy-grf
> +              - rockchip,rk3588-pcie3-phy-grf
> +              - rockchip,rk3588-pcie3-pipe-grf

Order is now messed up.

>                - rockchip,rk3288-sgrf
>                - rockchip,rk3566-pipe-grf
>                - rockchip,rk3568-usb2phy-grf


Best regards,
Krzysztof

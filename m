Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912EC512BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiD1Gkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242203AbiD1Gkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:40:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866947DE12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:37:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so7502502ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vQuJemEQZtOClpOcehCv8HwJ99NWWFLzVezPd8GOsHU=;
        b=SQfA/qWnxaXhMdzN8fwO8LJSkhrZCgPApUc0W26KbVtHa1/bbo0ViFX+ofQKfo+5K/
         DFVWIQYwoenoZq+bVHlU6015EMsluuxImU3vbKX1j71idFjW61GaANiq9LKtROHzWGE0
         IH1XbG4wXxRNEv1zby59TG+Wqh1myUW5SPt3BPOQAAbxcOHXK4yIzZl0B5qEUCZmSSbf
         PJnKcvbwbmDhH/eRu9KMo+Fxz7IpZAKy7jC484/zJ0N2Lgka0SLfQBdc2yUgfqRy+8RJ
         74O33hF9OKmq0x/p5VikCLJbyKvxOhqn2heymD7ZFkT8DD0voR6Rmn/b3KViDePpg6Gf
         dbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vQuJemEQZtOClpOcehCv8HwJ99NWWFLzVezPd8GOsHU=;
        b=Vy4Lhi3Q/7iWpzYX7aucKq2/szP16z7J+PXWLGKlBVm7TTynKLgv9wvzAz8rrXVFjm
         3/1uXwbb+LGcdFNsX+dl26CYLHmpD2D5dzKFctDBqXeidaQfebVo/O/00hPhrix8SNiu
         P7ipSj5AZHoWJAtWvCDyKjnLAPtfF9Y2VQ+MQr4ng5H03pJXCynQaM/ZEcyeDKDK+hnR
         nvjR39amb9WBy1KBJUPoy7ztEXZu6C4B2XbmICLi7g6fqC/KrnNAhVo1ZqK4MzY+NR8Y
         NvfgTeGhlavxSXnPsxzd25IDM08bjG6Zj5frEFWVl2bQtt63XiPoXDFWycoxGZJfE6Cm
         OOag==
X-Gm-Message-State: AOAM531tjHkkZLIeI2H1DMeMoPaOZdADjwL8cMQOoHhKMNdyjm3D3Gt0
        F4HBtWhvC92anOyom5bE2djYgQ==
X-Google-Smtp-Source: ABdhPJwIDG6JJQkX2j+dOnGWCEo3T5++ulatebavZxvudL1ZgszkW2TlVKRE4wi1f/ha07iHzj1kJQ==
X-Received: by 2002:a17:907:9482:b0:6da:8ad6:c8b5 with SMTP id dm2-20020a170907948200b006da8ad6c8b5mr29709648ejc.372.1651127853141;
        Wed, 27 Apr 2022 23:37:33 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709060b0a00b006f38412b2d0sm6224668ejg.171.2022.04.27.23.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:37:32 -0700 (PDT)
Message-ID: <ea6ccec6-81a3-b22d-46db-c31a9f1e85f3@linaro.org>
Date:   Thu, 28 Apr 2022 08:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT v2 05/11] dt-bindings: pci: add bifurcation option to
 Rockchip DesignWare binding
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
 <20220426132139.26761-6-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426132139.26761-6-linux@fw-web.de>
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
> Add bifurcation property for splitting PCIe lanes.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index bc0a9d1db750..a992970e8b85 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -74,6 +74,8 @@ properties:
>    reset-names:
>      const: pipe
>  
> +  bifurcation: true
> +

Does not look like standard property. Is it already defined somewhere?
All non-standard properties need vendor, type and description.


Best regards,
Krzysztof

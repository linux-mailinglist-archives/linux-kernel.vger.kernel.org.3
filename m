Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2A505C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbiDRP7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346055AbiDRP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:59:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609AB2E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:54:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b15so17913441edn.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vExbQgWTmo9cdYRjO3lZaZafAOj+3myJ54HYnxwjwJU=;
        b=wuoq961CO62wyGxE5bgeAgujXr7zZQiAQ5NJ7ce4QC79dgFvD2vhmS3tQuQ0jzoarp
         rAlPTLhDe7CAX/VpoRcnBxqvMQfU6In9g+pE9BcRciHJmYL4niuCUA2d+HXs6VQHSJl+
         zZiNnwwYfrfCGkaYVOSESqazWzKQl48myzXFkhAqnlrCUvAFqyEp+saWlcENjnyFhmZt
         lW5n5Fc16/wwCAMqB4k6vzgVq572yFU9vk5K5C2tY3mVAxLuYI5m9S9P7JmUX13ZCKX6
         i9j2JU5yA5jOIURyyBLPevztjcqODsHGgQZ0hrqv4rw/OTNWPRte7UuQfM7lYtW0x0sY
         gHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vExbQgWTmo9cdYRjO3lZaZafAOj+3myJ54HYnxwjwJU=;
        b=Jg/hOr62l2avr0G1SyDfnEOmPpwVsZ5Qaa0Ir7u39bQJEZxueGAA2CF20drT/Y528u
         lCWUaOxPPJxMrYogVCV2tsMsJum9AY9LYVBQcSPEu4nJapbwlDwHlvO5s8dTaIeOVPh6
         ZyxFwvxraxKMaGweGvqVCVX0r6t9TWAiYlihw1wS1TMU3rWW4SIUbQ3uCDHe7ET3kcDW
         GH7YLCHfWxcL4xGD+8uslW6NVHfWj2gq2CS8iW3107loTIiTNfWbcOKN4D5fxHdVkYcM
         P6P+KVJE7Eu+iKt58riZseVndQTd5uijxQIpvsLq8rmzG+t4RZVB7jycqUn7SFMWuP/1
         bQ0Q==
X-Gm-Message-State: AOAM531zoHg2YNLAetdvpToaOw/yvf1viIxW36PVHuq1MiOChlzmO5Aw
        TeMsc6sz39N8LxKxnnQk0ymuAw==
X-Google-Smtp-Source: ABdhPJxOU8XpoJAVWxnURpK73rhpEpQrFHR9tM8mD6DChWAt5Z1BftpA7RiDI3n7wvUfSZnXuXn8mQ==
X-Received: by 2002:aa7:ce11:0:b0:41d:5b84:eecd with SMTP id d17-20020aa7ce11000000b0041d5b84eecdmr12739801edv.15.1650297274423;
        Mon, 18 Apr 2022 08:54:34 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402154200b0042323822e15sm4584540edx.74.2022.04.18.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 08:54:33 -0700 (PDT)
Message-ID: <02b3fe1c-12f9-8f96-a9b5-df44ca001825@linaro.org>
Date:   Mon, 18 Apr 2022 17:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT 2/6] dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220416135458.104048-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2022 15:54, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatibles for PCIe v3 General Register Files.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 3be3cfd52f7b..ae48b58bd062 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -14,6 +14,8 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - rockchip,pcie30-phy-grf
> +              - rockchip,pcie30-pipe-grf

These are without SoC parts. Are these PCIe v3 General Register Files
part of some PCIe spec?

>                - rockchip,rk3288-sgrf
>                - rockchip,rk3566-pipe-grf
>                - rockchip,rk3568-usb2phy-grf


Best regards,
Krzysztof

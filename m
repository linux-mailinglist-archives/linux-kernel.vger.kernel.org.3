Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F485190B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiECVxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbiECVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:53:20 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FCF427D0;
        Tue,  3 May 2022 14:49:03 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id m25so5663555oih.2;
        Tue, 03 May 2022 14:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PMK6sujVThrZqgCpTOHtQZPh22N0TVlCzqEoQCk6YC0=;
        b=JHW3csXLqbFSyqinMtKbj44SSUhmh1W7ne5E9qgOCQexSwgEVGmSfhwYdSdyDBhwhk
         QSpDXB0xgrHEy3JERB3T+qXFohjGEAgCNhwbpfnUuOtXxA7NQdUVVkf9QojjwdU6oj70
         2cSg9ynHd8W0MMko1D7ejB5srEFO8NHrtuul4xe8pTI2vQ3+sgEXpOMcafghhqydjHuJ
         Bf1B1NErLR3iMP6Vu60FtS9+h4mIsPMbwJhgeg5jprJRFD4/AtwMggZE/xbPURXtMDrz
         R9O3wBLPHbGJwb1FaFXzoiy8OhqNpDE/38MlQgWbDVoaWXE3ALgineJtJzoF5G+lnIEo
         Da4Q==
X-Gm-Message-State: AOAM532C/RIDK2l6ELNJKuH+HGuVkie2TFSpGxYv2ZGEbPMP+jVDWpL9
        TIp103/c0W9RocJ12cHvz7zQRgbIvA==
X-Google-Smtp-Source: ABdhPJyXG3Qb+wCY6PcVesYD78Lvr1fJPRxuDGrnHOap6UmNMid5rtVdvpuNP3xxFfMNVRKy3LDlTQ==
X-Received: by 2002:aca:2403:0:b0:325:6dae:a63b with SMTP id n3-20020aca2403000000b003256daea63bmr2595593oic.230.1651614538887;
        Tue, 03 May 2022 14:48:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a11-20020a4a9b0b000000b0035ec65ac944sm4941869ook.16.2022.05.03.14.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:48:58 -0700 (PDT)
Received: (nullmailer pid 91855 invoked by uid 1000);
        Tue, 03 May 2022 21:48:57 -0000
Date:   Tue, 3 May 2022 16:48:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding
 of MT8192 clock
Message-ID: <YnGjScfQA9axBYBO@robh.at.kernel.org>
References: <20220429123133.28869-1-matthias.bgg@kernel.org>
 <20220429123133.28869-2-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429123133.28869-2-matthias.bgg@kernel.org>
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

On Fri, Apr 29, 2022 at 02:31:31PM +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The msdc gate is part of the MMC driver. Delete the binding description
> of this node.

An ABI break is okay because ...?

> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> ---
> 
> Changes in v2:
> - Delete compatible in binding descprition as well
> 
>  .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml      | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> index c8c67c033f8c..b57cc2e69efb 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> @@ -24,7 +24,6 @@ properties:
>            - mediatek,mt8192-imp_iic_wrap_w
>            - mediatek,mt8192-imp_iic_wrap_n
>            - mediatek,mt8192-msdc_top
> -          - mediatek,mt8192-msdc
>            - mediatek,mt8192-mfgcfg
>            - mediatek,mt8192-imgsys
>            - mediatek,mt8192-imgsys2
> @@ -107,13 +106,6 @@ examples:
>          #clock-cells = <1>;
>      };
>  
> -  - |
> -    msdc: clock-controller@11f60000 {
> -        compatible = "mediatek,mt8192-msdc";
> -        reg = <0x11f60000 0x1000>;
> -        #clock-cells = <1>;
> -    };
> -
>    - |
>      mfgcfg: clock-controller@13fbf000 {
>          compatible = "mediatek,mt8192-mfgcfg";
> -- 
> 2.34.1
> 
> 

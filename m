Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DDC578B87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiGRUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiGRUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:10:23 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F9AA462;
        Mon, 18 Jul 2022 13:10:22 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id o2so5192437ill.6;
        Mon, 18 Jul 2022 13:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqLfFJGdvrKUW1fmZt9ValV02p3rXb0EIAq0v1cNES8=;
        b=NnevbM7/7BUWDjPmVGEmz90r4bSVnH9OwSTL0h3dLHphxNrlH2uZoskTfY4peqiEqc
         cfPB7V1QR2f6jHUD9e9RFCiDJTR1Eh/XnfvwG15w99GPvRWh28Az2pbOOrVG3alC6B45
         nH19uH2brEOxmHj9HpaDjDflzs85ctsx9LkovZedii3ImuUtRZjalIftNijaKWTYpck9
         jt89HbQ6C3+Yu6Ey6caVRr5nwnRdj5lPYnUlg4ves3ZUvHHESGJj10den6ewsq0K6R+3
         TgmpJbI4fpkEvyVLQA8HIPANjAIIeH3h5gnvOnPXduxNhsdR7optT/y4NQx9gEqbb1wi
         wi9A==
X-Gm-Message-State: AJIora/FxP8yy8fiNIa54zf49p3EkWMumY0rgzbquwWxk/dsR83yp7G0
        bDCptmwxGfu/DCsLnUpZtw==
X-Google-Smtp-Source: AGRyM1vIK3KywiBRGl3M+VsgE1D2GxpaHCm/sub2KfIH9kA0N1m3Epw0wvneMsVhfP/2VtUlWvQIIg==
X-Received: by 2002:a92:6c05:0:b0:2da:b9e8:24df with SMTP id h5-20020a926c05000000b002dab9e824dfmr14653836ilc.99.1658175021933;
        Mon, 18 Jul 2022 13:10:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u75-20020a02234e000000b0033f4a1114a6sm5741039jau.178.2022.07.18.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:10:21 -0700 (PDT)
Received: (nullmailer pid 3464461 invoked by uid 1000);
        Mon, 18 Jul 2022 20:10:19 -0000
Date:   Mon, 18 Jul 2022 14:10:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V4] dt-bindings: mediatek: Add axi clock in mt8173 dts
 example
Message-ID: <20220718201019.GA3461716-robh@kernel.org>
References: <20220712111106.31089-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712111106.31089-1-xiangsheng.hou@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:11:07PM +0800, Xiangsheng Hou wrote:
> For mt8173, it is needed to add the axi clock for dma mode.

Needs to be sent to Mark Brown and linux-spi list. Use 
get_maintainers.pl.

> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> Changes from v3:
> - fix number of column characters
> 
> Changes from v2:
> - remove assigned clocks and parents in dt-binding
> 
> Changes from v1:
> - none
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> index 41e60fe4b09f..d3d7ed4b497b 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -82,8 +82,9 @@ examples:
>          compatible = "mediatek,mt8173-nor";
>          reg = <0 0x1100d000 0 0xe0>;
>          interrupts = <1>;
> -        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> -        clock-names = "spi", "sf";
> +        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>,
> +                 <&pericfg CLK_PERI_NFI>;
> +        clock-names = "spi", "sf", "axi";
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -- 
> 2.25.1
> 
> 

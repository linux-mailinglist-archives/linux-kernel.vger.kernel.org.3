Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B552F599
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353873AbiETWTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiETWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:19:13 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38529166D4E;
        Fri, 20 May 2022 15:19:13 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v65so11458789oig.10;
        Fri, 20 May 2022 15:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9dsJo+KUSNJhEleqZiYrTy2I+OsjWQH8r8DGAGeIs0=;
        b=Wce68HBGZRZ8AUkpJqxCNWxesMT0oL7PEu/F5s/G/uty0qa8lbFp3Ft2t60QlXThwJ
         9js2sH0jpkpAYOdight+5wXiMFRBkb4w6XZLYo7CgkvctFZptYJC73sTluK9LJjtaeV5
         MDmAmEIEuHCseRh9QsxXyRP2dZUiDDC+f1d/3z83wnTYyJObXYzzxhe9b8AFJQ5QWPbG
         LcfXs3r8Aikpk7liIkM8jqx4NmQ+mlbGorwdpj/2NWe1xVHVnT5uml+JFiplarBfyGnn
         MM/C4mnhHVe1DIMcxAcUN4tg1+BG4QV8xW06j3cU7Dld079HAFjO8we2koaZu7c80Nnd
         UAHQ==
X-Gm-Message-State: AOAM533Fuhy8+gw4kl4p/1H+fASUIWY6SKkmYt1BZ7alv0D7ypkdOuSm
        AxWwkCpRlDmq/6yyO7p4vj9bnKNIpg==
X-Google-Smtp-Source: ABdhPJzft3aq22SEVhwqjbd7HcdI0g2Hkb3t39TPzeI/Bi/8SVUST456M6/1/CAjek8nu0smQ3/REA==
X-Received: by 2002:a05:6808:14c1:b0:32a:f33d:86ca with SMTP id f1-20020a05680814c100b0032af33d86camr4898688oiw.89.1653085152543;
        Fri, 20 May 2022 15:19:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0384000000b0035eb4e5a6cdsm1569087ooi.35.2022.05.20.15.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:19:11 -0700 (PDT)
Received: (nullmailer pid 352851 invoked by uid 1000);
        Fri, 20 May 2022 22:19:10 -0000
Date:   Fri, 20 May 2022 17:19:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: mtk-clocks: Set #clock-cells as
 required property
Message-ID: <20220520221910.GA348732-robh@kernel.org>
References: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
 <20220518093631.25491-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518093631.25491-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:36:31AM +0200, AngeloGioacchino Del Regno wrote:
> This is a clock-controller binding, so it needs #clock-cells, or
> it would be of no use: add that to the list of required properties.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml  | 1 +
>  .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml         | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml  | 1 +
>  .../bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml         | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml  | 1 +
>  .../bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml         | 1 +
>  6 files changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

Wasn't there some discussion about moving these to bindings/clocks/? 
Maybe that was another one, it's all a blur...

Rob

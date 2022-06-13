Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47750549A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiFMRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiFMRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:50:39 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85666EC49;
        Mon, 13 Jun 2022 06:33:22 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id v7so4250879ilo.3;
        Mon, 13 Jun 2022 06:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=n5jciRFgHV7TEd2xOcxd5PlRxTUMR+//Y01eSUV2T1g=;
        b=5l10ej7sQUpEswpW04rtWz4pRj4xQIrt0OR65orJQ/8aNyUzErB4lfx660jaC8ohe/
         AJHE0KOingng4AtAl0qknv7yVH17QeVicwijWKTMtmuk1XcZoUNYd9tSAXL0RFLn+6aq
         TeMzZw4HAq4fagyK7P05XIjNb/RJ2l6ewvuN+m3XwN3gWqbUpxZWbEscBvukkQ6uUEZl
         9M3lzvNhv0y1IZ1mdMbcydHIVOjS0dE5+grx5oaSBMlR4bYyqwnls6Mx5LAfyvMoeB+v
         7YdKjFt676zUg9m/svwrdhXFC1RuIHGqcTH2qb4GblPC0AsdcBi37LfzQQqbeDkKfbrX
         JY6A==
X-Gm-Message-State: AOAM532G93LaXqEG4OrS8bDEqiSerU6mjFvgH9PFV8kbgarVsNvrFDdb
        pIpXSJfc0PQ1ig9ifOuzSw==
X-Google-Smtp-Source: ABdhPJwPF2UYqCLy0MjugVo/d0pZuzKLj39QY8kf66rRczmdaVGt+15ynEKyrpTTZPzJBoKuuGYMHw==
X-Received: by 2002:a05:6e02:1b04:b0:2d1:af55:eb92 with SMTP id i4-20020a056e021b0400b002d1af55eb92mr33611511ilv.227.1655127201997;
        Mon, 13 Jun 2022 06:33:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i2-20020a02ca02000000b0032e79d23f8fsm3510831jak.156.2022.06.13.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:33:21 -0700 (PDT)
Received: (nullmailer pid 3564135 invoked by uid 1000);
        Mon, 13 Jun 2022 13:33:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     daniel@ffwll.ch, chunkuang.hu@kernel.org, msp@baylibre.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        matthias.bgg@gmail.com, airlied@linux.ie, wenst@chromium.org,
        jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org,
        granquet@baylibre.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220613064841.10481-2-rex-bc.chen@mediatek.com>
References: <20220613064841.10481-1-rex-bc.chen@mediatek.com> <20220613064841.10481-2-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v11 01/12] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Date:   Mon, 13 Jun 2022 07:33:17 -0600
Message-Id: <1655127197.559996.3564134.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 14:48:30 +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> DP_INTF is similar to DPI but does not have the exact same feature set
> or register layouts.
> 
> DP_INTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
> 
> In this patch, we also do these string replacement:
> - s/mediatek/MediaTek/ in title.
> - s/Mediatek/MediaTek/ in description.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml     | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.example.dtb: dpi@1401d000: clocks: [[4294967295, 40], [4294967295, 41], [4294967295, 8]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.example.dtb: dpi@1401d000: clock-names: ['pixel', 'engine', 'pll'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


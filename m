Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CEA526BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384537AbiEMUsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384521AbiEMUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:48:38 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB15FE5;
        Fri, 13 May 2022 13:48:36 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id y63so11526616oia.7;
        Fri, 13 May 2022 13:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=X3TQnSjdMn1h88B2hKWq4Vtc4t9dgcXCcu4yQAA388I=;
        b=Nf6uWUMSC1Assz+k+DNJzTOWooI3GAVf03/KuJ4oYxD4kdNk9rz643Rkl+5XMzAq97
         Yi6kC4oPvuMbCN4UQ27AClPoDrIoO+T4miEgputgi4tBx2dQJQ5y5DV0WOLIkQQX0Ms5
         dYVE1Ckxw6j/w9KwC9OvqoeMG/QjwoiYbEUThtj7j/hmmoYWMtG5HSqOVJi3y3bx1WZJ
         kLmsnmXhiM5x+VMsNXVSR/hYOHea5GBhHdFoYEyK24a/RzPou5cRt/W7bNYJbzt6KVaK
         DRjGboe9oqy4hq+4UXkY2K1kAMDUGLj0Cvm0vWqmGntm0ZeUXW51kyDtzb2Gz71xUth7
         4Q2g==
X-Gm-Message-State: AOAM530z+jAB+bY1ykwY7uQN4Od8u/zic27WqHSUwNydjLXSu4fYBZMn
        4oYl3Vkjzam+feGgYNe1od37+LrOtw==
X-Google-Smtp-Source: ABdhPJwP+9t58/HsOC+vMOmnRUgE5YnXus5JIhh/6Mv2y+iU8XBnzrtKM2mxN6osLdIL8Ofj/qN0yw==
X-Received: by 2002:aca:aa42:0:b0:325:61e3:1726 with SMTP id t63-20020acaaa42000000b0032561e31726mr8474090oie.57.1652474915995;
        Fri, 13 May 2022 13:48:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870a60200b000e99b1909d4sm1426285oam.25.2022.05.13.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:48:35 -0700 (PDT)
Received: (nullmailer pid 894559 invoked by uid 1000);
        Fri, 13 May 2022 20:48:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, kernel@collabora.com, ikjn@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, fparent@baylibre.com, wenst@chromium.org,
        robh+dt@kernel.org, ck.hu@mediatek.com, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        martin.botka@somainline.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, weiyi.lu@mediatek.com,
        rex-bc.chen@mediatek.com, jason-jh.lin@mediatek.com,
        y.oudjana@protonmail.com, phone-devel@vger.kernel.org,
        bgolaszewski@baylibre.com, sboyd@kernel.org,
        konrad.dybcio@somainline.org, tinghan.shen@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        paul.bouchara@somainline.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, chun-jie.chen@mediatek.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220513165050.500831-5-angelogioacchino.delregno@collabora.com>
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com> <20220513165050.500831-5-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 4/5] dt-bindings: arm: mediatek: Add clock driver bindings for MT6795
Date:   Fri, 13 May 2022 15:48:33 -0500
Message-Id: <1652474913.760163.894558.nullmailer@robh.at.kernel.org>
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

On Fri, 13 May 2022 18:50:49 +0200, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../arm/mediatek/mediatek,mt6795-clock.yaml   | 67 +++++++++++++++++
>  .../mediatek/mediatek,mt6795-sys-clock.yaml   | 73 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml:67:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.example.dts:35.13-21 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


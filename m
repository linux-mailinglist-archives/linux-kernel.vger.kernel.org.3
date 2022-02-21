Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D284BD40E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbiBUChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:37:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiBUChB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:37:01 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6DB259;
        Sun, 20 Feb 2022 18:36:34 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id h16so14351509iol.11;
        Sun, 20 Feb 2022 18:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=z3L0QAaP0YwGTd6VI4wxx/3lOMZUuCl0MhaQbdJh1OQ=;
        b=GLKtyCbtxP8Kj6p6x/cJEBvNEE0RDa7W6EQApKmentYUWce4zJ+3MpU1mqs4VVDDq6
         P2MYmdSiWXDG76LPlbZ4/iGXpxlPbQyG+0cOHnGv0w5yMtTWr/IEIaz6nN1gkRBCqePl
         SAou+np1ZRp1iXxcVqjJRg4SOXv1fe1rbvm4X+fZFjkNo8bPGDDXZsSaQDUtCUH/Kfvz
         jlsF2G89rLM2Q0IeONKddpDrAVMCyRZr2nzuDNhktgNMIpfF9HpqzUg97yYP1DEw7Nm6
         yu41lXcKU3SgwgGtjRtN84+Aa8XSBc+t79iED0WrozycAwJXqE0pky6/3XCyB3hr0CZI
         4AnQ==
X-Gm-Message-State: AOAM533qfSwY0i9jgumYCuZvAD6PN3HdY0EI3mAPEbRuSiDjRWKEtYk5
        Cs7rCIN87685KbLT3E2uHQ==
X-Google-Smtp-Source: ABdhPJzC3lbA/3xbYHDC1TVY6Mc9mRZFu+uPq7kGdXhvdW9HCdoukC5Q8i8N7ZC5YawbHb6/C1rUWw==
X-Received: by 2002:a02:c851:0:b0:30e:2296:4290 with SMTP id r17-20020a02c851000000b0030e22964290mr14295308jao.49.1645410993813;
        Sun, 20 Feb 2022 18:36:33 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s9sm7433901ilv.50.2022.02.20.18.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:33 -0800 (PST)
Received: (nullmailer pid 2041539 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, airlied@linux.ie,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        angelogioacchino.delregno@collabora.com, tzimmermann@suse.de,
        ck.hu@mediatek.com, mripard@kernel.org, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
        jitao.shi@mediatek.com, linux-phy@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, linux-fbdev@vger.kernel.org, deller@gmx.de,
        chunkuang.hu@kernel.org, vkoul@kernel.org,
        chunfeng.yun@mediatek.com, kishon@ti.com
In-Reply-To: <20220218145437.18563-3-granquet@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-3-granquet@baylibre.com>
Subject: Re: [PATCH v8 02/19] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.343097.2041538.nullmailer@robh.at.kernel.org>
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

On Fri, 18 Feb 2022 15:54:20 +0100, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dts:20:18: fatal error: dt-bindings/power/mt8195-power.h: No such file or directory
   20 |         #include <dt-bindings/power/mt8195-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1594807

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


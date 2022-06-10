Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239A546735
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347667AbiFJNND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbiFJNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:12:49 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CFB5BE6C;
        Fri, 10 Jun 2022 06:12:44 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id d123so6259590iof.10;
        Fri, 10 Jun 2022 06:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IkgD32JQQv4iXIcEl6HeM9jrQJQd0Tq+F8d36Y5X2zg=;
        b=tzoazb7HJ57+oOqoUkqJQ1EV0aftXD5PAp3h4oVpz2Zxyn3q6P6STcF+S1mJYqvWma
         TSQsM5tqxl4/dOGW3rcg/LC4yUN0HZCFULVt88c2wKyaJf6fO+wFOAeG4CdUSOofmhph
         EkaDhc3gqWfb/Oikk9IuuShFCnEgTHtyvtav9ygKGkM/cCWaQn08uSI0g0j8Gw2QVJVh
         ECdag3quSfioBdJrbIxfaOgI12jexeBlnwbPr+7XKeowzEU3RDsJU0RbANLU/jfdX7F/
         xEJ03oJY83bJPCL9iiY0zLHL4GcMYF7Km0KBC6E5Jcct0koXp8zlGf5WH4WD/NKQ2X0r
         PPrw==
X-Gm-Message-State: AOAM532Ho6QCezIA06wV89ubcVSipHF5Fz1cAFVQy+N7ZpbZtSkbq4lk
        wQTtkRTt3IcsQWcljZs33A==
X-Google-Smtp-Source: ABdhPJw7sfj49a/XqcZX4iEyYBeVBikgyBwiHnh2QxO3rAv60pfY7q66XAD3rxdzNX0bgAVsDTmVOw==
X-Received: by 2002:a5d:9a13:0:b0:668:94ba:46ab with SMTP id s19-20020a5d9a13000000b0066894ba46abmr20425276iol.155.1654866764099;
        Fri, 10 Jun 2022 06:12:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z12-20020a02344c000000b003318ba8386bsm7885984jaz.81.2022.06.10.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:12:43 -0700 (PDT)
Received: (nullmailer pid 1529407 invoked by uid 1000);
        Fri, 10 Jun 2022 13:12:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     wenst@chromium.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        chunkuang.hu@kernel.org, daniel@ffwll.ch, matthias.bgg@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        granquet@baylibre.com, airlied@linux.ie, p.zabel@pengutronix.de,
        linux-fbdev@vger.kernel.org, ck.hu@mediatek.com,
        tzimmermann@suse.de, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, mripard@kernel.org,
        dri-devel@lists.freedesktop.org, deller@gmx.de, msp@baylibre.com,
        jitao.shi@mediatek.com
In-Reply-To: <20220610105522.13449-2-rex-bc.chen@mediatek.com>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com> <20220610105522.13449-2-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v11 01/10] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Fri, 10 Jun 2022 07:12:35 -0600
Message-Id: <1654866755.768151.1529406.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 18:55:13 +0800, Bo-Chen Chen wrote:
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
> [Bo-Chen: Fix reviewers' comment]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dtb: dp_tx@1c600000: max-lanes: b'\x04' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dtb: dp_tx@1c600000: max-linkrate: b'\x1f\xa4' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


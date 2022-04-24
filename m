Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65B50D21D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiDXNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiDXNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:50:55 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A988D16C17A;
        Sun, 24 Apr 2022 06:47:55 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e9027efe6aso6249819fac.10;
        Sun, 24 Apr 2022 06:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Pu6DnoU4e+S28wwiQtquR83df83fF19JIUY4ZsQ9G1U=;
        b=1yJt4kspoDaZPUYWJSt61Dv2vQcq5TPuUUfTn0ltlocx4gnpHJ7HjqpLPUTG04E7Bs
         MvXWyvmM2DSxqWWq4a5fWcAL0uOkOrRIvqSxculBos5HrPjRLBZSQFmUv5gmvIhLiKGh
         pm/HB3A9m0OQUpb0NFPoovhcxdCmAWpjOcU1utUcjN9NuLJWUScbx8vztc63mkzBpyOS
         8IOOj1V09v29pAHLKXQ1PZ1OXQVFYjmrWCPQVt0YRj9SNX4LlqnCaJoiLLE3Fj9D/NXc
         kKqwt0yR1G2bzd6di81RCBr5lAbrm6uei/Hp0JQQzR6kTexFGFW3yxiwp8mp9LzMjJpW
         nl/g==
X-Gm-Message-State: AOAM532nYqqHGr4c2AsPTgCf4WH2/pJLFyrQrQ7gObk+kvVwjWpt9lHS
        z0nXDXeMCZf1F4xajNrh6Q==
X-Google-Smtp-Source: ABdhPJyvEyxNrCShSr4B9GI+N2FFzDSFgIt2A4wEHMS5YRIGTBE48y06oer1YkM1bftG/CRPVFlAgQ==
X-Received: by 2002:a05:6870:ac06:b0:e9:cba:68cc with SMTP id kw6-20020a056870ac0600b000e90cba68ccmr3646271oab.144.1650808074936;
        Sun, 24 Apr 2022 06:47:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y83-20020aca4b56000000b003251ffeaf7csm724139oia.10.2022.04.24.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:47:54 -0700 (PDT)
Received: (nullmailer pid 1284015 invoked by uid 1000);
        Sun, 24 Apr 2022 13:47:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>, linux-clk@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220424084647.76577-4-y.oudjana@protonmail.com>
References: <20220424084647.76577-1-y.oudjana@protonmail.com> <20220424084647.76577-4-y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: mediatek: infracfg: Convert to DT schema
Date:   Sun, 24 Apr 2022 08:47:53 -0500
Message-Id: <1650808073.407864.1284014.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 12:46:47 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert infracfg bindings to DT schema format. Not all drivers
> currently implement resets, so #reset-cells is made a required
> property only for those that do. Using power-controller in the
> example node name makes #power-domain-cells required causing
> a dt_binding_check error. To solve this, the node is renamed to
> syscon@10001000.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
>  .../arm/mediatek/mediatek,infracfg.yaml       | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


infracfg@10001000: '#reset-cells' is a required property
	arch/arm64/boot/dts/mediatek/mt7986a-rfb.dtb
	arch/arm64/boot/dts/mediatek/mt7986b-rfb.dtb

syscon@10001000: '#reset-cells' is a required property
	arch/arm64/boot/dts/mediatek/mt2712-evb.dtb


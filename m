Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19A4AE34B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386541AbiBHWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386437AbiBHUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:33:35 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D65C0613CB;
        Tue,  8 Feb 2022 12:33:35 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so58414oov.3;
        Tue, 08 Feb 2022 12:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JRPrSLHlMGFs/3ziWzW4DwHIjPmQfKs7GHoGvsPVseE=;
        b=Dui+ygRdtRvnuNNl8Az4C1xnDVuCud4J8YazRDVoZaKuMm1CL41TAIybF8J+2coTTi
         w8rz983OochhgpVp1DekkSUfSweUKZLmEj3ioQje0K2vIdydMfCIwBzhYReInGndcO3H
         Xi/GuMLJuKum+7VxG5yCIj//eTRMoXP7uTcaJlpd0Io6mBZYPbnQWHVppJ20asBCEqAV
         Xz+yufUu1rRbo7VvkaAZC/a+VCAG5va3Lsb210x7AsU6AUdRQ7n9eYBKpSEoi0ouvJSX
         9Gd6QuAHYmvuJw4DNmKRXVWeLP68LLLLXnjbC7TuZxLEfpOcYsTXWSGP5VM/uITc6ae4
         ZAvg==
X-Gm-Message-State: AOAM531PTXxCWmEfh7bByDz++xtcrZjcSZX/H3c9KO5rMIglncwv2UnR
        kGcjnfK01r/ccluTn6emWw==
X-Google-Smtp-Source: ABdhPJy992PXewYBALzEYZBXPGbQ5OcH8lbZ6CwXGZxPSunoTW7Rr/84sO8nvJNszKtykvGlJvCgtg==
X-Received: by 2002:a05:6870:1215:: with SMTP id 21mr1027834oan.166.1644352414225;
        Tue, 08 Feb 2022 12:33:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u5sm5887627ooo.46.2022.02.08.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:33:33 -0800 (PST)
Received: (nullmailer pid 2969145 invoked by uid 1000);
        Tue, 08 Feb 2022 20:33:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, vkoul@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, cl@rock-chips.com, kishon@ti.com,
        kever.yang@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        david.wu@rock-chips.com, michael.riesch@wolfvision.net,
        linux-phy@lists.infradead.org, wulf@rock-chips.com,
        p.zabel@pengutronix.de, jbx6244@gmail.com
In-Reply-To: <20220208091326.12495-3-yifeng.zhao@rock-chips.com>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com> <20220208091326.12495-3-yifeng.zhao@rock-chips.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Tue, 08 Feb 2022 14:33:32 -0600
Message-Id: <1644352412.075016.2969144.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2022 17:13:24 +0800, Yifeng Zhao wrote:
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changes in v8: None
> Changes in v7:
> - remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
> 
> Changes in v5:
> - modify description for ssc and ext-refclk
> - remove apb reset
> 
> Changes in v4:
> - restyle
> - remove some minItems
> - add more properties
> - remove reset-names
> - move #phy-cells
> - add rockchip,rk3568-pipe-grf
> - add rockchip,rk3568-pipe-phy-grf
> 
> Changes in v3: None
> Changes in v2:
> - Fix dtschema/dtc warnings/errors
> 
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:0:0: /example-0/syscon@fdc50000: failed to match any schema with compatible: ['rockchip,rk3568-pipe-grf', 'syscon']
Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:0:0: /example-0/syscon@fdc70000: failed to match any schema with compatible: ['rockchip,rk3568-pipe-phy-grf', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1589719

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


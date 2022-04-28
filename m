Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE384513CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351868AbiD1Ugi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351834AbiD1Ugd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:36:33 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A889C0E42;
        Thu, 28 Apr 2022 13:33:17 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e67799d278so6270760fac.11;
        Thu, 28 Apr 2022 13:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=J3cE7MiG6hZTV7t9gy7Edw0SJtbuoMz271VEnExHnD0=;
        b=U4dFi7C3iyteroEe/7stMm3G5K1uMZazAmwUJje2D33ZH7rGiS+WJw1mM12JsuLWAm
         y+0SaPoP5Hse/EgkFAmw7rsn3pe8s+nKnLOZF1UQ4kA0pbWSHG6p97F/M/1GifZyu3Pv
         W8ofFMGFm6hFMuQhS5+n6tC2ldK8MWvethTcIfxL7kWwq228I8y8LALs1g5d+RaIyriC
         8dwvlobJ12ain1tnIoi6BOjWqd7ChuUpqIXg0jhp2bCEBBwy1T67YXQOGzMBI/y8446s
         vxQhYmUt3jqh5VXub6Plxb9KBHjdk+seTlZwn6iRm2NLYgQA5f06NaZ7RJxXokWHDvU8
         CKSQ==
X-Gm-Message-State: AOAM5336jpRk41VmCs84zAFKN6/MIsf0tX3a6wOHEH3Gxrt7Q1Swa675
        RIX8gtxAMLpAA4f5qDEAig==
X-Google-Smtp-Source: ABdhPJyIKCSFE8HADOvXCq4XSg7Q4QHv4eXtCiwjB/aZX//rs5FVokO0n3huOkyorbSQ8hAuq+erfA==
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id n14-20020a056870558e00b000e1db7c26aamr5244oao.63.1651177996283;
        Thu, 28 Apr 2022 13:33:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a056870e89600b000e686d13895sm2214899oan.47.2022.04.28.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 13:33:15 -0700 (PDT)
Received: (nullmailer pid 220468 invoked by uid 1000);
        Thu, 28 Apr 2022 20:33:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        git@xilinx.com, brgl@bgdev.pl, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@xilinx.com
In-Reply-To: <1651163798-15123-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1651163798-15123-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH] dt-bindings: gpio: zynq: Add all the supported compatibles
Date:   Thu, 28 Apr 2022 15:33:13 -0500
Message-Id: <1651177993.343093.220467.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 22:06:38 +0530, Radhey Shyam Pandey wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add the compatibles for zynqmp, versal and platform management controller
> nodes.
> 
> Fixes: 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> NOTE- There is 'gpio@e000a000: interrupts: [[0], [20], [4]] is too long'
> warning coming with upstream yaml. I am checking it on devicetree mailing
> list. https://www.spinics.net/lists/devicetree/msg493762.html
> ---
>  Documentation/devicetree/bindings/gpio/gpio-zynq.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


gpio@ff0a0000: '#address-cells', 'gpio-line-names', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb

gpio@ff0a0000: '#address-cells', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb


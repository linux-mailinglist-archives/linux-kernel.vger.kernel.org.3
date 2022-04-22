Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4A50B8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448062AbiDVNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiDVNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:39:15 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F7546AA;
        Fri, 22 Apr 2022 06:36:22 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e189so9024000oia.8;
        Fri, 22 Apr 2022 06:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=mQS+mOe2orSMjiuLFsak+S6Ca0B4tVfq9g6O7NPHWAQ=;
        b=aMR1K9CzPAxhN8KDw480pW+SHgYNKuUQ8Q5gMouQ3jVNHPmKGs+RQEezSpR+bHp/YK
         rnJfcmXxrEj+aFcp/md4gT8zssbVe5ws1nbPAbB+o5v0fGpKypN0o8Ue9xT5ImJrXQkt
         f4YrvFuGBJtUSGpXGSCSuQRjqH9FvqbKnEhF7RTcL8fjMRE4KW0PPKGGGKO7TvxEYDe0
         PE8/ugG5X57A0iLUmNs1xrHSGXqcTHOndEPaoo+BUMS5D6/Segctcq3eqC1A2Ow0cQ4m
         VPEIVFPvijPOH0pGmfsdx4BuJzudxYx/Ki8IGWDUcRyCgJPzbNai3R8+3faoFdis4v8P
         INJA==
X-Gm-Message-State: AOAM531RVfqcsA7eLJsV86uZFAbxkB1ZL6MWjNqQHVVRDnpCQwviTZMY
        VVz+MYdPoZuNj8rgonxrDg==
X-Google-Smtp-Source: ABdhPJybbmyWLxjo+nixlNq8Gcu+L6g7VQW1TV9wDUUa3TsjK9C1tjWSNmly786wjxHUXRr7AyXEZQ==
X-Received: by 2002:a05:6808:2388:b0:324:f195:bcb5 with SMTP id bp8-20020a056808238800b00324f195bcb5mr616056oib.238.1650634581771;
        Fri, 22 Apr 2022 06:36:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fu17-20020a0568705d9100b000e2b43e7fbasm628156oab.16.2022.04.22.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:36:21 -0700 (PDT)
Received: (nullmailer pid 1895586 invoked by uid 1000);
        Fri, 22 Apr 2022 13:36:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
In-Reply-To: <20220421175657.1259024-3-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com> <20220421175657.1259024-3-sean.anderson@seco.com>
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: sfp: Add clock properties
Date:   Fri, 22 Apr 2022 08:36:20 -0500
Message-Id: <1650634580.180348.1895585.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 13:56:51 -0400, Sean Anderson wrote:
> To program fuses, it is necessary to set the fuse programming time. This
> is determined based on the value of the platform clock. Add a clock
> property.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


efuse@1e80000: 'clock-names' is a required property
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb

efuse@1e80000: 'clocks' is a required property
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb


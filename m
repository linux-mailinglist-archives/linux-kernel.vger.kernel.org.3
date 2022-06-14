Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA054B82A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350666AbiFNR4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiFNR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:56:03 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B6286FA;
        Tue, 14 Jun 2022 10:56:02 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id s1so7168576ilj.0;
        Tue, 14 Jun 2022 10:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=SwWDE6cwQQmygMiXif7g/HNKoV630590Lu3na+H4tf8=;
        b=tOOrTUdfr/CyK2K1jLtyIM8+9borwZqL7JBbvd9z4DKFtEct0MXlFsMThuOZhJVZuZ
         74XyfS9KJpOy5B63BOowtsPYm0SwmdOjmvDxhlCrTnHMYNPL5x5RB0w4r2Hs0D6H1F+3
         2xbsjjG0Ug7sBJpTNaNN1+PSlhIXdENyRDQ2yd7wgTEHuD1cX6J7MKszX9VeSjQs9Lg9
         KykXj/MOxSiuRTZg+COuIaGKX84x3FjHEnV44cyv0rMmKaL9sZnmBO7hBCJUyYNQxtHL
         PAG/rspUqDbe0Rk1QBWo1Hgc82I2yFZ3Ro7XLEZ86oZm4Gf6EwnDNrhGyzbNGXmdximY
         gNDQ==
X-Gm-Message-State: AJIora8ogGpNyV8OvXIbLrX9AHd1ymUPXbLT/yRl/L2OG0ljb8GbPpPx
        pQTOI+VW1bT5+EbizV2SsA==
X-Google-Smtp-Source: AGRyM1s4AjNweeXDZMr26t3YCh80q9RGi6qfBYIzE3LD4gndL8OM1f++ViNKTeqwVNIKU6HjXmnQ/A==
X-Received: by 2002:a05:6e02:f44:b0:2d3:b54f:d83e with SMTP id y4-20020a056e020f4400b002d3b54fd83emr3699031ilj.9.1655229361518;
        Tue, 14 Jun 2022 10:56:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g18-20020a02c552000000b00332122c106dsm5150944jaj.152.2022.06.14.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:56:01 -0700 (PDT)
Received: (nullmailer pid 1889801 invoked by uid 1000);
        Tue, 14 Jun 2022 17:55:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     devicetree@vger.kernel.org, git@xilinx.com,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        sivadur@xilinx.com, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
In-Reply-To: <20220613144651.7300-1-piyush.mehta@xilinx.com>
References: <20220613144651.7300-1-piyush.mehta@xilinx.com>
Subject: Re: [PATCH V2] dt-bindings: ata: ahci-ceva: convert to yaml
Date:   Tue, 14 Jun 2022 11:55:59 -0600
Message-Id: <1655229359.837256.1889800.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 20:16:51 +0530, Piyush Mehta wrote:
> Convert the ahci-ceva doc to yaml.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Corrected the patch --prefix V3 to V2.
> - Added Required properties.
> ---
>  .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
>  .../devicetree/bindings/ata/ahci-ceva.yaml    | 197 ++++++++++++++++++
>  2 files changed, 197 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


ahci@fd0c0000: 'iommus' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb

ahci@fd0c0000: 'iommus', 'phy-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb


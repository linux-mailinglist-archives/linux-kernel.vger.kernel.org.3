Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618DB51BA4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbiEEIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiEEIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:30:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F217329AB;
        Thu,  5 May 2022 01:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 098AFB82C07;
        Thu,  5 May 2022 08:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692F9C385AF;
        Thu,  5 May 2022 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651739175;
        bh=11hrI6vhS7kRRgg7/k3uswpnwvA2t/fuUzKKIDKnTPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s65z05ICqWKP8COdFnw7XfRQ+t3AHgE09upqm0dwTN3UMc2C/J6QPoYjkL+WIHV+y
         dtbdHtBcbix9aNQbOzAN5qJYVA1sbakyQqnxwyf3O34X90ZN+BV6maQOycuYH1IL2k
         9+Vowl+zZy/evBVP9Cx39NJaVXO3/uhqIznvWeYaPzProkGxU73rN8TYjpNhE/X3Ei
         A/8jS5pZHJ/RqXhhSpVmDpuAlVf/oFLRQOqCBKAD6MejWxjhjpNQ2qqYFNENdkhsKz
         6sZrG1amspSyVD1B2ZWz7ixyJmoryvqILPuj1KFbl4ZBraVHIOOw6AZcX+NsL3UUaN
         gnMzqmUVnaPtA==
Date:   Thu, 5 May 2022 16:26:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/3] arm64: add i.MX93 support
Message-ID: <20220505082607.GE14615@dragon>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, May 03, 2022 at 08:29:48PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> 
> V2:
>  Update License
> 
> Add i.MX93 dtsi and 11x11 evk board support
> 
> The required bindings and drivers has already been in tree.
> There arem checkpatch error for the pin header files as other i.MX pin
> pin header files.
> 
> Peng Fan (3):
>   arm64: dts: freescale: Add i.MX93 dtsi support
>   arm64: dts: freescale: add i.MX93 11x11 EVK basic support
>   arm64: defconfig: enable i.MX93 clk & pinctrl

Could you check if we can eliminate some (if not all) of the dtbs_check
issues below?

Shawn


  DTC     arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb
  CHECK   arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: /: 'compatible' is a required property
	From schema: .local/lib/python3.8/site-packages/dtschema/schemas/root-node.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: /: 'model' is a required property
	From schema: .local/lib/python3.8/site-packages/dtschema/schemas/root-node.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@44380000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: repos/korg/imx/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@44000000/serial@44380000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@44390000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: repos/korg/imx/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@44000000/serial@44390000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: pinctrl@443c0000: 'pinctrl-0' is a dependency of 'pinctrl-names'
	From schema: .local/lib/python3.8/site-packages/dtschema/schemas/pinctrl/pinctrl-consumer.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@44000000/anatop@44480000: failed to match any schema with compatible: ['fsl,imx93-anatop', 'syscon']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42570000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@42000000/serial@42570000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42580000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@42000000/serial@42580000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42590000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@42000000/serial@42590000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@425a0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@42000000/serial@425a0000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@42690000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@42000000/serial@42690000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: serial@426a0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart'] is too long
	'fsl,imx93-lpuart' is not one of ['fsl,vf610-lpuart', 'fsl,ls1021a-lpuart', 'fsl,ls1028a-lpuart', 'fsl,imx7ulp-lpuart', 'fsl,imx8qxp-lpuart', 'fsl,imxrt1050-lpuart']
	'fsl,imx8ulp-lpuart' was expected
	'fsl,imx93-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
	'fsl,imx8qxp-lpuart' was expected
	From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb:0:0: /soc@0/bus@42000000/serial@426a0000: failed to match any schema with compatible: ['fsl,imx93-lpuart', 'fsl,imx7ulp-lpuart']
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43810000: interrupts: [[0, 57, 4], [0, 58, 4]] is too long
	From schema: Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43820000: interrupts: [[0, 59, 4], [0, 60, 4]] is too long
	From schema: Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@43830000: interrupts: [[0, 189, 4], [0, 190, 4]] is too long
	From schema: Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: gpio@47400000: interrupts: [[0, 10, 4], [0, 11, 4]] is too long
	From schema: Documentation/devicetree/bindings/gpio/gpio-vf610.yaml

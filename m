Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375A56A5BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiGGOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGGOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:44:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45431A80E;
        Thu,  7 Jul 2022 07:44:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 267Ei1PI062809;
        Thu, 7 Jul 2022 09:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657205041;
        bh=ABTgJp8tO2KpPdtj4JUN1lMd40vTDK073OIeD9rsd0w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=y8DjTDhUlMpIkN+GCnusjFwbQhN5dK9d5RFqEs0FzLvzGC1TpjtbWmvMJdPNODfXZ
         TFLoRI6PokmLxb+6TA43CBMD6c7MnYDq3qWsIFWmcNbCweZRLQE/XGJcAAUJtoJ7ja
         uPzg/v0Jag/vbmXsp67HwpKLKD8gCxImraJG+2BU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 267Ei1eh042654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 09:44:01 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 09:44:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 09:44:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 267Ei0xf028702;
        Thu, 7 Jul 2022 09:44:00 -0500
Date:   Thu, 7 Jul 2022 09:44:00 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65-main: Disable RNG node
Message-ID: <20220707144400.tk3wmpeijdhuxpzv@bryanbrattlof.com>
References: <20220706190838.26074-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220706190838.26074-1-afd@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On July  6, 2022 thus sayeth Andrew Davis:
> The hardware random number generator is used by OP-TEE and is access is
> denied to other users with SoC level bus firewalls. Any access to this
> device from Linux will result in firewall errors. Disable this node.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes from v1:
>  - Added comment in dtsi file
> 
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index e749343accedd..9de5a8294acd6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -127,6 +127,7 @@ rng: rng@4e10000 {
>  			reg = <0x0 0x4e10000 0x0 0x7d>;
>  			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&k3_clks 136 1>;
> +			status = "disabled"; /* Used by OP-TEE */

Just curious about how we should document disabling nodes. I was 
assuming the reasoning should be described in the bindings?

I would like to start disabling nodes by default in our dtsi files and 
enabling them in our top dts file, making it easier for others to use 
our device tree for a more focused purpose than our dev boards. I just 
didn't know where I should document why I disabled the nodes :)

~Bryan

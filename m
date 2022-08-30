Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73535A65EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiH3OHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiH3OHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:07:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADBF72D0;
        Tue, 30 Aug 2022 07:07:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UE74LJ033683;
        Tue, 30 Aug 2022 09:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661868424;
        bh=fMJU+CdfgTgvGibIly+sF9LbY8bZkcS5EvqunW4kU8s=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=aA63REEvErCg+vblsrEycBzLb5bMzOEblBasonhQ+kPaWRPirfqeWHqxHa+CtUNNg
         77MBMMMSUFVlI8Rh1R5Nr5JDcfhBXgt09YncBn9OoR0XCyEm1DumPbPZJwBTWzzTAc
         MKgSDBbOwvKT9sfHl6Y7MehSFGjRQpn+yVuoIKRU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UE7482108318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 09:07:04 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 09:07:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 09:07:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UE73KN076517;
        Tue, 30 Aug 2022 09:07:03 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am64-main: Enable crypto
 accelerator
In-Reply-To: <20220711085743.10128-3-j-choudhary@ti.com>
References: <20220711085743.10128-1-j-choudhary@ti.com>
 <20220711085743.10128-3-j-choudhary@ti.com>
Date:   Tue, 30 Aug 2022 19:37:02 +0530
Message-ID: <87wnapsu49.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jayesh Choudhary <j-choudhary@ti.com> writes:

> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> Add the node for SA2UL.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> [s-anna@ti.com: drop label, minor cleanups]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [j-choudhary@ti.com: disable rng-node, change flag to shared]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index ada00575f0f2..06fada0d82b1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1308,4 +1308,24 @@
>  		interrupt-names = "int0", "int1";
>  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>  	};
> +
> +	crypto: crypto@40900000 {
> +		compatible = "ti,am64-sa2ul";
> +		reg = <0x00 0x40900000 0x00 0x1200>;
> +		power-domains = <&k3_pds 133 TI_SCI_PD_SHARED>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> +		dmas = <&main_pktdma 0xc001 0>, <&main_pktdma 0x4002 0>,
> +		       <&main_pktdma 0x4003 0>;
> +		dma-names = "tx", "rx1", "rx2";
> +
> +		rng: rng@40910000 {
> +			compatible = "inside-secure,safexcel-eip76";
> +			reg = <0x00 0x40910000 0x00 0x7d>;
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&k3_clks 133 0>;
> +			status = "disabled"; /* Used by OP-TEE */
> +		};
> +	};
>  };

Both patches look good to me.

Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>

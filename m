Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAA5502D69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355696AbiDOQFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355239AbiDOQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:05:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A29D0F1;
        Fri, 15 Apr 2022 09:03:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id F26961F481A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650038601;
        bh=TK4L1RQq13E/GZlJ/Wh/rvinGwy2B3DcB8KhtlOOT6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/4QrexfPaGQ8b07q0ZSgcRXvYeIkYLZoSwNOIZxsjI5Rijc86hx7BhFJhWVERae9
         GPjnlcBOlm5VdmyC0TLuOSw96VI2XRy4fHsy3+6CBVKifWarDzb1wdNsizbt4r+agS
         OOWmb69cWxD+5NuB021KwD+hFLwlwnqHHWKfG3eb3+BY/+G057ej2P7geBcVWse2w8
         3vzY6oq0TJgPU/JwluNyZVqHIJrNeoliFc6R3bJc7mpo9Rc8QpMHxQxwF28xsfTf0B
         B6PItKjk18ro3nA0tPhiF1eIJEMS0X8RaFI4zN6S3pTIEK5NY0ODfL7feDREw9jAyc
         rk+eXeYYt4wsg==
Date:   Fri, 15 Apr 2022 12:03:14 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Hui-Liu Liu <hui.liu@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, eddie.huang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        fshao@chromium.org, srv_heupstream@mediatek.com,
        zhiyong.tao@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        yuchen.huang@mediatek.com, wen.su@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/1] arm64: dts: mt6359: add PMIC MT6359 nodes
Message-ID: <20220415160314.fxdvwl2jx7u7vhgj@notapiano>
References: <20220328103729.25102-1-hui.liu@mediatek.com>
 <20220328103729.25102-2-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220328103729.25102-2-hui.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 06:37:29PM +0800, Hui-Liu Liu wrote:
> From: Hui Liu <hui.liu@mediatek.com>
> 
> MT6359 is the primary PMIC for MT8192.
> Add PMIC MT6359 related node which is used for MT8192 platform.
> 
> Signed-off-by: Hui Liu <hui.liu@mediatek.com>

Hi Hui,

as the pwrap node on mt8192.dtsi has now been merged [1], please add an include
for this mt6359.dtsi in mt8192-evb.dtsi in the next version of this patch.

Thanks,
Nícolas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.18-next/dts64&id=261691b40128e6b76bb94d562457d8a5236cc7fa

> ---
>  arch/arm64/boot/dts/mediatek/mt6359.dtsi | 298 +++++++++++++++++++++++
>  1 file changed, 298 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
> new file mode 100644
> index 000000000000..df3e822232d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +
> +&pwrap {
> +	pmic: pmic {
> +		compatible = "mediatek,mt6359";
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		mt6359codec: mt6359codec {
> +		};
> +
> +		regulators {
> +			mt6359_vs1_buck_reg: buck_vs1 {
> +				regulator-name = "vs1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <2200000>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +			mt6359_vgpu11_buck_reg: buck_vgpu11 {
> +				regulator-name = "vgpu11";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-ramp-delay = <5000>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +			mt6359_vmodem_buck_reg: buck_vmodem {
> +				regulator-name = "vmodem";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-ramp-delay = <10760>;
> +				regulator-enable-ramp-delay = <200>;
> +			};
> +			mt6359_vpu_buck_reg: buck_vpu {
> +				regulator-name = "vpu";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-ramp-delay = <5000>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +			mt6359_vcore_buck_reg: buck_vcore {
> +				regulator-name = "vcore";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-ramp-delay = <5000>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +			mt6359_vs2_buck_reg: buck_vs2 {
> +				regulator-name = "vs2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1600000>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +			mt6359_vpa_buck_reg: buck_vpa {
> +				regulator-name = "vpa";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3650000>;
> +				regulator-enable-ramp-delay = <300>;
> +			};
> +			mt6359_vproc2_buck_reg: buck_vproc2 {
> +				regulator-name = "vproc2";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-ramp-delay = <7500>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +			mt6359_vproc1_buck_reg: buck_vproc1 {
> +				regulator-name = "vproc1";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-ramp-delay = <7500>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +			mt6359_vcore_sshub_buck_reg: buck_vcore_sshub {
> +				regulator-name = "vcore_sshub";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1193750>;
> +			};
> +			mt6359_vgpu11_sshub_buck_reg: buck_vgpu11_sshub {
> +				regulator-name = "vgpu11_sshub";
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1193750>;
> +			};
> +			mt6359_vaud18_ldo_reg: ldo_vaud18 {
> +				regulator-name = "vaud18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <240>;
> +			};
> +			mt6359_vsim1_ldo_reg: ldo_vsim1 {
> +				regulator-name = "vsim1";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3100000>;
> +			};
> +			mt6359_vibr_ldo_reg: ldo_vibr {
> +				regulator-name = "vibr";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +			mt6359_vrf12_ldo_reg: ldo_vrf12 {
> +				regulator-name = "vrf12";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1300000>;
> +			};
> +			mt6359_vusb_ldo_reg: ldo_vusb {
> +				regulator-name = "vusb";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-enable-ramp-delay = <960>;
> +				regulator-always-on;
> +			};
> +			mt6359_vsram_proc2_ldo_reg: ldo_vsram_proc2 {
> +				regulator-name = "vsram_proc2";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <7500>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +			mt6359_vio18_ldo_reg: ldo_vio18 {
> +				regulator-name = "vio18";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1900000>;
> +				regulator-enable-ramp-delay = <960>;
> +				regulator-always-on;
> +			};
> +			mt6359_vcamio_ldo_reg: ldo_vcamio {
> +				regulator-name = "vcamio";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1900000>;
> +			};
> +			mt6359_vcn18_ldo_reg: ldo_vcn18 {
> +				regulator-name = "vcn18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <240>;
> +			};
> +			mt6359_vfe28_ldo_reg: ldo_vfe28 {
> +				regulator-name = "vfe28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <120>;
> +			};
> +			mt6359_vcn13_ldo_reg: ldo_vcn13 {
> +				regulator-name = "vcn13";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1300000>;
> +			};
> +			mt6359_vcn33_1_bt_ldo_reg: ldo_vcn33_1_bt {
> +				regulator-name = "vcn33_1_bt";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3500000>;
> +			};
> +			mt6359_vcn33_1_wifi_ldo_reg: ldo_vcn33_1_wifi {
> +				regulator-name = "vcn33_1_wifi";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3500000>;
> +			};
> +			mt6359_vaux18_ldo_reg: ldo_vaux18 {
> +				regulator-name = "vaux18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +			mt6359_vsram_others_ldo_reg: ldo_vsram_others {
> +				regulator-name = "vsram_others";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <5000>;
> +				regulator-enable-ramp-delay = <240>;
> +			};
> +			mt6359_vefuse_ldo_reg: ldo_vefuse {
> +				regulator-name = "vefuse";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <2000000>;
> +			};
> +			mt6359_vxo22_ldo_reg: ldo_vxo22 {
> +				regulator-name = "vxo22";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2200000>;
> +				regulator-always-on;
> +			};
> +			mt6359_vrfck_ldo_reg: ldo_vrfck {
> +				regulator-name = "vrfck";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1700000>;
> +			};
> +			mt6359_vrfck_1_ldo_reg: ldo_vrfck_1 {
> +				regulator-name = "vrfck";
> +				regulator-min-microvolt = <1240000>;
> +				regulator-max-microvolt = <1600000>;
> +			};
> +			mt6359_vbif28_ldo_reg: ldo_vbif28 {
> +				regulator-name = "vbif28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-enable-ramp-delay = <240>;
> +			};
> +			mt6359_vio28_ldo_reg: ldo_vio28 {
> +				regulator-name = "vio28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +			mt6359_vemc_ldo_reg: ldo_vemc {
> +				regulator-name = "vemc";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +			mt6359_vemc_1_ldo_reg: ldo_vemc_1 {
> +				regulator-name = "vemc";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +			mt6359_vcn33_2_bt_ldo_reg: ldo_vcn33_2_bt {
> +				regulator-name = "vcn33_2_bt";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3500000>;
> +			};
> +			mt6359_vcn33_2_wifi_ldo_reg: ldo_vcn33_2_wifi {
> +				regulator-name = "vcn33_2_wifi";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3500000>;
> +			};
> +			mt6359_va12_ldo_reg: ldo_va12 {
> +				regulator-name = "va12";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +			};
> +			mt6359_va09_ldo_reg: ldo_va09 {
> +				regulator-name = "va09";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1200000>;
> +			};
> +			mt6359_vrf18_ldo_reg: ldo_vrf18 {
> +				regulator-name = "vrf18";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1810000>;
> +			};
> +			mt6359_vsram_md_ldo_reg: ldo_vsram_md {
> +				regulator-name = "vsram_md";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <10760>;
> +				regulator-enable-ramp-delay = <240>;
> +			};
> +			mt6359_vufs_ldo_reg: ldo_vufs {
> +				regulator-name = "vufs";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1900000>;
> +			};
> +			mt6359_vm18_ldo_reg: ldo_vm18 {
> +				regulator-name = "vm18";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1900000>;
> +				regulator-always-on;
> +			};
> +			mt6359_vbbck_ldo_reg: ldo_vbbck {
> +				regulator-name = "vbbck";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1200000>;
> +			};
> +			mt6359_vsram_proc1_ldo_reg: ldo_vsram_proc1 {
> +				regulator-name = "vsram_proc1";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +				regulator-ramp-delay = <7500>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +			mt6359_vsim2_ldo_reg: ldo_vsim2 {
> +				regulator-name = "vsim2";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3100000>;
> +			};
> +			mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
> +				regulator-name = "vsram_others_sshub";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1293750>;
> +			};
> +		};
> +
> +		mt6359rtc: mt6359rtc {
> +			compatible = "mediatek,mt6358-rtc";
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 
> 

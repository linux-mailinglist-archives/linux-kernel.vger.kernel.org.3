Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD3520F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiEJIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiEJIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:00:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64301E21A0;
        Tue, 10 May 2022 00:56:43 -0700 (PDT)
X-UUID: 6a2d6fb6ce50449fbbb8d80d84b9d196-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:c3acdfbc-3544-456e-91ba-762b048185d4,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:47
X-CID-INFO: VERSION:1.1.4,REQID:c3acdfbc-3544-456e-91ba-762b048185d4,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:47
X-CID-META: VersionHash:faefae9,CLOUDID:6c2c3fb3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:3223872f77b2,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,
        File:nil,QS:0,BEC:nil
X-UUID: 6a2d6fb6ce50449fbbb8d80d84b9d196-20220510
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1119141881; Tue, 10 May 2022 15:56:41 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 15:56:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 May 2022 15:56:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 10 May 2022 15:56:39 +0800
Message-ID: <6614cd3783666caa529106464e7684caf16d6582.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pmic: mt6366: add binding document
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <eddie.huang@mediatek.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <hsin-hsiung.wang@mediatek.com>,
        <sean.wang@mediatek.com>, <macpaul.lin@mediatek.com>,
        <wen.su@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 10 May 2022 15:56:38 +0800
In-Reply-To: <20220510064603.15920-2-zhiyong.tao@mediatek.com>
References: <20220510064603.15920-1-zhiyong.tao@mediatek.com>
         <20220510064603.15920-2-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 14:46 +0800, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 

I think "From: ..." can be removed?

> The commit adds mt6366 binding document.
> 
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>  .../bindings/regulator/mt6366-regulator.yaml  | 405
> ++++++++++++++++++
>  1 file changed, 405 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/regulator/mt6366-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6366-
> regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6366-
> regulator.yaml
> new file mode 100644
> index 000000000000..1f125f5ba860
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6366-
> regulator.yaml
> @@ -0,0 +1,405 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mt6366-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6366 Regulator from MediaTek Integrated
> +
> +maintainers:
> +  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> +

Hsing-Hsing is not responsible for regulator, so I think you can add
you as the maintainers.

> +description: |
> +  List of regulators provided by this controller. It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  MT6366 regulators node should be sub node of the MT6397 MFD node.
> +
> +patternProperties:
> +  "^buck_v(dram1|core|pa|proc11|proc12|gpu|s2|modem|s1)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(dram1|core|pa|proc11|proc12|gpu|s2|modem|s1)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_v(ibr|rf12|usb|camio|efuse|xo22)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(ibr|rf12|usb|camio|efuse|xo22)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_v(rfck|emc|a12|a09|ufs|bbck)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(rfck|emc|a12|a09|ufs|bbck)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_vsram_(proc2|others|md|proc1|others_sshub)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^vsram_(proc2|others|md|proc1|others_sshub)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_v(fe|bif|io)28$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(fe|bif|io)28$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_v(aud|io|aux|rf|m)18$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(aud|io|aux|rf|m)18$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_vsim[12]$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^vsim[12]$"
> +
> +    required:
> +      - regulator-name
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      regulators {
> +        mt6366_vdram1_reg: buck_vdram1 {
> +            regulator-name = "vdram1";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <2087500>;
> +            regulator-ramp-delay = <12500>;
> +            regulator-enable-ramp-delay = <0>;
> +            regulator-always-on;
> +            regulator-allowed-modes = <0 1>;

should be two space instead of 4 space?
mt6366_vdram1_reg: buck_vdram1 {
  regulator-name = "vdram1";
  ...
};

There is the same issue for this example.

> +        };
> +        mt6366_vcore_reg: buck_vcore {
> +            regulator-name = "vcore";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <200>;
> +            regulator-always-on;
> +            regulator-allowed-modes = <0 1>;
> +        };
> +       mt6366_vproc11_reg: buck_vproc11 {

one more space before mt6366_vproc11_reg?

> +            regulator-name = "vproc11";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <200>;
> +            regulator-always-on;
> +            regulator-allowed-modes = <0 1>;
> +        };
> +        mt6366_vproc12_reg: buck_vproc12 {
> +            regulator-name = "vproc12";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <200>;
> +            regulator-always-on;
> +            regulator-allowed-modes = <0 1>;
> +        };
> +        mt6366_vgpu_reg: buck_vgpu {
> +            regulator-name = "vgpu";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <200>;
> +            regulator-allowed-modes = <0 1>;
> +        };
> +        mt6366_vs2_reg: buck_vs2 {
> +            regulator-name = "vs2";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <2087500>;
> +            regulator-ramp-delay = <12500>;
> +            regulator-enable-ramp-delay = <0>;
> +            regulator-always-on;
> +        };
> +       mt6366_vmodem_reg: buck_vmodem {

ditto.

> +            regulator-name = "vmodem";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <900>;
> +            regulator-always-on;
> +            regulator-allowed-modes = <0 1>;
> +        };
> +        mt6366_vs1_reg: buck_vs1 {
> +            regulator-name = "vs1";
> +            regulator-min-microvolt = <1000000>;
> +            regulator-max-microvolt = <2587500>;
> +            regulator-ramp-delay = <12500>;
> +            regulator-enable-ramp-delay = <0>;
> +            regulator-always-on;
> +        };
> +        mt6366_vdram2_reg: ldo_vdram2 {
> +            regulator-name = "vdram2";
> +            regulator-min-microvolt = <600000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <3300>;
> +            regulator-always-on;
> +        };
> +        mt6366_vsim1_reg: ldo_vsim1 {
> +            regulator-name = "vsim1";
> +            regulator-min-microvolt = <1700000>;
> +            regulator-max-microvolt = <3100000>;
> +            regulator-enable-ramp-delay = <540>;
> +        };
> +        mt6366_vibr_reg: ldo_vibr {
> +            regulator-name = "vibr";
> +            regulator-min-microvolt = <1200000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-enable-ramp-delay = <60>;
> +        };
> +        mt6366_vrf12_reg: ldo_vrf12 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vrf12";
> +            regulator-min-microvolt = <1200000>;
> +            regulator-max-microvolt = <1200000>;
> +            regulator-enable-ramp-delay = <120>;
> +        };
> +        mt6366_vio18_reg: ldo_vio18 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vio18";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <2700>;
> +            regulator-always-on;
> +        };
> +        mt6366_vusb_reg: ldo_vusb {
> +            regulator-name = "vusb";
> +            regulator-min-microvolt = <3000000>;
> +            regulator-max-microvolt = <3100000>;
> +            regulator-enable-ramp-delay = <270>;
> +            regulator-always-on;
> +        };
> +        mt6366_vcamio_reg: ldo_vcamio {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vcamio";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <325>;
> +        };
> +        mt6366_vcamd_reg: ldo_vcamd {
> +            regulator-name = "vcamd";
> +            regulator-min-microvolt = <900000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <325>;
> +        };
> +        mt6366_vcn18_reg: ldo_vcn18 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vcn18";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vfe28_reg: ldo_vfe28 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vfe28";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <2800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vsram_proc11_reg: ldo_vsram_proc11 {
> +            regulator-name = "vsram_proc11";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <240>;
> +            regulator-always-on;
> +        };
> +        mt6366_vcn28_reg: ldo_vcn28 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vcn28";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <2800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vsram_others_reg: ldo_vsram_others {
> +            regulator-name = "vsram_others";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <240>;
> +            regulator-always-on;
> +        };
> +        mt6366_vsram_gpu_reg: ldo_vsram_gpu {
> +            regulator-name = "vsram_gpu";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <240>;
> +        };
> +        mt6366_vxo22_reg: ldo_vxo22 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vxo22";
> +            regulator-min-microvolt = <2200000>;
> +            regulator-max-microvolt = <2200000>;
> +            regulator-enable-ramp-delay = <120>;
> +            regulator-always-on;
> +        };
> +        mt6366_vefuse_reg: ldo_vefuse {
> +            regulator-name = "vefuse";
> +            regulator-min-microvolt = <1700000>;
> +            regulator-max-microvolt = <1900000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vaux18_reg: ldo_vaux18 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vaux18";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vmch_reg: ldo_vmch {
> +            regulator-name = "vmch";
> +            regulator-min-microvolt = <2900000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-enable-ramp-delay = <60>;
> +        };
> +        mt6366_vbif28_reg: ldo_vbif28 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vbif28";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <2800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vsram_proc12_reg: ldo_vsram_proc12 {
> +            regulator-name = "vsram_proc12";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <240>;
> +            regulator-always-on;
> +        };
> +        mt6366_vcama1_reg: ldo_vcama1 {
> +            regulator-name = "vcama1";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3000000>;
> +            regulator-enable-ramp-delay = <325>;
> +        };
> +        mt6366_vemc_reg: ldo_vemc {
> +            regulator-name = "vemc";
> +            regulator-min-microvolt = <2900000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-enable-ramp-delay = <60>;
> +        };
> +        mt6366_vio28_reg: ldo_vio28 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vio28";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <2800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_va12_reg: ldo_va12 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "va12";
> +            regulator-min-microvolt = <1200000>;
> +            regulator-max-microvolt = <1200000>;
> +            regulator-enable-ramp-delay = <270>;
> +            regulator-always-on;
> +        };
> +        mt6366_vrf18_reg: ldo_vrf18 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vrf18";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-enable-ramp-delay = <120>;
> +        };
> +        mt6366_vcn33_bt_reg: ldo_vcn33_bt {
> +            regulator-name = "vcn33_bt";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3500000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vcn33_wifi_reg: ldo_vcn33_wifi {
> +            regulator-name = "vcn33_wifi";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3500000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vcama2_reg: ldo_vcama2 {
> +            regulator-name = "vcama2";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3000000>;
> +            regulator-enable-ramp-delay = <325>;
> +        };
> +        mt6366_vmc_reg: ldo_vmc {
> +            regulator-name = "vmc";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-enable-ramp-delay = <60>;
> +        };
> +        mt6366_vldo28_reg: ldo_vldo28 {
> +            regulator-name = "vldo28";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <3000000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vaud28_reg: ldo_vaud28 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "vaud28";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <2800000>;
> +            regulator-enable-ramp-delay = <270>;
> +        };
> +        mt6366_vsim2_reg: ldo_vsim2 {
> +            regulator-name = "vsim2";
> +            regulator-min-microvolt = <1700000>;
> +            regulator-max-microvolt = <3100000>;
> +            regulator-enable-ramp-delay = <540>;
> +        };
> +        mt6366_vcore_sshub_reg: buck_vcore_sshub {
> +            regulator-name = "vcore_sshub";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +        };
> +        mt6366_vsram_others_sshub_reg: ldo_vsram_others_sshub {
> +            regulator-name = "vsram_others_sshub";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <1293750>;
> +        };
> +      };
> +    };
> +...


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA5550F3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbiDZI15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344758AbiDZI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:26:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9F3DDF9;
        Tue, 26 Apr 2022 01:23:18 -0700 (PDT)
X-UUID: ca5bc5c1788243d9bdf00873341344a6-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:deaf5418-98ed-4509-9059-884e43cd696f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:c5bdbb2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ca5bc5c1788243d9bdf00873341344a6-20220426
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906228943; Tue, 26 Apr 2022 16:23:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Apr 2022 16:23:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 16:23:10 +0800
Message-ID: <9547368870f6a8d5c5e6bd5dd497ddbe04c51b93.camel@mediatek.com>
Subject: Re: [PATCH V3 12/17] dt-binding: mt8192: Add infra_ao reset bit
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 26 Apr 2022 16:23:10 +0800
In-Reply-To: <418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
         <20220422060152.13534-13-rex-bc.chen@mediatek.com>
         <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
         <5ec37a01b0b84140a7d171b9a5cff7ad8f9fbe87.camel@mediatek.com>
         <418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 15:52 +0800, Krzysztof Kozlowski wrote:
> On 25/04/2022 07:01, Rex-BC Chen wrote:
> > On Sat, 2022-04-23 at 18:28 +0800, Krzysztof Kozlowski wrote:
> > > On 22/04/2022 08:01, Rex-BC Chen wrote:
> > > > To support reset of infra_ao, add the bit definition for
> > > > thermal/PCIe/SVS.
> > > > 
> > > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > > ---
> > > >  include/dt-bindings/reset/mt8192-resets.h | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/include/dt-bindings/reset/mt8192-resets.h
> > > > b/include/dt-bindings/reset/mt8192-resets.h
> > > > index be9a7ca245b9..d5f3433175c1 100644
> > > > --- a/include/dt-bindings/reset/mt8192-resets.h
> > > > +++ b/include/dt-bindings/reset/mt8192-resets.h
> > > > @@ -27,4 +27,14 @@
> > > >  
> > > >  #define MT8192_TOPRGU_SW_RST_NUM				
> > > > 23
> > > >  
> > > > +/* INFRA RST0 */
> > > > +#define MT8192_INFRA_RST0_LVTS_AP_RST				
> > > > 0
> > > > +/* INFRA RST2 */
> > > > +#define MT8192_INFRA_RST2_PCIE_PHY_RST				
> > > > 15
> > > > +/* INFRA RST3 */
> > > > +#define MT8192_INFRA_RST3_PTP_RST				
> > > > 5
> > > > +/* INFRA RST4 */
> > > > +#define MT8192_INFRA_RST4_LVTS_MCU				
> > > > 12
> > > > +#define MT8192_INFRA_RST4_PCIE_TOP				
> > > > 1
> > > 
> > > These should be the IDs of reset, not some register
> > > values/offsets.
> > > Therefore it is expected to have them incremented by 1.
> > > 
> > > 
> > 
> > Hello Krzysztof,
> > 
> > This is define bit.
> > 
> > There is serveral reset set for infra_ao while it's not serial.
> > For MT8192, it's 0x120/0x130/0x140/0x150/0x730.
> > We are implement #reset-cells = <2>, and we can use this reset
> > drive
> > more easier.
> > 
> > For example, in dts, we can define
> > infra_ao: syscon {
> > 	compatible = "mediatek,mt8192-infracfg", "syscon";
> >  	reg = <0 0x10001000 0 0x1000>;
> >  	#clock-cells = <1>;
> > 	#reset-cells = <2>;
> > };
> > 
> > thermal {
> > 	...
> > 	resets = <&infra_ao 0x730 MT8192_INFRA_RST4_LVTS_MCU>;
> > 	...
> > };
> > 
> > If it's acceptabel, I can update all bit difinition from 0 to 15
> > for
> > all reset set.
> 
> Bits are not acceptable, because you embed specific device
> programming
> model (register bits) into the binding.
> 
> These should be IDs, so decimal numbers incremented from 0, so:
> #define MT8192_INFRA_RST0_LVTS_AP_RST				0
> #define MT8192_INFRA_RST4_LVTS_MCU				1
> #define MT8192_INFRA_RST4_PCIE_TOP				2
> 
> And what is 0x730 in your example? It does not look like ID of a
> reset...
> 
> Entire changeset look wrong from DT point of view.
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Got it. I will modify them to reset index.
And the dts in my next version would somthing like this:

----
#define MT8192_INFRA_THERMAL_CTRL_RST			0
#define MT8192_INFRA_PEXTP_PHY_RST			79
#define MT8192_INFRA_PTP_RST				101
#define MT8192_INFRA_RST4_PCIE_TOP			129
#define MT8192_INFRA_THERMAL_CTRL_MCU_RST		140
----

infra_ao: syscon {
	compatible = "mediatek,mt8192-infracfg", "syscon";
	reg = <0 0x10001000 0 0x1000>;
	#clock-cells = <1>;
	#reset-cells = <1>;
};

thermal {
	...
	resets = <&infra_ao MT8192_INFRA_THERMAL_CTRL_MCU_RST>;
	...
};

BRs,
Rex


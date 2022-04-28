Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E979512D22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiD1HkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbiD1HkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:40:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE079D06B;
        Thu, 28 Apr 2022 00:36:45 -0700 (PDT)
X-UUID: 1300981bc8cb41678a376a278a13a03b-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e0690bd6-be61-466d-a8a8-bfc9ca3048ac,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:e0690bd6-be61-466d-a8a8-bfc9ca3048ac,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:cf1a032f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 1300981bc8cb41678a376a278a13a03b-20220428
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 258828951; Thu, 28 Apr 2022 15:36:38 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 28 Apr 2022 15:36:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 15:36:14 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 15:36:14 +0800
Message-ID: <eeef5e391b76e62e36892a82a5d7189569cd3ce0.camel@mediatek.com>
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
Date:   Thu, 28 Apr 2022 15:36:14 +0800
In-Reply-To: <93c0c4d7-1e3a-56d6-de22-aa2c948403e2@linaro.org>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
         <20220422060152.13534-13-rex-bc.chen@mediatek.com>
         <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
         <5ec37a01b0b84140a7d171b9a5cff7ad8f9fbe87.camel@mediatek.com>
         <418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org>
         <9547368870f6a8d5c5e6bd5dd497ddbe04c51b93.camel@mediatek.com>
         <49dd007b-f6f6-0278-8f06-f81cf951fcd3@linaro.org>
         <9b42b402be2b0ed065d176238ac2c41f2ec677ef.camel@mediatek.com>
         <93c0c4d7-1e3a-56d6-de22-aa2c948403e2@linaro.org>
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

On Thu, 2022-04-28 at 15:23 +0800, Krzysztof Kozlowski wrote:
> On 28/04/2022 08:48, Rex-BC Chen wrote:
> > On Thu, 2022-04-28 at 14:40 +0800, Krzysztof Kozlowski wrote:
> > > On 26/04/2022 10:23, Rex-BC Chen wrote:
> > > > On Mon, 2022-04-25 at 15:52 +0800, Krzysztof Kozlowski wrote:
> > > > > On 25/04/2022 07:01, Rex-BC Chen wrote:
> > > > > > On Sat, 2022-04-23 at 18:28 +0800, Krzysztof Kozlowski
> > > > > > wrote:
> > > > > > > On 22/04/2022 08:01, Rex-BC Chen wrote:
> > > > > > > > To support reset of infra_ao, add the bit definition
> > > > > > > > for
> > > > > > > > thermal/PCIe/SVS.
> > > > > > > > 
> > > > > > > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > > > > > > ---
> > > > > > > >  include/dt-bindings/reset/mt8192-resets.h | 10
> > > > > > > > ++++++++++
> > > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/include/dt-bindings/reset/mt8192-resets.h
> > > > > > > > b/include/dt-bindings/reset/mt8192-resets.h
> > > > > > > > index be9a7ca245b9..d5f3433175c1 100644
> > > > > > > > --- a/include/dt-bindings/reset/mt8192-resets.h
> > > > > > > > +++ b/include/dt-bindings/reset/mt8192-resets.h
> > > > > > > > @@ -27,4 +27,14 @@
> > > > > > > >  
> > > > > > > >  #define MT8192_TOPRGU_SW_RST_NUM			
> > > > > > > > 	
> > > > > > > > 23
> > > > > > > >  
> > > > > > > > +/* INFRA RST0 */
> > > > > > > > +#define MT8192_INFRA_RST0_LVTS_AP_RST			
> > > > > > > > 	
> > > > > > > > 0
> > > > > > > > +/* INFRA RST2 */
> > > > > > > > +#define MT8192_INFRA_RST2_PCIE_PHY_RST			
> > > > > > > > 	
> > > > > > > > 15
> > > > > > > > +/* INFRA RST3 */
> > > > > > > > +#define MT8192_INFRA_RST3_PTP_RST			
> > > > > > > > 	
> > > > > > > > 5
> > > > > > > > +/* INFRA RST4 */
> > > > > > > > +#define MT8192_INFRA_RST4_LVTS_MCU			
> > > > > > > > 	
> > > > > > > > 12
> > > > > > > > +#define MT8192_INFRA_RST4_PCIE_TOP			
> > > > > > > > 	
> > > > > > > > 1
> > > > > > > 
> > > > > > > These should be the IDs of reset, not some register
> > > > > > > values/offsets.
> > > > > > > Therefore it is expected to have them incremented by 1.
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Hello Krzysztof,
> > > > > > 
> > > > > > This is define bit.
> > > > > > 
> > > > > > There is serveral reset set for infra_ao while it's not
> > > > > > serial.
> > > > > > For MT8192, it's 0x120/0x130/0x140/0x150/0x730.
> > > > > > We are implement #reset-cells = <2>, and we can use this
> > > > > > reset
> > > > > > drive
> > > > > > more easier.
> > > > > > 
> > > > > > For example, in dts, we can define
> > > > > > infra_ao: syscon {
> > > > > > 	compatible = "mediatek,mt8192-infracfg", "syscon";
> > > > > >  	reg = <0 0x10001000 0 0x1000>;
> > > > > >  	#clock-cells = <1>;
> > > > > > 	#reset-cells = <2>;
> > > > > > };
> > > > > > 
> > > > > > thermal {
> > > > > > 	...
> > > > > > 	resets = <&infra_ao 0x730 MT8192_INFRA_RST4_LVTS_MCU>;
> > > > > > 	...
> > > > > > };
> > > > > > 
> > > > > > If it's acceptabel, I can update all bit difinition from 0
> > > > > > to
> > > > > > 15
> > > > > > for
> > > > > > all reset set.
> > > > > 
> > > > > Bits are not acceptable, because you embed specific device
> > > > > programming
> > > > > model (register bits) into the binding.
> > > > > 
> > > > > These should be IDs, so decimal numbers incremented from 0,
> > > > > so:
> > > > > #define MT8192_INFRA_RST0_LVTS_AP_RST				
> > > > > 0
> > > > > #define MT8192_INFRA_RST4_LVTS_MCU				
> > > > > 1
> > > > > #define MT8192_INFRA_RST4_PCIE_TOP				
> > > > > 2
> > > > > 
> > > > > And what is 0x730 in your example? It does not look like ID
> > > > > of a
> > > > > reset...
> > > > > 
> > > > > Entire changeset look wrong from DT point of view.
> > > > > 
> > > > > Best regards,
> > > > > Krzysztof
> > > > 
> > > > Hello Krzysztof,
> > > > 
> > > > Got it. I will modify them to reset index.
> > > > And the dts in my next version would somthing like this:
> > > > 
> > > > ----
> > > > #define MT8192_INFRA_THERMAL_CTRL_RST			0
> > > > #define MT8192_INFRA_PEXTP_PHY_RST			79
> > > > #define MT8192_INFRA_PTP_RST				101
> > > > #define MT8192_INFRA_RST4_PCIE_TOP			129
> > > > #define MT8192_INFRA_THERMAL_CTRL_MCU_RST		140
> > > 
> > > These are still not IDs, incremented by one.
> > > 
> > > So again from beginning:
> > > 0
> > > 1
> > > 2
> > > ...
> > > 
> > > Do not encode hardware register bits into the binding.
> > > 
> > > Best regards,
> > > Krzysztof
> > 
> > Hello Krzysztof,
> > 
> > It's not bit definiton, and it's index for our reset.
> > We have 32*5 reset bits for infra.
> > But we only use these 5 index currently, I do not list all of them.
> 
> You do not have to list all of them. You can list three, e.g.:
> 
> #define MT8192_INFRA_THERMAL_CTRL_RST			0
> #define MT8192_INFRA_PEXTP_PHY_RST			1
> #define MT8192_INFRA_PTP_RST				2
> 
> and you will add all further later. This is how all dt-binding
> headers
> are created.
> 
> > 
> > The implementation is in [1].
> > -----
> > static int mtk_reset_update_set_clr(struct reset_controller_dev
> > *rcdev,
> >  	unsigned int deassert_ofs = deassert ? 0x4 : 0;
> >  
> >  	return regmap_write(data->regmap,
> > 			    data->desc->rst_bank_ofs[id /          
> >  					RST_NR_PER_BANK] +
> > 			    deassert_ofs,
> > 			    BIT(id % RST_NR_PER_BANK));
> >  }
> 
> Exactly, you hard-code the hardware programming model - register
> values/bits/whatever - in the ID, which is not correct. Additionally,
> bindings are (mostly) independent of Linux implementation.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

The rest bits could be used in the future.
I am not sure who will use them.
I will list all 5*32 index in next version.

BRs,
Rex


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE450AEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443849AbiDVEDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443764AbiDVEDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:03:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845A6359;
        Thu, 21 Apr 2022 21:00:22 -0700 (PDT)
X-UUID: 59637d826a8e456097885ce81c9e3856-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3ae5548f-302a-4774-863a-7492d695ffd8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:6,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:6
X-CID-META: VersionHash:faefae9,CLOUDID:b1bdb8ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 59637d826a8e456097885ce81c9e3856-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 38023904; Fri, 22 Apr 2022 12:00:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 12:00:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 12:00:15 +0800
Message-ID: <6238e4bb6854fea0b075a99662a961a2d2d88cde.camel@mediatek.com>
Subject: Re: [PATCH V2 11/12] clk: mediatek: reset: Add infra_ao reset
 support for MT8192
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Allen-KH Cheng =?UTF-8?Q?=28=E7=A8=8B=E5=86=A0=E5=8B=B3=29?= 
        <Allen-KH.Cheng@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 22 Apr 2022 12:00:15 +0800
In-Reply-To: <CAGXv+5HMe7LaXiMJofW4ZT0Ku70mNAt2A=98YzZbx-frF7kQGQ@mail.gmail.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-12-rex-bc.chen@mediatek.com>
         <CAGXv+5HMe7LaXiMJofW4ZT0Ku70mNAt2A=98YzZbx-frF7kQGQ@mail.gmail.com>
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

Hello Chen-Yu,

On Thu, 2022-04-21 at 14:53 +0800, Chen-Yu Tsai wrote:
> On Wed, Apr 20, 2022 at 9:05 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > wrote:
> > 
> > The infra_ao reset is needed for MT8192. Therefore, we add this
> > patch
> > to support it.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mt8192.c         | 11 +++++++++++
> >  include/dt-bindings/reset/mt8192-resets.h | 11 +++++++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt8192.c
> > b/drivers/clk/mediatek/clk-mt8192.c
> > index ab27cd66b866..7926b83b9035 100644
> > --- a/drivers/clk/mediatek/clk-mt8192.c
> > +++ b/drivers/clk/mediatek/clk-mt8192.c
> > @@ -1114,6 +1114,13 @@ static const struct mtk_gate top_clks[] = {
> >         GATE_TOP(CLK_TOP_SSUSB_PHY_REF, "ssusb_phy_ref", "clk26m",
> > 25),
> >  };
> > 
> > +static const struct mtk_clk_rst_desc clk_rst_desc = {
> > +       .version = MTK_RST_SET_CLR,
> > +       .reg_num = 4,
> > +       .reg_ofs = 0x0,
> > +       .reset_n_cells = 2,
> 
> If you want to do this, you need to update the bindings first.

OK, I will add another patch for this.

> 
> > +};
> > +
> >  #define MT8192_PLL_FMAX                (3800UL * MHZ)
> >  #define MT8192_PLL_FMIN                (1500UL * MHZ)
> >  #define MT8192_INTEGER_BITS    8
> > @@ -1239,6 +1246,10 @@ static int clk_mt8192_infra_probe(struct
> > platform_device *pdev)
> >         if (r)
> >                 goto free_clk_data;
> > 
> > +       r = mtk_clk_register_rst_ctrl_with_dev(&pdev->dev,
> > &clk_rst_desc);
> > +       if (r)
> > +               goto free_clk_data;
> > +
> >         r = of_clk_add_provider(node, of_clk_src_onecell_get,
> > clk_data);
> >         if (r)
> >                 goto free_clk_data;
> > diff --git a/include/dt-bindings/reset/mt8192-resets.h
> > b/include/dt-bindings/reset/mt8192-resets.h
> > index be9a7ca245b9..feac1ac85906 100644
> > --- a/include/dt-bindings/reset/mt8192-resets.h
> > +++ b/include/dt-bindings/reset/mt8192-resets.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
> >  #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
> > 
> > +/* TOPRGU */
> >  #define
> > MT8192_TOPRGU_MM_SW_RST                                        1
> >  #define MT8192_TOPRGU_MFG_SW_RST                               2
> >  #define MT8192_TOPRGU_VENC_SW_RST                              3
> > @@ -27,4 +28,14 @@
> > 
> >  #define MT8192_TOPRGU_SW_RST_NUM                               23
> > 
> > +/* INFRA RST0 */
> > +#define MT8192_INFRA_RST0_LVTS_AP_RST                          0
> > +/* INFRA RST2 */
> > +#define MT8192_INFRA_RST2_PCIE_PHY_RST                         15
> > +/* INFRA RST3 */
> > +#define MT8192_INFRA_RST3_PTP_RST                              5
> > +/* INFRA RST4 */
> > +#define MT8192_INFRA_RST4_LVTS_MCU                             12
> > +#define MT8192_INFRA_RST4_PCIE_TOP                             1
> > +
> 
> This change should be part of the binding change.
> 
> For these, please also add a patch for the actual device tree
> changes.
> 

OK, I will do this.

BRs,
Rex
> 
> ChenYu
> 
> >  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> > --
> > 2.18.0
> > 


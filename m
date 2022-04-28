Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518D151324F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbiD1LWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiD1LWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:22:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F28A94F6;
        Thu, 28 Apr 2022 04:18:48 -0700 (PDT)
X-UUID: 6da760cb734a4341bb8b8abd0fde6d5b-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:d83dbdcb-c48c-45e9-af44-dd36e57a733c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:d83dbdcb-c48c-45e9-af44-dd36e57a733c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:5198d3c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 6da760cb734a4341bb8b8abd0fde6d5b-20220428
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 228262536; Thu, 28 Apr 2022 19:18:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 28 Apr 2022 19:18:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 19:18:41 +0800
Message-ID: <b83049a9cc9714a28c90a167245c43afddbc1aab.camel@mediatek.com>
Subject: Re: [PATCH V4 12/15] dt-bindings: reset: mediatek: Add infra_ao
 reset bit for MT8192/MT8195
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
Date:   Thu, 28 Apr 2022 19:18:41 +0800
In-Reply-To: <d96797dc-8fbd-fe1c-f970-2f6fc8ca5b69@linaro.org>
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
         <20220427030950.23395-13-rex-bc.chen@mediatek.com>
         <d96797dc-8fbd-fe1c-f970-2f6fc8ca5b69@linaro.org>
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

On Thu, 2022-04-28 at 15:18 +0800, Krzysztof Kozlowski wrote:
> On 27/04/2022 05:09, Rex-BC Chen wrote:
> > - To support reset of infra_ao, add the bit definition of
> >   thermal/PCIe/SVS for MT8192.
> > - To support reset of infra_ao, add the bit definition of
> >   thermal/SVS for MT8195.
> > - Add the driver comment to separate the reset index for
> >   TOPRGU and INFRA.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  include/dt-bindings/reset/mt8192-resets.h | 8 ++++++++
> >  include/dt-bindings/reset/mt8195-resets.h | 6 ++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/include/dt-bindings/reset/mt8192-resets.h
> > b/include/dt-bindings/reset/mt8192-resets.h
> > index be9a7ca245b9..ee0ca02a39bf 100644
> > --- a/include/dt-bindings/reset/mt8192-resets.h
> > +++ b/include/dt-bindings/reset/mt8192-resets.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
> >  #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
> >  
> > +/* TOPRGU resets */
> >  #define MT8192_TOPRGU_MM_SW_RST					
> > 1
> >  #define MT8192_TOPRGU_MFG_SW_RST				2
> >  #define MT8192_TOPRGU_VENC_SW_RST				3
> > @@ -27,4 +28,11 @@
> >  
> >  #define MT8192_TOPRGU_SW_RST_NUM				23
> >  
> > +/* INFRA resets */
> > +#define MT8192_INFRA_THERMAL_CTRL_RST			0
> > +#define MT8192_INFRA_PEXTP_PHY_RST				79
> > +#define MT8192_INFRA_PTP_RST					
> > 101
> > +#define MT8192_INFRA_RST4_PCIE_TOP				129
> > +#define MT8192_INFRA_THERMAL_CTRL_MCU_RST		140
> 
> This is still wrong. I gave you exactly what has to be used:
> 0
> 1
> 2
> ...
> 
> It's a decimal number incremented by one.
> 
> 
> > +
> >  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> > diff --git a/include/dt-bindings/reset/mt8195-resets.h
> > b/include/dt-bindings/reset/mt8195-resets.h
> > index a26bccc8b957..a3226f40779c 100644
> > --- a/include/dt-bindings/reset/mt8195-resets.h
> > +++ b/include/dt-bindings/reset/mt8195-resets.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
> >  #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
> >  
> > +/* TOPRGU resets */
> >  #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
> >  #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
> >  #define MT8195_TOPRGU_APU_SW_RST               2
> > @@ -26,4 +27,9 @@
> >  
> >  #define MT8195_TOPRGU_SW_RST_NUM               16
> >  
> > +/* INFRA resets */
> > +#define MT8195_INFRA_THERMAL_AP_RST            0
> > +#define MT8195_INFRA_PTP_RST                   101
> > +#define MT8195_INFRA_THERMAL_MCU_RST           138
> 
> Same issue.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for your review.
As mentioned in prvious mail, I will add all reset bits in MT8192 and
MT8195.

BRs,
Rex


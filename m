Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D853B251
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiFBDxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFBDxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:53:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CE15715;
        Wed,  1 Jun 2022 20:53:13 -0700 (PDT)
X-UUID: 52803397a9114282911d667d2341b7eb-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:daf369c0-4726-441c-8d6a-edeb9b49cef8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:45df0015-b515-4766-a72d-4514488fe823,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 52803397a9114282911d667d2341b7eb-20220602
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1855159040; Thu, 02 Jun 2022 11:53:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 2 Jun 2022 11:53:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 11:53:08 +0800
Message-ID: <e5810ed88646f700b157ac7c8d499a61db105617.camel@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA
 definition for mt8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?= 
        <Jason-JH.Lin@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 2 Jun 2022 11:53:08 +0800
In-Reply-To: <20220530070641.GE1363@bug>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
         <20220509044302.27878-2-rex-bc.chen@mediatek.com>
         <20220530070641.GE1363@bug>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-30 at 15:06 +0800, Pavel Machek wrote:
> On Mon 2022-05-09 12:43:00, Rex-BC Chen wrote:
> > From: "Nancy.Lin" <nancy.lin@mediatek.com>
> > 
> > Add vdosys1 RDMA definition.
> > 
> > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> 
> Your signoff will be needed, too.
> 
> Best regards,
> 								Pavel

Hello Pavel,

ok, I will add it in next version.
Thanks.

BRs,
Bo-Chen


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF84AB506
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiBGGgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiBGG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:29:22 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:29:20 PST
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5169EC043181;
        Sun,  6 Feb 2022 22:29:20 -0800 (PST)
X-UUID: b38ae3703fd145f7aa8aadeb02123d6a-20220207
X-UUID: b38ae3703fd145f7aa8aadeb02123d6a-20220207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 458394913; Mon, 07 Feb 2022 14:24:13 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Feb 2022 14:24:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Feb
 2022 14:24:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 14:24:11 +0800
Message-ID: <4490a88150f5aa108e1d6ff8ce55264c3b1734c2.camel@mediatek.com>
Subject: Re: [PATCH v22 1/7] dt-bindings: soc: mediatek: add mtk svs
 dt-bindings
From:   Roger Lu <roger.lu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        "HenryC Chen" <HenryC.Chen@mediatek.com>,
        Nishanth Menon <nm@ti.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Angus Lin <Angus.Lin@mediatek.com>
Date:   Mon, 7 Feb 2022 14:24:11 +0800
In-Reply-To: <YfnFBirxSnCqRDem@robh.at.kernel.org>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
         <20220127033956.24585-2-roger.lu@mediatek.com>
         <YfnFBirxSnCqRDem@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 2022-02-01 at 17:40 -0600, Rob Herring wrote:
> On Thu, 27 Jan 2022 11:39:50 +0800, Roger Lu wrote:
> > Document the binding for enabling mtk svs on MediaTek SoC.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >  .../bindings/soc/mediatek/mtk-svs.yaml        | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-
> > svs.yaml
> > 
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Oh, this patch has error detected and shown in [1]. Therefore, I fix it and
state the change at [2]. Thanks for the explanation and time to review the
patch.

[1] 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220107095200.4389-2-roger.lu@mediatek.com/
[2] 
https://patchwork.kernel.org/project/linux-mediatek/cover/20220127033956.24585-1-roger.lu@mediatek.com/
- Remove unnecessary "maxItems" from nvmem-cells in mtk-svs.yaml.


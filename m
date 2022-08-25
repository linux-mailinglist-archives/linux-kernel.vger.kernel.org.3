Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166875A0960
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiHYG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiHYG71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:59:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6391A1D13;
        Wed, 24 Aug 2022 23:59:25 -0700 (PDT)
X-UUID: 1457bb8bcaca4f6b9983a606c598a6c1-20220825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ownQ93bhTx2wCDrHvGFfWGNUedELMU2o04x/3pYfzZ8=;
        b=GdlFEJ7Bmjk3CS2AwYowhLKNixUS52ntwyIZ29Yxab+JA0IAqLBsT6QIK01ZfWPFRi825XyZkxbxCQ9ntBIq0pRc/BncE4Tau2zR9D2h8xe5hpUyvnv+3JKg4DkbinRSm1pXNqC8ha0zWHMCP+NFtDYQOTUZ00TDel4ZLo8SMhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:c1c5b8f9-c37e-4c26-9f54-11c631d61410,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:e2ed0f20-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1457bb8bcaca4f6b9983a606c598a6c1-20220825
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1789223745; Thu, 25 Aug 2022 14:59:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 25 Aug 2022 14:59:20 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 25 Aug 2022 14:59:20 +0800
Message-ID: <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?= 
        <Jason-JH.Lin@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?=" 
        <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 25 Aug 2022 14:59:20 +0800
In-Reply-To: <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
         <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-25 at 14:11 +0800, Krzysztof Kozlowski wrote:
> On 25/08/2022 08:56, Bo-Chen Chen wrote:
> > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > 
> > For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> > pipelines binding to 1 mmsys with the same power domain, the same
> > clock driver and the same mediatek-drm driver.
> > 
> > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding
> > to
> > 2 different power domains, different clock drivers and different
> > mediatek-drm drivers.
> 
> I don't see binding to different clock drivers and anyway that's not
> really an argument here. Please focus in description on hardware
> properties, IOW, are devices compatible or different. What is the
> incompatible difference between VDOSYS0 and 1?
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for yor review.

From the functions perspective:

Hardware pipeline of VDOSYS0 has these components: COLOR, CCORR, AAL,
GAMMA, DITHER.
They are related to PQ (Picture Quality) functions and they makes
VDOSYS0 supports PQ function while they are not including in VDOSYS1.

Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
component).
It makes VDOSYS1 supports the HDR function while it's not including in
VDOSYS0.

About mediatek ETHDR, you can refer to this series:

https://lore.kernel.org/all/20220819061456.8042-2-nancy.lin@mediatek.com/

To summary:
Only VDOSYS0 can support PQ adjustment.
Only VDOSYS1 can support HDR adjustment.

Is this description ok for you?
If it is ok, I will put them into commit message in next version.

BRs,
Bo-Chen


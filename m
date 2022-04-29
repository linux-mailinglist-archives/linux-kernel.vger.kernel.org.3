Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECD51421E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354350AbiD2GDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiD2GDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:03:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFBFB1A89;
        Thu, 28 Apr 2022 22:59:51 -0700 (PDT)
X-UUID: bd6b44fac70b4733bbe0d11853d89fcf-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6e9475b7-ebc5-477c-ac85-c26332b349d9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:31
X-CID-INFO: VERSION:1.1.4,REQID:6e9475b7-ebc5-477c-ac85-c26332b349d9,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:31
X-CID-META: VersionHash:faefae9,CLOUDID:3fd5232f-6199-437e-8ab4-9920b4bc5b76,C
        OID:6ec4fd23a083,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: bd6b44fac70b4733bbe0d11853d89fcf-20220429
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1785308049; Fri, 29 Apr 2022 13:59:47 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 29 Apr 2022 13:59:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 13:59:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 13:59:45 +0800
Message-ID: <9965188904de2e89bc5390fa6c71d9fb243f9d12.camel@mediatek.com>
Subject: Re: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
From:   YC Hung <yc.hung@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <broonie@kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <cezary.rojewski@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <allen-kh.cheng@mediatek.com>
Date:   Fri, 29 Apr 2022 13:59:46 +0800
In-Reply-To: <68895a40-559b-13ce-d433-f9b32c648323@gmail.com>
References: <20220106064847.15588-1-yc.hung@mediatek.com>
         <Yd4yNkeGlzdULNlv@robh.at.kernel.org>
         <68895a40-559b-13ce-d433-f9b32c648323@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattias/Rob,

Sorry I miss this mail.
Could you please help to check this patch? Thanks.

On Fri, 2022-01-14 at 13:56 +0100, Matthias Brugger wrote:
> 
> On 12/01/2022 02:43, Rob Herring wrote:
> > On Thu, 06 Jan 2022 14:48:48 +0800, YC Hung wrote:
> > > From: "YC Hung" <yc.hung@mediatek.com>
> > > 
> > > This patch adds mt8195 dsp document. The dsp is used for Sound
> > > Open
> > > Firmware driver node. It includes registers,  clocks, memory
> > > regions,
> > > and mailbox for dsp.
> > > 
> > > Signed-off-by: yc.hung <yc.hung@mediatek.com>
> > > ---
> > > Changes since v3:
> > >    Fix patch v3 error : v3 only provide difference between v3 and
> > > v2.
> > > 
> > > Changes since v2:
> > >    Remove useless watchdog interrupt.
> > >    Add commit message more detail description.
> > > 
> > > Changes since v1:
> > >    Rename yaml file name as mediatek,mt8195-dsp.yaml
> > >    Refine descriptions for mailbox, memory-region and drop unused
> > > labels
> > >    in examples.
> > > ---
> > >   .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 105
> > > ++++++++++++++++++
> > >   1 file changed, 105 insertions(+)
> > >   create mode 100644
> > > Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> > > 
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> 
> Rob, it seems we don't have a maintainer for this bindings. Shall I
> as MediaTek 
> SoC maintainer take them through my branch?
> 
> Regards,
> Matthias


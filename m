Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2777049ADEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352937AbiAYIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:25:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39130 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1449797AbiAYIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:20:18 -0500
X-UUID: 54edde21346943f9a2d85f5a21796c96-20220125
X-UUID: 54edde21346943f9a2d85f5a21796c96-20220125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 588502847; Tue, 25 Jan 2022 16:20:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 16:20:05 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:20:05 +0800
Message-ID: <356f512b549f90b329775e249fd48eb2954ade02.camel@mediatek.com>
Subject: Re: [PATCH v11 2/3] dts: arm64: mt8183: add Mediatek MDP3 nodes
From:   moudy ho <moudy.ho@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        "Maoguang Meng" <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>
Date:   Tue, 25 Jan 2022 16:20:05 +0800
In-Reply-To: <d61ec481-8059-a897-504a-0125f88fad61@collabora.com>
References: <20220105093758.6850-1-moudy.ho@mediatek.com>
         <20220105093758.6850-3-moudy.ho@mediatek.com>
         <d61ec481-8059-a897-504a-0125f88fad61@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-21 at 12:58 +0100, AngeloGioacchino Del Regno wrote:
> Il 05/01/22 10:37, Moudy Ho ha scritto:
> > Add device nodes for Media Data Path 3 (MDP3) modules.
> > 
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 108
> > ++++++++++++++++++++++-
> >   1 file changed, 107 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index ba4584faca5a..b872ef1ff6b3 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -1325,6 +1325,79 @@
> >   			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> > 0 0x1000>;
> >   		};
> >   
> > +		mdp3_rdma0: mdp3_rdma0@14001000 {
> > +			compatible = "mediatek,mt8183-mdp3",
> > +				     "mediatek,mt8183-mdp3-rdma0";
> > +			mediatek,scp = <&scp>;
> > +			mediatek,mdp3-comps = "mediatek,mt8183-mdp3-
> > dl1",
> > +					      "mediatek,mt8183-mdp3-
> > dl2",
> > +					      "mediatek,mt8183-mdp3-
> > path1",
> > +					      "mediatek,mt8183-mdp3-
> > path2",
> > +					      "mediatek,mt8183-mdp3-
> > imgi",
> > +					      "mediatek,mt8183-mdp3-
> > exto";
> > +			reg = <0 0x14001000 0 0x1000>,
> > +			      <0 0x14000000 0 0x1000>,
> > +			      <0 0x14005000 0 0x1000>,
> > +			      <0 0x14006000 0 0x1000>,
> > +			      <0 0x15020000 0 0x1000>;
> > +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> > 0x1000 0x1000>,
> > +						  <&gce SUBSYS_1400XXXX
> > 0 0x1000>,
> > +						  <&gce SUBSYS_1400XXXX
> > 0x5000 0x1000>,
> > +						  <&gce SUBSYS_1400XXXX
> > 0x6000 0x1000>,
> > +						  <&gce SUBSYS_1502XXXX
> > 0 0x1000>;
> > +			power-domains = <&spm
> > MT8183_POWER_DOMAIN_DISP>;
> > +			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> > +				 <&mmsys CLK_MM_MDP_RSZ1>,
> > +				 <&mmsys CLK_MM_MDP_DL_TXCK>,
> > +				 <&mmsys CLK_MM_MDP_DL_RX>,
> > +				 <&mmsys CLK_MM_IPU_DL_TXCK>,
> > +				 <&mmsys CLK_MM_IPU_DL_RX>;
> > +			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
> > +			mediatek,mmsys = <&mmsys>;
> > +			mediatek,mm-mutex = <&mutex>;
> > +			mediatek,mailbox-gce = <&gce>;
> > +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
> > +				 <&gce 21 CMDQ_THR_PRIO_LOWEST>,
> > +				 <&gce 22 CMDQ_THR_PRIO_LOWEST>,
> > +				 <&gce 23 CMDQ_THR_PRIO_LOWEST>;
> 
> Hello Moudy,
> the mboxes for gce 21, 22, 23 are missing the third cell. Please fix.
> 
> Regards,
> Angelo

Hi Angelo,
Thanks for the reminder, but I'm a bit confused, the previous
version(v10) mentioned that the current upstream mbox has only 2
cells.
So I should follow this rule to remove the extra 0 in the first item as
follows:
 +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
 +				 <&gce 21 CMDQ_THR_PRIO_LOWEST>,
 +				 <&gce 22 CMDQ_THR_PRIO_LOWEST>,
 +				 <&gce 23 CMDQ_THR_PRIO_LOWEST>;

Thanks,
Moudy Ho
> 
> > +			gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
> > +				     <&gce 0x14010000 SUBSYS_1401XXXX>,
> > +				     <&gce 0x14020000 SUBSYS_1402XXXX>,
> > +				     <&gce 0x15020000 SUBSYS_1502XXXX>;
> > +		};
> > +
> 
> 


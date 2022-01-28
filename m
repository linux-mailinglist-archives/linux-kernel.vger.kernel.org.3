Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E967C49F1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiA1D35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:29:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56444 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236369AbiA1D3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:29:55 -0500
X-UUID: b58cd72e861f4f87a52553ba73bac302-20220128
X-UUID: b58cd72e861f4f87a52553ba73bac302-20220128
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 421102729; Fri, 28 Jan 2022 11:29:51 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 28 Jan 2022 11:29:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Jan
 2022 11:29:49 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 11:29:48 +0800
Message-ID: <f1a722ca06545c8fcb23707356b889e7c963ea7a.camel@mediatek.com>
Subject: Re: [PATCH v1, 7/8] media: uapi: Init VP9 stateless decode params
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 28 Jan 2022 11:29:48 +0800
In-Reply-To: <07468ddd-22a8-c2a5-21fd-8468e0e77d74@collabora.com>
References: <20220127025544.10854-1-yunfei.dong@mediatek.com>
         <20220127025544.10854-8-yunfei.dong@mediatek.com>
         <07468ddd-22a8-c2a5-21fd-8468e0e77d74@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thanks for your suggestion,

Separate this patch with mt8195 support, and sent it again.
On Thu, 2022-01-27 at 11:35 +0100, AngeloGioacchino Del Regno wrote:
> Il 27/01/22 03:55, Yunfei Dong ha scritto:
> > Init some of VP9 frame decode params to default value.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> Hello Yunfei,
> 
> This patch is not strictly related to MediaTek SoCs, since it's
> modfying v4l2-core.
> Can you please send this patch separately?
> 
> Thanks,
> Angelo
> 
Best Regards,
Yunfei Dong
> > ---
> >   drivers/media/v4l2-core/v4l2-ctrls-core.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > index 54abe5245dcc..b25c77b8a445 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > @@ -112,6 +112,7 @@ static void std_init_compound(const struct
> > v4l2_ctrl *ctrl, u32 idx,
> >   	struct v4l2_ctrl_mpeg2_picture *p_mpeg2_picture;
> >   	struct v4l2_ctrl_mpeg2_quantisation *p_mpeg2_quant;
> >   	struct v4l2_ctrl_vp8_frame *p_vp8_frame;
> > +	struct v4l2_ctrl_vp9_frame *p_vp9_frame;
> >   	struct v4l2_ctrl_fwht_params *p_fwht_params;
> >   	void *p = ptr.p + idx * ctrl->elem_size;
> >   
> > @@ -152,6 +153,13 @@ static void std_init_compound(const struct
> > v4l2_ctrl *ctrl, u32 idx,
> >   		p_vp8_frame = p;
> >   		p_vp8_frame->num_dct_parts = 1;
> >   		break;
> > +	case V4L2_CTRL_TYPE_VP9_FRAME:
> > +		p_vp9_frame = p;
> > +		p_vp9_frame->profile = 0;
> > +		p_vp9_frame->bit_depth = 8;
> > +		p_vp9_frame->flags |= V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING
> > |
> > +			V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
> > +		break;
> >   	case V4L2_CTRL_TYPE_FWHT_PARAMS:
> >   		p_fwht_params = p;
> >   		p_fwht_params->version = V4L2_FWHT_VERSION;
> > 
> 
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBACF49F1D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbiA1D2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:28:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:40490 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236369AbiA1D2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:28:36 -0500
X-UUID: fd76c5dacd1f4fd6bdf0e4d6027a16be-20220128
X-UUID: fd76c5dacd1f4fd6bdf0e4d6027a16be-20220128
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 935666080; Fri, 28 Jan 2022 11:28:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 28 Jan 2022 11:28:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 11:28:28 +0800
Message-ID: <c7e8cccc04aeb5520e5b3f090c89d1356b763acd.camel@mediatek.com>
Subject: Re: [PATCH v1, 7/8] media: uapi: Init VP9 stateless decode params
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
CC:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
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
Date:   Fri, 28 Jan 2022 11:28:28 +0800
In-Reply-To: <CAGXv+5ELuvvG6dwXH5DdHtjOm4j4AAVTk2UxGOitF5v5Vx265A@mail.gmail.com>
References: <20220127025544.10854-1-yunfei.dong@mediatek.com>
         <20220127025544.10854-8-yunfei.dong@mediatek.com>
         <CAGXv+5ELuvvG6dwXH5DdHtjOm4j4AAVTk2UxGOitF5v5Vx265A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

Thanks for your suggestion.
Send this patch again.
On Thu, 2022-01-27 at 17:23 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jan 27, 2022 at 10:56 AM Yunfei Dong <
> yunfei.dong@mediatek.com> wrote:
> > 
> > Init some of VP9 frame decode params to default value.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> Maybe add
> 
> Fixes: b88dbe38dca8 ("media: uapi: Add VP9 stateless decoder
> controls")
> 
Best Regards,
Yunfei Dong
> > ---
> >  drivers/media/v4l2-core/v4l2-ctrls-core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > index 54abe5245dcc..b25c77b8a445 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > @@ -112,6 +112,7 @@ static void std_init_compound(const struct
> > v4l2_ctrl *ctrl, u32 idx,
> >         struct v4l2_ctrl_mpeg2_picture *p_mpeg2_picture;
> >         struct v4l2_ctrl_mpeg2_quantisation *p_mpeg2_quant;
> >         struct v4l2_ctrl_vp8_frame *p_vp8_frame;
> > +       struct v4l2_ctrl_vp9_frame *p_vp9_frame;
> >         struct v4l2_ctrl_fwht_params *p_fwht_params;
> >         void *p = ptr.p + idx * ctrl->elem_size;
> > 
> > @@ -152,6 +153,13 @@ static void std_init_compound(const struct
> > v4l2_ctrl *ctrl, u32 idx,
> >                 p_vp8_frame = p;
> >                 p_vp8_frame->num_dct_parts = 1;
> >                 break;
> > +       case V4L2_CTRL_TYPE_VP9_FRAME:
> > +               p_vp9_frame = p;
> > +               p_vp9_frame->profile = 0;
> > +               p_vp9_frame->bit_depth = 8;
> > +               p_vp9_frame->flags |=
> > V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING |
> > +                       V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
> > +               break;
> >         case V4L2_CTRL_TYPE_FWHT_PARAMS:
> >                 p_fwht_params = p;
> >                 p_fwht_params->version = V4L2_FWHT_VERSION;
> > --
> > 2.25.1
> > 


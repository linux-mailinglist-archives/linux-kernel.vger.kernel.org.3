Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139950C808
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiDWHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiDWHhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:37:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9C1BA83C;
        Sat, 23 Apr 2022 00:34:11 -0700 (PDT)
X-UUID: 6c746fe8ae0041f5b0486d4f43f5c0f3-20220423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6ba8b50a-d57b-4671-88b6-a30d4e8ea215,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:25
X-CID-INFO: VERSION:1.1.4,REQID:6ba8b50a-d57b-4671-88b6-a30d4e8ea215,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:4b93aef0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 6c746fe8ae0041f5b0486d4f43f5c0f3-20220423
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1222477034; Sat, 23 Apr 2022 15:34:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 23 Apr 2022 15:34:04 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Apr 2022 15:34:02 +0800
Message-ID: <ad60061db14c9f08e6b1aed3389d3744d8a12be0.camel@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Fix v4l2 compliance decoder
 cmd test fail
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Sat, 23 Apr 2022 15:34:02 +0800
In-Reply-To: <678a06f5-0519-dab3-35ac-5915b47d422e@xs4all.nl>
References: <20220406012048.5970-1-yunfei.dong@mediatek.com>
         <678a06f5-0519-dab3-35ac-5915b47d422e@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for your suggestion, I will resend patch v4 according to your
suggestion.

Best Regards,
Yunfei Dong
On Thu, 2022-04-21 at 12:47 +0200, Hans Verkuil wrote:
> On 06/04/2022 03:20, Yunfei Dong wrote:
> > Will return -EINVAL using standard framework api when test
> > stateless
> > decoder with cmd VIDIOC_(TRY)DECODER_CMD.
> > 
> > Using another return value to adjust v4l2 compliance test for user
> > driver(GStreamer/Chrome) won't use decoder cmd.
> > 
> > Fixes: 8cdc3794b2e3 ("media: mtk-vcodec: vdec: support stateless
> > API")
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> > changes compared with v2:
> > - add reviewed-by tag
> > changes compared with v1:
> > - add Fixes: tag
> > ---
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > index 3859e4c651c6..69b0e797d342 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > @@ -51,8 +51,7 @@ static int vidioc_try_decoder_cmd(struct file
> > *file, void *priv,
> >  
> >  	/* Use M2M stateless helper if relevant */
> >  	if (ctx->dev->vdec_pdata->uses_stateless_api)
> > -		return v4l2_m2m_ioctl_stateless_try_decoder_cmd(file,
> > priv,
> > -								cmd);
> > +		return -ENOTTY;
> >  	else
> >  		return v4l2_m2m_ioctl_try_decoder_cmd(file, priv, cmd);
> >  }
> 
> So in other words, if the stateless api is used, then
> (TRY_)DECODER_CMD
> is not implemented. And that's because this driver doesn't set the
> V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF capability as that's not
> needed.
> And so there is no need for (TRY_)DECODER_CMD to be implemented.
> 
> If that's the case, then it is much better to just disable these two
> ioctls with v4l2_disable_ioctl() if the stateless API is used.
> 
> And just drop the uses_stateless_api checks in both
> vidioc_try_decoder_cmd
> and vidioc_decoder_cmd. This patch only changed
> vidioc_try_decoder_cmd,
> but of course vidioc_decoder_cmd needs to be modified as well.
> 
> Regards,
> 
> 	Hans


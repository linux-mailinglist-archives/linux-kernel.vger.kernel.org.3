Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383058D1F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiHICOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHICOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:14:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DA186F5;
        Mon,  8 Aug 2022 19:14:29 -0700 (PDT)
X-UUID: e8f5d0cb958f4b22a0aa7c1aba99d1e3-20220809
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=y8g00+MVfQ7zjg+9qQtJsoC54ym+QwCyy5TT9zwswNA=;
        b=JsFPM6PS557liQ59PGHrTq7Cy65VMQvZ56hKUF1zyCEsOy+3VI9WWAvfBkittXVxGPp3PANgLXqW52qODCqJ5jb5b5i/Srk790XVBRTRVZpQCqJQfHsoPbppYUGYwZksyisbCmmCqd+sbLKYY1qyNa8BksCok1k8UeSAp8fX08U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:d670fdfa-5e56-4d00-a3b2-8f919da888de,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:40
X-CID-INFO: VERSION:1.1.9,REQID:d670fdfa-5e56-4d00-a3b2-8f919da888de,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:40
X-CID-META: VersionHash:3d8acc9,CLOUDID:64af1e9c-da39-4e3b-a854-56c7d2111b46,C
        OID:f4cded7e47b4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e8f5d0cb958f4b22a0aa7c1aba99d1e3-20220809
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1012388443; Tue, 09 Aug 2022 10:14:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 9 Aug 2022 10:14:23 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 9 Aug 2022 10:14:22 +0800
Message-ID: <ceed53ee78f1364771f781a5567dd186ec4694ad.camel@mediatek.com>
Subject: Re: [PATCH v5, 0/8] Support H264 multi-core encoder on MT8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tomasz Figa <tfiga@google.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 9 Aug 2022 10:14:22 +0800
In-Reply-To: <8ae4bf37a743755d046f9d0a9e8ad303c7a5041d.camel@collabora.com>
References: <20220729035129.3634-1-irui.wang@mediatek.com>
         <8ae4bf37a743755d046f9d0a9e8ad303c7a5041d.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Nicolas,

Sorry for late, we have tested this change by chrome tast test before:

tast run $IP video.PlatformEncoding.v4l2_h264*

here are the average fps results:
Before:
180p: 1913
180_meet: 1935

360p: 554
360_meet: 571

720p: 159
720_meet: 189

After:
180p: 2236
180_meet: 2337

360p: 820
360_meet: 830

720p: 324
720_meet: 390

Thanks
BRs
On Fri, 2022-07-29 at 11:08 -0400, Nicolas Dufresne wrote:
> Hi Irui,
> 
> Le vendredi 29 juillet 2022 à 11:51 +0800, Irui Wang a écrit :
> > MT8195 has two H264 encoder hardware, named core0 and core1, this
> > two
> > cores can encode two input frames separately at the same time to
> > achieve
> > higher performance.
> 
> I suspect you could provide some performance numbers on that specific
> HW before
> and after your change ? This could help integrator regarding what
> type of gain
> they can expect of back-porting this feature. This is not strictly
> mandatory
> though.
> 
> > 
> > This series of patches are used to enable the two H264 encoder
> > cores,
> > the difference between encoding process before and after enable two
> > cores is just like as below:
> > As-Is: Synchronous
> > V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder
> > IRQ
> > -->
> > encoding done with result --> job_finish
> > V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder
> > IRQ
> > -->
> > encoding done with result --> job_finish
> > ...
> > To-Be: Asynchronous
> > V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
> > ..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
> > (venc core0 may encode done here, done the encoding result to
> > client)
> > V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.
> > 
> > ---
> > changes compared with v4:
> > - reabse to the newer linux media stage tree.
> > - remove "mediatek,venc-multi-core" property since sub-device can
> >   be probed by of_platform_populate api directly.
> > - some modifications for patch v4's review comments.
> > 
> > changes compared with v3:
> > - rebase to the newer linux media stage.
> > - add a capability to indicate scp firmware support multi-core.
> > - probe core0 as main device, core1 as sub-device.
> > 
> > changes compared with v2:
> > - update venc core dt-bindings, add two new properties for current
> >   usage.
> > - parse venc multi_core mode from device tree.
> > - rebase to the newer linux media stage.
> > 
> > changes compared with v1:
> > - of_platform_populate was used in place of the component
> > framework.
> > - new yaml file for venc cores.
> > - some modifications for patch v1's review comments.
> > ---
> > 
> > Irui Wang (8):
> >   dt-bindings: media: mediatek: vcodec: Adds encoder cores dt-
> > bindings
> >     for mt8195
> >   media: mediatek: vcodec: Enable venc dual core usage
> >   media: mediatek: vcodec: Refactor venc power manage function
> >   media: mediatek: vcodec: Add more extra processing for multi-core
> >     encoding
> >   media: mediatek: vcodec: Add venc power on/off function
> >   media: mediatek: vcodec: Refactor encoder clock on/off function
> >   media: mediatek: vcodec: Add multi-core encoding process
> >   media: mediatek: vcodec: Return encoding result in asynchronous
> > mode
> > 
> >  .../media/mediatek,vcodec-encoder-core.yaml   | 218
> > ++++++++++++++++
> >  .../media/mediatek,vcodec-encoder.yaml        |   1 -
> >  .../media/platform/mediatek/vcodec/Makefile   |   4 +-
> >  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  28 +-
> >  .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 113 ++++++--
> >  .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  11 +-
> >  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  44 +++-
> >  .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 156 +++++++++++
> >  .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  34 +++
> >  .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 178 +++++++++++--
> >  .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  11 +-
> >  .../mediatek/vcodec/mtk_vcodec_util.c         |  19 ++
> >  .../mediatek/vcodec/mtk_vcodec_util.h         |   3 +
> >  .../mediatek/vcodec/venc/venc_h264_if.c       | 243
> > ++++++++++++++----
> >  .../mediatek/vcodec/venc/venc_vp8_if.c        |   3 +-
> >  .../platform/mediatek/vcodec/venc_drv_if.c    |  75 ++++--
> >  .../platform/mediatek/vcodec/venc_drv_if.h    |   6 +
> >  .../platform/mediatek/vcodec/venc_vpu_if.c    |   9 +-
> >  .../platform/mediatek/vcodec/venc_vpu_if.h    |   3 +-
> >  19 files changed, 1028 insertions(+), 131 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > core.yaml
> >  create mode 100644
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> >  create mode 100644
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> > 
> 
> 


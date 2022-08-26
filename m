Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E705A24CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbiHZJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiHZJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:47:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CA89822;
        Fri, 26 Aug 2022 02:47:01 -0700 (PDT)
X-UUID: 5d42f5d9c5314e29bebdbf706d9b667a-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2MesSwzmqG+668R8hXG9RG6Emlt91VldPxqdmS8624E=;
        b=nhcnE4y1tzbJORS7YLn9pcgLv2as36BBmFO9IrUxSvMKkqrL9kDf7S7CobfyuuokcPoXPHzcF0yv0hi1rWecSOo04sntTR/Zam5S6DaI5QIvjS/xVVZ9PUVvqPRYnuF670KW617PBl+InwUJ6aOYncq6dFIRNbOzZ1svzuY2v8o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:c0191fd6-d9a4-4c41-bad4-280175e6ace0,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18,CLOUDID:3c053420-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5d42f5d9c5314e29bebdbf706d9b667a-20220826
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1687321687; Fri, 26 Aug 2022 17:46:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 17:46:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 17:46:53 +0800
Message-ID: <e7cdece7bbb48a9a24778b96691b06f4eac944e6.camel@mediatek.com>
Subject: Re: [PATCH v2, 4/6] media: mediatek: vcodec: Remove encoder driver
 get IRQ resource
From:   Irui Wang <irui.wang@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 26 Aug 2022 17:46:53 +0800
In-Reply-To: <CAGXv+5Eqcv-K1O-5foTcHYXKh+0yipo-i+EjgYOMemS3_82fAQ@mail.gmail.com>
References: <20220720085731.11011-1-irui.wang@mediatek.com>
         <20220720085731.11011-5-irui.wang@mediatek.com>
         <CAGXv+5Eqcv-K1O-5foTcHYXKh+0yipo-i+EjgYOMemS3_82fAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Dear Chen-Yu,

many thanks for your comments.

On Fri, 2022-08-26 at 12:08 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Jul 20, 2022 at 4:58 PM Irui Wang <irui.wang@mediatek.com>
> wrote:
> > 
> > The "platform_get_resource(pdev, IORESOURCE_IRQ, 0)" is no longer
> > used after commit a1a2b7125e107("of/platform: Drop static setup of
> > IRQ resource from DT core"), so just remove the function in
> > encoder driver to avoid driver probe failed.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >  .../media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c   | 8 ----
> > ----
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > index ea667b867b56..6d8964fb4fa2 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > @@ -228,7 +228,6 @@ static int mtk_vcodec_probe(struct
> > platform_device *pdev)
> >  {
> >         struct mtk_vcodec_dev *dev;
> >         struct video_device *vfd_enc;
> > -       struct resource *res;
> >         phandle rproc_phandle;
> >         enum mtk_vcodec_fw_type fw_type;
> >         int ret;
> > @@ -272,13 +271,6 @@ static int mtk_vcodec_probe(struct
> > platform_device *pdev)
> >                 goto err_res;
> >         }
> > 
> > -       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -       if (res == NULL) {
> > -               dev_err(&pdev->dev, "failed to get irq resource");
> > -               ret = -ENOENT;
> > -               goto err_res;
> > -       }
> > -
> >         dev->enc_irq = platform_get_irq(pdev, 0);
> 
> platform_get_irq() returns a negative number on failure. You should
> check for errors here as the previous check was removed.
> 
> The description of platform_get_irq() explicitly mentions:
> 
>     Device drivers should check the return value for errors so as to
>     not pass a negative integer value to the request_irq() APIs.
> 
> Hans has queued up this patch, so maybe you could provide a follow-up
> patch to fix this?
> 
Another same patch has been already merged into linux-next tree, so
this current patch can be dropped.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c?id=750a914adb7ded3669b47daed6d9d749110b4107
 

Thanks
Best Regards
> 
> Regards
> ChenYu
> 
> 
> >         irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
> >         ret = devm_request_irq(&pdev->dev, dev->enc_irq,
> > --
> > 2.18.0
> > 


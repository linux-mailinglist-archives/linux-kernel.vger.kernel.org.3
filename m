Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268D53F407
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiFGCpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiFGCpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:45:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE6EAE6B;
        Mon,  6 Jun 2022 19:45:00 -0700 (PDT)
X-UUID: e7a56f64fb5a4d8a84f6971b420cd71c-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:466f59a2-2175-4f7b-b1b1-71b4631e0cf4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:526fdce4-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: e7a56f64fb5a4d8a84f6971b420cd71c-20220607
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 632121357; Tue, 07 Jun 2022 10:44:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Jun 2022 10:44:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 7 Jun 2022 10:44:54 +0800
Message-ID: <88f99e3feac6fc897de2aa0911908d3878cc2cc2.camel@mediatek.com>
Subject: Re: [PATCH v10 03/21] drm/edid: Convert cea_sad helper struct to
 kernelDoc
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Vinod Koul" <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-fbdev@vger.kernel.org>
Date:   Tue, 7 Jun 2022 10:44:54 +0800
In-Reply-To: <652139e639c7e80795e01b3b4f88ba03b85d66c5.camel@gmail.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-4-granquet@baylibre.com>
         <652139e639c7e80795e01b3b4f88ba03b85d66c5.camel@gmail.com>
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

On Mon, 2022-05-23 at 12:57 +0200, Matthias Brugger wrote:
> On Mon, 2022-05-23 at 12:47 +0200, Guillaume Ranquet wrote:
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > 
> 
> We need a commit message here.
> 

Hello Matthias,

ok, I will add commit message in next version.

Thanks.

BRs,
Bo-Chen

> > ---
> >  include/drm/drm_edid.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 144c495b99c4..37c420423625 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -359,12 +359,18 @@ struct edid {
> >  
> >  #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1]
> > << 8))
> >  
> > -/* Short Audio Descriptor */
> > +/**
> > + * struct cea_sad - Short Audio Descriptor.
> > + * @format: See HDMI_AUDIO_CODING_TYPE_*.
> > + * @channels: max number of channels - 1.
> > + * @freq: See CEA_SAD_FREQ_*.
> > + * @byte2: meaning depends on format.
> > + */
> >  struct cea_sad {
> >         u8 format;
> > -       u8 channels; /* max number of channels - 1 */
> > +       u8 channels;
> >         u8 freq;
> > -       u8 byte2; /* meaning depends on format */
> > +       u8 byte2;
> >  };
> >  
> >  struct drm_encoder;
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


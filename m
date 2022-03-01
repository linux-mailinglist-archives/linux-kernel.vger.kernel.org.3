Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF94C814F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiCACzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCACzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:55:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68F2F00B;
        Mon, 28 Feb 2022 18:54:16 -0800 (PST)
X-UUID: c89f52d5a4f64ae984fa7867e84596d3-20220301
X-UUID: c89f52d5a4f64ae984fa7867e84596d3-20220301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1464772391; Tue, 01 Mar 2022 10:54:08 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 1 Mar 2022 10:54:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 10:54:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 10:54:06 +0800
Message-ID: <5f257ac1fbc46a28f220dbd0b8bb70002fb9a1cb.camel@mediatek.com>
Subject: Re: [3/4] dt-bindings: reset: mt8186: add DSI reset bit for MMSYS
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 1 Mar 2022 10:54:06 +0800
In-Reply-To: <YhkDPe3KuaRW6b2Y@robh.at.kernel.org>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
         <20220216014505.28428-4-rex-bc.chen@mediatek.com>
         <YhkDPe3KuaRW6b2Y@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for your review.
I will do this in next version.

BRs,
Rex

On Fri, 2022-02-25 at 10:26 -0600, Rob Herring wrote:
> On Wed, Feb 16, 2022 at 09:45:04AM +0800, Rex-BC Chen wrote:
> > Add DSI software reset bit which is controlled by MMSYS for MT8186.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  include/dt-bindings/reset/mt8186-resets.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/dt-bindings/reset/mt8186-resets.h
> > b/include/dt-bindings/reset/mt8186-resets.h
> > index 36e5764e2e6c..5f850370c42c 100644
> > --- a/include/dt-bindings/reset/mt8186-resets.h
> > +++ b/include/dt-bindings/reset/mt8186-resets.h
> > @@ -30,4 +30,7 @@
> >  #define MT8186_TOPRGU_IMG2_SW_RST				22
> >  #define MT8186_TOPRGU_SW_RST_NUM				23
> >  
> > +/* MMSYS resets */
> > +#define MT8186_MMSYS_SW0_RST_B_DISP_DSI0			19
> 
> This can just be squashed into the previous patch.
> 
> > +
> >  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */
> > -- 
> > 2.18.0
> > 
> > 


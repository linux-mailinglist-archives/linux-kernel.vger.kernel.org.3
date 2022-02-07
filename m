Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBA4AB714
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349412AbiBGJAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiBGI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:58:49 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:58:47 PST
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC7C043181;
        Mon,  7 Feb 2022 00:58:47 -0800 (PST)
X-UUID: 2cf4953b30db4e768f0e74993407d011-20220207
X-UUID: 2cf4953b30db4e768f0e74993407d011-20220207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2141366659; Mon, 07 Feb 2022 16:53:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Feb 2022 16:53:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 16:53:42 +0800
Message-ID: <618ca2903de8fe3b1f68c450273af7a170de2675.camel@mediatek.com>
Subject: Re: [v1 1/2] dt-bindings: power: Add MT8186 power domains
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 7 Feb 2022 16:53:42 +0800
In-Reply-To: <ae307028-979b-7e58-dd6f-f1d52520859b@gmail.com>
References: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
         <20220108131953.16744-2-chun-jie.chen@mediatek.com>
         <Yd43V1woRMAcXOfS@robh.at.kernel.org>
         <ae307028-979b-7e58-dd6f-f1d52520859b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-14 at 13:49 +0100, Matthias Brugger wrote:
> 
> On 12/01/2022 03:05, Rob Herring wrote:
> > On Sat, Jan 08, 2022 at 09:19:52PM +0800, Chun-Jie Chen wrote:
> > > Add power domains dt-bindings for MT8186.
> > > 
> > > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > ---
> > >   .../power/mediatek,power-controller.yaml      |  1 +
> > >   include/dt-bindings/power/mt8186-power.h      | 32
> > > +++++++++++++++++++
> > >   2 files changed, 33 insertions(+)
> > >   create mode 100644 include/dt-bindings/power/mt8186-power.h
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/power/mediatek,power-
> > > controller.yaml
> > > b/Documentation/devicetree/bindings/power/mediatek,power-
> > > controller.yaml
> > > index d6ebd77d28a7..135c6f722091 100644
> > > --- a/Documentation/devicetree/bindings/power/mediatek,power-
> > > controller.yaml
> > > +++ b/Documentation/devicetree/bindings/power/mediatek,power-
> > > controller.yaml
> > > @@ -26,6 +26,7 @@ properties:
> > >         - mediatek,mt8167-power-controller
> > >         - mediatek,mt8173-power-controller
> > >         - mediatek,mt8183-power-controller
> > > +      - mediatek,mt8186-power-controller
> > >         - mediatek,mt8192-power-controller
> > >         - mediatek,mt8195-power-controller
> > >   
> > > diff --git a/include/dt-bindings/power/mt8186-power.h
> > > b/include/dt-bindings/power/mt8186-power.h
> > > new file mode 100644
> > > index 000000000000..ca8ea2d24801
> > > --- /dev/null
> > > +++ b/include/dt-bindings/power/mt8186-power.h
> > > @@ -0,0 +1,32 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > 
> > Dual license please.
> > 
> 
> Other then that series looks good.
> 
> Regards,
> Matthias
> 

Ok, I will update license in next patch.

Thanks!
Best Regards,
Chun-Jie

> > > +/*
> > > + * Copyright (c) 2022 MediaTek Inc.
> > > + * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_POWER_MT8186_POWER_H
> > > +#define _DT_BINDINGS_POWER_MT8186_POWER_H
> > > +
> > > +#define MT8186_POWER_DOMAIN_MFG0			0
> > > +#define MT8186_POWER_DOMAIN_MFG1			1
> > > +#define MT8186_POWER_DOMAIN_MFG2			2
> > > +#define MT8186_POWER_DOMAIN_MFG3			3
> > > +#define MT8186_POWER_DOMAIN_SSUSB			4
> > > +#define MT8186_POWER_DOMAIN_SSUSB_P1			5
> > > +#define MT8186_POWER_DOMAIN_DIS				6
> > > +#define MT8186_POWER_DOMAIN_IMG				7
> > > +#define MT8186_POWER_DOMAIN_IMG2			8
> > > +#define MT8186_POWER_DOMAIN_IPE				9
> > > +#define MT8186_POWER_DOMAIN_CAM				10
> > > +#define MT8186_POWER_DOMAIN_CAM_RAWA			11
> > > +#define MT8186_POWER_DOMAIN_CAM_RAWB			12
> > > +#define MT8186_POWER_DOMAIN_VENC			13
> > > +#define MT8186_POWER_DOMAIN_VDEC			14
> > > +#define MT8186_POWER_DOMAIN_WPE				15
> > > +#define MT8186_POWER_DOMAIN_CONN_ON			16
> > > +#define MT8186_POWER_DOMAIN_CSIRX_TOP			17
> > > +#define MT8186_POWER_DOMAIN_ADSP_AO			18
> > > +#define MT8186_POWER_DOMAIN_ADSP_INFRA			19
> > > +#define MT8186_POWER_DOMAIN_ADSP_TOP			20
> > > +
> > > +#endif /* _DT_BINDINGS_POWER_MT8186_POWER_H */
> > > -- 
> > > 2.18.0
> > > 
> > > 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4602482ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiACHpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:45:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59636 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230370AbiACHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:45:23 -0500
X-UUID: cfc88ef970f049fba0806cd9aca3ad48-20220103
X-UUID: cfc88ef970f049fba0806cd9aca3ad48-20220103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 528300326; Mon, 03 Jan 2022 15:45:19 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Jan 2022 15:45:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 Jan
 2022 15:45:17 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 15:45:16 +0800
Message-ID: <28bc9c8ba962e09e321db3149c1196edefe4e856.camel@mediatek.com>
Subject: Re: [PATCH v20 5/7] dt-bindings: soc: mediatek: add mt8192 svs
 dt-bindings
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Mon, 3 Jan 2022 15:45:17 +0800
In-Reply-To: <98efb356-dc0d-fa7e-5579-7984f2bb3e84@gmail.com>
References: <20210721070904.15636-1-roger.lu@mediatek.com>
         <20210721070904.15636-6-roger.lu@mediatek.com>
         <98efb356-dc0d-fa7e-5579-7984f2bb3e84@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,


On Thu, 2021-12-30 at 16:30 +0100, Matthias Brugger wrote:
> Please add a commit message.

Sure, I'll add it in the next version. Thanks.

> 
> Regards,
> Matthias
> 
> On 21/07/2021 09:09, Roger Lu wrote:
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/soc/mediatek/mtk-svs.yaml         | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> > b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> > index a855ced410f8..59342e627b67 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> > @@ -22,6 +22,7 @@ properties:
> >     compatible:
> >       enum:
> >         - mediatek,mt8183-svs
> > +      - mediatek,mt8192-svs
> >   
> >     reg:
> >       maxItems: 1
> > @@ -51,6 +52,13 @@ properties:
> >         - const: svs-calibration-data
> >         - const: t-calibration-data
> >   
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    items:
> > +      - const: svs_rst
> > +
> >   required:
> >     - compatible
> >     - reg
> > 


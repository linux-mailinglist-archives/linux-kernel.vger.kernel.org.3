Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEF524DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354126AbiELNFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354113AbiELNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:05:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE320F4F1;
        Thu, 12 May 2022 06:05:05 -0700 (PDT)
X-UUID: 87dee6ed4fa44a5f9c12b7f8518422a7-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0c1c24e1-58a1-4cc5-bb7d-54c0783dc77c,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:faefae9,CLOUDID:3eb212a7-eab7-4b74-a74d-5359964535a9,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 87dee6ed4fa44a5f9c12b7f8518422a7-20220512
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2047737170; Thu, 12 May 2022 21:04:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 21:04:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 21:04:59 +0800
Message-ID: <14cdb1e17015e299231e72356e661203d4beda17.camel@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     <krzk+dt@kernel.org>, <cw00.choi@samsung.com>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>,
        <khilman@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 12 May 2022 21:04:59 +0800
In-Reply-To: <CAGXv+5G6Qv1JcsZNrw5=USJSzPkczW42FgXRYqAK=xS-moO6nw@mail.gmail.com>
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
         <20220425125546.4129-2-johnson.wang@mediatek.com>
         <CAGXv+5HgyN+kp86M2GgFtbruXSAMSLxsh9vf8zVE5TxRMyTyaA@mail.gmail.com>
         <a8e5fd9de1feece9051e1624c5cf3b672131a122.camel@mediatek.com>
         <CAGXv+5G6Qv1JcsZNrw5=USJSzPkczW42FgXRYqAK=xS-moO6nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 18:48 +0800, Chen-Yu Tsai wrote:
> On Mon, May 9, 2022 at 8:14 PM Johnson Wang <
> johnson.wang@mediatek.com> wrote:
> > 
> > Hi Chen-Yu,
> > 
> > On Tue, 2022-04-26 at 11:18 +0800, Chen-Yu Tsai wrote:
> > > On Mon, Apr 25, 2022 at 8:56 PM Johnson Wang <
> > > johnson.wang@mediatek.com> wrote:
> > > > 
> > > > Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> > > > 
> > > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > > ---
> > > >  .../bindings/interconnect/mediatek,cci.yaml   | 139
> > > > ++++++++++++++++++
> > > >  1 file changed, 139 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/interconnect/mediatek,cci.yam
> > > > l
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/interconnect/mediatek,cci.y
> > > > aml
> > > > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.y
> > > > aml
> > > > new file mode 100644
> > > > index 000000000000..e5221e17d11b
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.y
> > > > aml
> > > > @@ -0,0 +1,139 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > > > 
https://urldefense.com/v3/__http://devicetree.org/schemas/interconnect/mediatek,cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDlQ9pSDO$
> > > > 
> > > > +$schema:
> > > > 
https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDoE9YHyu$
> > > > 
> > > > +
> > > > +title: MediaTek Cache Coherent Interconnect (CCI) frequency
> > > > and
> > > > voltage scaling
> > > > +
> > > > +maintainers:
> > > > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > > +
> > > > +description: |
> > > > +  MediaTek Cache Coherent Interconnect (CCI) is a hardware
> > > > engine
> > > > used by
> > > > +  MT8183 and MT8186 SoCs to scale the frequency and adjust the
> > > > voltage in
> > > > +  hardware. It can also optimize the voltage to reduce the
> > > > power
> > > > consumption.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - mediatek,mt8183-cci
> > > > +      - mediatek,mt8186-cci
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description:
> > > > +          The multiplexer for clock input of CPU cluster.
> > > 
> > > of the bus, not CPU cluster.
> > 
> > Thanks for your suggestion.
> > I will correct it in the next version.
> > 
> > > 
> > > > +      - description:
> > > > +          A parent of "cpu" clock which is used as an
> > > > intermediate
> > > > clock source
> > > > +          when the original CPU is under transition and not
> > > > stable
> > > > yet.
> > > 
> > > This really should be handled in the clk controller, and not by
> > > every
> > > device
> > > that happens to take a clock from a mux with upstream PLLs that
> > > can
> > > change
> > > in clock rate. The end device hardware only takes one clock
> > > input.
> > > That's it.
> > > 
> > 
> > To make this intermediate clock works properly, this driver is also
> > responsible for handling the Vproc voltage and ensures the voltage
> > is
> > high enough to support intermediate clock rate.
> > 
> > If we move intermediate clock rate control to clock driver, then
> > intermediate voltage control may be handled by the clock driver
> > itself
> > as well.
> > 
> > We believe that is not reasonable because clock driver shouldn't
> > handle
> > voltage control. On the other hand, DVFS driver is more suitable
> > for
> > doing this job.
> 
> Either way the DVFS driver handles the voltage change.
> 
> Right now the driver is doing:
> 
> 1. Raise voltage if scaling up
> 2. Mux CCI clock over to stable clock
> 3. Set rate for CCI PLL
> 4. Mux CCI clock back to CCI PLL
> 5. Drop voltage if scaling down
> 
> I'm saying that the clock driver should handle 2+4 transparently when
> any
> driver requests a rate change on the CCI clock. So instead the driver
> would
> do:
> 
> 1. Raise voltage if scaling up
> 2. Set rate for CCI _clock_
>    Here the clock driver would do:
>    a. Mux CCI clock over to stable clock
>    b. Change clock rate for original parent, i.e. the CCI PLL
>    c. Mux CCI clock back to original parent, i.e. the CCI PLL
>    and back to the devfreq driver ...
> 3. Drop voltage if scaling down
> 
> Does that make sense?
> 
> 
> Regards
> ChenYu

Hi Chen-Yu,

Before we mux the CCI clock to an intermediate clock(MAINPLL), we must
ensure that regulator voltage is high enough (we call it intermediate
voltage) to support the intermediate clock rate.

Based on this concept, if we move mux control to clock driver, there
will be a dilemma about which driver to adjust the voltage.

1)When DVFS calls clk_set_rate(), clock driver scales up the regulator
voltage to higher than intermediate voltage and then mux the CCI clock.

This option is not reasonable because clock driver shouldn't handle the
regulators.


2)DVFS scales up the regulator voltage, then calls clk_set_rate(). 
Clock driver mux the CCI clock to the intermediate clock.

This option isn't straightforward and makes one confused easily. For a
person who reads this driver, he may not understand why we adjust the
voltage before clk_set_rate().

That's why we put intermediate voltage/freq together in the DVFS.

BRs,
Johnson Wang


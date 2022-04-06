Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8ED4F637B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiDFPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiDFPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:36:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596C44A4D2;
        Wed,  6 Apr 2022 05:50:27 -0700 (PDT)
X-UUID: 3e7fdf788b5b4bceaaa07a2a1ac9796e-20220406
X-UUID: 3e7fdf788b5b4bceaaa07a2a1ac9796e-20220406
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1457013016; Wed, 06 Apr 2022 20:49:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 6 Apr 2022 20:49:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 20:49:32 +0800
Message-ID: <bf6d645d9c8d0cc0ada530d9a3ebf27df838cc52.camel@mediatek.com>
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq
 dt-bindings
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Wed, 6 Apr 2022 20:49:32 +0800
In-Reply-To: <YipjOXdCNUxdy+ey@robh.at.kernel.org>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-3-jia-wei.chang@mediatek.com>
         <YipjOXdCNUxdy+ey@robh.at.kernel.org>
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

On Thu, 2022-03-10 at 14:44 -0600, Rob Herring wrote:
> On Mon, Mar 07, 2022 at 08:21:49PM +0800, Tim Chang wrote:
> > 1. add cci property.
> > 2. add example of MT8186.
> > 
> > Signed-off-by: Jia-Wei Chang <
> > jia-wei.chang@mediatek.corp-partner.google.com>
> > ---
> >  .../bindings/cpufreq/cpufreq-mediatek.yaml    | 41
> > +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml
> > index 584946eb3790..d3ce17fd8fcf 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml
> > @@ -48,6 +48,10 @@ properties:
> >        When absent, the voltage scaling flow is handled by
> > hardware, hence no
> >        software "voltage tracking" is needed.
> >  
> > +  cci:
> > +    description:
> > +      Phandle of the cci to be linked with the phandle of CPU if
> > present.
> 
> We already have a binding for this. See cci-control-port.

Hi Rob,

Pardon me for my late reply.

It seems that "cci-control-port" is hardware IP from ARM.
But mediatek-cpufreq uses MTK internal CCI hardware IP.
I think I should keep this change here.

Thanks.

> 
> > +
> >    "#cooling-cells":
> >      description:
> >        For details, please refer to


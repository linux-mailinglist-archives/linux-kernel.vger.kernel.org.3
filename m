Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8F4EEE0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbiDAN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiDAN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:28:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760D1E5A76;
        Fri,  1 Apr 2022 06:26:09 -0700 (PDT)
X-UUID: dee1b64c61124726bc8e9091fbac4a30-20220401
X-UUID: dee1b64c61124726bc8e9091fbac4a30-20220401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1610955157; Fri, 01 Apr 2022 21:26:03 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 1 Apr 2022 21:26:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 Apr
 2022 21:26:00 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 21:26:00 +0800
Message-ID: <de1751bb13fb14b591fbe046ff274530ad62162e.camel@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform
 cpufreq-mediatek into yaml
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Fri, 1 Apr 2022 21:26:00 +0800
In-Reply-To: <96a823a2-f3b6-9fb7-c9d6-f1315f6056fd@kernel.org>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-2-jia-wei.chang@mediatek.com>
         <ee98d248-b2cd-e975-84df-448917a79287@canonical.com>
         <2cf526d400c011b5172ba4fc2c3f03b4a4f371dc.camel@mediatek.com>
         <96a823a2-f3b6-9fb7-c9d6-f1315f6056fd@kernel.org>
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

On Thu, 2022-03-24 at 11:33 +0100, Krzysztof Kozlowski wrote:
> On 24/03/2022 10:38, Jia-Wei Chang wrote:
> > > 
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > mediatek.yaml
> > > > b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > mediatek.yaml
> > > > new file mode 100644
> > > > index 000000000000..584946eb3790
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > mediatek.yaml
> > > > @@ -0,0 +1,131 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: 
> > > > 
https://urldefense.com/v3/__http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2NdpChkMA$
> > > >  
> > > > +$schema: 
> > > > 
https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2O8T_oxCQ$
> > > >  
> > > > +
> > > > +title: Mediatek CPUFREQ driver Device Tree Bindings
> > > 
> > > Please remove "driver Device Tree Bindings" because the title
> > > should
> > > describe the hardware. Therefore it could be something like
> > > "Mediatek
> > > SoC CPU frequency and voltage scaling".
> > 
> > Thanks for your suggestion of title.
> > Or should I use the origin title "Binding for MediaTek's CPUFreq
> > driver"?
> 
> Mediatek CPUFREQ
> or
> Mediatek CPU frequency scaling

Ok, I will choose one of it.

> 
> > 
> > > 
> > > How is it related to cpufreq-mediatek-hw.yaml? The names/title
> > > look
> > > unfortunately too similar.
> > 
> > No, mediatek-cpufreq is performing in kernel driver rather than on
> > hardware.
> > On the other hand, mediatek-cpufreq-hw is performing on hardware.
> > That's why "hw" is present in its name.
> 
> Unfortunately, I do not get it. The bindings are only about hardware,
> so
> how bindings could be about CPU frequency scaling not in hardware?

Sorry, let me correct my statements.

For mediatek-cpufreq here, the required hardware are clock and
regulator which have to be under control of mediatek-cpufreq. That's
the reason why it needs bindings.

mediatek-cpufreq scales up and down voltage and frequency via kernel
framework of clock and regulator, however, mediatek-cpufreq-hw delegate
the voltage and frequency control to a hardware agent instead.

> 
> > 
> > > 
> > > In general this does not look like proper bindings (see also
> > > below
> > > lack
> > > of compatible). Bindings describe the hardware, so what is
> > > exactly
> > > the
> > > hardware here?
> > 
> > Except for SoC, there's no requirement of hardware binding for
> > mediatek-cpufreq.
> > mediatek-cpufreq recognizes the compatible of Mediatek SoC while
> > probing.
> 
> What is the hardware here? If there is no requirement for bindings
> for
> mediate-cpufreq, why do we have this patch here?

Sorry, that's my mistake.
Clock and regulator are required hardware for mediatek-cpufreq.

> 
> > 
> > > 
> > > > +
> > > > +maintainers:
> > > > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > > +
> > > > +description: |
> > > > +  CPUFREQ is used for scaling clock frequency of CPUs.
> > > > +  The module cooperates with CCI DEVFREQ to manage frequency
> > > > for
> > > > some Mediatek
> > > > +  SoCs.
> > > > +
> > > > +properties:
> > > 
> > > How is this schema going to be applied? I don't see here select
> > > neither
> > > compatible.
> > 
> > As mentioned above, only compatible of SoC is required for
> > mediatek-
> > cpufreq.
> 
> It does not answer my questions. How the schema is going to be
> applied?

Currently, we do use compatible of SoC to probe mediatek-cpufreq.

If the better way is using clock and regulator opp, do you have a
suggestion to approach that?
I mean I can't find a good example from other vendors trying to do that
way. Or maybe I miss something?

> 
> 
> Best regards,
> Krzysztof


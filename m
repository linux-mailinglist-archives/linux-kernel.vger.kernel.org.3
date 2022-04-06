Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2234F5E36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiDFMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiDFMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:40:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF224F501;
        Wed,  6 Apr 2022 01:42:24 -0700 (PDT)
X-UUID: e397f6d152cc4f0c955b648740969813-20220406
X-UUID: e397f6d152cc4f0c955b648740969813-20220406
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 459747624; Wed, 06 Apr 2022 16:42:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Apr 2022 16:42:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 16:42:18 +0800
Message-ID: <d44ab059acdb92dc3e6b84f2ffb27964ecd97c84.camel@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform
 cpufreq-mediatek into yaml
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
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
Date:   Wed, 6 Apr 2022 16:42:17 +0800
In-Reply-To: <56c5870e-bc41-39be-6b53-785396d8812b@linaro.org>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-2-jia-wei.chang@mediatek.com>
         <ee98d248-b2cd-e975-84df-448917a79287@canonical.com>
         <2cf526d400c011b5172ba4fc2c3f03b4a4f371dc.camel@mediatek.com>
         <96a823a2-f3b6-9fb7-c9d6-f1315f6056fd@kernel.org>
         <de1751bb13fb14b591fbe046ff274530ad62162e.camel@mediatek.com>
         <56c5870e-bc41-39be-6b53-785396d8812b@linaro.org>
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

On Fri, 2022-04-01 at 18:32 +0200, Krzysztof Kozlowski wrote:
> On 01/04/2022 15:26, Jia-Wei Chang wrote:
> > On Thu, 2022-03-24 at 11:33 +0100, Krzysztof Kozlowski wrote:
> > > On 24/03/2022 10:38, Jia-Wei Chang wrote:
> > > > > 
> > > > > > 
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > > mediatek.yaml
> > > > > > b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > > mediatek.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..584946eb3790
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > > mediatek.yaml
> > > > > > @@ -0,0 +1,131 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: 
> > > > > > 
> > 
> > 
https://urldefense.com/v3/__http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2NdpChkMA$
> > > > > >  
> > > > > > +$schema: 
> > > > > > 
> > 
> > 
https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2O8T_oxCQ$
> > > > > >  
> > > > > > +
> > > > > > +title: Mediatek CPUFREQ driver Device Tree Bindings
> > > > > 
> > > > > Please remove "driver Device Tree Bindings" because the title
> > > > > should
> > > > > describe the hardware. Therefore it could be something like
> > > > > "Mediatek
> > > > > SoC CPU frequency and voltage scaling".
> > > > 
> > > > Thanks for your suggestion of title.
> > > > Or should I use the origin title "Binding for MediaTek's
> > > > CPUFreq
> > > > driver"?
> > > 
> > > Mediatek CPUFREQ
> > > or
> > > Mediatek CPU frequency scaling
> > 
> > Ok, I will choose one of it.
> > 
> > > 
> > > > 
> > > > > 
> > > > > How is it related to cpufreq-mediatek-hw.yaml? The
> > > > > names/title
> > > > > look
> > > > > unfortunately too similar.
> > > > 
> > > > No, mediatek-cpufreq is performing in kernel driver rather than
> > > > on
> > > > hardware.
> > > > On the other hand, mediatek-cpufreq-hw is performing on
> > > > hardware.
> > > > That's why "hw" is present in its name.
> > > 
> > > Unfortunately, I do not get it. The bindings are only about
> > > hardware,
> > > so
> > > how bindings could be about CPU frequency scaling not in
> > > hardware?
> > 
> > Sorry, let me correct my statements.
> > 
> > For mediatek-cpufreq here, the required hardware are clock and
> > regulator which have to be under control of mediatek-cpufreq.
> > That's
> > the reason why it needs bindings.
> > 
> > mediatek-cpufreq scales up and down voltage and frequency via
> > kernel
> > framework of clock and regulator, however, mediatek-cpufreq-hw
> > delegate
> > the voltage and frequency control to a hardware agent instead.
> 
> OK, that makes sense, thanks for explanation.
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > In general this does not look like proper bindings (see also
> > > > > below
> > > > > lack
> > > > > of compatible). Bindings describe the hardware, so what is
> > > > > exactly
> > > > > the
> > > > > hardware here?
> > > > 
> > > > Except for SoC, there's no requirement of hardware binding for
> > > > mediatek-cpufreq.
> > > > mediatek-cpufreq recognizes the compatible of Mediatek SoC
> > > > while
> > > > probing.
> > > 
> > > What is the hardware here? If there is no requirement for
> > > bindings
> > > for
> > > mediate-cpufreq, why do we have this patch here?
> > 
> > Sorry, that's my mistake.
> > Clock and regulator are required hardware for mediatek-cpufreq.
> > 
> > > 
> > > > 
> > > > > 
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +  CPUFREQ is used for scaling clock frequency of CPUs.
> > > > > > +  The module cooperates with CCI DEVFREQ to manage
> > > > > > frequency
> > > > > > for
> > > > > > some Mediatek
> > > > > > +  SoCs.
> > > > > > +
> > > > > > +properties:
> > > > > 
> > > > > How is this schema going to be applied? I don't see here
> > > > > select
> > > > > neither
> > > > > compatible.
> > > > 
> > > > As mentioned above, only compatible of SoC is required for
> > > > mediatek-
> > > > cpufreq.
> > > 
> > > It does not answer my questions. How the schema is going to be
> > > applied?
> > 
> > Currently, we do use compatible of SoC to probe mediatek-cpufreq.
> 
> Probing and binding to compatible is correct, but there is no
> compatible
> here, so the schema is a no-op. Does nothing.

Correct. I will update it in the next version.

> 
> > If the better way is using clock and regulator opp, do you have a
> > suggestion to approach that?
> > I mean I can't find a good example from other vendors trying to do
> > that
> > way. Or maybe I miss something?
> 
> One other way (proper) is to use cpufreq-dt and existing bindings. I
> understand that maybe you need some specific bindings here, but I
> fail
> to see how they would work. IOW, you don't have the compatible, no
> select, so nothing can use these bindings. Also bindings do not refer
> to
> any specific hardware, like SoC model.
> 
> It's good that you try to convert existing bindings to DT schema, but
> with that they should be probably fixed/updated to match proper
> bindings.

I got it. I will add compatible information to property of bindings and
dts example here as well.

Should I split the overall change of yaml into two patches? One for
conversion of bindings and the other for the rest of change.

> 
> Best regards,
> Krzysztof


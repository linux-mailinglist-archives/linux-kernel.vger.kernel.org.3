Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96BF4E6132
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349289AbiCXJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbiCXJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:39:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B4124BDC;
        Thu, 24 Mar 2022 02:38:18 -0700 (PDT)
X-UUID: 0cec53a16ece475bade4477638f50375-20220324
X-UUID: 0cec53a16ece475bade4477638f50375-20220324
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 742649390; Thu, 24 Mar 2022 17:38:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 24 Mar 2022 17:38:09 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 17:38:09 +0800
Message-ID: <2cf526d400c011b5172ba4fc2c3f03b4a4f371dc.camel@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform
 cpufreq-mediatek into yaml
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
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
Date:   Thu, 24 Mar 2022 17:38:09 +0800
In-Reply-To: <ee98d248-b2cd-e975-84df-448917a79287@canonical.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-2-jia-wei.chang@mediatek.com>
         <ee98d248-b2cd-e975-84df-448917a79287@canonical.com>
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

Dear Krzysztof,

Thanks for your comments.
Pardon me for not being familiar with upstream rules and my late reply.
I was supposed to have an internal review before submission and I will.

On Mon, 2022-03-07 at 19:57 +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 13:21, Tim Chang wrote:
> > convert Mediatek cpufreq devicetree binding to YAML.
> 
> Start with capital letter please.

Sure, I will update it in the next version.

> > 
> > Signed-off-by: Jia-Wei Chang <
> > jia-wei.chang@mediatek.corp-partner.google.com>
> > ---
> >  .../bindings/cpufreq/cpufreq-mediatek.yaml    | 131
> > ++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> 
> You wrote "convert" but where is the removal of TXT?

Sorry, I missed it and I will fix it in the next version.

> 
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml
> > new file mode 100644
> > index 000000000000..584946eb3790
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.yaml
> > @@ -0,0 +1,131 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2NdpChkMA$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2O8T_oxCQ$
> >  
> > +
> > +title: Mediatek CPUFREQ driver Device Tree Bindings
> 
> Please remove "driver Device Tree Bindings" because the title should
> describe the hardware. Therefore it could be something like "Mediatek
> SoC CPU frequency and voltage scaling".

Thanks for your suggestion of title.
Or should I use the origin title "Binding for MediaTek's CPUFreq
driver"?

> 
> How is it related to cpufreq-mediatek-hw.yaml? The names/title look
> unfortunately too similar.

No, mediatek-cpufreq is performing in kernel driver rather than on
hardware.
On the other hand, mediatek-cpufreq-hw is performing on hardware.
That's why "hw" is present in its name.

> 
> In general this does not look like proper bindings (see also below
> lack
> of compatible). Bindings describe the hardware, so what is exactly
> the
> hardware here?

Except for SoC, there's no requirement of hardware binding for
mediatek-cpufreq.
mediatek-cpufreq recognizes the compatible of Mediatek SoC while
probing.

> 
> > +
> > +maintainers:
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > +
> > +description: |
> > +  CPUFREQ is used for scaling clock frequency of CPUs.
> > +  The module cooperates with CCI DEVFREQ to manage frequency for
> > some Mediatek
> > +  SoCs.
> > +
> > +properties:
> 
> How is this schema going to be applied? I don't see here select
> neither
> compatible.

As mentioned above, only compatible of SoC is required for mediatek-
cpufreq.

> 
> > +  clocks:
> > +    items:
> > +      - description:
> > +          The first one is the multiplexer for clock input of CPU
> > cluster.
> > +      - description:
> > +          The other is used as an intermediate clock source when
> > the original
> > +          CPU is under transition and not stable yet.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: "cpu"
> > +      - const: "intermediate"
> > +
> > +  operating-points-v2:
> > +    description:
> > +      For details, please refer to
> > +      Documentation/devicetree/bindings/opp/opp-v2.yaml
> > +
> > +  opp-table: true
> 
> You have operating-points-v2. What is this for? Did it exist in
> original
> bindings?

Yes, all of these properties exist in the original bindings.
operating-point-v2 is used to determine the voltage and frequency of
dvfs which is further utilized by mediatek-cpufreq here.

> 
> > +
> > +  proc-supply:
> > +    description:
> > +      Phandle of the regulator for CPU cluster that provides the
> > supply
> > +      voltage.
> > +
> > +  sram-supply:
> > +    description:
> > +      Phandle of the regulator for sram of CPU cluster that
> > provides the supply
> > +      voltage. When present, the cpufreq driver needs to do
> > "voltage tracking"
> > +      to step by step scale up/down Vproc and Vsram to fit SoC
> > specific needs.
> > +      When absent, the voltage scaling flow is handled by
> > hardware, hence no
> > +      software "voltage tracking" is needed.
> > +
> > +  "#cooling-cells":
> > +    description:
> > +      For details, please refer to
> > +      Documentation/devicetree/bindings/thermal/thermal-cooling-
> > devices.yaml
> 
> Skip description, it's obvious. Instead add here const with value.

Sure, I'll remove description and add const value in the next version.

> 
> 
> Best regards,
> Krzysztof


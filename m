Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E41E4E613B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiCXJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiCXJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:44:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CA9F397;
        Thu, 24 Mar 2022 02:42:37 -0700 (PDT)
X-UUID: 4f954e6c32d645d4a4e9e3c6011611e7-20220324
X-UUID: 4f954e6c32d645d4a4e9e3c6011611e7-20220324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1360054208; Thu, 24 Mar 2022 17:42:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 24 Mar 2022 17:42:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Mar
 2022 17:42:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 17:42:29 +0800
Message-ID: <c150e9ed7faa4c06f55f7d7623655b65c8575121.camel@mediatek.com>
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq
 dt-bindings
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
Date:   Thu, 24 Mar 2022 17:42:29 +0800
In-Reply-To: <d5c5e3f7-7f50-6c57-f82a-41d5494ea514@canonical.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-3-jia-wei.chang@mediatek.com>
         <d5c5e3f7-7f50-6c57-f82a-41d5494ea514@canonical.com>
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

On Mon, 2022-03-07 at 19:59 +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 13:21, Tim Chang wrote:
> > 1. add cci property.
> > 2. add example of MT8186.
> 
> One logical change at a time. Are these related? Why entirely new
> example just for "cci" node? Maybe this should be part of existing
> example?

Yes, the cci property is required in some SoC, e.g. mt8183 and mt8186,
because cpu and cci share the same power supplies.
I will update the commit message and add an example of mt8186 to
present usage of cci.

> 
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
> This does not look like a standard type, so you need type.

Sure, I will add the type for it in the next version.

> 
> 
> 
> Best regards,
> Krzysztof


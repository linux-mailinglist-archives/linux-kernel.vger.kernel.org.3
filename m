Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3614EEE30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbiDANed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346390AbiDANe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:34:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464EE27E843;
        Fri,  1 Apr 2022 06:32:38 -0700 (PDT)
X-UUID: 6fd7bcdb20df4918b71ce6db4b724572-20220401
X-UUID: 6fd7bcdb20df4918b71ce6db4b724572-20220401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 849117271; Fri, 01 Apr 2022 21:32:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 Apr 2022 21:32:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 21:32:32 +0800
Message-ID: <14bfabd88ecbe8cc4ec359f8249f180128a6572e.camel@mediatek.com>
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq
 dt-bindings
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
Date:   Fri, 1 Apr 2022 21:32:32 +0800
In-Reply-To: <18c791ce-059a-87a5-eaf4-057f8e232fe7@kernel.org>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-3-jia-wei.chang@mediatek.com>
         <d5c5e3f7-7f50-6c57-f82a-41d5494ea514@canonical.com>
         <c150e9ed7faa4c06f55f7d7623655b65c8575121.camel@mediatek.com>
         <18c791ce-059a-87a5-eaf4-057f8e232fe7@kernel.org>
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

On Thu, 2022-03-24 at 11:35 +0100, Krzysztof Kozlowski wrote:
> On 24/03/2022 10:42, Jia-Wei Chang wrote:
> > On Mon, 2022-03-07 at 19:59 +0100, Krzysztof Kozlowski wrote:
> > > On 07/03/2022 13:21, Tim Chang wrote:
> > > > 1. add cci property.
> > > > 2. add example of MT8186.
> > > 
> > > One logical change at a time. Are these related? Why entirely new
> > > example just for "cci" node? Maybe this should be part of
> > > existing
> > > example?
> > 
> > Yes, the cci property is required in some SoC, e.g. mt8183 and
> > mt8186,
> > because cpu and cci share the same power supplies.
> 
> I asked why this cannot be part of existing example.

I misunderstood that.
I will update the complete example in the next version.

> 
> > I will update the commit message and add an example of mt8186 to
> > present usage of cci.
> 
> You added the example here, didn't you?

Yes, I did add it here.

> 
> Best regards,
> Krzysztof


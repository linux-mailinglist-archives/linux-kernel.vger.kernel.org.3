Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51F4F5AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiDFKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiDFKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:15:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937203BD257;
        Tue,  5 Apr 2022 20:32:24 -0700 (PDT)
X-UUID: ee9315ccb60b4dfa9d5938f31a8092b2-20220406
X-UUID: ee9315ccb60b4dfa9d5938f31a8092b2-20220406
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1518079559; Wed, 06 Apr 2022 11:32:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 6 Apr 2022 11:32:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 11:32:18 +0800
Message-ID: <41781640ceee45e763bb0f3d6c765fea76826fa5.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: devfreq: mediatek: add mtk cci devfreq
 dt-bindings
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Wed, 6 Apr 2022 11:32:18 +0800
In-Reply-To: <ac0e3336-f9eb-def9-68ea-ab49e2c467a1@kernel.org>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
         <20220307122513.11822-2-jia-wei.chang@mediatek.com>
         <bf418e08-2e32-5e61-abd8-abb0d8f5c080@canonical.com>
         <13482b1b4244df5c0c0a4d6a60cdb2a7ba88500a.camel@mediatek.com>
         <aa34eccf-ef08-4a8f-7a6c-7fbd05bd54b6@kernel.org>
         <126e0905c2eb9f22a0be46dd7aa8ac891622346d.camel@mediatek.com>
         <ac0e3336-f9eb-def9-68ea-ab49e2c467a1@kernel.org>
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

On Sat, 2022-04-02 at 13:31 +0200, Krzysztof Kozlowski wrote:
> On 01/04/2022 15:39, Jia-Wei Chang wrote:
> > > > > 
> > > > > > +
> > > > > > +  operating-points-v2:
> > > > > > +    description:
> > > > > > +      For details, please refer to
> > > > > > +      Documentation/devicetree/bindings/opp/opp-v2.yaml
> > > > > > +
> > > > > > +  opp-table: true
> > > > > 
> > > > > Same comments as your CPU freq bindings apply.
> > > > 
> > > > mtk-cci-devfreq is a new driver and its arch is same as
> > > > mediatek-
> > > > cpufreq so that the properties of mtk-cci are refer to
> > > > mediatek-
> > > > cpufreq 
> > > > bindings.
> > > > operating-point-v2 is used to determine the voltage and
> > > > frequency
> > > > of
> > > > dvfs which is further utilized by mtk-cci-devfreq.
> > > 
> > > "operating-point-v2" is understood, but the same as in cpufreq
> > > bindings,
> > > I am questioning why do you have "opp-table: true". It's a bit
> > > confusing, so maybe I miss something?
> > 
> > Yes, you're correct.
> > "opp-table: true" should be removed.
> > I messed it up.
> 
> No, I think I was wrong. The opp-table pretty frequently is embedded
> in
> the the device node itself. The operating-points-v2 references it.
> 
> You don't use it in the example, but it might be a valid usage, so it
> can stay. Sorry for the confusion, it passed some time since I looked
> at
> OPP bindings.

You remind me of "opp-table: true" and the reason why I use it here is
exactly as you mentioned. Sorry I was not familiar enough with this to
respond it clearly and confidently.

I think it is proper to keep "opp-table: true" and add a complete opp
table information in dts example here as well.

Thanks for your comments.

> 
> 
> Best regards,
> Krzysztof


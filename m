Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BBB50F494
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbiDZIhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbiDZIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602774848;
        Tue, 26 Apr 2022 01:27:00 -0700 (PDT)
X-UUID: d252231955874f388ed19aaa27160fc0-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:12f92259-211b-468d-92b1-beb7f924bcc5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:12f92259-211b-468d-92b1-beb7f924bcc5,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:a5e6bb2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: d252231955874f388ed19aaa27160fc0-20220426
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 465555622; Tue, 26 Apr 2022 16:26:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 26 Apr 2022 16:26:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 16:26:54 +0800
Message-ID: <1ec1f18809a75faef249cf2303dd19d26c51afff.camel@mediatek.com>
Subject: Re: [PATCH V4 01/14] dt-bindings: cpufreq: mediatek: Add MediaTek
 CCI property
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 26 Apr 2022 16:26:54 +0800
In-Reply-To: <9ff80bc2-d63b-14aa-5769-20bff6e3a21e@linaro.org>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-2-rex-bc.chen@mediatek.com>
         <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
         <811bf944-a230-ab9b-583a-840e57af8a1e@linaro.org>
         <28f75ac2995b116af9b2accf760786d1d1798c93.camel@mediatek.com>
         <7873f0fa-25c3-191f-5096-3ceb9afd50cc@linaro.org>
         <c1b910098a0a5cbe06ec971c1bf745ac37986274.camel@mediatek.com>
         <9ff80bc2-d63b-14aa-5769-20bff6e3a21e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 12:52 +0200, Krzysztof Kozlowski wrote:
> On 25/04/2022 12:20, Rex-BC Chen wrote:
> > > However I am not sure if you solved your problem... see below:
> > > 
> > > > For example:
> > > > mediatek cci set 1.2V originally. When cpufreq want to adjust
> > > > lower
> > > > frequency adn set voltage to 1.0V.
> > > > The framework will remain using 1.2V to prevent crash of
> > > > mediatek
> > > > cci.
> > > 
> > > No, regulator_set_voltage() for proc_reg says:
> > > "NOTE: If the regulator is shared between several devices then
> > > the
> > > lowest
> > >  request voltage that meets the system constraints will be used."
> > > 
> > > Not the highest. So when your devfreq and cpufreq boots, calling
> > > regulator_set_voltage will still cause high frequency and low
> > > voltage.
> > > 
> > 
> > From the driver comment, I think it still needs to match "meets the
> > system constraints".
> > 
> > From drivers, we can trace the driver and it finally to
> > regulator_get_optimal_voltage().
> > In [1], the framework will get max voltage while finding each
> > device's
> > voltage.
> > 
> > [1]: 
> > 
https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c*L3815__;Iw!!CTRNKA9wMg0ARbw!35L9ISPWDpbGPsLEc0935D2nWTLtaLSNfPipvteddPaxwO2i_KaN0wfWegpkyaPjjagW$
> >  
> 
> Right, actually in your case it's the regulator_check_consumers()
> above
> that line, because you
> 
> I think it's quite generic problem, so would be worth solving for
> more
> regulator consumers, but your approach is fine. At least I do not
> have
> anything smarter, at the moment.
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for your review!
I will send next version to modify the description of mediatek,cci when
the driver part is explained clear.

BRs,
Rex


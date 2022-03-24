Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB834E614A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiCXJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiCXJun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:50:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A84EF6F;
        Thu, 24 Mar 2022 02:49:11 -0700 (PDT)
X-UUID: b52eb9a7d30c473c87e0d2785ec59a2c-20220324
X-UUID: b52eb9a7d30c473c87e0d2785ec59a2c-20220324
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 158482102; Thu, 24 Mar 2022 17:49:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 17:49:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 17:49:07 +0800
Message-ID: <076256c903e71137b4b4b2891388509ceb009dfa.camel@mediatek.com>
Subject: Re: [PATCH 4/4] cpufreq: mediatek: add platform data and clean up
 voltage tracking logic
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
Date:   Thu, 24 Mar 2022 17:49:07 +0800
In-Reply-To: <a728aaa0-bde9-b9a9-971a-2e4b52f2b7bf@canonical.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-5-jia-wei.chang@mediatek.com>
         <a728aaa0-bde9-b9a9-971a-2e4b52f2b7bf@canonical.com>
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

On Mon, 2022-03-07 at 20:03 +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 13:21, Tim Chang wrote:
> > 1. add required header files and remove unnecessary header files.
> > 2. some soc needs different min/max voltage shift and voltage
> > tracking
> >    attributes. make these variables into platform data to support
> >    future soc.
> > 3. add need_voltage_tracking variable to platforma data. if true,
> > it
> >    indicates soc is required to realize the voltage tracking
> > between
> >    voltage of sram and voltage of cpu by software approach.
> > otherwise,
> >    the voltage tracking is realized by hardware approach.
> > 4. add opp frequency look-up function as mtk_cpufreq_get() and
> >    registered in cpufreq framework.
> > 5. update voltage_tracking() logic and drv_init(). in drv_init(),
> > it
> >    always sets highest opp voltage before return. it could prevent
> > from
> >    high-freqeuncy-low-voltage issue if two or more clients using
> > the
> >    same regulator.
> 
> One change at a time.

Sure, I will split the change and send one change in one commit.

> 
> > 
> > Signed-off-by: Jia-Wei Chang <
> > jia-wei.chang@mediatek.corp-partner.google.com>
> 
> Your SoB does not match from field.

I will update it for the whole series in next version.

> 
> Best regards,
> Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C10450DDCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiDYKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiDYKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:24:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F853E11;
        Mon, 25 Apr 2022 03:21:06 -0700 (PDT)
X-UUID: 08903f58e0914418b670cfa033d53c5e-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:42a19959-8c17-493e-af10-58856b0d30c9,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:241006f0-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 08903f58e0914418b670cfa033d53c5e-20220425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 748409254; Mon, 25 Apr 2022 18:20:58 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Apr 2022 18:20:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 18:20:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 18:20:55 +0800
Message-ID: <c1b910098a0a5cbe06ec971c1bf745ac37986274.camel@mediatek.com>
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
Date:   Mon, 25 Apr 2022 18:20:55 +0800
In-Reply-To: <7873f0fa-25c3-191f-5096-3ceb9afd50cc@linaro.org>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-2-rex-bc.chen@mediatek.com>
         <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
         <811bf944-a230-ab9b-583a-840e57af8a1e@linaro.org>
         <28f75ac2995b116af9b2accf760786d1d1798c93.camel@mediatek.com>
         <7873f0fa-25c3-191f-5096-3ceb9afd50cc@linaro.org>
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

On Mon, 2022-04-25 at 10:55 +0200, Krzysztof Kozlowski wrote:
> On 25/04/2022 08:19, Rex-BC Chen wrote:
> > On Fri, 2022-04-22 at 19:34 +0200, Krzysztof Kozlowski wrote:
> > > On 22/04/2022 19:26, Krzysztof Kozlowski wrote:
> > > > On 22/04/2022 09:52, Rex-BC Chen wrote:
> > > > > MediaTek Cache Coherent Interconnect (CCI) uses software
> > > > > devfreq
> > > > > module
> > > > > for scaling clock frequency and adjust voltage.
> > > > > The phandle could be linked between CPU and MediaTek CCI for
> > > > > some
> > > > > MediaTek SoCs, like MT8183 and MT8186.
> > > > > Therefore, we add this property in cpufreq-mediatek.txt.
> > > > > 
> > > > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > > > ---
> > > > >  .../devicetree/bindings/cpufreq/cpufreq-
> > > > > mediatek.txt         | 5
> > > > > +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > mediatek.txt
> > > > > b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > mediatek.txt
> > > > > index b8233ec91d3d..3387e1e2a2df 100644
> > > > > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > mediatek.txt
> > > > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > > > mediatek.txt
> > > > > @@ -20,6 +20,11 @@ Optional properties:
> > > > >  	       Vsram to fit SoC specific needs. When absent,
> > > > > the
> > > > > voltage scaling
> > > > >  	       flow is handled by hardware, hence no software
> > > > > "voltage
> > > > > tracking" is
> > > > >  	       needed.
> > > > > +- mediatek,cci:
> > > > > +	MediaTek Cache Coherent Interconnect (CCI) uses the
> > > > > software
> > > > > devfreq module to
> > > > > +	scale the clock frequency and adjust the voltage.
> > > > 
> > > > Devfreq is a SW mechanism, it should not be part of bindings
> > > > description.
> > 
> > Hello Krzysztof,
> > 
> > The reason we want to get the "mediatek,cci":
> > We need to check the mediatek cci is ready and probed done.
> > Because cpufreq and mediatek cci are sharing the same regulator in
> > little core cpus.
> > Therefore, to prevent high frequency low voltage issue, we need to
> > make
> > sure the mediatek cci is ready.
> > 
> > If mediatek cci is ready, cpufreq and mediatek cci will register
> > the
> > same regulator and from regulator's implementation, if there are
> > two
> > device using the same regulator, the framwork will make sure it's
> > using
> > the max voltage.
> 
> Thanks for explanation. The property should be described with what
> you
> said here. The property and description should match hardware, so
> there
> is no place for devfreq. Instead mention that power rail is shared or
> voltage regulators are common.
> 

Hello Krzysztof,

I will modify the description to the reason why we need mediatek,cci.

> However I am not sure if you solved your problem... see below:
> 
> > For example:
> > mediatek cci set 1.2V originally. When cpufreq want to adjust lower
> > frequency adn set voltage to 1.0V.
> > The framework will remain using 1.2V to prevent crash of mediatek
> > cci.
> 
> No, regulator_set_voltage() for proc_reg says:
> "NOTE: If the regulator is shared between several devices then the
> lowest
>  request voltage that meets the system constraints will be used."
> 
> Not the highest. So when your devfreq and cpufreq boots, calling
> regulator_set_voltage will still cause high frequency and low
> voltage.
> 

From the driver comment, I think it still needs to match "meets the
system constraints".

From drivers, we can trace the driver and it finally to
regulator_get_optimal_voltage().
In [1], the framework will get max voltage while finding each device's
voltage.

[1]: 
https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L3815

> > 
> > Therefore, we need to confirm the mediatek cci is ready and
> > register
> > the regulator.
> > 
> > > > 
> > > > > +	For details, please refer to
> > > > > +	Documentation/devicetree/bindings/interconnect/mediatek
> > > > > ,cci.yam
> > > > > l
> > > > 
> > > > Since the file does not exist, I have troubles reviewing it.
> > > > First
> > > > of
> > > > all, you already have "mediatek,cci-control" property in DT, so
> > > > why
> > > > using different name?
> > 
> > I am not sure where is "mediatek,cci-control". I think this name is
> > not
> > used before.
> > 
> 
> Documentation/devicetree/bindings/net/mediatek-net.txt
> 
> > > > 
> > > > Second, it looks like you want to put devfreq into bindings
> > > > instead
> > > > of
> > > > using proper interconnect bindings.
> > > 
> > > Actually judging by the driver this looks like some
> > > device-boot-time-ordering, so I wonder whether this is a proper
> > > way
> > > to
> > > express it.
> > 
> > Yes, we need to get the mediatek cci node and let cpufreq and
> > mediatek
> > cci link succefully. In that case, we can know the mediatek cci is
> > ready. And we can set the voltage using the regulator framwork.
> > 
> > [1]: 
> > 
https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220422075239.16437-11-rex-bc.chen@mediatek.com/__;!!CTRNKA9wMg0ARbw!xOuKKyjBosmRcUseQXU9SiPu8msBXrrQAASdxwVbR0SU2inuXUtO180Y0Erkpy-JmOwu$
> >  
> 
> Yes, I see the use case. I am not convinced yet whether this is
> proper
> approach...
> 

When mediatek cci is ready (probe done and register regulator done), we
can confirm that regulator framwork will make sure the voltage setting
is safe.

BRs,
Rex

> 
> Best regards,
> Krzysztof


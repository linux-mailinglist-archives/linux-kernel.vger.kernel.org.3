Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3150D95F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiDYGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiDYGXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:23:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351BF39686;
        Sun, 24 Apr 2022 23:20:01 -0700 (PDT)
X-UUID: 3d60d7f6bf3441559828bd996a1967e1-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3d1af839-fdae-4626-8d32-4624b770c9da,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:33f4d2f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3d60d7f6bf3441559828bd996a1967e1-20220425
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1599255307; Mon, 25 Apr 2022 14:19:55 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Apr 2022 14:19:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 14:19:51 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 14:19:51 +0800
Message-ID: <28f75ac2995b116af9b2accf760786d1d1798c93.camel@mediatek.com>
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
Date:   Mon, 25 Apr 2022 14:19:51 +0800
In-Reply-To: <811bf944-a230-ab9b-583a-840e57af8a1e@linaro.org>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-2-rex-bc.chen@mediatek.com>
         <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
         <811bf944-a230-ab9b-583a-840e57af8a1e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-22 at 19:34 +0200, Krzysztof Kozlowski wrote:
> On 22/04/2022 19:26, Krzysztof Kozlowski wrote:
> > On 22/04/2022 09:52, Rex-BC Chen wrote:
> > > MediaTek Cache Coherent Interconnect (CCI) uses software devfreq
> > > module
> > > for scaling clock frequency and adjust voltage.
> > > The phandle could be linked between CPU and MediaTek CCI for some
> > > MediaTek SoCs, like MT8183 and MT8186.
> > > Therefore, we add this property in cpufreq-mediatek.txt.
> > > 
> > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt         | 5
> > > +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > mediatek.txt
> > > index b8233ec91d3d..3387e1e2a2df 100644
> > > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > mediatek.txt
> > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > > mediatek.txt
> > > @@ -20,6 +20,11 @@ Optional properties:
> > >  	       Vsram to fit SoC specific needs. When absent, the
> > > voltage scaling
> > >  	       flow is handled by hardware, hence no software "voltage
> > > tracking" is
> > >  	       needed.
> > > +- mediatek,cci:
> > > +	MediaTek Cache Coherent Interconnect (CCI) uses the software
> > > devfreq module to
> > > +	scale the clock frequency and adjust the voltage.
> > 
> > Devfreq is a SW mechanism, it should not be part of bindings
> > description.

Hello Krzysztof,

The reason we want to get the "mediatek,cci":
We need to check the mediatek cci is ready and probed done.
Because cpufreq and mediatek cci are sharing the same regulator in
little core cpus.
Therefore, to prevent high frequency low voltage issue, we need to make
sure the mediatek cci is ready.

If mediatek cci is ready, cpufreq and mediatek cci will register the
same regulator and from regulator's implementation, if there are two
device using the same regulator, the framwork will make sure it's using
the max voltage.
For example:
mediatek cci set 1.2V originally. When cpufreq want to adjust lower
frequency adn set voltage to 1.0V.
The framework will remain using 1.2V to prevent crash of mediatek cci.

Therefore, we need to confirm the mediatek cci is ready and register
the regulator.

> > 
> > > +	For details, please refer to
> > > +	Documentation/devicetree/bindings/interconnect/mediatek,cci.yam
> > > l
> > 
> > Since the file does not exist, I have troubles reviewing it. First
> > of
> > all, you already have "mediatek,cci-control" property in DT, so why
> > using different name?

I am not sure where is "mediatek,cci-control". I think this name is not
used before.

> > 
> > Second, it looks like you want to put devfreq into bindings instead
> > of
> > using proper interconnect bindings.
> 
> Actually judging by the driver this looks like some
> device-boot-time-ordering, so I wonder whether this is a proper way
> to
> express it.

Yes, we need to get the mediatek cci node and let cpufreq and mediatek
cci link succefully. In that case, we can know the mediatek cci is
ready. And we can set the voltage using the regulator framwork.

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220422075239.16437-11-rex-bc.chen@mediatek.com/

BRs,
Rex
> 
> 
> Best regards,
> Krzysztof


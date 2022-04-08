Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67D4F92DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiDHK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiDHK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:27:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590025F651;
        Fri,  8 Apr 2022 03:24:53 -0700 (PDT)
X-UUID: e076817dd6434f348d7a6e4cc24b21cb-20220408
X-UUID: e076817dd6434f348d7a6e4cc24b21cb-20220408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1050780404; Fri, 08 Apr 2022 18:24:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 18:24:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 18:24:47 +0800
Message-ID: <8d466903d42dbc823f4d0a245378d983ab904435.camel@mediatek.com>
Subject: Re: [PATCH V2 01/15] dt-bindings: cpufreq: mediatek: Add MediaTek
 CCI property
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 8 Apr 2022 18:24:47 +0800
In-Reply-To: <a171f33c-cda1-8602-ac67-93076b676578@linaro.org>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-2-rex-bc.chen@mediatek.com>
         <a171f33c-cda1-8602-ac67-93076b676578@linaro.org>
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

On Fri, 2022-04-08 at 10:10 +0200, Krzysztof Kozlowski wrote:
> On 08/04/2022 06:58, Rex-BC Chen wrote:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > MediaTek Cache Coherent Interconnect (CCI) uses software devfreq
> > module
> > for scaling clock frequency and adjust voltage.
> > The phandle could be linked between CPU and MediaTek CCI for some
> > MediaTek SoCs, like MT8183 and MT8186.
> > Therefore, we add this property in cpufreq-mediatek.txt.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt          | 4
> > ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.txt
> > index b8233ec91d3d..d1b3d430c25c 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek.txt
> > @@ -20,6 +20,10 @@ Optional properties:
> >  	       Vsram to fit SoC specific needs. When absent, the
> > voltage scaling
> >  	       flow is handled by hardware, hence no software "voltage
> > tracking" is
> >  	       needed.
> > +- cci: MediaTek Cache Coherent Interconnect uses software devfreq
> > module for scaling
> > +       clock frequency and adjust voltage.
> 
> You need to describe the type. I am a bit confused whether this is a
> cci
> (so cci-control-port property?) or an interconnect (so interconnect
> property)... It does not look like a generic property, so you need
> vendor prefix.

Hello Krzysztof,

Thanks for your review.

Yes, this cci is not arm's cci (cci-control-port property), and it's
mediatek's cci. I will revise this name to "mtk-cci" in next version.

> 
> > +       For details, please refer to
> > +       Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> 
> Such file does not exist.

This mediatek cci is still upstreaming in this patch:
message-id:20220408052150.22536-2-johnson.wang@mediatek.com

Do you have suggestion that I should put this reference?
Or I just remove it and describe the mediatek cci in detail?

BRs,
Rex
> 
> 
> Best regards,
> Krzysztof


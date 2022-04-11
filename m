Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC04F4FB3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbiDKGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiDKGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:51:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44418C3;
        Sun, 10 Apr 2022 23:49:07 -0700 (PDT)
X-UUID: 629b40469371445890242bf9eddf07fe-20220411
X-UUID: 629b40469371445890242bf9eddf07fe-20220411
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 657101163; Mon, 11 Apr 2022 14:49:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 14:48:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 14:48:59 +0800
Message-ID: <292e5b8df8a011fdbb9c271e39ba927c6076484a.camel@mediatek.com>
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
Date:   Mon, 11 Apr 2022 14:48:59 +0800
In-Reply-To: <0ef8f2c3-fd16-041b-3304-b167a2a36ff9@linaro.org>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-2-rex-bc.chen@mediatek.com>
         <a171f33c-cda1-8602-ac67-93076b676578@linaro.org>
         <8d466903d42dbc823f4d0a245378d983ab904435.camel@mediatek.com>
         <0ef8f2c3-fd16-041b-3304-b167a2a36ff9@linaro.org>
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

On Fri, 2022-04-08 at 13:49 +0200, Krzysztof Kozlowski wrote:
> On 08/04/2022 12:24, Rex-BC Chen wrote:
> > > 
> > > You need to describe the type. I am a bit confused whether this
> > > is a
> > > cci
> > > (so cci-control-port property?) or an interconnect (so
> > > interconnect
> > > property)... It does not look like a generic property, so you
> > > need
> > > vendor prefix.
> > 
> > Hello Krzysztof,
> > 
> > Thanks for your review.
> > 
> > Yes, this cci is not arm's cci (cci-control-port property), and
> > it's
> > mediatek's cci. I will revise this name to "mtk-cci" in next
> > version.
> 
> Vendor is "mediatek" and comma comes after it. See devicetree spec
> paragraph 2.3.1.
> 

Hello Krzysztof,

OK, I will revise as "mediatek,cci" in next version.

> > 
> > > 
> > > > +       For details, please refer to
> > > > +       Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> > > 
> > > Such file does not exist.
> > 
> > This mediatek cci is still upstreaming in this patch:
> > message-id:20220408052150.22536-2-johnson.wang@mediatek.com
> > 
> > Do you have suggestion that I should put this reference?
> > Or I just remove it and describe the mediatek cci in detail?
> 
> It's ok, but you need to keep path/filename updated.
> 
> 
> Best regards,
> Krzysztof

From your comment of cci series.
I will write is to be
"Documentation/devicetree/bindings/devfreq/mediatek,cci.yaml"

Thanks!

BRs,
Rex


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB3599863
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiHSJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347426AbiHSJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:21:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A3E588D;
        Fri, 19 Aug 2022 02:21:13 -0700 (PDT)
X-UUID: 287ec98e284f4966998cf3d7f317b25a-20220819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WPx28nuo9RcwR75sB21q6ymmTD71bLmGxP0/PKNXITQ=;
        b=FU30adMy92dNfqEU4l6hLja0mdw0Qv2TpXsDEegxTnKlcAnoKOQ14GeSn7FDIxzFgvSrlJgiuDeYU6cv+8A8T5T58hiCtzZPTIp8yxnKuCWgl5kzHv1kY1FVSqRWoa0BJzknPyBTfbn1pxEDqtxoSeQDCO7zn9zA5Aww/UBfNmI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:33e0be97-958d-4f19-b732-b70b18d8cb17,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:33e0be97-958d-4f19-b732-b70b18d8cb17,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:adb2b667-a9d9-4672-a3c8-12721739a220,C
        OID:6e6f2b17f0cc,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 287ec98e284f4966998cf3d7f317b25a-20220819
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1780500561; Fri, 19 Aug 2022 17:21:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Aug 2022 17:21:05 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Aug 2022 17:21:05 +0800
Message-ID: <b36cfc74fa9f1aed5f7fe60dd810c5fcf4073b65.camel@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: add mt8188 cpufreq hw
 dt-bindings
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hector Yuan <hector.yuan@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Date:   Fri, 19 Aug 2022 17:21:05 +0800
In-Reply-To: <106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org>
References: <20220805091211.2791-1-jia-wei.chang@mediatek.com>
         <20220805091211.2791-2-jia-wei.chang@mediatek.com>
         <106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-05 at 11:18 +0200, Krzysztof Kozlowski wrote:
> On 05/08/2022 11:12, jia-wei.chang wrote:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > Add mt8188 cpufreq hw compatible in dt-bindings.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >  .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml      | 4
> > +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
> > mediatek-hw.yaml
> > b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-
> > hw.yaml
> > index 9cd42a64b13e..b56d36224612 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-
> > hw.yaml
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-
> > hw.yaml
> > @@ -16,7 +16,9 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    const: mediatek,cpufreq-hw
> > +    enum:
> > +      - mediatek,cpufreq-hw
> 
> Can you add a comment mentioning for which SoCs this is? Someone
> added a
> generic compatible covering all MediaTek cpufreq-hw (all!) and now
> you
> say it does not cover all?
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

I realized it is possible to make MT8188 completely reuse the
compatibles "mediatek,cpufreq-hw" and platform driver as well.

This series for MT8188 mediatek-cpufreq-hw is no longer required to be
reviewed.

Thanks for your help.



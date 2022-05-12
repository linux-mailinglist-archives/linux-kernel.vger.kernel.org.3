Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1752252425E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiELCQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiELCQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:16:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616641B7A4;
        Wed, 11 May 2022 19:15:58 -0700 (PDT)
X-UUID: 42a4c590455b48428919eb8086b89e23-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fff98e7f-170e-4607-bece-21ff7b8a5323,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:47
X-CID-INFO: VERSION:1.1.4,REQID:fff98e7f-170e-4607-bece-21ff7b8a5323,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:47
X-CID-META: VersionHash:faefae9,CLOUDID:e4f14025-b432-452e-9e03-2bf3148aed85,C
        OID:495731bb0d09,Recheck:0,SF:28|17|19|48,TC:nil,Content:4,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 42a4c590455b48428919eb8086b89e23-20220512
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 369692403; Thu, 12 May 2022 10:15:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 10:15:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 10:15:48 +0800
Message-ID: <cf30fef1db3f42f7c188f1488f5289517ff04844.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pmic: mt6366: add binding document
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <eddie.huang@mediatek.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <hsin-hsiung.wang@mediatek.com>,
        <sean.wang@mediatek.com>, <macpaul.lin@mediatek.com>,
        <wen.su@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 12 May 2022 10:15:48 +0800
In-Reply-To: <3e5ddde1-9d0c-a5e8-1828-aef1d1165a3e@linaro.org>
References: <20220510064603.15920-1-zhiyong.tao@mediatek.com>
         <20220510064603.15920-2-zhiyong.tao@mediatek.com>
         <6614cd3783666caa529106464e7684caf16d6582.camel@mediatek.com>
         <3e5ddde1-9d0c-a5e8-1828-aef1d1165a3e@linaro.org>
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

On Wed, 2022-05-11 at 17:36 +0200, Krzysztof Kozlowski wrote:
> On 10/05/2022 09:56, Rex-BC Chen wrote:
> > > +examples:
> > > +  - |
> > > +    pmic {
> > > +      regulators {
> > > +        mt6366_vdram1_reg: buck_vdram1 {
> > > +            regulator-name = "vdram1";
> > > +            regulator-min-microvolt = <500000>;
> > > +            regulator-max-microvolt = <2087500>;
> > > +            regulator-ramp-delay = <12500>;
> > > +            regulator-enable-ramp-delay = <0>;
> > > +            regulator-always-on;
> > > +            regulator-allowed-modes = <0 1>;
> > 
> > should be two space instead of 4 space?
> > mt6366_vdram1_reg: buck_vdram1 {
> >   regulator-name = "vdram1";
> >   ...
> > };
> > 
> > There is the same issue for this example.
> 
> Indentation is four spaces.
> 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/Documentation/devicetree/bindings/writing-schema.rst?h=for-next&id=7a150b0d850e37e7bdfc87459edd0ff302f67478*n111__;Iw!!CTRNKA9wMg0ARbw!yGLurJNfCjmllj-0EbUwL_HZef0f6MlfC8U968TLmzDG13EL7BErcZjtKu9cf6MMcz-E$
>  
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for your correction.

BRs,
Rex


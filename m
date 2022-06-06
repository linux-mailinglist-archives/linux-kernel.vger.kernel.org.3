Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2EC53DFD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbiFFCwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFFCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:52:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87630B2F;
        Sun,  5 Jun 2022 19:52:02 -0700 (PDT)
X-UUID: 22f519b0d8684bd48f0b24d3fe1e0c55-20220606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:373d1128-b6ba-4757-9a25-544eeb922b03,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:78ed3e7e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 22f519b0d8684bd48f0b24d3fe1e0c55-20220606
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 864540654; Mon, 06 Jun 2022 10:51:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 6 Jun 2022 10:51:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 6 Jun 2022 10:51:56 +0800
Message-ID: <fa71cdebe09b7939bccc3b4b4f40d62afdb09158.camel@mediatek.com>
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 6 Jun 2022 10:51:56 +0800
In-Reply-To: <2c610d82-65bf-60c8-05f3-434eaa1cfc8b@linaro.org>
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
         <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
         <eb4deff1a01c09783518bbaff8fe4e4c4ca6fa5b.camel@mediatek.com>
         <591767ee-e349-7a17-a9e9-b95d0500c7c1@linaro.org>
         <774c075ca4ad815c88be755cfb51889a171e835d.camel@mediatek.com>
         <9e3f5586-59fa-42cc-770c-b8694b4f2bf3@linaro.org>
         <a1140bd47cbd68436d0b9e147c2d6d6327ac092e.camel@mediatek.com>
         <2c610d82-65bf-60c8-05f3-434eaa1cfc8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 2022-06-02 at 14:26 +0200, Krzysztof Kozlowski wrote:
> On 02/06/2022 13:53, Tinghan Shen wrote:
> > Hi Krzysztof,
> > 
> > On Thu, 2022-06-02 at 12:45 +0200, Krzysztof Kozlowski wrote:
> > > On 02/06/2022 12:19, Tinghan Shen wrote:
> > > > Hi Krzysztof,
> > > > 
> > > > On Thu, 2022-06-02 at 09:40 +0200, Krzysztof Kozlowski wrote:
> > > > > On 02/06/2022 08:44, Tinghan Shen wrote:
> > > > > > > > +  mbox-names:
> > > > > > > > +    items:
> > > > > > > > +      - const: mbox0
> > > > > > > > +      - const: mbox1
> > > > > > > 
> > > > > > > These should be rather some meaningful names, e.g. "rx" and "tx".
> > > > > > 
> > > > > > The mbox name has to align with the adsp ipc driver.
> > > > > > The adsp ipc driver is using 'mbox%d' for mailbox channels.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > 
> > > > 
> > 
> > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c__;!!CTRNKA9wMg0ARbw!1TmempNkQhC5QuLBhyfWo_AC97MoLuWipsGV-LPaW9RKNPheU7Bgc-eboNi1JA1nC5I$
> > > > > >  
> > > > > > 
> > > > > > 	chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> > > > > > 
> > > > > > 	/* ...snip... */
> > > > > > 
> > > > > > 	adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > > > > > 
> > > > > > Is it ok to continue using these names?
> > > > > 
> > > > > It is a bit confusing... how did that driver got merged recently without
> > > > > bindings? Why bindings are separate?
> > > > > 
> > > > > The bindings always come together in one patchset with the driver
> > > > > implementing them. Bindings are though a separate patch, yet still
> > > > > followed by the driver which uses them.
> > > > > 
> > > > > I do not see any compatibles in that driver, which suggests there is no
> > > > > other binding using it. If that's correct, then you need to change the
> > > > > driver.
> > > > > 
> > > > 
> > > > The mtk-adsp-ipc driver's sole function is to encapsulate the operations 
> > > > of mailbox framework from adsp ipc users. The mtk-adsp-ipc is not defined 
> > > > in the dts file and we don't need it to be defined. The creation of mtk-adsp-ipc 
> > > > device is requested by adsp ipc users via the use of 'platform_device_register_data'[1].
> > > > 
> > > > the driver implemented the mailbox framework is 'mtk-adsp-mailbox'[2]. it has 
> > > > corresponding hardwares and a yaml file[3] to describe it.
> > > 
> > > I don't understand how is this related. We talk here about the
> > > mbox-names for this bindings file. You replied, that these bindings are
> > > already used by something, but now you say that they are not? So why do
> > > you need to change anything in any driver?
> > > 
> > > Simple question - do the bindings here "add mt8186 dsp document" are
> > > used by any specific Linux driver already?
> > 
> > This bindings, 'add mt8186 dsp document', are used by the SOF sound driver of MT8186[1]. 
> > 
> > I'm sorry for miss leading you in previous reply. I was thought that you're 
> > asking why the mtk-adsp-ipc driver got merged without bindings. So, I tried 
> > to explain why mtk-adsp-ipc doesn't have bindings.
> 
> Then my question is kind of still valid:
> How did "mt8186 SOF" driver got merged recently without bindings? Why
> bindings are separate?
> 
> You cannot just sneak in usage of bindings in a driver, then submit
> bindings and say "we already have an user!". No, the bindings come with
> the driver. Always.
> 
> Linked patch [1] brings undocumented compatible mediatek,mt8186-dsp, so
> you should see big fat warning when running checkpatch. So this points
> that you did not run checkpatch which is another not acceptable
> submission. :(
> 
> [1]
> https://lore.kernel.org/all/20220422055659.8738-2-tinghan.shen@mediatek.com/
> 

I apologize for breaking the rules and sending inappropriate patches.

I was thought that it was acceptable to send community reviewed patches in a series, 
then followed the bindings at another patch. I was believed that separating un-reviewed
binding patch from reviewed driver patches would aid in patch acceptance.
Now, I see I make a big mistake. I'm sorry.

Best regards,
TingHan





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693E853B83A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiFBLyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiFBLyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:54:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D42124F;
        Thu,  2 Jun 2022 04:54:00 -0700 (PDT)
X-UUID: 183222a3be0e4e32885b82fb4483396f-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:aac1de43-83cb-4c44-a7c1-966b469447ee,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:0a2fb26e-b02c-4af4-b838-5c14aaa063c7,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 183222a3be0e4e32885b82fb4483396f-20220602
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1510683135; Thu, 02 Jun 2022 19:53:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Jun 2022 19:53:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jun 2022 19:53:53 +0800
Message-ID: <a1140bd47cbd68436d0b9e147c2d6d6327ac092e.camel@mediatek.com>
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
Date:   Thu, 2 Jun 2022 19:53:54 +0800
In-Reply-To: <9e3f5586-59fa-42cc-770c-b8694b4f2bf3@linaro.org>
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
         <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
         <eb4deff1a01c09783518bbaff8fe4e4c4ca6fa5b.camel@mediatek.com>
         <591767ee-e349-7a17-a9e9-b95d0500c7c1@linaro.org>
         <774c075ca4ad815c88be755cfb51889a171e835d.camel@mediatek.com>
         <9e3f5586-59fa-42cc-770c-b8694b4f2bf3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 2022-06-02 at 12:45 +0200, Krzysztof Kozlowski wrote:
> On 02/06/2022 12:19, Tinghan Shen wrote:
> > Hi Krzysztof,
> > 
> > On Thu, 2022-06-02 at 09:40 +0200, Krzysztof Kozlowski wrote:
> > > On 02/06/2022 08:44, Tinghan Shen wrote:
> > > > > > +  mbox-names:
> > > > > > +    items:
> > > > > > +      - const: mbox0
> > > > > > +      - const: mbox1
> > > > > 
> > > > > These should be rather some meaningful names, e.g. "rx" and "tx".
> > > > 
> > > > The mbox name has to align with the adsp ipc driver.
> > > > The adsp ipc driver is using 'mbox%d' for mailbox channels.
> > > > 
> > > > 
> > > > 
> > 
> > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c__;!!CTRNKA9wMg0ARbw!1TmempNkQhC5QuLBhyfWo_AC97MoLuWipsGV-LPaW9RKNPheU7Bgc-eboNi1JA1nC5I$
> > > >  
> > > > 
> > > > 	chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> > > > 
> > > > 	/* ...snip... */
> > > > 
> > > > 	adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > > > 
> > > > Is it ok to continue using these names?
> > > 
> > > It is a bit confusing... how did that driver got merged recently without
> > > bindings? Why bindings are separate?
> > > 
> > > The bindings always come together in one patchset with the driver
> > > implementing them. Bindings are though a separate patch, yet still
> > > followed by the driver which uses them.
> > > 
> > > I do not see any compatibles in that driver, which suggests there is no
> > > other binding using it. If that's correct, then you need to change the
> > > driver.
> > > 
> > 
> > The mtk-adsp-ipc driver's sole function is to encapsulate the operations 
> > of mailbox framework from adsp ipc users. The mtk-adsp-ipc is not defined 
> > in the dts file and we don't need it to be defined. The creation of mtk-adsp-ipc 
> > device is requested by adsp ipc users via the use of 'platform_device_register_data'[1].
> > 
> > the driver implemented the mailbox framework is 'mtk-adsp-mailbox'[2]. it has 
> > corresponding hardwares and a yaml file[3] to describe it.
> 
> I don't understand how is this related. We talk here about the
> mbox-names for this bindings file. You replied, that these bindings are
> already used by something, but now you say that they are not? So why do
> you need to change anything in any driver?
> 
> Simple question - do the bindings here "add mt8186 dsp document" are
> used by any specific Linux driver already?

This bindings, 'add mt8186 dsp document', are used by the SOF sound driver of MT8186[1]. 

I'm sorry for miss leading you in previous reply. I was thought that you're 
asking why the mtk-adsp-ipc driver got merged without bindings. So, I tried 
to explain why mtk-adsp-ipc doesn't have bindings.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=1f0214a86de87011ecb96f22545dd6e5c7324cd7

Thanks,
TingHan


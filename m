Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81153B988
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiFBNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiFBNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:16:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1AE12815F;
        Thu,  2 Jun 2022 06:16:53 -0700 (PDT)
X-UUID: c1d556eec5f54276bba7f00231caee76-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:381915d8-e31d-48ff-9dff-80a415fd6e33,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:381915d8-e31d-48ff-9dff-80a415fd6e33,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:5174ea37-9855-4915-a138-f5705f1f3d02,C
        OID:782c3a5bafc4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: c1d556eec5f54276bba7f00231caee76-20220602
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1570426419; Thu, 02 Jun 2022 21:16:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Thu, 2 Jun 2022 13:16:44 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 2 Jun 2022 18:19:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 18:19:36 +0800
Message-ID: <774c075ca4ad815c88be755cfb51889a171e835d.camel@mediatek.com>
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
Date:   Thu, 2 Jun 2022 18:19:36 +0800
In-Reply-To: <591767ee-e349-7a17-a9e9-b95d0500c7c1@linaro.org>
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
         <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
         <eb4deff1a01c09783518bbaff8fe4e4c4ca6fa5b.camel@mediatek.com>
         <591767ee-e349-7a17-a9e9-b95d0500c7c1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 2022-06-02 at 09:40 +0200, Krzysztof Kozlowski wrote:
> On 02/06/2022 08:44, Tinghan Shen wrote:
> > > > +  mbox-names:
> > > > +    items:
> > > > +      - const: mbox0
> > > > +      - const: mbox1
> > > 
> > > These should be rather some meaningful names, e.g. "rx" and "tx".
> > 
> > The mbox name has to align with the adsp ipc driver.
> > The adsp ipc driver is using 'mbox%d' for mailbox channels.
> > 
> > 
> > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c__;!!CTRNKA9wMg0ARbw!1TmempNkQhC5QuLBhyfWo_AC97MoLuWipsGV-LPaW9RKNPheU7Bgc-eboNi1JA1nC5I$
> >  
> > 
> > 	chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> > 
> > 	/* ...snip... */
> > 
> > 	adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > 
> > Is it ok to continue using these names?
> 
> It is a bit confusing... how did that driver got merged recently without
> bindings? Why bindings are separate?
> 
> The bindings always come together in one patchset with the driver
> implementing them. Bindings are though a separate patch, yet still
> followed by the driver which uses them.
> 
> I do not see any compatibles in that driver, which suggests there is no
> other binding using it. If that's correct, then you need to change the
> driver.
> 

The mtk-adsp-ipc driver's sole function is to encapsulate the operations 
of mailbox framework from adsp ipc users. The mtk-adsp-ipc is not defined 
in the dts file and we don't need it to be defined. The creation of mtk-adsp-ipc 
device is requested by adsp ipc users via the use of 'platform_device_register_data'[1].

the driver implemented the mailbox framework is 'mtk-adsp-mailbox'[2]. it has 
corresponding hardwares and a yaml file[3] to describe it.

I'll send a patch to change the mbox name at next version.
It's better to have some meaningful names as you said.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=e0100bfd383c7d994d2e957e85ca56a5fe5a3f43
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=af2dfa96c52d042df5deb29fb6e32d3ff4d76a61
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=afa092e1e8824363d3174fef329c034445c111d5

Thanks,
TingHan



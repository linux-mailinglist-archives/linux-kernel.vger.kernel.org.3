Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF85F4F79F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbiDGIlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiDGIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:40:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C011A545;
        Thu,  7 Apr 2022 01:38:55 -0700 (PDT)
X-UUID: 9a1d0fb835094fb4a348b1ab21a58e9b-20220407
X-UUID: 9a1d0fb835094fb4a348b1ab21a58e9b-20220407
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1173894335; Thu, 07 Apr 2022 16:38:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Apr 2022 16:38:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 16:38:50 +0800
Message-ID: <e8f85610ab27403aa2b0689ecb70714c5a33e479.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: Correct disp_aal
 binding for MT8183
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <chunkuang.hu@kernel.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <yongqiang.niu@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 7 Apr 2022 16:38:50 +0800
In-Reply-To: <594c124d-403f-56f1-b9fb-f48042d7056b@linaro.org>
References: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
         <20220406094654.29722-2-rex-bc.chen@mediatek.com>
         <397e30c2-18c3-93d6-16f5-b113be77f51a@linaro.org>
         <c9a54f1c9350d63489a0f85443f5623fe5d7fe1d.camel@mediatek.com>
         <594c124d-403f-56f1-b9fb-f48042d7056b@linaro.org>
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

On Thu, 2022-04-07 at 08:49 +0200, Krzysztof Kozlowski wrote:
> On 07/04/2022 08:22, Rex-BC Chen wrote:
> > On Wed, 2022-04-06 at 16:44 +0200, Krzysztof Kozlowski wrote:
> > > On 06/04/2022 11:46, Rex-BC Chen wrote:
> > > > The driver data of MT8183 and MT8173 are different.
> > > > The value of has_gamma for MT8173 is true while the value of
> > > > MT8183
> > > > is
> > > > false. Therefore, the compatible of disp_aal for MT8183 is not
> > > > suitable
> > > > for the compatible for MT8173.
> > > 
> > > Just because one feature is not supported, it does not mean they
> > > are
> > > incompatible, which you claim in the patch below. Are you sure
> > > they
> > > are
> > > really incompatible and MT8173 fallback cannot be used?
> > > 
> > > 
> > > Best regards,
> > > Krzysztof
> > 
> > Hello Krzysztof,
> > 
> > Thanks for your review.
> > 
> > The difference of disp_aal for each MediaTek SoCs is "has_gamma".
> > And we only control this variable for different MediaTek SoCs.
> > 
> > The value of has_gamma for MT8173 is true.
> > The value of has_gamma for MT8183 is false. (Moreover, the driver
> > data
> > is null for MT8183)
> > 
> > From this situation, I think it's not compatible between MT8173 and
> > MT8183.
> 
> You repeated the commit msg without bringing any new information...
> but
> let it be, I assume setting gamma on MTT8183 is incorrect or produces
> wrong results.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Sorry for this.
I can explain more detailed.

For MT8173, the gamma module is inside disp_aal. When we need to adjust
gamma value, we need to use "has_gamma" to control gamma function
inside disp_aal to adjust gamma value.

Since MT8183 (MT8192/MT8195/MT8186), display gamma is seperated from
disp_aal. We just need to control disp_gamma directly and we don't need
to control gamma function inside disp_aal.

I will add these comments to commit message in next version to explain
it.

BRs,
Rex


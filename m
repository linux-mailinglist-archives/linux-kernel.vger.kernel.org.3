Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D898F59804F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbiHRIr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiHRIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:47:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33172B07E4;
        Thu, 18 Aug 2022 01:47:08 -0700 (PDT)
X-UUID: 77110a5cb87a4ca2bec2bd45b72470e2-20220818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GkI2Q29NX4fYBfJbo6t6SxsmffGa04COpADeR3pZqb8=;
        b=dhZzPg7/g0t8WwEC2uyGtO1YGyjH7IYxe1ShudiT9s3AjtHapN6uX+2RY+Ec9o1L/uRj8HhH/q6/oBsH8SJSOux1GZHs3zV1BwfKJ4zbNfJQlAx0K2lJdUbhatymfS+Qkkxe8QrTxqaBHHABzvwZ+r4QJQaSIy1sJy2mK2QvJ58=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:bd15ed81-29f3-4129-9ec0-7aed3c85155b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:a890089d-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 77110a5cb87a4ca2bec2bd45b72470e2-20220818
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1334742908; Thu, 18 Aug 2022 16:47:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 18 Aug 2022 16:47:02 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Aug 2022 16:47:01 +0800
Message-ID: <61af66dd70c7a4a95072868cdf217d3747b97634.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for
 pinctrl nodes
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Guodong Liu <guodong.liu@mediatek.com>
Date:   Thu, 18 Aug 2022 16:47:01 +0800
In-Reply-To: <20220817160928.ppkjonuymr7rn4bu@notapiano>
References: <20220817052615.27153-1-allen-kh.cheng@mediatek.com>
         <20220817160928.ppkjonuymr7rn4bu@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nícolas,

On Wed, 2022-08-17 at 12:09 -0400, Nícolas F. R. A. Prado wrote:
> Hi Allen,
> 
> On Wed, Aug 17, 2022 at 01:26:15PM +0800, Allen-KH Cheng wrote:
> > The mt8186 contains 8 GPIO physical address bases that correspond
> > to
> > the 'reg-names' of the pinctrl driver. The 'reg-names' entries in
> > bindings are ordered incorrectly, though. The system crashes due of
> > an
> > erroneous address when the regulator initializes.
> > 
> > We fix the 'reg-names' for the pinctrl nodes and the pinctrl-mt8186
> > example in bindings.
> > 
> > Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl
> > file and binding document")
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> 
> The sender's (your) signed-off-by should come last [1]. Also, what is
> the
> participation of Guodong in this patch? If Guodong helped in writing
> the patch
> there should also be a Co-developed-by tag for Guodong, as shown in
> [1].
> 
> [1] 
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/submitting-patches.html*when-to-use-acked-by-cc-and-co-developed-by__;Iw!!CTRNKA9wMg0ARbw!1_mWpRIIYugoUq7AlCzsuuJoxY3jETMdZ6U3QXxh8a8FKe2mb5kCUOSAvZGqK3bUHBje7g$
>  

Guodong and I consult on this patch. I will add a Co-developed-by tag
for Guodong.

> 
> > ---
> 
> [..]
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> 
> [..]
> > @@ -232,12 +232,12 @@ examples:
> >              <0x10002200 0x0200>,
> >              <0x10002400 0x0200>,
> >              <0x10002600 0x0200>,
> > -            <0x10002A00 0x0200>,
> > +            <0x10002a00 0x0200>,
> 
> Also, you should avoid making changes that don't have to do with the
> patch
> itself. This patch is about fixing the reg names, so no need to touch
> the
> formatting of addresses. It just adds noise.
> 
> Other than that,
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Thanks,
> Nícolas


Ok, no problem. I will remove unrelated part.

Thanks,
Allen



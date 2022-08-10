Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350B58E4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiHJBvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHJBvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:51:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD853D30;
        Tue,  9 Aug 2022 18:51:37 -0700 (PDT)
X-UUID: e78040478acc42bd83fbf7e6f2122c14-20220810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Z48Z/6BJ44USMBjWFHetu114Y1YDE9zrqDWzGJN6TIE=;
        b=qX6H7K3rikADL0LoouX5RiB9bp4veNnZ7ANj8Nz1+tlSEl1633b3edOm2ONWTXYe6IlkThgYLXRr51964OwMB9DnxffOkZHnxZvi7GcVnvIoFLGtTq5kjFspxZmmBB3Hm9jgxIiZckRPsb3YIQeuj0rOE4B4tb6hNf+Pp0yxFyw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:bae890a1-6131-4e6f-acf0-edca531d5bc9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:59a05eae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e78040478acc42bd83fbf7e6f2122c14-20220810
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1860812105; Wed, 10 Aug 2022 09:51:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 10 Aug 2022 09:51:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 10 Aug 2022 09:51:32 +0800
Message-ID: <1238beb0a140a0987b8fdda6e7bbadfbb2415ed4.camel@mediatek.com>
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update
 condition for mt8195 smi node
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 10 Aug 2022 09:51:32 +0800
In-Reply-To: <20220809135312.hadcs7ti2cgyyuez@notapiano>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
         <20220804021553.14867-3-tinghan.shen@mediatek.com>
         <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
         <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
         <20220809135312.hadcs7ti2cgyyuez@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-09 at 09:53 -0400, Nícolas F. R. A. Prado wrote:
> On Tue, Aug 09, 2022 at 07:01:10PM +0800, Tinghan Shen wrote:
> > Hi Krzysztof,
> > 
> > On Thu, 2022-08-04 at 17:12 +0200, Krzysztof Kozlowski wrote:
> > > On 04/08/2022 04:15, Tinghan Shen wrote:
> > > > 
> > > > It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> > > > matches the 'else' conditions for gen2 HW without gals.
> > > > 
> > > > Rewrite the 'else' condition to specifically identify the compatibles
> > > > that utilizing gen2 HW without gals.
> > > > 
> > > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > > Reviewed-by: AngeloGioacchino Del Regno
> > > >  <angelogioacchino.delregno@collabora.com>
> > > 
> > > Unfortunately, your patches got corrupted.
> > > 
> > > 
> > > Best regards,
> > > Krzysztof
> > 
> > Do you mean rebase to the latest linux-next?
> > I'll rebase in the next version, thanks!
> 
> Hi TingHan,
> 
> the issue is that some line wrapping happened on your patches, which broke tags
> and also the diffs themselves (it's very obvious on patch 3). So you need to
> sort out your setup so that no longer happens, and resend the patch.
> 
> Thanks,
> Nícolas

I see. I'll send the next version after fix the weired wrapping...
Thank you.


Best regards,
TingHan



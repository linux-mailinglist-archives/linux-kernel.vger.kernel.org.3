Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40F85A7A63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiHaJm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiHaJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:42:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE70B777A;
        Wed, 31 Aug 2022 02:42:51 -0700 (PDT)
X-UUID: c12ef8bd3b9c47a3b89bbbc5f9ee6099-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lBl/RPlIlb3KsjLgT/BWykSBimBWV4uOIzFGSIBye1k=;
        b=NP3bk8Qcg+OAnR4BrjRuyc29EiFMBLNjFU2bxswrGkkwx0Ed7gqY5f+nx2oz1aOHuO4wWTzvDrS94qx4yMgayaaN07nrpFzQdo45ua+yWLAamI3+dbirCKmXNFItPyUOajBAIE2s4g0Io0pRR6g3cGRm4ELfN7UoxfZwJWSNuUg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:76624fc3-ea14-4db1-8e73-11e8bd74bd8c,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:aac8ad20-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c12ef8bd3b9c47a3b89bbbc5f9ee6099-20220831
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 996513629; Wed, 31 Aug 2022 17:42:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 31 Aug 2022 17:42:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 31 Aug 2022 17:42:47 +0800
Message-ID: <af5ce6dd2f359741506e6d91e1a7301846bfae35.camel@mediatek.com>
Subject: Re: linux-next: build warnings after merge of the mediatek tree
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Wed, 31 Aug 2022 17:42:42 +0800
In-Reply-To: <20220831154248.20da2b6c@canb.auug.org.au>
References: <20220831154248.20da2b6c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 15:42 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mediatek tree, today's linux-next build (arm64
> defconfi)
> produced these warnings:
> 
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning
> (power_domains_property): /soc/vcodec@18002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning
> (power_domains_property): /soc/vcodec@19002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning
> (power_domains_property): /soc/vcodec@18002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning
> (power_domains_property): /soc/vcodec@19002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning
> (power_domains_property): /soc/vcodec@18002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning
> (power_domains_property): /soc/vcodec@19002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning
> (power_domains_property): /soc/vcodec@18002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning
> (power_domains_property): /soc/vcodec@19002000: Missing property
> '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle
> (referred from power-domains[0])
> 
> Introduced by commit
> 
>   d3dfd4688574 ("arm64: dts: mediatek: Update mt81xx scpsys node to
> align with dt-bindings")
> 

Hi Stephen,


I help TingHan to send this email because he encounters some IT issue.
---
I send a patch to fix these warnings.

https://lore.kernel.org/all/20220831065100.27722-1-tinghan.shen@mediatek.com/


I'm sorry to produce these warnings.



Best regards,
TingHan
---

BRs,
Johnson Wang


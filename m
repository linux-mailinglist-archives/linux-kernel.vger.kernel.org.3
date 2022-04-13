Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF14FECCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiDMCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDMCTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:19:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA7A24BDF;
        Tue, 12 Apr 2022 19:16:56 -0700 (PDT)
X-UUID: e9f2f699d8434f1aa79683e32a83811c-20220413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9235956a-d02e-46f9-9ba6-afac918df9e4,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:53,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:53
X-CID-INFO: VERSION:1.1.4,REQID:9235956a-d02e-46f9-9ba6-afac918df9e4,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:53,FILE:0,RULE:Release_UHam,AC
        TION:release,TS:53
X-CID-META: VersionHash:faefae9,CLOUDID:fb453178-0afa-4dca-bdec-ca54c998425a,C
        OID:e47890283164,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: e9f2f699d8434f1aa79683e32a83811c-20220413
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1672171992; Wed, 13 Apr 2022 10:16:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 13 Apr 2022 10:16:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Apr 2022 10:16:50 +0800
Message-ID: <25f9b550e2a179db63aff2639f7a140633dd5b17.camel@mediatek.com>
Subject: Re: [PATCH] arm64: dts: mt7986: add built-in Wi-Fi device nodes
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, Ryder Lee <ryder.Lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Apr 2022 10:16:50 +0800
In-Reply-To: <20220221020708.12724-1-chui-hao.chiu@mediatek.com>
References: <20220221020708.12724-1-chui-hao.chiu@mediatek.com>
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

On Mon, 2022-02-21 at 10:07 +0800, Peter Chiu wrote:
> This enables built-in 802.11ax Wi-Fi support.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
> This patch depends on below patchs
> 1) https://patchwork.kernel.org/patch/12704208/
> 2) https://patchwork.kernel.org/patch/12704207/
> 3) https://patchwork.kernel.org/patch/12739683/
> ---
>  arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 41
> +++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 19 +++++++++
>  arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 43
> ++++++++++++++++++++
>  3 files changed, 103 insertions(+)
> 

Hello, just a gentle ping.

Best regards,
Peter Chiu


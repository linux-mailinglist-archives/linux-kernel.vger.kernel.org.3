Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70944524245
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiELCBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiELCBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:01:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0514C432;
        Wed, 11 May 2022 19:01:27 -0700 (PDT)
X-UUID: d9385e84e31444dfae259bba4c41b9f5-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:33386eec-26ac-493e-a459-34ec10e4aa16,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:faefae9,CLOUDID:da5a8727-a01c-4223-8f5a-12d972216e7b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d9385e84e31444dfae259bba4c41b9f5-20220512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1040162746; Thu, 12 May 2022 10:00:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 10:00:42 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 12 May 2022 10:00:40 +0800
Message-ID: <40c12cdf833113405fce1146234db26e883eaf35.camel@mediatek.com>
Subject: Re: [PATCH v4] dt-bindings: nvmem: convert mtk-efuse.txt to YAML
 schema
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Date:   Thu, 12 May 2022 10:00:40 +0800
In-Reply-To: <20220511151733.GA313710-robh@kernel.org>
References: <20220509014521.10248-1-chunfeng.yun@mediatek.com>
         <20220511151733.GA313710-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 10:17 -0500, Rob Herring wrote:
> On Mon, May 09, 2022 at 09:45:21AM +0800, Chunfeng Yun wrote:
> > Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v4: fix duplicated unit-address in example;
> >     drop reviewed-by Rob, due to changes;
> > 
> > v3: add reviewed-by Rob
> > 
> > v2:
> >    1. remove description of subnodes which is covered by nvmem.yaml
> > suggested by Rob
> >    2. change the example which is commoner than mt8173's
> 
> I'm assuming this will be resent with all the changes from the other 
> conversion posted[1].
Yes, I'm doing it now, thanks

> 
> Rob
> 
> [1] 
> https://lore.kernel.org/all/73b1feab3ecb20fef0339b322a61d63146b5790a.camel@mediatek.com/


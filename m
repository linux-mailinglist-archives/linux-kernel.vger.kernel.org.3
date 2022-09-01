Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4C5A91E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiIAIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiIAIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:16:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45F1706D;
        Thu,  1 Sep 2022 01:16:35 -0700 (PDT)
X-UUID: 44d7660e4c97499b865c3f4473251e96-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mSKU3/XNrzgDEXyKoQN+SoaiHQESlxP9Gq2Nquvsogg=;
        b=Cqnaie7DGwMn5apetXJgAJtILSyK7TxAv8CLnpsaCuZVZSPQcnJAThFbSDt0X9a2P8gKLgv69Cz5IMZKgxfOadEDs3nFM9MgXU/lcelseBWq4D4Iluy5TB2NYVY8sYASNKkVaKbHT27+xD+482hGs5sj+c2i+AF6tRUbGBL/azc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:cf580489-ebd6-44a9-bec1-cbcacb796034,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18,CLOUDID:53624dd0-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 44d7660e4c97499b865c3f4473251e96-20220901
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <liju-clr.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1255327469; Thu, 01 Sep 2022 16:16:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Sep 2022 16:16:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 1 Sep 2022 16:16:28 +0800
Message-ID: <092345db980b30c577350edc46d88dc3888736d4.camel@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
From:   Liju-clr Chen <liju-clr.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 1 Sep 2022 16:16:28 +0800
In-Reply-To: <0b17f336-5c04-e375-ef4a-3804f9702bf8@kernel.org>
References: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
         <20220816065330.27570-2-Runyang.Chen@mediatek.com>
         <0b17f336-5c04-e375-ef4a-3804f9702bf8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Hi Maintainers,

Gentle ping for this patch.
It would be appreciated if you could give some suggestions.

Best Regards,
Liju Chen

On Tue, 2022-08-16 at 12:49 +0300, Krzysztof Kozlowski wrote:
> On 16/08/2022 09:53, Runyang Chen wrote:
> > From: Runyang Chen <runyang.chen@mediatek.com>
> > 
> > Add dt-binding documentation of watchdog for MediaTek MT8188 Soc
> > 
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof


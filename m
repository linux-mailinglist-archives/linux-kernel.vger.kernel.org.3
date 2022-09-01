Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC35A93E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIAKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiIAKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:09:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE971BE6;
        Thu,  1 Sep 2022 03:09:19 -0700 (PDT)
X-UUID: 0474b46c71b345afb741aec2b360d0d8-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KK3UoclfL8kHmhowR+FoFpgrghLqeaE9E9mavmz6o0s=;
        b=cTxLfPFRWWWlltNRc07SLaOFK03k3PCyBMdkIoq2bPNdeVjI4OUIED6ZVhoiXkk0POg8IjoMMXJVc9TEM94VHtSAOfyvu5V8ZThhHWogUJKovI/hxfAUyPWrlNGBg6t6yGTZoyG/dmUn0ZDDMqtAWRz7MFxLDTRVq+6JKykqw54=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:6413d021-eaca-41d5-a2e4-7cf711807f5e,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:54
X-CID-INFO: VERSION:1.1.10,REQID:6413d021-eaca-41d5-a2e4-7cf711807f5e,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_H
        amU,ACTION:release,TS:54
X-CID-META: VersionHash:84eae18,CLOUDID:2677d020-1c20-48a5-82a0-25f9c331906d,C
        OID:015415365b97,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 0474b46c71b345afb741aec2b360d0d8-20220901
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <liju-clr.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1567260529; Thu, 01 Sep 2022 18:04:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Sep 2022 18:03:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 1 Sep 2022 18:03:59 +0800
Message-ID: <36bbb36f1f6a8991856a01a82300298ad5423359.camel@mediatek.com>
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
Date:   Thu, 1 Sep 2022 18:03:59 +0800
In-Reply-To: <5dbdcb11-ae9c-e2b5-793b-35fa16a4208b@kernel.org>
References: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
         <20220816065330.27570-2-Runyang.Chen@mediatek.com>
         <0b17f336-5c04-e375-ef4a-3804f9702bf8@kernel.org>
         <092345db980b30c577350edc46d88dc3888736d4.camel@mediatek.com>
         <5dbdcb11-ae9c-e2b5-793b-35fa16a4208b@kernel.org>
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

On Thu, 2022-09-01 at 12:44 +0300, Krzysztof Kozlowski wrote:
> On 01/09/2022 11:16, Liju-clr Chen wrote:
> > Hi Maintainers,
> > 
> > Gentle ping for this patch.
> > It would be appreciated if you could give some suggestions.
> 
> Why ping? You got the ack, so what do you need from me?
> 

I apologized for this mistake. 
I should reply this on cover letter instead of this patch.
Sorry for any inconvenience caused.

Best Regards,
Liju Chen

> Best regards,
> Krzysztof


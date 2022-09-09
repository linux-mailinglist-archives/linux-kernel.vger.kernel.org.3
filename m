Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91FF5B2CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiIIDLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIIDKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:10:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B0EE515;
        Thu,  8 Sep 2022 20:07:34 -0700 (PDT)
X-UUID: 5e79a057b13942c09b9e35314c44a0aa-20220909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=O8XSr7TlTnh60b4oLOGBXsUmL/yWTMg9D9NJFxQgOA8=;
        b=um76aH5AiDtTx98jNeC9+yXNL4CbY57mlkZH8dXVfN0jlND+XJkmWJ7IBkPRHzLUUyS+UTS41tXGleXG7JoMs4MtH8hlfU2qBrKiw1RyfSTAnkiAhi7xTy5G1DijmZuZCbbeNxjSvXBYbdh63eWTMzqo/CwYLFww3PuU+x4uJx0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:adc0224c-ba4a-4450-b588-a0f8ac7b8d0b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:125cd8f5-6e85-48d9-afd8-0504bbfe04cb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5e79a057b13942c09b9e35314c44a0aa-20220909
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1503427057; Fri, 09 Sep 2022 11:07:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Sep 2022 11:07:26 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 9 Sep 2022 11:07:26 +0800
Message-ID: <113219ac80cceaa4a39434e4370db821e26a5275.camel@mediatek.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Fri, 9 Sep 2022 11:07:25 +0800
In-Reply-To: <82576790-9fb0-ee1b-2308-fbe292068bd9@linaro.org>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
         <20220829080830.5378-2-chunfeng.yun@mediatek.com>
         <d1f49935-b465-7495-d345-f35bf4dea9f9@linaro.org>
         <d30353e4dbb785c3ce31ef54b791bfe3d23df904.camel@mediatek.com>
         <82576790-9fb0-ee1b-2308-fbe292068bd9@linaro.org>
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

On Wed, 2022-08-31 at 09:02 +0300, Krzysztof Kozlowski wrote:
> On 31/08/2022 06:14, Chunfeng Yun wrote:
> > > These bindings are expected to be
> > > usable/applicable on several devices, so units, not register
> > > values
> > > which can change between devices, are the proper and reliable way
> > > to
> > > describe a feature.
> > 
> > I prefer to use exact level values, but not the inexact values with
> > units (e.g. -percent, -microvolt).
> 
> What stops you from using exact values - bp?
See reply for the first series, thanks

> 
> Best regards,
> Krzysztof


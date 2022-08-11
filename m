Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB258F97D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiHKIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiHKIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:48:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B92915C2;
        Thu, 11 Aug 2022 01:48:04 -0700 (PDT)
X-UUID: f72537cb771d4bdc9445ffe5dbe9282d-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LiVXk2XwzFDt8yLn3peMfVkSM9+eJCJ3bq5pHTyqyjs=;
        b=hDAXhdLuVnM6+0lYauPdtPSs0lXUg1ASRWXERgi5jE87QZacq6tqbJFwJJ66kphEEqc88M2JWhBPEl+6dZKoUSKD9gIEj74BfvVWjd/TVmZZ4Na5+cKSkjMhsy1kmBVIZGv3LwNJCdYs+sqgURqLWx61hI/DR6qe+UP5LQIVzag=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:bed13883-7436-4613-836b-43574a83db9f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:d9325f9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f72537cb771d4bdc9445ffe5dbe9282d-20220811
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1053201935; Thu, 11 Aug 2022 16:47:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 16:47:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 11 Aug 2022 16:47:58 +0800
Message-ID: <a06b9ef2126980724219b488113881f726c7b434.camel@mediatek.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 11 Aug 2022 16:47:58 +0800
In-Reply-To: <5a6545cc-97a2-7aa8-7b67-6488154e9db3@linaro.org>
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
         <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
         <5a6545cc-97a2-7aa8-7b67-6488154e9db3@linaro.org>
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

Hi Krzysztof,

On Wed, 2022-08-10 at 19:49 +0300, Krzysztof Kozlowski wrote:
> On 21/07/2022 04:48, Allen-KH Cheng wrote:
> > The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
> > We should not use 'mediatek,mt6589-wdt' as fallback.
> > 
> > For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt
> > fallback.
> > 
> > Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for
> > MediaTek MT8186")
> > Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for
> > Mediatek MT8195")
> > Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for
> > Mediatek MT7986")
> > Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-
> > cells")
> 
> Missing spaces around SHA.
> 
> Best regards,
> Krzysztof

Thanks for your friendly reminder.

I'll pay more attention in the next time.

Thanks,
Allen


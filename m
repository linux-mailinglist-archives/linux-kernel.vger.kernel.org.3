Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9A595C79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiHPM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiHPM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:56:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A285A0626;
        Tue, 16 Aug 2022 05:55:38 -0700 (PDT)
X-UUID: d59141687e644814850fd643e8747338-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xtsIq1uDUUFshftfGHmMdF9c6lD7cY1mGwUtoM45Wk0=;
        b=umskDh4KLwOww2AjUZFXJtoiQWH/M6Elhg7G3saKU7Y4HW/CrgmMKbK/yI0knE5bvpJtws+jfMCG+uNGAqKTiMvuDZURMdkg60jKxwk6q3xB+WoyqWouq7req2OhXcD/CPdgdyC5hPdSbsnqd+dNZ8w5UZ2xfjvCRAdbXFt2SBs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:feacfdd1-a8bd-420a-819c-b5fb0e904aa2,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:51
X-CID-INFO: VERSION:1.1.10,REQID:feacfdd1-a8bd-420a-819c-b5fb0e904aa2,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:51
X-CID-META: VersionHash:84eae18,CLOUDID:4feaf9ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:a5590f0c6722,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: d59141687e644814850fd643e8747338-20220816
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1493968202; Tue, 16 Aug 2022 20:55:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 20:55:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 16 Aug 2022 20:55:30 +0800
Message-ID: <51abb54a5d5bea76a855f20d3e28e90a3eb0efba.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for
 pinctrl nodes
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Guodong Liu <guodong.liu@mediatek.com>
Date:   Tue, 16 Aug 2022 20:55:29 +0800
In-Reply-To: <c411c5c5-0a8b-c85c-2d57-1a387eb0d28f@linaro.org>
References: <20220815122503.2768-1-allen-kh.cheng@mediatek.com>
         <c411c5c5-0a8b-c85c-2d57-1a387eb0d28f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 2022-08-16 at 10:14 +0300, Krzysztof Kozlowski wrote:
> On 15/08/2022 15:25, Allen-KH Cheng wrote:
> > There are 8 GPIO physical address bases in mt8186, corresponding to
> > the
> > items of 'reg-names' with the pinctrl driver. but the order of
> 
> New sentences start with capital letter.
> 
> > 'reg-names' is not correct. The mt8186 pinctrl driver would get the
> > wrong address, causing the system to restart when regulator
> > initializes
> > . we 
> 
> ^^^ Something is missing. Sentence looks unfinished, full stop is in
> new
> line, next sentence does not start with capital letter.
> 
> 

Thanks for your kind reminder.
I'll update in the next version.

Best regards,
Allen

> > fix 'reg-names' for pinctrl nodes and the pinctrl-mt8186 example
> > in bindings.
> > 
> > Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl
> > file and binding document")
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> > ---
> 
> Best regards,
> Krzysztof


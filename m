Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8367A5AA6AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiIBDxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiIBDx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:53:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C3B56F0;
        Thu,  1 Sep 2022 20:53:24 -0700 (PDT)
X-UUID: a66dea104b2b44089b418b38e3f39878-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=k/qxywixk7Je4QAulmTspgqKqxl2g8Y8PGMTJqOATZw=;
        b=E5oopIo3fh9cayLq8TE1Q4G88WoK1j+8eoo1bc8iAZ3ppHaKuDbbQXGzEUtZA5HlE6F28lnr14LUvk9EGFSkUlm6gwuJmjJDJYDu8ujpijrkmOlwt9kofrNiWUZZVvCotm5369ZqK0XyYXHlWXJTBZtdCWw5t0uGE9EKVCgJSvw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:b9296e61-8616-4a6f-a532-abac6694c84e,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:2,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-3
X-CID-META: VersionHash:84eae18,CLOUDID:f2e566d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a66dea104b2b44089b418b38e3f39878-20220902
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jianhua.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1387420935; Fri, 02 Sep 2022 11:53:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 2 Sep 2022 11:53:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 2 Sep 2022 11:53:16 +0800
Message-ID: <8bc2ac6c1cd18431d2fad50673e39474e5b87149.camel@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: media: mediatek-jpeg-encoder: Add
 MT8188 compatible string
From:   Jianhua Lin <jianhua.lin@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 2 Sep 2022 11:53:16 +0800
In-Reply-To: <d506a523-6638-78f3-6a7d-2d9312302403@linaro.org>
References: <20220719100214.2096-1-jianhua.lin@mediatek.com>
         <20220719100214.2096-2-jianhua.lin@mediatek.com>
         <d506a523-6638-78f3-6a7d-2d9312302403@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans Verkuil,

Gentle ping for this patch, if there is anything I need to modify,
please kindly let me know.

Thanks.

On Wed, 2022-07-20 at 08:28 +0200, Krzysztof Kozlowski wrote:
> On 19/07/2022 12:02, Jianhua Lin wrote:
> > Add compatible for MT8188 jpeg encoder.
> > 
> > Signed-off-by: Jianhua Lin <jianhua.lin@mediatek.com>
> > ---
> >  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 
> > 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof


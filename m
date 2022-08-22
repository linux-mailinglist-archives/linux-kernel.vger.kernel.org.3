Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986D159BAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiHVH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHVH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:56:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9122B188;
        Mon, 22 Aug 2022 00:56:18 -0700 (PDT)
X-UUID: 86a95cf46e184b5785ea06c3390e9d5e-20220822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=NGXPT7+mPmovmUCCRnU+eezzrRuI/5/eaI3MEaYC8zA=;
        b=lLh1sE//MWKvLz5W24FOH5S6YV1VCDPT8/5KxNqWussOdE/8TL0H8y8dgi1fujy6mfd0CIxZFykeZK+298GA/o7IMjxE3EkR446VjjemLebBX7GWsdsKZEPfvqICZhI9/j8fWt3u2JJ9h8XXnDk95GMBh+uPX2Z/++XNiwWCxPE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:68654480-6d74-457a-8e08-cea19ac6de41,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:ae3065c9-6b09-4f60-bf82-12f039f5d530,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 86a95cf46e184b5785ea06c3390e9d5e-20220822
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1680168738; Mon, 22 Aug 2022 15:56:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 22 Aug 2022 15:56:10 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 22 Aug 2022 15:56:09 +0800
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add scpsys compatible for
 mt8186
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>
References: <20220819124736.21768-1-allen-kh.cheng@mediatek.com>
 <e5572e77-4ba5-d8f3-4e9e-04ac5dc416fe@linaro.org>
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Message-ID: <365eb0ad-8423-b8e3-298f-b356a2250dd0@mediatek.com>
Date:   Mon, 22 Aug 2022 15:56:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e5572e77-4ba5-d8f3-4e9e-04ac5dc416fe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 8/19/22 8:53 PM, Krzysztof Kozlowski wrote:
> On 19/08/2022 15:47, Allen-KH Cheng wrote:
>> Add a new scpsys compatible for mt8186 SoC.
>>
>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> ---
> 
> No DTS using it?
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof
> 

I had it all arranged to send anther DTS using patch after
https://patchwork.kernel.org/project/linux-mediatek/list/?series=666901
is applied.


But I see your comments in
https://lore.kernel.org/all/a810ec42-825c-1a85-568f-b70f04b58280@linaro.org/,
I think it's better that adding another DTS using patch for scpsys nodes
into a series (include this patch).

Thanks,
Allen

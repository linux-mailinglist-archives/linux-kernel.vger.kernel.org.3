Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FAD5A1E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbiHZCD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiHZCDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:03:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A0CAC94;
        Thu, 25 Aug 2022 19:03:11 -0700 (PDT)
X-UUID: 1ad1f94a29e94d22b3d0e6513719be8e-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:Subject; bh=JpBdRJBBzq6P5ZQ16LVd+gkiupvyrupsuxc/Ajvy418=;
        b=dYDXwVryVt8OYWNxZLZaSpBJXljNIknHCXSijhyQOlu47FWcIw8f3v6PvDqEI6Ff1gxnMbeDCjXJxDzudpLulStggX01vuQcemVndXJNPi4pPRNXgL63YYi/mEydkXwaahXTvvmYNX/LFU3t4TiehnXfZQSsH8hQjn2cqIYTDzo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:a6376ff1-ad6b-4256-a24e-6da899ec20a0,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:51
X-CID-INFO: VERSION:1.1.10,REQID:a6376ff1-ad6b-4256-a24e-6da899ec20a0,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:51
X-CID-META: VersionHash:84eae18,CLOUDID:bcaaa6cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:e6b61ddbd8c8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1ad1f94a29e94d22b3d0e6513719be8e-20220826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 835807649; Fri, 26 Aug 2022 10:03:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 10:03:01 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 10:03:01 +0800
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add scpsys compatible for
 mt8186
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
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
 <365eb0ad-8423-b8e3-298f-b356a2250dd0@mediatek.com>
Message-ID: <b5696b65-e150-244f-05ea-ce9312970d3d@mediatek.com>
Date:   Fri, 26 Aug 2022 10:03:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <365eb0ad-8423-b8e3-298f-b356a2250dd0@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainers,

On 8/22/22 3:56 PM, Allen-KH Cheng wrote:
> Hi Krzysztof,
> 
> On 8/19/22 8:53 PM, Krzysztof Kozlowski wrote:
>> On 19/08/2022 15:47, Allen-KH Cheng wrote:
>>> Add a new scpsys compatible for mt8186 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>
>> No DTS using it?
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> I had it all arranged to send anther DTS using patch after
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=666901
> is applied.
> 
> 
> But I see your comments in
> https://lore.kernel.org/all/a810ec42-825c-1a85-568f-b70f04b58280@linaro.org/,
> I think it's better that adding another DTS using patch for scpsys nodes
> into a series (include this patch).
> 
> Thanks,
> Allen
> 

I found Matthias send a patch for renaming mediatek,mt8195-scpsys.yaml. [1]

I will update this patch after [1] is applied.

[1]
https://patchwork.kernel.org/project/linux-mediatek/patch/20220825141656.15747-1-matthias.bgg@kernel.org/

Thanks,
Allen

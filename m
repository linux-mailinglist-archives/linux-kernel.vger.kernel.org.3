Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FF53B51F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiFBI2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiFBI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:27:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C211E26F360;
        Thu,  2 Jun 2022 01:27:53 -0700 (PDT)
X-UUID: f225be05e0ad4ae19709be6028d247ca-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:6544d012-d7e9-45b9-a5ea-84cee5440326,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:3609e137-9855-4915-a138-f5705f1f3d02,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: f225be05e0ad4ae19709be6028d247ca-20220602
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 324604989; Thu, 02 Jun 2022 16:27:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 2 Jun 2022 16:27:45 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 16:27:45 +0800
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
To:     Yong Wu <yong.wu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bear Wang <bear.wang@mediatek.com>,
        Macross Chen <macross.chen@mediatek.com>,
        Kidd-KW Chen <Kidd-KW.Chen@mediatek.com>,
        Andy Hsieh <Andy.Hsieh@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
 <8ac7a6766c635412b408cb5295ddb3da37541140.camel@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <59cedd50-4141-e589-11ae-b8d1a017eb46@mediatek.com>
Date:   Thu, 2 Jun 2022 16:27:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ac7a6766c635412b408cb5295ddb3da37541140.camel@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 2:18 PM, Yong Wu wrote:
> On Mon, 2022-05-30 at 20:03 +0200, Fabien Parent wrote:
>> Add IOMMU binding documentation for the MT8365 SoC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>   .../bindings/iommu/mediatek,iommu.yaml        |  2 +
>>   include/dt-bindings/memory/mt8365-larb-port.h | 96
>> +++++++++++++++++++
>>   2 files changed, 98 insertions(+)
>>   create mode 100644 include/dt-bindings/memory/mt8365-larb-port.h
> 
> [snip...]
> 
>> +#ifndef _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
>> +#define _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
>> +
>> +#include <dt-bindings/memory/mtk-memory-port.h>
>> +
>> +#define M4U_LARB0_ID			0
>> +#define M4U_LARB1_ID			1
>> +#define M4U_LARB2_ID			2
>> +#define M4U_LARB3_ID			3
>> +#define M4U_LARB4_ID			4
>> +#define M4U_LARB5_ID			5
>> +#define M4U_LARB6_ID			6
>> +#define M4U_LARB7_ID			7
> 
> Remove these. they are no used, right?

AIOT and customers are using the modules and their related IOMMU modules.
DISP0, VENC, VDEC, ISP (CAMSYS), and APU (as far as I know, which should 
be VP6?) were all supported.

> 
>> +
>> +/* larb0 */
>> +#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(0, 0)
>> +#define M4U_PORT_DISP_OVL0_2L	MTK_M4U_ID(0, 1)
> 
> [...]
> 
>>
>> +/* larb4 */
>> +#define M4U_PORT_APU_READ		MTK_M4U_ID(0, 0)
>> +#define M4U_PORT_APU_WRITE		MTK_M4U_ID(0, 1)
> 
> Please remove these two APU definitions. currently these are not
> supported.

Kidd, please help to check if APU use these definitions with Yong.
However, I think these are all available to the customers.

Thanks
Macpaul Lin

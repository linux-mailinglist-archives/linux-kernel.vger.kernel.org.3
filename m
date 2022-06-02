Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6453B249
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiFBDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFBDwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:52:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600A2E9;
        Wed,  1 Jun 2022 20:52:43 -0700 (PDT)
X-UUID: 3ff230b8e35743a6a46dcca47ce5415f-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:bc2b454a-0ba9-445c-bd84-6e5e0628a0e4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:bdb68c0d-3a0d-4bbe-9d72-0e5d26d57423,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 3ff230b8e35743a6a46dcca47ce5415f-20220602
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 811584588; Thu, 02 Jun 2022 11:52:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 2 Jun 2022 11:52:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 11:52:38 +0800
Message-ID: <016eb93f0bee329c061725cb5096d49ab4240152.camel@mediatek.com>
Subject: Re: [PATCH v1 00/15] Add support for MT8195 SCP 2nd core
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Date:   Thu, 2 Jun 2022 11:52:38 +0800
In-Reply-To: <919ca8ee-4b01-e601-714c-26098647d5c7@linaro.org>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
         <919ca8ee-4b01-e601-714c-26098647d5c7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
 
On Wed, 2022-06-01 at 13:46 +0200, Krzysztof Kozlowski wrote:
> On 01/06/2022 13:21, Tinghan Shen wrote:
> > The MT8195 System Companion Processor(SCP) is a dual-core RISC-V MCU.
> > Current mediatek remoteproc driver only supports bring-up single core 
> > SCP or the 1st core of a dual-core SCP. This series support to bring-up 
> 
>       ^^ this or is confusing a bit.
> 
> Does this mean that MT8195 has three RISC-V MCUs?

My intention is to express that current SCP driver supports bring-up,
1. the single core SCP, e.g. MT8183
2. the 1st core of dual-core SCP, e.g. MT8195


Perhaps rewriting as follows is preferable?

"The mediatek remoteproc driver currently only allows bringing up a single 
core SCP. It only supports bringing up the 1st core in SoCs with a dual-core SCP."
> 
> > the 2nd core of a dual-core SCP.
> 
> 
> 
> Best regards,
> Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE47352455C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbiELGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbiELGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:05:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B02631D;
        Wed, 11 May 2022 23:05:45 -0700 (PDT)
X-UUID: 94997701536f472dbebcae6c7ba853c8-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6e4b1bcc-5816-4e8c-b62b-de4f6de9f4ab,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:6e4b1bcc-5816-4e8c-b62b-de4f6de9f4ab,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:d7535448-e22d-4f1a-9d3f-55c4a2b00ea4,C
        OID:cb026531e4b5,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 94997701536f472dbebcae6c7ba853c8-20220512
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1604091499; Thu, 12 May 2022 14:05:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 12 May 2022 14:05:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 14:05:38 +0800
Message-ID: <ca85977bcff2e3de925d7ab834b8654ec5ddf8c1.camel@mediatek.com>
Subject: Re: [PATCH v6 00/10] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <khilman@baylibre.com>, <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 12 May 2022 14:05:39 +0800
In-Reply-To: <20220512054825.aqe4g4lupuqj3rcq@vireshk-i7>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
         <20220506042004.hqzpb66shak4y7rz@vireshk-i7>
         <86851bd03128cc61082d516ebff929d3637063cb.camel@mediatek.com>
         <20220512052732.iqphgpveoyrqjlqg@vireshk-i7>
         <af82434adea0b648d74ed5ffd123e0faaaac6508.camel@mediatek.com>
         <20220512054825.aqe4g4lupuqj3rcq@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 11:18 +0530, Viresh Kumar wrote:
> On 12-05-22, 13:33, Rex-BC Chen wrote:
> > Matthias is not the member of mediatek, so I think we still need
> > his
> > feedback for these three patches.
> 
> Please ping him and ask for his feedback then.
> 

ok, I will do this.
Thanks!

BRs,
Rex


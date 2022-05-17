Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33F529EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiEQKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiEQKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:02:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E35F2D;
        Tue, 17 May 2022 03:02:14 -0700 (PDT)
X-UUID: b63e995b8210496ba0dba6811dc8b7f3-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:401017f9-3c99-46d5-b8bf-e3595f1903e4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:401017f9-3c99-46d5-b8bf-e3595f1903e4,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:31577ce2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:b694db9682df,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: b63e995b8210496ba0dba6811dc8b7f3-20220517
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 195184224; Tue, 17 May 2022 18:02:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 17 May 2022 18:02:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 May 2022 18:02:07 +0800
Message-ID: <eab324a190c47cd139c243d1034fa44aa51f9377.camel@mediatek.com>
Subject: Re: [PATCH v6 00/10] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 17 May 2022 18:02:07 +0800
In-Reply-To: <dde746ce-5663-e12f-4537-4206945b6b59@gmail.com>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
         <20220506042004.hqzpb66shak4y7rz@vireshk-i7>
         <86851bd03128cc61082d516ebff929d3637063cb.camel@mediatek.com>
         <20220512052732.iqphgpveoyrqjlqg@vireshk-i7>
         <af82434adea0b648d74ed5ffd123e0faaaac6508.camel@mediatek.com>
         <20220512054825.aqe4g4lupuqj3rcq@vireshk-i7>
         <ca85977bcff2e3de925d7ab834b8654ec5ddf8c1.camel@mediatek.com>
         <dde746ce-5663-e12f-4537-4206945b6b59@gmail.com>
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

On Tue, 2022-05-17 at 11:57 +0200, Matthias Brugger wrote:
> 
> On 12/05/2022 08:05, Rex-BC Chen wrote:
> > On Thu, 2022-05-12 at 11:18 +0530, Viresh Kumar wrote:
> > > On 12-05-22, 13:33, Rex-BC Chen wrote:
> > > > Matthias is not the member of mediatek, so I think we still
> > > > need
> > > > his
> > > > feedback for these three patches.
> > > 
> > > Please ping him and ask for his feedback then.
> > > 
> > 
> > ok, I will do this.
> > Thanks!
> > 
> 
> Sorry for the late reply. I'll take the DTS patches through my tree.
> As I'm late 
> to the game this will be for v5.20.
> 
> Regards,
> Matthias

Hello Matthias,

Thanks for you reply,
I send another version for this series.
Please refer to this:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=641933

BRs,
Rex


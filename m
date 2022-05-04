Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58A519EAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349159AbiEDMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEDMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:00:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666F18342;
        Wed,  4 May 2022 04:57:15 -0700 (PDT)
X-UUID: 68ad077453d943dc954df963fc5c3163-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b565527c-a0c4-4a30-8c39-ac9ef5bece4c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:b565527c-a0c4-4a30-8c39-ac9ef5bece4c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:4eed8ab2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 68ad077453d943dc954df963fc5c3163-20220504
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1706728257; Wed, 04 May 2022 19:57:11 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 19:57:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 19:57:09 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 4 May 2022 19:57:09 +0800
Message-ID: <332f8adec6601f97ab2814d06330883a251e41ec.camel@mediatek.com>
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
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
Date:   Wed, 4 May 2022 19:57:09 +0800
In-Reply-To: <20220504082249.anrvkf2ssbxyzz5m@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-8-rex-bc.chen@mediatek.com>
         <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
         <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
         <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
         <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
         <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
         <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
         <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
         <27a5dddd91b3dcbd69f08c10108cdec808237ace.camel@mediatek.com>
         <20220504082249.anrvkf2ssbxyzz5m@vireshk-i7>
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

On Wed, 2022-05-04 at 13:52 +0530, Viresh Kumar wrote:
> On 03-05-22, 19:33, Rex-BC Chen wrote:
> > Our observation tells us cpufreq_online is setting only once at
> > boot
> > for one cpu cluster.
> > But we can see the problem repeatly occurs once cpufreq_get is
> > invoked.
> > 
> > e.g.
> > [ 71.154560] cpufreq: Warning: CPU frequency out of sync: cpufreq
> > and
> > timing core thinks of 500000, is 499999 kHz
> > [ 71.155880] cpufreq: notification 0 of frequency transition to
> > 499999
> > kHz
> > [ 71.156777] cpufreq: notification 1 of frequency transition to
> > 499999
> > kHz
> > [ 71.187241] cpufreq: target for CPU 0: 500000 kHz, relation 0,
> > requested 500000 kHz
> > [ 71.188246] cpufreq: target_freq/policy->cur: 500000/499999 kHz
> 
> Lemme know if this helps:
> 
> 
https://lore.kernel.org/lkml/39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org/
> 

Hello Viresh,

Thanks a lot! It helps to fix this issue.
And I will drop this patch in the next version.

BRs,
Rex


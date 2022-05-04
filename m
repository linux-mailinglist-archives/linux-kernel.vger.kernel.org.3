Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74167519ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbiEDMHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiEDMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:07:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C3201B5;
        Wed,  4 May 2022 05:03:34 -0700 (PDT)
X-UUID: 4ac783a083044c47887f725726467a71-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:af7312e9-ca77-48d5-9c67-f2b729f75e05,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:d86e2b16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 4ac783a083044c47887f725726467a71-20220504
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 651015430; Wed, 04 May 2022 20:03:28 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 20:03:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 20:03:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 4 May 2022 20:03:26 +0800
Message-ID: <d2427c54c4e56cb6b4d4cdf16d9aedfd211ba748.camel@mediatek.com>
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
Date:   Wed, 4 May 2022 20:03:26 +0800
In-Reply-To: <20220504115826.5qqj22x4c7jldfxz@vireshk-i7>
References: <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
         <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
         <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
         <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
         <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
         <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
         <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
         <27a5dddd91b3dcbd69f08c10108cdec808237ace.camel@mediatek.com>
         <20220504082249.anrvkf2ssbxyzz5m@vireshk-i7>
         <332f8adec6601f97ab2814d06330883a251e41ec.camel@mediatek.com>
         <20220504115826.5qqj22x4c7jldfxz@vireshk-i7>
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

On Wed, 2022-05-04 at 17:28 +0530, Viresh Kumar wrote:
> On 04-05-22, 19:57, Rex-BC Chen wrote:
> > Thanks a lot! It helps to fix this issue.
> > And I will drop this patch in the next version.
> 
> Please provide your Tested-by in that thread then, it will help.
> 

Hello Viresh,

The verification is done by Jia-wei.
I will help him to provide Tested-by.

Thanks.

BRs,
Rex


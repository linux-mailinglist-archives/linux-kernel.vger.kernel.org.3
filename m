Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313157346E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiGMKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMKia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:38:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA40FD51C;
        Wed, 13 Jul 2022 03:38:22 -0700 (PDT)
X-UUID: 8e25dad35ffc4f0592d46075c10dd7cb-20220713
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:ace90e29-5bbf-4620-98e5-2e6e35d8a559,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:54
X-CID-INFO: VERSION:1.1.8,REQID:ace90e29-5bbf-4620-98e5-2e6e35d8a559,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_HamU,ACTI
        ON:release,TS:54
X-CID-META: VersionHash:0f94e32,CLOUDID:a60d61d7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:0e45bc946b18,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8e25dad35ffc4f0592d46075c10dd7cb-20220713
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 761655014; Wed, 13 Jul 2022 18:38:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 13 Jul 2022 18:38:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jul 2022 18:38:14 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <lecopzer.chen@mediatek.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <pmladek@suse.com>, <sparclinux@vger.kernel.org>,
        <sumit.garg@linaro.org>, <wangqing@vivo.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: RE: [PATCH v6 0/6] Support hld delayed init based on Pseudo-NMI for arm64
Date:   Wed, 13 Jul 2022 18:38:14 +0800
Message-ID: <20220713103814.16826-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220617040740.25631-1-lecopzer.chen@mediatek.com>
References: <20220617040740.25631-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark
 
Sorry for another ping,
but would you please help review this or comment about it?


Thanks a lot.

 
> Hi Will, Mark
>
> Could you help review arm parts of this patchset, please?
> 
> For the question mention in both [1] and [2],
> 
> > I'd still like Mark's Ack on this, as the approach you have taken doesn't
> > really sit with what he was suggesting.
> >
> > I also don't understand how all the CPUs get initialised with your patch,
> > since the PMU driver will be initialised after SMP is up and running.
> 
> The hardlock detector utilizes the softlockup_start_all() to start all
> the cpu on watchdog_allowed_mask, which will do watchdog_nmi_enable()
> that registers perf event on each CPUs.
> Thus we simply need to retry lockup_detector_init() in a single cpu which
> will reconfig and call to softlockup_start_all().
> 
> Also, the CONFIG_HARDLOCKUP_DETECTOR_PERF selects SOFTLOCKUP_DETECTOR,
> IMO, this shows that hardlockup detector supports from softlockup.
> 
> 
> > We should know whether pNMIs are possible once we've completed
> > setup_arch() (and possibly init_IRQ()), long before SMP, so so I reckon
> > we should have all the information available once we get to
> > lockup_detector_init(), even if that requires some preparatory rework.
> 
> Hardlockup depends on PMU driver , I think the only way is moving
> pmu driver at setup_arch() or any point which is earlier than
> lockup_detector_init(), and I guess we have to reorganize the architecture
> of arm PMU.
> 
> The retry function should benifit all the arch/ not only for arm64.
> Any arch who needs to probe its pmu as module can use this without providing
> a chance to mess up the setup order. 
> 
> 
> Please let me know if you have any concern about this, thank you
> 
> 
> [1] https://lore.kernel.org/all/CAFA6WYPPgUvHCpN5=EpJ2Us5h5uVWCbBA59C-YwYQX2ovyVeEw@mail.gmail.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20210419170331.GB31045@willie-the-truck/
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469D74C54F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiBZJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 04:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 04:53:16 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546E1BE94;
        Sat, 26 Feb 2022 01:52:34 -0800 (PST)
X-UUID: f0eb3a26f43443c5a941dfb29e7f5b4f-20220226
X-UUID: f0eb3a26f43443c5a941dfb29e7f5b4f-20220226
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 300805053; Sat, 26 Feb 2022 17:52:25 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 26 Feb 2022 17:52:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 26 Feb
 2022 17:52:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Feb 2022 17:52:23 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <pmladek@suse.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH 1/5] kernel/watchdog: remove WATCHDOG_DEFAULT
Date:   Sat, 26 Feb 2022 17:52:23 +0800
Message-ID: <20220226095223.15585-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YhjPyCl7Rjh6acQN@alley>
References: <YhjPyCl7Rjh6acQN@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat 2022-02-12 18:43:45, Lecopzer Chen wrote:
> > No reference to WATCHDOG_DEFAULT, remove it.
> 
> It would be enough to mention the link to the previous
> version in the cover letter.

Thanks, I'll tweak the commit message in next version patch.

> 
> > this commit reworks from [1].
> > 
> > [1] https://lore.kernel.org/lkml/20211014024155.15253-2-kernelfans@gmail.com/
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>


BRs,
Lecopzer

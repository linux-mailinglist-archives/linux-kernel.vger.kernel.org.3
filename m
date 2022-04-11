Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E564FBAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbiDKLR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiDKLRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:17:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845EEAE74;
        Mon, 11 Apr 2022 04:14:18 -0700 (PDT)
X-UUID: 1b6f1b0d0b4e4c32ad271348631c70d6-20220411
X-UUID: 1b6f1b0d0b4e4c32ad271348631c70d6-20220411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 547388954; Mon, 11 Apr 2022 19:14:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 19:14:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:14:13 +0800
Message-ID: <869b905e18571debcd5682b61b8cd8cafd0f3ebb.camel@mediatek.com>
Subject: Re: [PATCH V2 14/15] cpufreq: mediatek: Add support for MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Kevin Hilman <khilman@baylibre.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 11 Apr 2022 19:14:12 +0800
In-Reply-To: <7h8rsf5lih.fsf@baylibre.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-15-rex-bc.chen@mediatek.com>
         <7h8rsf5lih.fsf@baylibre.com>
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

On Fri, 2022-04-08 at 14:10 -0700, Kevin Hilman wrote:
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> 
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > The platform data of MT8186 is different from previous MediaTek
> > SoCs,
> > so we add a new compatible and platform data for it.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> There's no upstream DT for MT8186, so I"m curious how this was
> tested/valiated with upstream?
> 
> Kevin

Hello Kevin,

Thanks for your review.
The series of MT8186 DTS is still upstreaming.
From Matthias's comment, he will review MT8186 DTS series after clock
series is accepted.

We just now test MT8186 cpufreq on chromeos kernel v5.15.

MT8186 DTS series:
message id:20220311130732.22706-1-allen-kh.cheng@mediatek.com

BRs,
Rex


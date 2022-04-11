Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D774FBA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbiDKLN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbiDKLNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:13:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173BE34;
        Mon, 11 Apr 2022 04:09:52 -0700 (PDT)
X-UUID: 4d1ee65a5a024114b512a6064079f27b-20220411
X-UUID: 4d1ee65a5a024114b512a6064079f27b-20220411
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1431660548; Mon, 11 Apr 2022 19:09:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 19:09:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:09:44 +0800
Message-ID: <5c6dc5ed28c64f62b66e7b68b54c342b63e42d42.camel@mediatek.com>
Subject: Re: [PATCH V2 15/15] cpufreq: mediatek: Use device print to show
 logs
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 11 Apr 2022 19:09:44 +0800
In-Reply-To: <20220411032922.yj4p42is5ky6bgau@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-16-rex-bc.chen@mediatek.com>
         <20220411032922.yj4p42is5ky6bgau@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-11 at 08:59 +0530, Viresh Kumar wrote:
> On 08-04-22, 12:59, Rex-BC Chen wrote:
> > Replace pr_* with dev_* to show logs.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 41 +++++++++++++++++---------
> > ----
> >  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> One should always arrange the patches in this form:
> 
> - Fix bugs first (since they need to be applied first and need to go
>   to stable kernels too).
> 
> - Trivial fixes next, like this one which you chose to be present at
>   15/15. I would have applied this one right away, if it wasn't he
>   last one, because of which we have conflicts now.
> 
> - Non-trivial patches later, so reviews on them don't affect other
>   patches.
> 
Hello Viresh,

Thanks for your review and suggestions.
I will put this patch to first in next version.

BRs,
Rex


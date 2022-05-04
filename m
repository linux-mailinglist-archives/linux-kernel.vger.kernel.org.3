Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE57519EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbiEDMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiEDMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:10:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E11E3CD;
        Wed,  4 May 2022 05:06:42 -0700 (PDT)
X-UUID: 0945cdf5d10b472bbb0d06fd096e0f9d-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4571927b-e1ff-4707-ad51-20fa77eb49f8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:17842b16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 0945cdf5d10b472bbb0d06fd096e0f9d-20220504
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 393181000; Wed, 04 May 2022 20:06:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 20:06:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 4 May 2022 20:06:38 +0800
Message-ID: <af5d30f36092f387e4de7e4c09ca09f9de0478ba.camel@mediatek.com>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to
 mismatch
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>
Date:   Wed, 4 May 2022 20:06:38 +0800
In-Reply-To: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
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

On Wed, 2022-05-04 at 13:51 +0530, Viresh Kumar wrote:
> For some platforms, the frequency returned by hardware may be
> slightly
> different from what is provided in the frequency table. For example,
> hardware may return 499 MHz instead of 500 MHz. In such cases it is
> better to avoid getting into unnecessary frequency updates, as we may
> end up switching policy->cur between the two and sending unnecessary
> pre/post update notifications, etc.
> 
> This patch has chosen allows the hardware frequency and table
> frequency
> to deviate by 1 MHz for now, we may want to increase it a bit later
> on
> if someone still complains.
> 
> Reported-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 

Hello Viresh,

Thanks for your help!
Jia-wei verified this patch in his device, and I help him to add this.

Tested-by: Jia-wei Chang <jia-wei.chang@mediatek.com>

BRs,
Rex


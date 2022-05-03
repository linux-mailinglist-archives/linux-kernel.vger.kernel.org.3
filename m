Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A493518352
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiECLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:37:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0A1FA7F;
        Tue,  3 May 2022 04:33:56 -0700 (PDT)
X-UUID: 3f02b69008e940648899deba6a136be6-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e26d4717-7fed-4b66-92ba-d10b923e60d3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:e26d4717-7fed-4b66-92ba-d10b923e60d3,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:190653c7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 3f02b69008e940648899deba6a136be6-20220503
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1654081226; Tue, 03 May 2022 19:33:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 May 2022 19:33:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 3 May 2022 19:33:48 +0800
Message-ID: <27a5dddd91b3dcbd69f08c10108cdec808237ace.camel@mediatek.com>
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
Date:   Tue, 3 May 2022 19:33:48 +0800
In-Reply-To: <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-8-rex-bc.chen@mediatek.com>
         <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
         <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
         <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
         <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
         <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
         <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
         <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-28 at 17:18 +0530, Viresh Kumar wrote:
> On 28-04-22, 19:16, Rex-BC Chen wrote:
> > Yes, the call stack will eventually go to __cpufreq_driver_target.
> > However, we can observe the mismatch between target_freq and
> > policy-cur 
> > with a tiny difference.
> > e.g.
> > [ 553.065356] cpufreq: target for CPU 0: 500000 kHz, relation 0,
> > requested 500000 kHz
> > [ 553.066366] cpufreq: target_freq/policy->cur: 500000/499999 kHz
> 
> So you are trying to set the frequency to 500 MHz now, but policy-
> >cur says it
> is 499 MHz.
> 
Hello Viresh,

Yes.

> > We check the assignment of policy->cur could be either from
> > cpufreq_driver->get_intermediate or from cpufreq_driver->get.
> 
> policy->cur is set only at two places, in your case:
> - CPUFREQ_POSTCHANGE
> - cpufreq_online()
> 
> From what I understand, it is possible that cpufreq_online() is
> setting your
> frequency to 499999 (once at boot), but as soon as a frequency change
> has
> happened after that, policy->cur should be set to 500 MHz and you
> should see
> this problem only once.
> 

Our observation tells us cpufreq_online is setting only once at boot
for one cpu cluster.
But we can see the problem repeatly occurs once cpufreq_get is invoked.

e.g.
[ 71.154560] cpufreq: Warning: CPU frequency out of sync: cpufreq and
timing core thinks of 500000, is 499999 kHz
[ 71.155880] cpufreq: notification 0 of frequency transition to 499999
kHz
[ 71.156777] cpufreq: notification 1 of frequency transition to 499999
kHz
[ 71.187241] cpufreq: target for CPU 0: 500000 kHz, relation 0,
requested 500000 kHz
[ 71.188246] cpufreq: target_freq/policy->cur: 500000/499999 kHz

> From CPUFREQ_POSTCHANGE notifier, we always set policy->cur from the
> table
> itself, which should be 500000 MHz.
> 

Our observation tells me it can be either 499999 kHz or 500000 kHz.
This can be printed at the last line of CPUFREQ_POSTCHANGE within
'cpufreq_notify_transition'

> I wonder how you see policy->cur to be 499999 here. Does this happen
> only once ?
> Or repeatedly ?
> 

It repeatly happens.

> > But it is strange to have the frequency value like 499999 kHz.
> > Is the result of tiny frequency difference expected from your point
> > of
> > view?
> 
> Clock driver can give this value, that is fine.
> 

Thanks for your answer.

> > > What do you mean by "voltage pulse" here? What actually happens
> > > which
> > > you want to avoid.
> > > 
> > 
> > When cpufreq is fixed to lowest opp, "voltage pulse" is a quick
> > voltage
> > rising and falling phenomenon which can be observed if
> > 'cpufreq_get' is
> > invoked.
> 
> Do check if the call is reaching your driver's ->target_index(), it
> should be
> which it should not, ideally.
> 

Yes, 'cpufreq_get' will eventually go to '->target_index()' because of
inequality between target_freq and policy->cur.

And we realized that the "voltage pulse" is generated by quick
switching voltage from 500 MHz to intermediate voltage and back to 500
MHz in current mediatek-cpufreq.c.
To fix it, we think two possible ways to approach.
One is from cpufreq framework side. Is it expected to update the
cpufreq platform driver repeatly for this case?
If it is expected, then from platform driver side, mediatek-cpufreq
should handle a condition to avoid unnecessary intermediate voltage
switching.

BRs,
Rex

> > Thank you for sharing the correct information.
> > Is it possible to get frequency (API) a simple way, like get
> > current
> > opp frequency?
> 
> Lets dig/debug a bit further and fix this if a real problem exists.
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639F500451
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbiDNCfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiDNCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:35:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C93193E;
        Wed, 13 Apr 2022 19:32:34 -0700 (PDT)
X-UUID: 50fd56eeb8ca4a7a98dcc5b707929fc3-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0af9424a-3ad4-438b-875e-02c45679f611,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:0af9424a-3ad4-438b-875e-02c45679f611,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:d24d14a9-d103-4e36-82b9-b0e86991b3df,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 50fd56eeb8ca4a7a98dcc5b707929fc3-20220414
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1189990021; Thu, 14 Apr 2022 10:32:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 14 Apr 2022 10:32:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 10:32:29 +0800
Message-ID: <12c630946ce9d7b8c80143615496238759323981.camel@mediatek.com>
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
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
Date:   Thu, 14 Apr 2022 10:32:29 +0800
In-Reply-To: <7hlew83blk.fsf@baylibre.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-14-rex-bc.chen@mediatek.com>
         <7hfsmn5m9f.fsf@baylibre.com>
         <bc6dd020a1cc3f00f5be2bf2929046b9116bbeef.camel@mediatek.com>
         <7hwnfv4hfr.fsf@baylibre.com>
         <f00e3df2e270e5edc160f8ff1bd8c52a49bf71d5.camel@mediatek.com>
         <7h5yne3zlx.fsf@baylibre.com>
         <98957e61b040b6c5b6a6b39e6eb661e07e510277.camel@mediatek.com>
         <7hlew83blk.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 14:41 -0700, Kevin Hilman wrote:
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> 
> [...]
> 
> > From the Chanwoo's devfreq passive govonor series, it's impossible
> > to
> > let cci devreq probed done before cpufreq because the passive
> > govonor
> > will search for cpufreq node and use it.
> > 
> > Ref: function: cpufreq_passive_register_notifier()
> > 
> > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=b670978ddc43eb0c60735c3af6e4a370603ab673__;!!CTRNKA9wMg0ARbw!z58Lc1p9REo88oHn-NkxroN_fBd0TsHYmhscNZwnWwT71ecRkTeqZ6vFl5l7HpkTdM6t$
> >  
> 
> Well this is a problem, because CCI depends on CPUfreq, but CPUfreq
> depends on CCI, so one of them has to load and then wait for the
> other.
> 
> > After I discuss with Angelo and Jia-wei, we think we are keeping
> > the
> > function in target_index and if the cci is not ready we will use
> > the
> > voltage which is set by bootloader to prevent high freqeuncy low
> > voltage crash. And then we can keep seting the target frequency.
> > 
> 
>  > We assume the setting of bootloader is correct and we can do this.
> 
> I'm still not crazy about this because you're lying to the CPUfreq
> framework.  It's requesting one OPP, but you're not setting that,
> you're
> just keeping the bootloader frequency.
> 
> In my earlier reply, I gave two other options for handling this.
> 
> 1) set a (temporary) constraint on the voltage regulator so that it
> cannot change.
> 
> or more clean, IMO:
> 
> 2) set a CPUfreq policy that restricts available OPPs to ones that
> will
> not break CCI.
> 
> Either of these solutions allow you to load the CPUfreq driver early,
> and then wait for the CCI driver to be ready before removing the
> restrictions.

Hello Kevin,

I think I do not describe this clearly.
The proposal is:

In cpufreq probe:
we record the voltage value which is set by bootloader.

In mtk_cpufreq_set_target():
We do NOT directly return 0.
Instead, we will find the voltage of target cpufreq and use the value
max(booting voltage, target cpufreq voltage)

mtk_cpufreq_set_target() {
	/* NOT return 0 if !is_ccifreq_ready */
	....
	vproc = get voltage of target cpufreq from opp.

	if (ccifreq_supported && !is_ccifreq_ready)
		vproc = max(vproc, vproc_on_boot)

	//setting voltage and target frequency
	....
}

> 
> > For the SoCs that including ci hardware (8183 and 8186), we think
> > it's
> > not ok if we don't probe cci correctly.
> > If we failed to get cci node, I think we sould return -ENODEV and
> > the
> > probe of cpufreq failed.
> > 
> > What do you think the solution?
> 
> I think it would be better if CPUfreq probes sucessfully, but
> restricts
> the OPPs available until CCI is ready.  If CCI fails to probe/load,
> you
> still have a working CPUfreq driver, it just has a restricted set of
> OPPs.
> 
> Kevin

If we can use the solution.
I think it will be ok for this situation.

Thanks!

BRs,
Rex


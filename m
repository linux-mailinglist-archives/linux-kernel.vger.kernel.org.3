Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B16500BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbiDNK4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiDNK4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:56:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C89785964;
        Thu, 14 Apr 2022 03:53:46 -0700 (PDT)
X-UUID: fca42ba6a59d40d7b9191394f2be496b-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:495b6e50-7533-45af-a89b-7e85957b0d23,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:495b6e50-7533-45af-a89b-7e85957b0d23,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:ae6a6178-0afa-4dca-bdec-ca54c998425a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: fca42ba6a59d40d7b9191394f2be496b-20220414
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1957113257; Thu, 14 Apr 2022 18:53:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 14 Apr 2022 18:53:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 18:53:39 +0800
Message-ID: <be86691b529dd691203fbb5b35f8572e7e9119a8.camel@mediatek.com>
Subject: Re: [PATCH V2 10/15] cpufreq: mediatek: Make sram regulator optional
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
Date:   Thu, 14 Apr 2022 18:53:39 +0800
In-Reply-To: <7ho81b5n9v.fsf@baylibre.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-11-rex-bc.chen@mediatek.com>
         <7ho81b5n9v.fsf@baylibre.com>
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

On Fri, 2022-04-08 at 13:32 -0700, Kevin Hilman wrote:
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> 
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > For some MediaTek SoCs, like MT8186, it's possible that the sram
> > regulator
> > is shared between CPU and CCI.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> nit: missing your sign-off.
> 
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index 9e9bce0ff235..8f688d47e64b 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -435,7 +435,7 @@ static int mtk_cpu_dvfs_info_init(struct
> > mtk_cpu_dvfs_info *info, int cpu)
> >  	}
> >  
> >  	/* Both presence and absence of sram regulator are valid cases.
> > */
> > -	info->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
> > +	info->sram_reg = regulator_get_optional(cpu_dev, "sram");
> 
> The changelog says that this regulator may be shared with CCI, so I
> understand it's no longer exclusive.  But here you make it optional,
> which should be explained in the changelog.  If it's not actually
> optional, then it should just be normal "get".
> 
> Kevin

Hello Kevin,

Since cpufreq and cci devfreq might share the same sram regulator in
MediaTek SoC, it is no longer exclusive as you mentioned.

The reason to use regulator_get_optional is we hope regulator framework
can return error for error handling rather than a dummy handler from
regulator_get api.

I will add this to commit message in next version.

Thanks.

BRs,
Rex


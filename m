Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC39E50ADBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387881AbiDVC1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443333AbiDVC1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:27:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECF4B1DC;
        Thu, 21 Apr 2022 19:24:45 -0700 (PDT)
X-UUID: 7ceff751403c40149ff85e4986925678-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4cd73f59-0e2d-4a4b-8407-568bd6f809ad,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:53,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:61
X-CID-INFO: VERSION:1.1.4,REQID:4cd73f59-0e2d-4a4b-8407-568bd6f809ad,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:53,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:61
X-CID-META: VersionHash:faefae9,CLOUDID:3f34b5ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:2261f5381ea9,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 7ceff751403c40149ff85e4986925678-20220422
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 473631616; Fri, 22 Apr 2022 10:24:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 10:24:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 10:24:39 +0800
Message-ID: <d67d5f4f2ec96ade2398e7c0897dbb16bf5fb145.camel@mediatek.com>
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Nishanth Menon" <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Date:   Fri, 22 Apr 2022 10:24:39 +0800
In-Reply-To: <7hsfq6ql4v.fsf@baylibre.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
         <7hczhbe3wn.fsf@baylibre.com>
         <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
         <7hsfq6ql4v.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, 2022-04-21 at 12:41 -0700, Kevin Hilman wrote:
> Hi Roger,
> 
> Roger Lu <roger.lu@mediatek.com> writes:
> 
> > On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:
> 
> [...]
> 
> > > That being said, it would be really nice to see an integration tree
> > > where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
> > > 
> > > For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
> > > board, it fails to probe[1] because there is no CCI node in the upstream
> > > mt8183.dtsi.
> > > 
> > > I'm assuming this series is also not very useful without the CPUfreq
> > > series from Rex, so being able to test this, CCI and CPUfreq together on
> > > MT8183 on a mainline kernel would be very helpful.
> > > 
> > > Kevin
> > > 
> > > [1]
> > > [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
> > > [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe
> > > fail
> > 
> > Just share. I've tested this series on below two platforms and it works as
> > expected.
> > - mt8183-Krane (kernel-v5.10)
> > - mt8192-Hayato (kernel-v5.4)
> 
> Unfortunately testing on v5.4 and v5.10 with lots of other additional
> out-of-tree patches does not give much confidence that this series works
> with upstream, especially when I've given a few reasons why it will not
> work uptream.
> 
> The examples I gave above for CCI and CPUs/cluster disable are good
> examples, but another one I forgot to mention is the dependency on Mali.
> The SVS driver will never probe because it also depens on a "mali" node,
> which doesn't exist upstream either (but panfrost does, and acutually
> loads/probes fine on v5.17/v5.18) so this should be fixed to work with
> upstream panfrost.
> 
> IMO, in order for this to be merged upstream, it should at least have
> some basic validation with upstream, and so far I have not even been
> able to make it successfuly probe.  To do that, you will need to either
> provide a list of the dependencies for testing this with mainline
> (e.g. CCI series, CPUfreq series, any DT changes), or even better, an
> integration tree based on recent mainline (e.g. v5.17 stable, or
> v5.18-rc) which shows all the patches (in addition to this series) used
> to validate this on mainline.

No problem. We'll find a machine that can be run correctly with recent mainline
(e.g. v5.17 stable, or v5.18-rc) and add patches (CCI series + CPUfreq series +
any DT changes) to test this SVS series. Thanks very much.

> 
> Thanks,
> 
> Kevin
> 
> 
> 


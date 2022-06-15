Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4654C04A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiFODsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFODsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:48:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A244F44E;
        Tue, 14 Jun 2022 20:48:44 -0700 (PDT)
X-UUID: 386566dbd05e4b839c4e3d6571a5e888-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:63dc35d9-5fc0-44ab-819a-bfe3489fafbb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:63dc35d9-5fc0-44ab-819a-bfe3489fafbb,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:7d768548-4c92-421c-ad91-b806c0f58b2a,C
        OID:91aab2dd5763,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 386566dbd05e4b839c4e3d6571a5e888-20220615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2075489283; Wed, 15 Jun 2022 11:48:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 11:48:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:48:36 +0800
Message-ID: <722c704fd6964d5c5cef731cd34ca3f71222b681.camel@mediatek.com>
Subject: Re: [PATCH v3 07/10] scsi: ufs-mediatek: Support flexible
 parameters for smc calls
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bart Van Assche <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Date:   Wed, 15 Jun 2022 11:48:36 +0800
In-Reply-To: <fe6ba3bd-81f4-215d-5f1b-0fa05e68a0c5@acm.org>
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
         <20220614141655.14409-8-stanley.chu@mediatek.com>
         <fe6ba3bd-81f4-215d-5f1b-0fa05e68a0c5@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Tue, 2022-06-14 at 09:28 -0700, Bart Van Assche wrote:
> On 6/14/22 07:16, Stanley Chu wrote:
> > From: Alice Chao <alice.chao@mediatek.com>
> > 
> > Provide flexible number of parameters for UFS SMC calls to be
> > easily used for future SMC usages.
> 
> How far in the future? Please only introduce what is needed for this 
> patch series.

Sure, I just rewrote and simplified SMC call macros according to your
good suggestions in v4.

> 
> > +/*
> > + * SMC call wapper function
> 
>                 ^^^^^^
> typo

Fixed in v4.
> 
> > + */
> > +#define _ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, v6) \
> > +		arm_smccc_smc(MTK_SIP_UFS_CONTROL, \
> > +				  cmd, v1, v2, v3, v4, v5, v6, &(res))
> > +
> > +#define _ufs_mtk_smc_0(cmd, res) \
> > +	_ufs_mtk_smc(cmd, res, 0, 0, 0, 0, 0, 0)
> > +
> > +#define _ufs_mtk_smc_1(cmd, res, v1) \
> > +	_ufs_mtk_smc(cmd, res, v1, 0, 0, 0, 0, 0)
> > +
> > +#define _ufs_mtk_smc_2(cmd, res, v1, v2) \
> > +	_ufs_mtk_smc(cmd, res, v1, v2, 0, 0, 0, 0)
> > +
> > +#define _ufs_mtk_smc_3(cmd, res, v1, v2, v3) \
> > +	_ufs_mtk_smc(cmd, res, v1, v2, v3, 0, 0, 0)
> > +
> > +#define _ufs_mtk_smc_4(cmd, res, v1, v2, v3, v4) \
> > +	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, 0, 0)
> > +
> > +#define _ufs_mtk_smc_5(cmd, res, v1, v2, v3, v4, v5) \
> > +	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, 0)
> > +
> > +#define _ufs_mtk_smc_6(cmd, res, v1, v2, v3, v4, v5, v6) \
> > +	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, v6)
> > +
> > +#define _ufs_mtk_smc_selector(cmd, res, v1, v2, v3, v4, v5, v6,
> > FUNC, ...) FUNC
> > +
> > +#define ufs_mtk_smc(...) \
> > +	_ufs_mtk_smc_selector(__VA_ARGS__, \
> > +	_ufs_mtk_smc_6(__VA_ARGS__), \
> > +	_ufs_mtk_smc_5(__VA_ARGS__), \
> > +	_ufs_mtk_smc_4(__VA_ARGS__), \
> > +	_ufs_mtk_smc_3(__VA_ARGS__), \
> > +	_ufs_mtk_smc_2(__VA_ARGS__), \
> > +	_ufs_mtk_smc_1(__VA_ARGS__), \
> > +	_ufs_mtk_smc_0(__VA_ARGS__) \
> > +	)
> 
> If _ufs_mtk_smc() would be modified to accept an struct _ufs_mtk_args
> as 
> its only argument, would that allow to simplify the above into the 
> following?
> 
> #define ufs_mtk_smc(...) \
>    _ufs_mtk_smc((struct _ufs_mtk_args){__VA_ARGS__})
> 
> > +/*
> > + * Sip kernel interface
> > + */
> 
> What is "Sip"? Should it perhaps be spelled as "SIP"?
> 
> Thanks,
> 
> Bart.


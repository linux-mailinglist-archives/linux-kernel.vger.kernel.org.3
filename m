Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A04B1D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiBKDuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:50:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiBKDug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:50:36 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9605F48;
        Thu, 10 Feb 2022 19:50:35 -0800 (PST)
X-UUID: ad3d138fad4e49e1be92cfee2c0b992c-20220211
X-UUID: ad3d138fad4e49e1be92cfee2c0b992c-20220211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 198974902; Fri, 11 Feb 2022 11:50:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Feb 2022 11:50:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 11:50:30 +0800
Message-ID: <053d70915fe6f2a8b3848fb0e83a3113d156d875.camel@mediatek.com>
Subject: Re: [V11, PATCH 03/19] soc: mediatek: add header for mediatek SIP
 interface
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "James Liao" <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Date:   Fri, 11 Feb 2022 11:50:30 +0800
In-Reply-To: <21030007-f135-58ee-ecfb-8ee0fcfdf155@collabora.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
         <20210812085846.2628-4-dawei.chien@mediatek.com>
         <21030007-f135-58ee-ecfb-8ee0fcfdf155@collabora.com>
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

On Thu, 2022-02-03 at 16:14 +0100, AngeloGioacchino Del Regno wrote:
> Il 12/08/21 10:58, Dawei Chien ha scritto:
> > From: Henry Chen <henryc.chen@mediatek.com>
> > 
> > Add a header to collect SIPs and add one SIP call to initialize
> > power
> > management hardware for the SIP interface defined to access the SPM
> > handling vcore voltage and ddr rate changes on mt8183 (and most
> > likely
> > later socs).
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > Signed-off-by: Arvin Wang <arvin.wang@mediatek.com>
> 
> Please sign-off this and all the other patches that you send.

Thank you for your review, I would sign-off all the others patches on
next version.


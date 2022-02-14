Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04C34B3FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiBNCdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:33:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbiBNCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:32:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA95AECB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:32:12 -0800 (PST)
X-UUID: 5634885e033f4b2ba8bad653b3e2e193-20220214
X-UUID: 5634885e033f4b2ba8bad653b3e2e193-20220214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1241168833; Mon, 14 Feb 2022 10:32:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 10:32:09 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 10:32:09 +0800
Message-ID: <9295cbd918d1303f5cc2bbb7defb94d5e338606d.camel@mediatek.com>
Subject: Re: [0/3] Cooperate with DSI RX devices to modify dsi funcs and
 delay mipi high to cooperate with panel sequence
From:   CK Hu <ck.hu@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 14 Feb 2022 10:32:09 +0800
In-Reply-To: <1644589818-13066-1-git-send-email-xinlei.lee@mediatek.com>
References: <1644589818-13066-1-git-send-email-xinlei.lee@mediatek.com>
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

Hi, Xinlei:

On Fri, 2022-02-11 at 22:30 +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> In order to match the changes of DSI RX devices (for example,
> anx7625), 
> the poweron/poweroff of dsi is extracted from enable/disable and 
> defined as new funcs (pre_enable/post_disable).
> 
> The delayed MIPI signal is pulled high from LP00 to LP11, 
> in order to match the power-on sequence of the panel.

This is series a bug-fix or new feature (If anx7625 has never work in
upstream and this series would make support anx7625, this is new
feature) If this is a bug-fix, add Fixes tag [1] in patches.

[1] 
https://www.kernel.org/doc/html/v5.16/process/submitting-patches.html

Regards,
CK

> 
> Jitao Shi (3):
>   drm/mediatek: dsi fine tune the dsi poweron flow
>   drm/mediatek: dsi bridge implement pre_enable and post_disable
>   drm/mediatek: keep dsi as LP00 before dcs cmds transfer
> 
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 73 +++++++++++++++++++++++++---
> ----------
>  1 file changed, 49 insertions(+), 24 deletions(-)
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C24D266F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiCIDIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiCIDII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:08:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC5714A6F0;
        Tue,  8 Mar 2022 19:07:08 -0800 (PST)
X-UUID: daade56b740b43d3b91adfd9e2c0c7f3-20220309
X-UUID: daade56b740b43d3b91adfd9e2c0c7f3-20220309
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 246531414; Wed, 09 Mar 2022 11:04:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Mar 2022 11:04:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 11:04:31 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <lukas.bulwahn@gmail.com>
CC:     <bin.liu@mediatek.com>, <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mchehab@kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: drop unreachable contact for MEDIATEK JPEG DRIVER
Date:   Wed, 9 Mar 2022 11:04:31 +0800
Message-ID: <20220309030431.31247-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220308114300.12502-1-lukas.bulwahn@gmail.com>
References: <20220308114300.12502-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

> After sending a patch to Rick Chang, the mediatek mail server responded:
> 
>   ** Message not delivered **
> 
>   Your message couldn't be delivered to rick.chang@mediatek.com because
>   the remote server is misconfigured. See technical details below for more
>   information.
> 
>   The response from the remote server was:
>   550 Relaying mail to rick.chang@mediatek.com is not allowed
> 
> So, drop Rick Chang from the MEDIATEK JPEG DRIVER section.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I confirmed that Rick Chang has left Mediatek, so it is ok to remove his name.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Thanks,
Miles

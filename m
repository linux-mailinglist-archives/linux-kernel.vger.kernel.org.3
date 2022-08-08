Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839D458C4F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiHHIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHHIfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:35:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48735263D;
        Mon,  8 Aug 2022 01:35:18 -0700 (PDT)
X-UUID: e00517e4fe0c42c5a04c3cb478211a06-20220808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=H1gH13JIdDwMN199QhmpDW0yWKPk/chPlNXobtyICTY=;
        b=SPMsn3u410SY/PNOGAwVFmZknwYkIS1bxwfPQDcF/nL8jbhHvXARFes1EoMOvqtc2hv6BpP8yWtSKR2f1VFFrLywsPTovgtrJx+FFcqH8sNFtC2uUfQNMAGIRa23JNsRY0mQV1CxppQMIYMvRwLULA5ZyRQtyK/zXgzmy/i+rVo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:abfee422-2053-4124-b0f4-d4c54eb7abf0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:133135ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e00517e4fe0c42c5a04c3cb478211a06-20220808
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1657741834; Mon, 08 Aug 2022 16:35:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 8 Aug 2022 16:35:11 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Aug 2022 16:35:11 +0800
Message-ID: <63920b2ae09e8f82a9b866cd01ddb63b958fb4e8.camel@mediatek.com>
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Simplify some error message
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Date:   Mon, 8 Aug 2022 16:35:11 +0800
In-Reply-To: <7705a9dff8e097070c492d6f4f8aafaaa890f049.1659763173.git.christophe.jaillet@wanadoo.fr>
References: <7705a9dff8e097070c492d6f4f8aafaaa890f049.1659763173.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-08-06 at 07:19 +0200, Christophe JAILLET wrote:
> dev_err_probe() already prints the error code in a human readable
> way, so
> there is no need to duplicate it as a numerical value at the end of
> the
> message.
> 
> Fixes: ddaf0d6dc467 ("usb: common: usb-conn-gpio: use dev_err_probe()
> to print log")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/common/usb-conn-gpio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c
> b/drivers/usb/common/usb-conn-gpio.c
> index b39c9f1c375d..44c5127175b7 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -208,10 +208,9 @@ static int usb_conn_probe(struct platform_device
> *pdev)
>  	if (PTR_ERR(info->vbus) == -ENODEV)
>  		info->vbus = NULL;
>  
> -	if (IS_ERR(info->vbus)) {
> -		ret = PTR_ERR(info->vbus);
> -		return dev_err_probe(dev, ret, "failed to get vbus
> :%d\n", ret);
> -	}
> +	if (IS_ERR(info->vbus))
> +		return dev_err_probe(dev, PTR_ERR(info->vbus),
> +				     "failed to get vbus\n");
How about putting dev_err_probe() in a single line? it doesn't exceed
100 chars.

>  
>  	info->role_sw = usb_role_switch_get(dev);
>  	if (IS_ERR(info->role_sw))


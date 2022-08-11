Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C958F894
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiHKHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiHKHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:49:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0B8E9B2;
        Thu, 11 Aug 2022 00:49:22 -0700 (PDT)
X-UUID: 2c24c874b51f4c8389e6af48ac0d47ca-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=61XhcT8p7U2ythcRq1ZKIH+rMJLYKYuleNkS3KVnsl4=;
        b=FI8Xk3i7iekGIRyWN03AH3pJQ7yzl0IX/GfTz9JjJ23zx29hGGX8yJPt1hFmdmi9wN3rJ9pc9l4qT2k9sq+uIfpJmEHD28ACUBwreFXjNaG3WYJTmlhzfuKiPwUsvJuKmvc5CJu0y99ZSWhtgHnNcSZTJlI2mk0tQGtDyR7ZAcs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:385dcd3b-2422-426b-ab46-f61ac596c3c8,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:67715d9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2c24c874b51f4c8389e6af48ac0d47ca-20220811
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 169198960; Thu, 11 Aug 2022 15:49:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 15:49:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Aug 2022 15:49:13 +0800
Message-ID: <267e2c23f488756ab3256f787750ef4979398279.camel@mediatek.com>
Subject: Re: [PATCH v2] usb: common: usb-conn-gpio: Simplify some error
 message
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 11 Aug 2022 15:49:13 +0800
In-Reply-To: <7505a9dfa1e097070c492d6f6f84afa2a490b040.1659763173.git.christophe.jaillet@wanadoo.fr>
References: <7505a9dfa1e097070c492d6f6f84afa2a490b040.1659763173.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-09 at 22:28 +0200, Christophe JAILLET wrote:
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
> Change in v2:
>   * keep the message on the same line of dev_err_probe() because the
> line is
>     still < 100 char   [Chunfeng Yun <chunfeng.yun@mediatek.com>]
> ---
>  drivers/usb/common/usb-conn-gpio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c
> b/drivers/usb/common/usb-conn-gpio.c
> index b39c9f1c375d..44c5127175b7 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -208,10 +208,8 @@ static int usb_conn_probe(struct platform_device
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
> +		return dev_err_probe(dev, PTR_ERR(info->vbus), "failed
> to get vbus\n");
>  
>  	info->role_sw = usb_role_switch_get(dev);
>  	if (IS_ERR(info->role_sw))
Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks



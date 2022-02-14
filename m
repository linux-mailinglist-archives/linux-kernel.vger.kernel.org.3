Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2128B4B4AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBNKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:33:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348982AbiBNKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:31:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D19DD78;
        Mon, 14 Feb 2022 01:59:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 79FD21F43053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644832798;
        bh=PmeiC/wYqvKXsD5lUE5EB7IB8YOl2pZWINM/lweU0uQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=huItp0jpBT5mIuS3V2qntF47BW1WYY6qF2Sphz5S5Es9/zaydd2GXERLPFT48Tg7I
         fkYl24WNF0i/WY3JaQYCJ4SSLVD397Irnv1yVkV8sJRdWorZgZlGvWQ4JvmRgIy9AW
         4qSFNoTZ+SW09YJaey4sO0UFk6hq1dZVLsm6Dd6QV3E/z+KHfZ0TLRiUb+9xA4V8oP
         WSZZI6dCgNTb/OX7OQ275Y3ZmvM+Zt3BQYxwqkjQGpQBbxWMQmjJqRjtsdBGygbnRO
         SdcBfHb106jhNlW++A9eGBwHtD0h0Ai93vVVfLmlQxpqs6wNuz0vPKnxnkoyO6nMHT
         IGQakN7qdIYYA==
Message-ID: <2dae87c6-c796-4687-0f21-86a0b36ae1ac@collabora.com>
Date:   Mon, 14 Feb 2022 10:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 2/3] pinctrl: add pinctrl driver on mt8186
Content-Language: en-US
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220214030631.4969-1-guodong.liu@mediatek.com>
 <20220214030631.4969-3-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220214030631.4969-3-guodong.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/22 04:06, Guodong Liu ha scritto:
> This commit includes pinctrl driver for mt8186.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/mediatek/Kconfig              |    7 +
>   drivers/pinctrl/mediatek/Makefile             |    1 +
>   drivers/pinctrl/mediatek/pinctrl-mt8186.c     | 1311 ++++++++++
>   drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h | 2186 +++++++++++++++++
>   4 files changed, 3505 insertions(+)
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8186.c
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h
> 

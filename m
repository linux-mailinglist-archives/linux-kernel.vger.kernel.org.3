Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFE5068FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350761AbiDSKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350717AbiDSKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:49:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED491B7B6;
        Tue, 19 Apr 2022 03:46:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8D1601F416DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650365200;
        bh=miYHRwrSfiYZQBPctYUYWsQLZRG1eJ5lKnyCAoRZDKU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VbzXgqYfkge78XHuAUROvfBmnV6GgopU5H+v2XI/sGzcG4DomOxUVKrETu2o1NdW1
         EjLpIFj+42X3tCYm1tPkA6nXS6N61SJh0aMuSnz0mqGQnbAWKRxoIOZg/YxWyrHqZd
         AbQX56pIxFefA9TcPFA8rP25yJAA8Nyo2PxieWhyi46/PJd6Mnts/macCkkyOyKxz8
         o0GKW7Ou/2Dju0g5ExIbXa9/y9n0/1m2jtAjzpIckw9RcEXVrhvYy4B3qQcBeZ94CS
         jaEVOZTOdXLBNVyI69I3Vp6oiMbU6QE4neFW+EqHHqT1K5NI0L1nsyFmAYWStuG+cQ
         4/mzWt5krFI4w==
Message-ID: <20eaaba7-19cb-8f1d-ecf4-bfac14d50f67@collabora.com>
Date:   Tue, 19 Apr 2022 12:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/7] clk: mediatek: reset: Add reset.h
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        yong.liang@mediatek.com, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
 <20220418132154.7401-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220418132154.7401-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/04/22 15:21, Rex-BC Chen ha scritto:
> Add a new file "reset.h" to place some definitions for clock reset.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mtk.h | 10 +---------
>   drivers/clk/mediatek/reset.h   | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/clk/mediatek/reset.h
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index dafdf30fe94e..dfb0549ceb6c 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -12,6 +12,7 @@
>   #include <linux/kernel.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> +#include <reset.h>

This should be

#include "reset.h"

...since the header is in the same directory.



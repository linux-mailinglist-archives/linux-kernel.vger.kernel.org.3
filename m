Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D54F511A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844733AbiDFBv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383922AbiDEPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:14:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C9176D2B;
        Tue,  5 Apr 2022 06:28:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5C7E11F45039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649165288;
        bh=Z7ly7VhlEOXC12e1olu1To154Rm7ZW9SK4TYqH7rDZo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YHL0QdBT1QmRtgT1WU9noVhfECYnV9pv95Lc/V6R++QnDzUSC2k02WMDvZxPYIqfC
         gLEPY9mGBOB3Ne3oJ9Fvio2HgVmNjVcTPPJywzKLqnLMgSHzyyxNm2VU+OKPP7xUgS
         NxHwaXlNkMsQ/0RoyXHb0SeMz7dJ9xRxhR6tUCYcwGWgKSpCG91s4GtEhC5WjcfAQ8
         fdMxOZq/UtoMGw2siwvAgd0HgX4GvVXbRt1i/W+IOsTvRtIQZFxYAEieFZrDEHzDRx
         TsPLd3kKeLSeWHpX3guu/wf6Vy4idnvwHtLUOAFiBAH4HGkH1w0w6y+HElgwdZltN7
         8yKI1tAXvkkaw==
Message-ID: <4bf0e4e0-6b87-5de3-22ff-b1f6b4cde0b4@collabora.com>
Date:   Tue, 5 Apr 2022 15:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rtc: mt6397: Fix potential NULL dereference in
 mtk_rtc_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404132553.28064-1-linmq006@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220404132553.28064-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/04/22 15:25, Miaoqian Lin ha scritto:
> platform_get_resource() may return NULL, add proper check to
> avoid potential NULL dereferencing.
> 
> Fixes: fc2979118f3f ("rtc: mediatek: Add MT6397 RTC driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


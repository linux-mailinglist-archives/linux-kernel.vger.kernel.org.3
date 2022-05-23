Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7F53141C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiEWQFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiEWQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:05:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D76427D4;
        Mon, 23 May 2022 09:05:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F26181F421DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653321937;
        bh=pq7khLHWi/yVaniPHLobCPtQ0hFap6Dt/6ZtOvKKXjQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IagPd4MIZk3813/QMTC2CR9tyjBOBR7zUEEg2EmdwoFASN3/2QbQGk7QfbMqJcB/w
         Awucbs11+Vn/YOVnt9lVyV5aHf/EUvsE79CgmwUF4y3VqWbm9xIfJKImlCMmRAmLU7
         o271Lfn+CTFyqOdE4X7nI9AKxk0VE8yIbObs0f+DZTtwRZE7ALEx+dqVmb/se4Yvil
         mu+2pAInNmUFU1wPODKj+sdpwQI6+Nt+W7oTwBjKy/UtM5lG+PzGOSMFRp1d7HK3QJ
         Euh+ATlGBYoA7efQYJGpsj3iFHKUbK8ZrUTLmr+Bu/t0l9H9Ov4F/Tq2zK5hhrq08q
         vSdTC+8ovfpLg==
Message-ID: <9bb62269-986b-180e-ce5f-ac8cf7d667ff@collabora.com>
Date:   Mon, 23 May 2022 18:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/8] clk: mediatek export mtk_clk_simple_probe and
 mtk_clk_simple_remove
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220523160053.1922-1-miles.chen@mediatek.com>
 <20220523160053.1922-2-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523160053.1922-2-miles.chen@mediatek.com>
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

Il 23/05/22 18:00, Miles Chen ha scritto:
> Export mtk_clk_simple_probe and mtk_clk_simple_remove because we need
> them for MediaTek tristate clk drivers.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Hello Miles,

the changes in this patch are exactly the same as what I've pushed in my
MT6795 clocks series, so you should simply advertise a dependency on my
patch [6/7] for this series.

https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

Regards,
Angelo

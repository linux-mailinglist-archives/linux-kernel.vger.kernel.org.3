Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7095070ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiDSOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiDSOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:48:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7907824963;
        Tue, 19 Apr 2022 07:46:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F0FCF1F418EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650379558;
        bh=FVuKTUec4tBCzLgLqf1gROYOLTVYEwjYfzcNXIVZxLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dg7kzEFRHsPSTzBwTQUmD6Owo+bMJHYmWIxU6FFgzIoaYG+NLZ1deDBXubLqBI4kh
         Nq9OlalmpgHIk01fCbDn6Ode2D13fDxy3w9rdbRl78lf0yvXRVpwSqZb9W5yeiH7Vr
         TDKLMiPCWb0ZgWNs1kzaUv40MZbacg/a6VA9lO+wgm+cHOcg8P2DspuZ/MmLogKDrL
         RbiwMJkmfn9GdZ6Yn8KzbbXUo23ABKHi7EBfmAgil2+/cPlsJzSXmYk+UU5MV32Zjw
         PmxR0Bgp3KLlGD3V7qXwGngXqqFMop+r4cpQU7d5EtH3/qZNacGr1hmBjnSYnnT3B3
         qjCNxSo3pfLlA==
Message-ID: <3b622166-6d03-0e8c-8812-47e9fae6e374@collabora.com>
Date:   Tue, 19 Apr 2022 16:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/7] clk: mediatek: Make mtk_clk_register_composite()
 static
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220419081246.2546159-1-wenst@chromium.org>
 <20220419081246.2546159-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220419081246.2546159-2-wenst@chromium.org>
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

Il 19/04/22 10:12, Chen-Yu Tsai ha scritto:
> mtk_clk_register_composite() is not used anywhere outside of the file it
> is defined.
> 
> Make it static.
> 
> Fixes: 9741b1a68035 ("clk: mediatek: Add initial common clock support for Mediatek SoCs.")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Hello Chen-Yu,
I think that you should send this patch separately from the rest, as this is
just a simple cleanup that is totally unrelated to the more important conversion
that you're doing in this series.

By the way, for this one, feel free to take my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

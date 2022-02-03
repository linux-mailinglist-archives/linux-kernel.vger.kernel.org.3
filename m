Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC214A81DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbiBCJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42664 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbiBCJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 91C401F45310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881845;
        bh=0YKA29I9dGqT+kRMVnEfwXAWDziKXePsM7uLyg8Eon8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ljfT+rGj4GAiBsF3Wbt0FcbftjA6VPN2TMas89EuJnfyt5wYsNp3AwT7iz+4RioAC
         8mTmAcv9hLOhr/LFsDH6v7iaeyfG4IXqzCCnE0m1UaHentF2inNX4WSYzzhKOc06ZO
         QmC5saGyFgNEQuNmoodrPYn76XKh0mbfzSPKbmXyCMchMeZbWm24te5Qizu7ejyDzl
         Bk2BAYdxGfRo6owJAUYm3zMxTZObWKYWL+o5NNIILyRSP60AARUaiWhcmrG1FYh2Yo
         KfNSVtPxuit25LS0jTU5lrz9grnwxHIMlzS8UzvjYMjV/hN0tglUIxQJSyr6bNXGaf
         Mrd//1Ps3fcjA==
Message-ID: <b8f6ca21-f516-5e13-2758-03bf9ddebe49@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 10/31] clk: mediatek: mux: Internalize struct
 mtk_clk_mux
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-11-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-11-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> struct mtk_clk_mux is an implementation detail of the mux clk type,
> and is not used outside of the implementation.
> 
> Internalize the definition to minimize leakage of details and shrink
> the header file.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


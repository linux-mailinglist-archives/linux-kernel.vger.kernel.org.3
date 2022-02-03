Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E624A81EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349937AbiBCJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349924AbiBCJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077DC06173D;
        Thu,  3 Feb 2022 01:50:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 142EE1F45310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881852;
        bh=ZaSyARU2vZM/NZDFHPoOvB2PBVGfIhlAJTWJWOdtiTs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BUhLagX9u84O1uNCmmmWJ/EwOGKXwHVlczhgqRZwuva3eC0aIvH7qx1jn6VEL8ift
         0xXKdIDcPHomvrkNKcYnmW4xwwT3YqVvmnABi+1cXwn55CGvdTdH1Y+juDnmvA7rYH
         goPDq72F3dbErvXft7MHZYN3oRiNbKsZ/rZRo9wQNdSEPt+KGes03wGXm4/tGtAcTz
         NTYrEr/vyV7dmVS/RXFKkd0guI5wim+KzR8BCz5x4aMZK8MY1w+UXOCsuW4gELSA6Q
         NieA1Jsdq1rlrzZgXUpx4eDbjovGH3K7QMSRv6HPxmO4G4o89YNDtvdIoFCbLml+4T
         tU0uE73wvzPjg==
Message-ID: <0e9654d0-489b-90d8-bd1a-429aa9971533@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 06/31] clk: mediatek: cpumux: Implement unregister API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-7-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The cpumux clk type within the MediaTek clk driver library only has
> a register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the cpumux type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


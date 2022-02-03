Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244EA4A81EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349985AbiBCJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349900AbiBCJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:51:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E2FC061714;
        Thu,  3 Feb 2022 01:51:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ED5681F45311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881867;
        bh=Ng6BX49JV9c3BZn7jU/h+TPKiJrrjsEs4Yh+faXunQM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Thobw6v5uR2WlURFKu10eIE4gZB50/TDNdX7/SKRq5t2XylM8CyxZOHe/v/k0Ujl5
         +Lk8RKt6/1mPkwuDeFLYTke3+thRvr0GrBYfgVfVrcY2uA1oenvO013dNnCmXiIEA5
         4Cmg6BzWOqWk/o1fUNEiX7zxqigmx1nbLyenylf0IQJMPYCQIbw3ZNUPf6QH9OvySx
         Wn05c4SqHEpPoNhbN+PUX6Gs2Fip3Hvc5dKeaV60rBrC/eYkQOQy9zKylqqJXI7gM6
         tFH2PI7lA2zxL/jGc7t0BSAn8AkBFGLMefsxdJGd/Vne9JJfio1TUx3W75OR+O2Ezw
         aAhIK/8Pqrz1Q==
Message-ID: <8e4163ae-368c-592d-e1c7-83e0649a6140@collabora.com>
Date:   Thu, 3 Feb 2022 10:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 03/31] clk: mediatek: gate: Internalize clk
 implementation
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> struct mtk_clk_gate and mtk_clk_register_gate() are not used outside of
> the gate clk library. Only the API that handles a list of clks is used
> by the individual platform clk drivers.
> 
> Internalize the parts that aren't used outside of the implementation.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

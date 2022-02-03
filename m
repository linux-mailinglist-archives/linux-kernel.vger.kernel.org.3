Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89254A81B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbiBCJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiBCJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3FC06173B;
        Thu,  3 Feb 2022 01:47:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CADE31F45303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881640;
        bh=m9MLBN9ORSXZfgMj3WYcXMzwHzNPjhfv/4IsqIC0ZKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TU8k5MweW/rmmZ4AJ/RMc/xNtSSVnI149PAhIv8E7YoKVgTbdoKBOp0rZK2nHAHJh
         FL2XXwdcr2sWEs2wrEHlx8RQZ6el4oup13GC0k0v60CpZoOI6/3IspPbsRFEr3u0bG
         Chgs5miwBnMOBHo8Mok4PlwIyuhEEL8DrPa8LhKE11N0Vo2tsc3H95fUZFoaW4BXzP
         ZxB9zcGDLsWahz8fh4qttFfkOwaufzT6YE2WsRWLxJOkfXDrKnoZsqVLzdPRRWpMBc
         vZmb7EUtKIGi/cadxMyySIwRw4+aX7xewg7JJMMD/WXYWJZLk/t7E6folq/0HMNakR
         VR+hm6xVsMNDg==
Message-ID: <752d5d00-4e05-1bd6-564f-3bce21a35713@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 15/31] clk: mediatek: Implement
 mtk_clk_unregister_fixed_clks() API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-16-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-16-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> mtk_clk_register_fixed_clks(), as the name suggests, is used to register
> a given list of fixed rate clks. However it is lacking a counterpart
> unregister API.
> 
> Implement said unregister API so that the various clock platform drivers
> can utilize it to do proper unregistration, cleanup and removal.
> 
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Hello Chen-Yu,

I like this entire series, but I had to manually apply this patch (and some of
the other ones)...

Especially for the ones that will be touching MT8195 clock drivers, can you
please rebase over series [1] by Chun-Jie?

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=603955

Thanks,
Angelo


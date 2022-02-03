Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D74A81D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349854AbiBCJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiBCJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19411C06173B;
        Thu,  3 Feb 2022 01:50:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BAAAE1F4530E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881808;
        bh=u0ccJYHRiiNGbW0hqtPBw67zxGgUU7hHj9QdESZAnfY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SMpC0uaEhR6koKK8uY+kUeigZJS4oYt8bc538kZMyH/WrnVf0GMDf9lamhp2Mry/j
         vjtHhWepKhbu02Sncrww8JOdyWru3u2BZ93OL6aaI2jZcZ1UA6tz0xdHGciSigvOox
         JSqO5IhDuZepGwJqRHWK+U6NHpJsba2c5XrvXC6XScpljWT6MqmMA4+j7WAFFodTqV
         ihNr68Ts55q3s1XoIazUwQBQpzHGkWthjOzuQ5wA13vG2Kt+/P0Uk/E1nAjLPg/LgW
         zM2ta4IUK9x44J44WYEuFAX/+6fVPDbdbZuaOPpC/WC0FNahpc4kJroU+Q/Eqk+HZq
         Dg7MBexEivt/Q==
Message-ID: <f0a9db7a-9482-eef0-c533-f2abecd15ccf@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 16/31] clk: mediatek: Implement
 mtk_clk_unregister_factors() API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-17-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-17-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> mtk_clk_register_factors(), as the name suggests, is used to register
> a given list of fixed factor clks. However it is lacking a counterpart
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


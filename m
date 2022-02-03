Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA024A81BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349827AbiBCJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349838AbiBCJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB07C061714;
        Thu,  3 Feb 2022 01:47:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 889F61F45306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881660;
        bh=CtAf9R3ZOxXpWPZVvlH0tdvzu9XAVmDW7deoe+JbFZA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WGq0vuGeF+K8D6du8XrezwA1WX0pM7sxQb7zGwx0de4tXaBxZKx1j6Bn/rnnwMz+k
         HM0RZQ5me6cou30bw9fuoY/zEp7ME0LaCcR5vzT4XuxD5Kdv73eO2ZCCIasQUK81IJ
         mM4s485v0iSwbLEvK7E6LcJpPLau+Q563AD4u4+1K/x+QIla8Xo7n6QJzIc8rSsJ7n
         gZiZaNEQDgkmd2qBrC3n8yqa4L3+fbJrPQN9+Y1mnr6+BxTSL4dFAiOVKVwZk7A2Co
         TvYW5IWs5fRhS3kKBeEKfmf2b7iA+WSV9M5SF8YVVLmYHtauCjDtyzQfCMqYoGIyiS
         a+Wwig6zsc4iA==
Message-ID: <6d1c3b80-fd00-877e-ecc8-7ac449798145@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 24/31] clk: mediatek: mux: Implement error handling in
 register API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-25-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-25-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The mux clk type registration function does not stop or return errors
> if any clk failed to be registered, nor does it implement an error
> handling path. This may result in a partially working device if any
> step failed.
> 
> Make the register function return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


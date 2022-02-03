Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE344A81CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349848AbiBCJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:49:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42528 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiBCJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:49:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C764A1F45307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881766;
        bh=uXlE7ZgmZCPiQSZDSfYjZ//saRDp/ZdLtxVuwjRJSJA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CtFlxPYcpoKjtHove7Yb+rDAGLttgOlB6mjh3TmkVVSroXN/40MSFrlD41LL3XCWC
         F3FDebKHc7tXHGnaH6pQefXWGAJBrojavanmRs/hG7Q5Ybs8On/1rFxzIpe+ZXhpS4
         f9A3avD8j9+Ubqo3K3jVb0g4fGCmlhL+06lwbwnAqRfA0ws7v/C6h1b1/X0PADntiz
         d5D5hXl2KvU9mEQ6A0VDI73rQ9ezh0HeMmW03dZhYeM1my9BnJ7PzD8G/zli1DlFVa
         X8uEdnLr1CO13TkbWmY8e47o14A6S2RWP89TvIc6n6jtkLrM2oCYiHulm+pBjMxB83
         eflLXzIerSXdw==
Message-ID: <9b9a639b-aba2-74d3-62af-70812ced735c@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 21/31] clk: mediatek: cpumux: Implement error handling
 in register API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-22-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-22-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The cpumux clk type registration function does not stop or return errors
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


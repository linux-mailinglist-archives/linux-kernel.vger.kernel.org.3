Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5024A81BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349821AbiBCJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42452 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBCJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DA3221F45305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881657;
        bh=JwV0A7bKfw2t49I+q52URU9G7qRHadOUm5Qr7PbD0Gk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d1UzUIZvHUO59Gd/9Jqnj9c4N0bc3XXx/fnTcvlluuX743InESwIVwHI0WkfJcJLq
         rwxiksuHSDqcn79L6PuxK7t3GmbqMl+vuNID+A3MF/Hd55hlQp95sn+eoPRCXs1RkP
         EsaHTnlE0AaJkl9H0TrvZVTU4yFdEX+JgQwBSHgisBTaqXOVJLmoKRr6jc1f4WKvCh
         K+RXKJNspFSx0uhbPxbo4xj7Z4tNgLWNdC6YBaoPhUHjDd4T4r2Pt4so+G21rX5LgL
         p9QbTj9q/BxWBDHKSRig7k1KVXcf1DTbrhdElGGLMzr6ke1hM+uAEcth4xwfJcRfMo
         mrB5VuJzapRDA==
Message-ID: <ae5874a7-aa2f-e738-1d2d-884011d824b2@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 25/31] clk: mediatek: pll: Implement error handling in
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
 <20220202134834.690675-26-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-26-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The pll clk type registration function does not stop or return errors
> if any clk failed to be registered, nor does it implement an error
> handling path. This may result in a partially working device if any
> step failed.
> 
> Make the register function return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, and unmap the I/O space, is done in the new
> error path.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


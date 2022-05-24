Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8BC532690
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiEXJh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiEXJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:37:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEDE64703;
        Tue, 24 May 2022 02:37:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B48671F42BE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653385069;
        bh=qHa34R8f2dgn0S0aTujwYgvn8k0a6Ednt5C8zaOJtHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rbi97nHhxIbIYR01ryXjkpEsOOYmYxRBjOpv8gBgFlqcAJNu0iYeUXjUlBgvOSBDz
         JMUDqtYfaufxibthmP3yLbdrJzcVBz42ptkJQlmcHoAKRmT36SKicme1prIYCDawEw
         +QUBsNagovSXHlgBBScMriv3mnO1BNY7Dpll16KhY6L4L+knJtiNfgQ7MxkyGLKYhZ
         5aazG1w7cSwCbc5MQg/FCrM2LorBLSe5BSW4z7ifVn3nxJh0wXzTyuLsU0FUwO9In7
         qm6zVx/6yuc5vbhDtOatD2QmT36VRa3JXjYXVTNimA6oRtFjpIE7A1QxoHr3gDjyjP
         lubz0MjIud3Og==
Message-ID: <911c729a-b9dc-056a-7c83-718ddb52db95@collabora.com>
Date:   Tue, 24 May 2022 11:37:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 7/7] clk: mediatek: mt8192: add mtk_clk_simple_remove
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220524083843.9994-1-miles.chen@mediatek.com>
 <20220524083843.9994-8-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220524083843.9994-8-miles.chen@mediatek.com>
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

Il 24/05/22 10:38, Miles Chen ha scritto:
> mt8192 is already using mtk_clk_simple_probe,
> but not mtk_clk_simple_remove.
> 
> Let's add mtk_clk_simple_remove for mt8192.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

[For test on MT8192 Asurada Spherion]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


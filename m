Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858E24D7FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiCNKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbiCNKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:19:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603BDE30;
        Mon, 14 Mar 2022 03:18:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9BB481F43E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253108;
        bh=Xhm3zTCf6fMF/1xTFWS49KczB8qcaMTMqtJUqaWvAOQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HebpY9GHsh4/EF1tb4cHCYjdHjqFoVaMStCWf+GYjxlRAznKIX3amuZoiYtQxjE8M
         IIUk+s1KDRkDTFgsSTXfphKdFlww+OayPkTXu+Jf3EYt5xxqmqgguuIIvvuTOVcZVZ
         ln9nTOWYrtlF0uoLsEngQLKneKZsZQUE6nB4ez+0c6/gAsrYLdxLLcF9B2yaj47abM
         Qn150wl9SlffmS6MUiRrpGFpuTBJctTNO79R6IRtJtPfKlyg377hLtWqpE3kLermgu
         3YlGn4WBRNl4DkHPKZuUZmVqhXH219FD3YThf3h7kDgqzlJkB08my6jvOx9f7vHvdV
         Hx/+EuJRSsfLQ==
Message-ID: <5f79e76b-1333-159c-2dc7-0f7e8927e4df@collabora.com>
Date:   Mon, 14 Mar 2022 11:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 03/19] ASoC: mediatek: mt8186: support audsys clock control
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-4-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-4-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 audio cg control. Audio clock gates are registered to
> CCF for reference count and clock parent management.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8186/mt8186-audsys-clk.c | 150 ++++++++++++++++++
>   sound/soc/mediatek/mt8186/mt8186-audsys-clk.h |  15 ++
>   .../soc/mediatek/mt8186/mt8186-audsys-clkid.h |  45 ++++++
>   3 files changed, 210 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clkid.h
> 

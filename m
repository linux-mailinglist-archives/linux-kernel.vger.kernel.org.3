Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE134D7FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiCNKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiCNKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:30:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC603F309;
        Mon, 14 Mar 2022 03:29:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 81ACD1F4355A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253757;
        bh=tW8FyRuL6n5L/qwnAWR7Khp5bAbCAxndU7Bal/l1SLE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P/Z2aAIy4xDzgiDQgftx8TBfT4KE3jqICwKh8pxOQ/GeFYXHOm4DyZ4rg31wZqgFB
         TLuxHH11Zq/2+69x8VTtxZaGrvO05jWvfWUCoOwEuYCAGOmpilAssD7pRdsAIaxVWN
         ndrmlPff25/547PQtONC0Yf03kgGarcvppr1o7GQQlCiuhIBL4DH+vsyKL9HXo4TkA
         sTLrh9ezFervX49WkQ81b1QsxC07xFarfVG9FaFMiS/VdTxzRBjg3u0Kc+z3n8nRXI
         MbkLCdaLU+nVtkcjFUf/kMiDFwAlg/9aM5AjxMdCzUaGG/4a7bMH2oedGbXZ0KE9KS
         6ROAMt0TqRscw==
Message-ID: <b5910ef5-6203-5823-3ce7-682f0324d8bd@collabora.com>
Date:   Mon, 14 Mar 2022 11:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 08/19] ASoC: mediatek: mt8186: support pcm in platform driver
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
 <20220313151023.21229-9-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-9-jiaxin.yu@mediatek.com>
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
> Add mt8186 pcm dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-pcm.c | 423 +++++++++++++++++++++
>   1 file changed, 423 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
> 

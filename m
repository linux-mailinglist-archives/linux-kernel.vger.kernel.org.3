Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1E5376E6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiE3IhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiE3Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:36:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945963DF;
        Mon, 30 May 2022 01:36:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1421C1F426C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653899814;
        bh=QXMptDFhVLDAZ07/57pWnVM0NdwQo1qtAyHj2BDt4F8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n0xiApnA0e8UvIxSWTqERaumNNNm8/b06GVD7/p9fWcUcapEn+C63xTjDfz8KAnnG
         LhNUq94LFyG1Rdr2NKCc4I8nh4Sg2V9I4RFWDkcRx0AGvFHzSg5IJgOgtr2WP8wc2G
         sE1JP6y2pP9vzshKi48iKYWcwJ8ubqyUe+pdIzPatXHI9qH1pSdk6GYu5pnkwzmuXQ
         /RLJPZbsiSDjdvAB1FMiA8mwchMaK5uKf2rIM7LlOdSriZP/CI3qDXVEsobQAxGmX8
         0sw9ZETCj736BXuidmBCvjFMiT123esoVNO7yOoMEGSvbnm3D945Gkq6FVHbHwkjuq
         stq1W0osDjqCA==
Message-ID: <3e977bb3-7d4d-8d11-8779-62ae72d2c117@collabora.com>
Date:   Mon, 30 May 2022 10:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: mt8192: Use generic bias
 instead of pull-*-adv
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220525155714.1837360-1-nfraprado@collabora.com>
 <20220525155714.1837360-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220525155714.1837360-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/22 17:57, Nícolas F. R. A. Prado ha scritto:
> Commit cafe19db7751 ("pinctrl: mediatek: Backward compatible to previous
> Mediatek's bias-pull usage") allowed the bias-pull-up and bias-pull-down
> properties to be used for setting PUPD/R1/R0 type bias on mtk-paris
> based SoC's, which was previously only supported by the custom
> mediatek,pull-up-adv and mediatek,pull-down-adv properties.
> 
> Since the bias-pull-{up,down} properties already have defines associated
> thus being more descriptive and is more universal on MediaTek platforms,
> and given that there are no mediatek,pull-{up,down}-adv users on mt8192
> yet, remove the custom adv properties in favor of the generic ones.
> 
> Note that only mediatek,pull-up-adv was merged in the binding, but not
> its down counterpart.
> 
> Fixes: edbacb36ea50 ("dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogiocchino.delregno@collabora.com>


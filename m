Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199957FDA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiGYKgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiGYKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:35:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D61835A;
        Mon, 25 Jul 2022 03:35:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0FB56601AA6;
        Mon, 25 Jul 2022 11:35:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658745354;
        bh=uJhjhv9FEf4L8eIR0Uo4rGRFYDm94By0OZtCQ7aMwS0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IZXFrqEAmkP6tSa8ke4aIOQTmJcLqTi85C4KCMTtR2p6A74so/XsYXJ0OrX5inCC9
         2SsTT7PLbgMmqI6Q8SVaFtJWUgqcy3tJKiCwZK1LI0oJw4gTGJ67puWWNi9Orhrq0A
         ymKJwZZ+HKzUInw0rU1iV9I8VX7dLLDXX/wHbkzPTNoXxhtE23mxakoRGC+9jl6PCK
         RaJIri0xaDmxW5+NgzhysPsRlBBz18kRlq2W/c9PrgABEekxFacLDdpOPyNcvzc8XZ
         f8ChmX4v58mFMNHqR3YxudPT/nj2F0o39Iehx/WlMrozY1D8LsvO65EjLMwfvAkB3a
         P7kwfbhSbOx9Q==
Message-ID: <b52caf77-7fdc-8496-3087-e4d392c93853@collabora.com>
Date:   Mon, 25 Jul 2022 12:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: mt8186: Add and use
 drive-strength-microamp
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220725100253.10687-1-allen-kh.cheng@mediatek.com>
 <20220725100253.10687-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725100253.10687-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/22 12:02, Allen-KH Cheng ha scritto:
> Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
> PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
> drive-strength-microamp instead of mediatek,drive-strength-adv.
> 
> Similarly to the mt8192 and mt8195, there's no user of property
> 'mediatek,drive-strength-adv', hence removing it is safe.
> 
> Fixes: 338e953f1bd1(dt-bindings: pinctrl: mt8186: add pinctrl file and binding document)
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

The fixes tag format is wrong... Please fix that:

Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding 
document")

(sorry about wrapped line if you see it, that's supposed to be one line!).

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8497E4E3C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiCVKch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiCVKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:32:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA15C354;
        Tue, 22 Mar 2022 03:31:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1033B1F43122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647945067;
        bh=wsuVdARlaeRl+D4+nBJjwWfODrGAZGldOBP9V39TNIU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mBWT5adqZ+p0KfBLO4NV3PK/6NkAUyxZl0PG1AM3d8aV5YDxPBm0AttaQlJudAKdK
         7FLb80e0w/hPFeD1ojdxJgvjZ5TMty8ta37TMXcKN4/SX/9n0WiYFFbnYcMHsduZG+
         O/oMiKpGZ0LQ59JRlWkEYSfaJG2pYNoocVuiMOm7MCAO7btxRFYRByilCYyQNjFnqz
         x3YCHm2NT8lzB1u0SLXzhYUply3LN4rQ/wxpHBplW4sfRp7ROYL33DOLFBT8LQh9/a
         aC8+ZnpiBnG4Vv4+46i8NmcFrCyFDF3ZA2mov9GVFeuhqnBkYLFVE5dCWTa8wk6pUq
         tufK8+7JiN97w==
Message-ID: <555f4a78-dd7a-59f3-e1db-f040c97c61b4@collabora.com>
Date:   Tue, 22 Mar 2022 11:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v11 0/3] Add basic SoC support for mediatek mt8195
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220216113131.13145-1-tinghan.shen@mediatek.com>
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

Il 16/02/22 12:31, Tinghan Shen ha scritto:
> This series adds basic SoC support for Mediatek's SoC MT8195.
> ---
> Changes in v11:
>    - rebase on 5.17-rc4

..snip...

Hello Matthias,

this series introducing very basic support for this new SoC is definitely
ready to be merged and well tested.

Can you please pick it?

P.S.: Patch 2/3 (pinctrl binding) was already picked by Linux Walleij,
and it's already upstream.

Thank you,
Angelo

> 
> Tinghan Shen (3):
>    dt-bindings: arm: mediatek: Add mt8195 pericfg compatible
>    dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property
>    arm64: dts: Add mediatek SoC mt8195 and evaluation board
> 
>   .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
>   .../bindings/pinctrl/pinctrl-mt8195.yaml      |   35 +
>   arch/arm64/boot/dts/mediatek/Makefile         |    1 +
>   arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  161 +++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1049 +++++++++++++++++
>   5 files changed, 1247 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> 



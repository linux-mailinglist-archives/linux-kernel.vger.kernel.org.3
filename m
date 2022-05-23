Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66C530DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiEWK2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiEWK2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:28:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647BE45528;
        Mon, 23 May 2022 03:28:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3656A1F42DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653301686;
        bh=6HOFmXMLuuQlR2jthI0qX4qDnJpUAY/sE6Yz7Hnf0l4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WlmWP4e76yMRW1BxHDLUlEvX+rVSvbWr/A4p7/SYEN3IfxnO1PoycBHDevi6Y1spP
         K9VJHb7MNaW/Vl+TEFb6SjDIGuTP3gL4cZk4qKCuZ/i4W7c44ek5QGMUIfBh94m832
         42oDY1dWeTETHAuXtnDv2PXRxcQ2Ku+8qonoL1Up0af+wWG7fSaLl3Drol4Ov0w1uB
         t6bQUdHbsQCVxJ/6v1HZfz7Igs4Xptu+7bbCECrFbRy4DXAOKIuDoeImuAACT8m5D8
         o20nG/x/FCuNdXSkByGDYMWbz35nHVj2rfN+vl5NYfRnPBDyMJDfgZLPvsObEiJr2o
         TaH27MV3WREUA==
Message-ID: <5067ec46-7a82-6b7b-5b07-3102cfaefbf6@collabora.com>
Date:   Mon, 23 May 2022 12:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND v8 00/19] Cleanup MediaTek clk reset drivers and support
 SoCs
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, nfraprado@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 11:33, Rex-BC Chen ha scritto:
> In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
> folder. MediaTek clock reset driver is used to provide reset control
> of modules controlled in clk, like infra_ao.

Thanks for this very fast resend for the T-b tag fixes (and don't worry,
it happens).

Btw, in my opinion, this series is good to go.

Cheers,
Angelo

> 
> Changes for v8 resend:
> 1. Remove tested-by tag from Nícolas for MT8195/MT8186 patches.
> 2. Add reviewed-by tag from AngeloGioacchino.
> 
> Changes for v8:
> 1. Use 'enum mtk_reset_version' to replace u8 in patch 5 and 6.
> 2. Use lowercase '0xc' in patch 7.
> 3. Drop "simple-mfd" in patch 16 because it's for original reset controller.
> 4. v8 is based on linux-next next-20220520 and Chen-Yu's series[1].
> 
> Changes for v7:
> 1. v7 is based on linux-next next-20220519 and Chen-Yu's series[1].
> 2. Add support for MT8186.
> 
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=643003
> 
> Changes for v6:
> 1. Add a new patch to support inuput argument index mode.
> 2. Revise definition in reset.h to index.
> 
> Rex-BC Chen (19):
>    clk: mediatek: reset: Add reset.h
>    clk: mediatek: reset: Fix written reset bit offset
>    clk: mediatek: reset: Refine and reorder functions in reset.c
>    clk: mediatek: reset: Extract common drivers to update function
>    clk: mediatek: reset: Merge and revise reset register function
>    clk: mediatek: reset: Revise structure to control reset register
>    clk: mediatek: reset: Support nonsequence base offsets of reset
>      registers
>    clk: mediatek: reset: Support inuput argument index mode
>    clk: mediatek: reset: Change return type for clock reset register
>      function
>    clk: mediatek: reset: Add new register reset function with device
>    clk: mediatek: reset: Add reset support for simple probe
>    dt-bindings: arm: mediatek: Add #reset-cells property for
>      MT8192/MT8195
>    dt-bindings: reset: mediatek: Add infra_ao reset index for
>      MT8192/MT8195
>    clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
>    arm64: dts: mediatek: Add infra #reset-cells property for MT8192
>    arm64: dts: mediatek: Add infra #reset-cells property for MT8195
>    dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
>    dt-bindings: arm: mediatek: Add #reset-cells property for MT8186
>    clk: mediatek: reset: Add infra_ao reset support for MT8186
> 
>   .../mediatek/mediatek,mt8186-sys-clock.yaml   |   3 +
>   .../mediatek/mediatek,mt8192-sys-clock.yaml   |   3 +
>   .../mediatek/mediatek,mt8195-sys-clock.yaml   |   3 +
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   1 +
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  15 +-
>   drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
>   drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
>   drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
>   drivers/clk/mediatek/clk-mt2701.c             |  22 +-
>   drivers/clk/mediatek/clk-mt2712.c             |  22 +-
>   drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
>   drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
>   drivers/clk/mediatek/clk-mt7622.c             |  22 +-
>   drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
>   drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
>   drivers/clk/mediatek/clk-mt8135.c             |  22 +-
>   drivers/clk/mediatek/clk-mt8173.c             |  22 +-
>   drivers/clk/mediatek/clk-mt8183.c             |  18 +-
>   drivers/clk/mediatek/clk-mt8186-infra_ao.c    |  23 ++
>   drivers/clk/mediatek/clk-mt8192.c             |  29 +++
>   drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  24 +++
>   drivers/clk/mediatek/clk-mtk.c                |   7 +
>   drivers/clk/mediatek/clk-mtk.h                |   9 +-
>   drivers/clk/mediatek/reset.c                  | 198 +++++++++++++-----
>   drivers/clk/mediatek/reset.h                  |  82 ++++++++
>   include/dt-bindings/reset/mt8186-resets.h     |   5 +
>   include/dt-bindings/reset/mt8192-resets.h     |   8 +
>   include/dt-bindings/reset/mt8195-resets.h     |   6 +
>   28 files changed, 523 insertions(+), 95 deletions(-)
>   create mode 100644 drivers/clk/mediatek/reset.h
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902AC575F90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiGOK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGOK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:57:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D285D6F;
        Fri, 15 Jul 2022 03:57:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7448B6601A59;
        Fri, 15 Jul 2022 11:57:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657882634;
        bh=Cm36lUlMtdM68Ok/fjKgE+JF5RB7+n5un2L24yN4VrY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HkoOcJP8PaQorVWoQjSGsfd338Dn037tTgUCpgPzHMbhICd6o3MvSZsRtuJ/FOMHS
         /xf6DFBBKgacdeCFUiLYFi6UkQz3V8NC8ctB0Hp6rK5qd1F8EAKhBDgk8V3gmks0tU
         L5O4LLJ2Bl+n/biCY5dioE1/Lz0cumVNfRDw7CDH8anONVq7iiI6IYUL2cA+BHwjik
         ZeQKXfoW1Hfoz5J65iU0dhHnHKHVLcoSttnnmTacf0OWso0QoWRMqfFiskfbB6JjFz
         DT7GjBc2G8mv9Y2D3LiYaV0A1TG2He4sE3ko7G8Z24P0n9SwXyWh8NK6enMEg//Xxb
         g91VYSlxxKafw==
Message-ID: <2f87c42a-d097-4acd-eed2-dc9f6aa564cc@collabora.com>
Date:   Fri, 15 Jul 2022 12:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] MediaTek Kompanio 1200 MT8195 - DisplayPort clocks
 fixes
Content-Language: en-US
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617111248.90505-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220617111248.90505-1-angelogioacchino.delregno@collabora.com>
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

Il 17/06/22 13:12, AngeloGioacchino Del Regno ha scritto:
> This series fixes the two DPINTF clocks to propagate rate change
> requests to their own parent (and also fixes vdo1_dpintf's parent name).
> 
> This is needed in order to stay clean in the DisplayPort driver and
> avoid adding (now useless) custom handling of clocks reparenting based
> on the wanted final clock rate.
> 
> Changes in v3:
>   - Fixed tags ordering.
> 
> AngeloGioacchino Del Regno (2):
>    clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's
>      parent
>    clk: mediatek: clk-mt8195-vdo1: Reparent and set rate on vdo1_dpintf's
>      parent
> 
>   drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
>   drivers/clk/mediatek/clk-mt8195-vdo1.c | 6 +++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 

Gentle ping for this patch.

Without this one, DisplayPort (both DP and eDP) won't work on MT8195.

Thanks,
Angelo

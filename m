Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6866F48D55D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiAMKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiAMKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:03:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4113C06173F;
        Thu, 13 Jan 2022 02:03:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 812D71F45859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642068189;
        bh=5ieh+AI9nLafp/BCA/vxAMNQqRDFiZ9V6lcGw3F7r9Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mtRZidLzCsunTl6BiP4P0m1w3+IEE5orE/aFNHE7C/ZjM9lf/d0o4l2aiGhKi1ORJ
         RFxhHSeNXnd2BisTbr9OnxwPKYoI5rQXmUN4VtGhaf/1phRyM2vCYgfrRjGxF3mN/I
         qMixpjZa6euybAK9yOJXEVy4cMHnGGwCxf8BzfcbzRbVVU7KXU5rVZ5IycYRjtcnXp
         7bKOh+e6Y0FVElSm06A8LApFyxO8MFZBKFmZMQOCFQx7FH+68dtbDrO89Exdver9fr
         V7s7M1RLDnWq1mmN+2DqAgUVO+uJ2KGlMPVyqbgTZoeXvOvHNA/KOP8Z/8PMzyomYL
         fyplk4HfWeovg==
Subject: Re: [PATCH v4 5/5] arm64: dts: mediatek: Correct system timer clock
 of MT8192
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220113065822.11809-1-allen-kh.cheng@mediatek.com>
 <20220113065822.11809-6-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <963c8993-a63e-2282-66e3-415ac897bded@collabora.com>
Date:   Thu, 13 Jan 2022 11:03:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113065822.11809-6-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/22 07:58, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> When the initial devicetree for mt8192 was added in 48489980e27e ("arm64:
> dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"), the
> clock driver for mt8192 was not yet upstream, so the clock property nodes
> were set to the clk26m clock as a placeholder.
> 
> Given that the clock driver has since been added through 710573dee31b ("clk:
> mediatek: Add MT8192 basic clocks support"), as well as its dt-bindings
> through f35f1a23e0e1 ("clk: mediatek: Add dt-bindings of MT8192 clocks") and
> devicetree nodes through 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192
> clock controllers"), fix the systimer clock property to point to the actual
> clock.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A184A81B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbiBCJre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiBCJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7795C061714;
        Thu,  3 Feb 2022 01:47:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 50FA41F45305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881652;
        bh=WU4eeRXiAs8mjWnJEvdQ0ANmvSO20F6MjLLjrC9HNT4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lyc8+SPSya/hclAoLe1Xrzec84Owqqht/YNf/eWDfmXpkp5CVdBwo0uifi325zuDL
         q2zLcHnUZrafd3YlJoGqJCo6eeGKgssaEfy+qj6awD8DzNxo80TPdKqNbrBHDq4t7r
         KD3l4H5CAcavag8SEns6GU6/jEztquSCvUR4Ax14IXNnPIqTbPwBned8ro07oMeyYB
         vJ75+r/DqWefvyl8zKwH4yGkRIGvXVq0Xn8mpuitBSFIJGo0YBPm3QooCDxeGu420S
         e2KgSdHcAfcRd7sVf562mzPJN2daSA2q9kfrvP5ev0fVnsx5/zG+fgaTSwPiJxYgoO
         aNYCooc5ujodA==
Message-ID: <34a65278-7842-823a-8ea4-f64da62adb6a@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 31/31] clk: mediatek: Warn if clk IDs are duplicated
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-32-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-32-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The Mediatek clk driver library handles duplicate clock IDs in two
> different ways: either ignoring the duplicate entry, or overwriting
> the old clk. Either way may cause unexpected behavior, and the latter
> also causes an orphan clk that cannot be cleaned up.
> 
> Align the behavior so that later duplicate entries are ignored, and
> a warning printed. The warning will also aid in making the issue
> noticeable.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


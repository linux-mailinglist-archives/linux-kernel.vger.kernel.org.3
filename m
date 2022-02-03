Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728B24A81EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349964AbiBCJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbiBCJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E21C061714;
        Thu,  3 Feb 2022 01:50:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3B78B1F45312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881851;
        bh=UslgxD+QUohWXG2QM5oeqgf7yzlI6Zmso8kNly/Sz/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mraiHQjxioYAQh7GhNkuMx01FlcRjUM5f3UhMbDIKfm2YSjRAgarnPNhJBlw8obXi
         Jl/fu2mFPYGzi8KAQIC9eEcUKPLEEq2I3y+tWLN7i8O9GGUTLmA5oauDbfFZaOHxPH
         o3NE69eAqrbrm1YYT9Qcj1LWiGwj2zttX205tRN8P0ymPHjXHVNpwkG/HW//L2vIeU
         oZwcAH+4OE/EQbUAfBbSq9Xw2pva0M3u5JLMYCsMmkG8DJrJ4Lgewlx5YX+9EYftms
         lM7mDBhdNKcdgtcfYvB3+tYAiM/gT1mc3VjfRI81d4X/dUM4do4z9JOdfw2ZT61XAo
         haFC+qtr8LmVQ==
Message-ID: <4587cdf3-a906-38cf-cedc-82b6795fc14f@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 08/31] clk: mediatek: cpumux: Clean up included headers
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-9-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-9-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> Some headers with the declaration of functions and structures aren't
> directly included. Explicitly include them so that future changes to
> other headers would not result in an unexpected build break.
> 
> On the header side, add forward declarations for any data structures
> whose pointers are used in function signatures. No headers are
> required.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C698E4A81E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349891AbiBCJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349912AbiBCJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 67EF71F45311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881837;
        bh=mzOFXDAXAzLAhEhLjMCEupxX73tzuR4dAS6Der8FZvs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=buShtQpzXhsuTNYzJseURVnMRXIHBdpF7xQC3T/3BehhB4p8CJ5c7TQ/1LcychNtg
         +ou5gLa/21biMSRzfpJ1N0RlJdHvzMoRqGqY2/wvpc6w19zUoRMHdn/oAzTWMkFiUd
         h3DAsnrM7LKlF3JsxmDmXOVuhAI2PnNmlWROEJnYCnoiUUA9iypMUMmArVOe3artHC
         jggksN1XsxIUbU1kaAO9kSOcT7q9yseXtPZ9U72xHuBj7PNE8bB96DxGBBzO9w1WPQ
         w1fxdz6FoHNs1ILJ5c5wKn4xW3y7mkeMd0FU1xdZrdocaqwjZdSuQez2WQ0MRKW5IQ
         6M97ZjcU0ajjA==
Message-ID: <60067d0d-fc48-0af5-c182-d36388a89f45@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 12/31] clk: mediatek: pll: Split definitions into
 separate header file
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-13-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-13-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> When the PLL type clk was implemented in the MediaTek clk driver
> library, the data structure definitions and function declaration
> were put in the common header file.
> 
> Since it is its own type of clk, and not all platform clk drivers
> utilize it, having the definitions in the common header results
> in wasted cycles during compilation.
> 
> Split out the related definitions and declarations into its own
> header file, and include that only in the platform clk drivers that
> need it.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


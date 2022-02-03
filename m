Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E94A81EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349956AbiBCJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349923AbiBCJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:51:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DAC06173B;
        Thu,  3 Feb 2022 01:51:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B396A1F45310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881864;
        bh=JTkyG0VtgzUZdehkshEy/dIoTYtvqxNPnBCvRzk9B/k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HDCL75P7N/5OuXBAnaeW7nXLNA+2OxceD5nmX/0qsOZDX3sbiZ2hVufjWeUUOT+2d
         bNdDLda7DZb5FzFVSrUYawX4sc72U6uUpdaOLJjX7iWpxnUyQrCZuczGEcf6oM2cto
         A7WDo3Q6A+Hf6a8CfudDGPXIewUWBvVvEeAdtBco84L1uVbIHuz0bGLgiiG6/o98X6
         dRGDIP54lc07XgHlBa6jh1a8x/R9NksW2RXDos5bcjfFInIUtW+VOf/d4svx5CvxFD
         MlNW7XJdRxvQ90nWPE5kjxb28/eYXS36DOcd5wqtUXSHtca+eWzV8u3enCVYXvVjo1
         Y/XbsstPPkOFw==
Message-ID: <66fdf2c7-e723-beb4-e9a5-9b87998d6eeb@collabora.com>
Date:   Thu, 3 Feb 2022 10:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 04/31] clk: mediatek: gate: Implement unregister API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The gate clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the gate type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

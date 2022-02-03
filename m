Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9F4A81DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbiBCJux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42678 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349903AbiBCJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3549C1F45311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881849;
        bh=y/MhQQILS/yrG3t5+P96243Yz1T4mHZbgHuKFMh1hL8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b91ROQvE8KQUleX8xKpjxxJMWOBsMVW2I6yH0PFRv9VMoXr+QICO+ou8j7fb1yNlO
         BNJL0/8sd0SCbxaOndiuR86r+3jL8i57PuCfMHgpNtPapdJQqGnXbY5/cJ0Jqlz5a9
         vFPmWUIzPl/MNoOQNUFnVw4zqLtIefkmXAAbAlftdueEgEn8kdtvtHi2io6m6ZqZC2
         x6+ZBP+/KMC6ZwpR6g/rxVhsbypwJfQtOGWNOhakSGh5xY2pkr8XyiLDFlKJs9LbWR
         JYR1/g5XPWI+Pj3ereMJMd4iW2V9pw7vObCeIAFsmpp3lkWJK3vBn5ZfBO8yQwXl5M
         cw4rwFKby+E8g==
Message-ID: <c8d1a8b0-8c84-1d27-3f53-2bb16728021a@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 09/31] clk: mediatek: mux: Implement unregister API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-10-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-10-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The mux clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the mux type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


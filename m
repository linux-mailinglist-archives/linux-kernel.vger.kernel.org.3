Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600BE4A81D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiBCJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349902AbiBCJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4117C061714;
        Thu,  3 Feb 2022 01:50:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3D8C91F45310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881834;
        bh=bPye+b/gezqZUJB5Cavj0EZwZtjeapMlPkWvsqbKe+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GToAt42Gm99QQhYwS8QiOER5X25pVLyRPKbhEIINVmKzecffzi7Bouwp6FUJ0SrSj
         GaIKvohXqCbBXXm5/AQiA4QlSaENSyyR+7iMW0MpalPj55XIFi9zIjalot/JtmwEZN
         XcwPwbp0/h0jORcpSbVA/Q8Pe0WeCL2HBrw9rQ/KAMW0UtzUcBOjNOYYfRX+o+SWi2
         oaCBLetw2GZgRRHvZZFcB1Molm9rNDoDLuvI8A1Liba6DMMnd3gRTUinBgxUXoK1x7
         nFxCBvZa8n3Rr3tzmp1Jozhh2mTuX78D5djuCD+dyO3DfmzMF3jExhyqHCq6lk2Fs1
         qIQCGMeG15Znw==
Message-ID: <ef183484-142c-5f74-0483-95e5c9af7992@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 13/31] clk: mediatek: pll: Implement unregister API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-14-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-14-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The PLL clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the PLL type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


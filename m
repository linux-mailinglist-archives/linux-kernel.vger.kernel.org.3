Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DE4A81B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiBCJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiBCJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3DF101F45307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881655;
        bh=f4XDyewCMqOA7NpYOnT++25Q2hO+IFLmu3VrNw76j4E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RUYjadw20ftwwUwDWiD800D2aVD+eBRX6qm8I3ufUyl0t4C4xQl9l3PlNm1JQkrKU
         88KjjmRMvDWg7rBMHsqcyquM7Qawjzn2aNhOY3xMy26iNBTpdIVR83/S/7p7MY6RAk
         oi0upBch7AFc64XA6eadvNcUbZh458/n5eenfR0jjhXIRwwGnqXaEdGVbGrP/NPhY8
         AwxKF3UyOAyv26hjdcYqUpkO6t9EsgHLwWbr+p+v5RBsEzQPObaxHdcEWaMf1C0rB7
         ONthJZfMOBJf55OTTAUPEjUwupq+++fDatzBaq6SpBzLuWUWMFye8W9aFHepq0phJ9
         e3fcCM16ix5ag==
Message-ID: <737f3fdd-9349-ce8e-be14-41f1378e163b@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 26/31] clk: mediatek: mtk: Implement error handling in
 register APIs
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-27-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-27-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The remaining clk registration functions do not stop or return errors
> if any clk failed to be registered, nor do they implement error
> handling paths. This may result in a partially working device if any
> step fails.
> 
> Make the register functions return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
> 
> This also makes the |struct clk_data *| argument mandatory, as it is
> used to track the list of clks registered.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


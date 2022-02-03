Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF44A81DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiBCJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiBCJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C971C06173D;
        Thu,  3 Feb 2022 01:50:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B24511F4530C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881808;
        bh=1f8Tnb8qEXcDfjjPM9iKXR27s8APvpCQ3rN4h6SQTs4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MeS0RR5EmsyI4qsjP6h7Q1ZqdZRYY5iVRVYzEDyPFFxT4FnzBdf5SHMkNmzGWpt+L
         O9HUs/qtP3AFMm1aRlPdLdhlwgrfhzxhdVQVb24Awy0eAyj8b5cOWNYbE/wFLQ1VfL
         RbqM5IC7rsntt6yPNNTDpAFwiFmmoGN1worKtMnT6j4Y73Xw2uKPL0F4VXfrllE6+p
         nDYdcuL/x9z5pzIF8c6wOlc/8s7t4JIbQpYjH78PyAi1zK14kUd3eKhnwfmfUC/pLW
         mT2RIKkNzjuudPzIjIsdJPb5ZGJrFZYoltFZrOCDRurADWj8vpMcxzs8lc1IeIltDL
         HRzIqqET84wnA==
Message-ID: <a10a380c-25db-8203-1d52-f807fa517b7e@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 17/31] clk: mediatek: Implement
 mtk_clk_unregister_divider_clks() API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-18-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-18-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> mtk_clk_register_divider_clks(), as the name suggests, is used to register
> a given list of divider clks. However it is lacking a counterpart
> unregister API.
> 
> Implement said unregister API so that the various clock platform drivers
> can utilize it to do proper unregistration, cleanup and removal.
> 
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11DA4A81ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiBCJvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349938AbiBCJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA08C061741;
        Thu,  3 Feb 2022 01:50:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0464C1F45314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881853;
        bh=ipkRReMbtwAu7xVakE/HQLluSawAEt4oVRymv8x74FU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CmS4rRqAT167M1QT73NOFMcpgmpS9Kp/FtLNs/g+G/Wb7BvdYpB1s/j5qZPOoL4a5
         51OCVb74DUHNH4GTCeQY5XqGcrVZKCnsLZdG9NEmV8kN0N0JkhT7H8CNBTws9q5JWH
         IYbib783BsUjE2mZ4LwiEJVLCx4pFLmNmNRD+jFHqNWz7DAqvGtzW/KnOIqmW8VaNh
         ASNW/Ue6Jqn5nQ24u6Gyd7hNTWZ6OFDhflaXRmyPUuHtw2qpo81MShoTLfIEpd0+Qo
         4NNICSOFmsbBDVNQ+Jq2bBhKgsBMMGZKNQxmQfLLkBHmhQ1MMA1MdSQYu8/wXBrG2z
         hoH8ELUFZs5ww==
Message-ID: <0465047f-c4b9-d608-5c8e-c520d0ebcc6f@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 05/31] clk: mediatek: gate: Clean up included headers
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-6-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-6-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> Some included headers aren't actually used anywhere, while other headers
> with the declaration of functions and structures aren't directly
> included.
> 
> Get rid of the unused ones, and add the ones that should be included
> directly.
> 
> On the header side, replace headers that are included purely for data
> structure definitions with forward declarations. This decreases the
> amount of preprocessing and compilation effort required for each
> inclusion.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


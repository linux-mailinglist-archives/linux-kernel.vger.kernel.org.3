Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D434A81F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349968AbiBCJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42706 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiBCJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5A9441F45313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881851;
        bh=HgNfql0xDMRNN68LGiYkvxm0vW+TozB6ZDFhQ+Q/MmI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WBPnKS5GhtsUKhfJnBNLSJ2g0Rn1lA0Jq+OO9FA/tHV6Y7cVq4bBE8JEP+3yHXneX
         pRqznUvF5mhocQXKmxpT5luPZaW/7pDTOj8Hk2lm5rQIeJQxiZ/HH3eShgpxNsUldp
         RHeNKyU2WAMRt6+IDUVIIsHTjDoj7ZD8BJBeoIyMJVnI0wHFZy3TCbKGWkLmAaCHs6
         KrffmPmZYJyojT/NCmO/fICX8t/vQCkfGLg2JKMHH1brFuFUPqF7qL4J23V7X/Lt8f
         FCzbdfkehpxfpS+aUArL22gm+9rZ+gRpNDMWCLt9zUTFaWf+hKnOOO8lHwC/aPfZoK
         DucntcCYtDQGg==
Message-ID: <7fc5e936-29e2-2cbf-623e-e515de5c5e9d@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 07/31] clk: mediatek: cpumux: Internalize struct
 mtk_clk_cpumux
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-8-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> struct mtk_clk_cpumux is an implementation detail of the cpumux clk
> type, and is not used outside of the implementation.
> 
> Internalize the definition to minimize leakage of details and shrink
> the header file.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


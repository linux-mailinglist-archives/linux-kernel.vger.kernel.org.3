Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8E4A81B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbiBCJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349810AbiBCJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ABC8A1F45306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881654;
        bh=0eDqvPEflRo8g7k3cDJMFx8JuULFPhHFEmjsSyhm084=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BBHdCm7Q+XivOugEvd2+n8ApYZ1sJ/TyA2i6A2UqlsWvDeM7JDXpniybzWgddoEYF
         kLb9pQpAaXK5iM/cP6f5yjzlzqScmYk3ymayuWKHAWrnsMGO9KvfAZGrqtZ9rO/AzN
         bGyZXmcRH17SUM6d6dldRoLUhfh9ui08ygXvIwH46EOcngfMlMGZDuW6lWFcyyHzDG
         Do5407jRemG3N0ReXbigjyVLKy8JXXBzQ3Dp+vQkvO5KeKuZD1IqgholWW9FgkWyC5
         NezgXw9gtpinb559RAIjFWvfrqF5LnCXwu+UYT0iUEvQgKyWHCYiDuzaxlBmbkNfaZ
         NicALLfEKO1GQ==
Message-ID: <91d99498-be0c-41ea-8465-03cf5eecdf62@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 27/31] clk: mediatek: Unregister clks in
 mtk_clk_simple_probe() error path
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-28-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-28-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
> 
> Now that the library does have APIs to unregister clks, use them
> in the error path of mtk_clk_simple_probe() to do proper cleanup.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

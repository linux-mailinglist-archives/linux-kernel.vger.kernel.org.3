Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A262B4A8785
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351808AbiBCPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiBCPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:19:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DFC061714;
        Thu,  3 Feb 2022 07:19:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F3CBD1F45DD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901591;
        bh=Y4Zm4KPyB1FOH77ABF0K2197miav+doaaGPC3u1pF5U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OmtdcCSb+NWBtEoOk+BBKVDRqD/brB5MQcY6Ib4oYAh/mDhk65lWIWIqj/ieBuv0z
         Nx6xv/YSQ377h9yqbZKrmtxS/TcWdnbBIhVHiQ3uIWA6+U+FPDqpi5xPIIWriXiQpB
         rLeA+yJ7fnQy3RWRWquuEJlvY2j/APVvS6jkJ7TogXmv/MlyggaqVVG6D5pYPG8t8c
         Om+R0riRN7uxkLGqGpExk/hQrKcX19Dr9NrE3tTF4R1hEw96HR31W8XCSKDV6B91IM
         g9r8IjsFDwGdWKJSJS8BSnOJ4dCDNBP8nNgoGizccZKl1m6fTv/LggURd+eezK+GaR
         OEppq7mfwakdg==
Message-ID: <90d4713c-cfac-3c1a-7680-d6a5f7d6ec21@collabora.com>
Date:   Thu, 3 Feb 2022 16:19:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11,PATCH 13/19] interconnect: mediatek: add support for mt8195
Content-Language: en-US
To:     Dawei Chien <dawei.chien@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-14-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-14-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> add platform data of mt8195
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>

Reviewed-by: AngeloGioachino Del Regno <angelogioacchino.delregno@collabora.com>


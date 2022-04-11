Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6C4FB6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbiDKJJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344121AbiDKJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:09:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B452CCA3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:07:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E7FD11F4345E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649668054;
        bh=+Ie0DN6gHz0U0bleo45pyJxPZcXhCSbDfFBMIFKa1rQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N3NYyP4ztRH6tRcghLb6udo+lUXEmChUVRL6hoVaSpqGIjP2fe7QNKy8QcenXfgCc
         PpEX1a55kYNMQ1FW7838x9hZyqcpU1YuRa8m9tcOMDlrlXKX+PposdErthgLagmzUh
         QRYDWhutcSxxMwIcUtJKv59qWlR42j4Y9GRvxkVJwJYYUVINTCBb/dmFkpxQvmxlml
         KRtGp8Ri4H46AMqp/NSKuSfMP90FUhFE9FputYepCkwKKcNfqG4FV1asNo+qUcFTQ2
         yL6FMHKVEmCi7FW+2KrpRcKUU0hXn3tN28Hae1ywhfWWuxUyKcQR9ENBtV8raLUUVH
         0pFYaxkTo20sg==
Message-ID: <54c2b102-1506-cdda-51b6-39823d17134c@collabora.com>
Date:   Mon, 11 Apr 2022 11:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4, 1/4] drm/mediatek: Adjust the timing of mipi signal
 from LP00 to LP11
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, rex-bc.chen@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1649644308-8455-1-git-send-email-xinlei.lee@mediatek.com>
 <1649644308-8455-2-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1649644308-8455-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/04/22 04:31, xinlei.lee@mediatek.com ha scritto:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> Old sequence:
> 1. Pull the MIPI signal high
> 2. Delay & Dsi_reset
> 3. Set the dsi timing register
> 4. dsi clk & lanes leave ulp mode and enter hs mode
> 
> The sequence after patching is:
> 1. Set the dsi timing register
> 2. Pull the MIPI signal high
> 3. Delay & Dsi_reset
> 4. dsi clk & lanes leave ulp mode and enter hs mode
> 
> Fixes: 2dd8075d2185 ("drm/mediatek: mtk_dsi: Use the drm_panel_bridge API")
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


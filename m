Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9E4FB6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbiDKJJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiDKJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:09:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1D93A182
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:07:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6AB831F43463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649668056;
        bh=ZiY1smplfC8Q/27VCH66ZDkjUfbqOxGVogTWZECGfIM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V5pDyBHW7uzDcMd299MPjxd0ZepU4WVJX6o8/EW2tAPqu6wgHvf+Dr64HsObiTitt
         300hqHzv7AehGss5J8ERbQAQiTLw3Y786e97s2rswwr+foIEw1q0m0n87JQJMi9ANY
         vg1d4eLj3k3lRSy5R5CfwzuE6G2GlCab0dsmhLN6YTDtZEo6Khk9XA0bNoxtzqr6Pi
         W5O9j5rQG3rVqui1eGZhSQ08a1s5Z4fdr6t4Xctcy32hFoeCa7KhuMCJdwTeCPXtTY
         uzohXaYwjvke9VbwyftEkH0zO14Uu8DhMLgqs9Sa8tONHiUWbt1IMJ6kbSBLxnrnRd
         BxsDRcJow0B3g==
Message-ID: <914baf06-0fe9-0802-26a5-71e5a0715ce3@collabora.com>
Date:   Mon, 11 Apr 2022 11:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4, 2/4] drm/mediatek: Separate poweron/poweroff from
 enable/disable and define new funcs
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, rex-bc.chen@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1649644308-8455-1-git-send-email-xinlei.lee@mediatek.com>
 <1649644308-8455-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1649644308-8455-3-git-send-email-xinlei.lee@mediatek.com>
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
> In order to match the changes of "Use the drm_panel_bridge API",
> the poweron/poweroff of dsi is extracted from enable/disable and
> defined as new funcs (pre_enable/post_disable).
> 
> Fixes: 2dd8075d2185 ("drm/mediatek: mtk_dsi: Use the drm_panel_bridge API")
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


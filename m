Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F755C48B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiF0KT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiF0KTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:19:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7384110FB;
        Mon, 27 Jun 2022 03:19:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FB026601822;
        Mon, 27 Jun 2022 11:19:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656325192;
        bh=B05eVpTPDvSH5kRE63nQuTVqlP0G5H8QGhr6i4PP/Gc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l4HYQVy3A/okvck/4kADeDAZ40G3lPo1V3YtIyhBRqCsHQ63SLEuTrXmPmbSnRx0C
         rYfEKCpN20OqZYXFmT/lhfaf9yBqo1Nr0V7Lg6P1IcumzGQXvgvIHNSp8OS4uQ2kla
         ZB3ztKRby9hpCfegz/jeWZCT4YsqK66gaZhbUVP+C8XYh+BR4qLh9E0ic660E52BD7
         6k+KXgn2Z9RDvQsjpCoqGMC4TT8EG25uyRMcZjVFfe0+BZLR53m1ngblpQXLA2rPZB
         8ZmUEJNwxCli92Yjqhbr9WTC/UfAouP3LiMKoL2naDSRDAmv4Z1LreJFby+/ZnA8U/
         3rc/2tcs99gVg==
Message-ID: <39d87507-8cbd-27bd-258f-0dad84ff3b0b@collabora.com>
Date:   Mon, 27 Jun 2022 12:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v12 08/10] drm/mediatek: set monitor to DP_SET_POWER_D3 to
 avoid garbage
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220627080341.5087-1-rex-bc.chen@mediatek.com>
 <20220627080341.5087-9-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627080341.5087-9-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/22 10:03, Bo-Chen Chen ha scritto:
> Set the monitor power state to DP_SET_POWER_D3 to avoid garbage.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


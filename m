Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867455D087
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiF0Kwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiF0Kwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:52:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35116460;
        Mon, 27 Jun 2022 03:52:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B8C26601826;
        Mon, 27 Jun 2022 11:52:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656327157;
        bh=WxkNGjx5kgWUdeLMvig/vI26O0/WciY9uF+6rptUBeA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mA8gY84WX77GS+QSIgYY5nCzqSl5cGKnzWNf1K0Zu4fxBdEtwNYJtYZXQjBPRxvBE
         SrAYXwtgLPVqMYoSHlGoQPqcMsY59XWaRVrXM40cpFD2R0+wbtBJnV4q0QkBZfLjqv
         9fyU4zKOEX3dkiPg01j2zpGhUQPv7fQoUQSrKO3wHW5gQkZoXa/LHTMLYLwbnRK0zG
         2xOZ1ZJNq5/owiBnbAsz1O1SOqBBy9u9LvrMno34QX1mAnZdA5ThoUpsWcsknUMq7D
         b2cUIkSbGRU5crGxtGBDNX4lcBmUr0ncZBp2MGLlZqHHzixhptuUA7aMiKebwqddqr
         lWZaoVGb/IrFA==
Message-ID: <693d8201-5da9-8ad0-2194-812f7bfb19b2@collabora.com>
Date:   Mon, 27 Jun 2022 12:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v14 15/15] drm/mediatek: dpi: Only enable dpi after the
 bridge is enabled
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
 <20220624030946.14961-16-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220624030946.14961-16-rex-bc.chen@mediatek.com>
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

Il 24/06/22 05:09, Bo-Chen Chen ha scritto:
> From: Guillaume Ranquet <granquet@baylibre.com>
> 
> Enabling the dpi too early causes glitches on screen.
> 
> Move the call to mtk_dpi_enable() at the end of the bridge_enable
> callback to ensure everything is setup properly before enabling dpi.
> 
> Fixes: 9e629c17aa8d ("drm/mediatek: Add DPI sub driver")
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


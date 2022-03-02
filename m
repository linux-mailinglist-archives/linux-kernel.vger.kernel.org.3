Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD54CA5F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiCBN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiCBN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:26:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10041CFFE;
        Wed,  2 Mar 2022 05:26:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E9A591F44E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646227574;
        bh=vIbI9aNzOb5Yz1Pb7B8zVtgYkA/gIFiYF+AyCtFN6y8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mO/NL1EeZ7vpHaJLT+lciSlTguGF2C81AFnzhEdgFH6TC5y/Brb9oJ6+DxM9vmujM
         FELXibdgQSP7F7AtjgHoJDL3a4XzhsaWXLM0hEj0TqZsGocHvvvkbUH3sVZpNsS0x+
         za59oWN6X7M+SQN6r4hKc/wKjXYFI3u8I+wMcLcUyguRhVOLZIpg8dG0qBTnXDepfb
         Bb9vGfTK0Y28bV1ElQ5DZ5sdEh/ZV7RkRBvxL+zqLui/ITL7YP9aJVeJm8AHIUgL6s
         pKd95O0mBomkxpuTZEeNb4nwOVKA3E27bdgZwe0xPw0qyfPJLt7r6oThxqXyF1On7u
         DRtsfAzLL1KMA==
Message-ID: <f006d46c-8060-3bee-b589-5e39c1ebf768@collabora.com>
Date:   Wed, 2 Mar 2022 14:26:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 00/12] Add Mediatek Soc DRM (vdosys0) support for
 mt8195
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Jitao shi <jitao.shi@mediatek.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com>
 <c73eefcbf85cbb1eb9d1278e675608f8d9775693.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c73eefcbf85cbb1eb9d1278e675608f8d9775693.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/22 11:13, Jason-JH Lin ha scritto:
> Hello Matthias,
> 
> The DRM parts are all reviewed by Chun-Kuang.
> Can you spare some time to give us some suggestion for mmsys parts?
> 
> Or do you think we should separate the driver of mmsys related patches
> to another series and resend again?
> Would it be better to combine mmsys related patches from vdosys0 [1]
> and vdosys1 [2] series?
> 
> e.g.
> [v1,0/7] soc: mediatek: mmsys: add mt8195 mmsys support
> [v1,1/7] dt-bindings: arm: mediatek: mmsys: add power and gce
> properties
> [v1,2/7] dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding
> [v1,3/7] dt-bindings: reset: mt8195: add vdosys1 reset control bit
> [v1,4/7] soc: mediatek: mmsys: add mtk-mmsys support for mt8195 vdosys0
> [v1,5/7] soc: mediatek: mmsys: add mtk-mmsys support for mt8195 vdosys1
> [v1,6/7] soc: mediatek: mmsys: add mtk-mmsys config API for mt8195
> vdosys1
> [v1,7/7] soc: mediatek: mmsys: modify reset controller for MT8195
> vdosys1
> 
> ---
> [1] Add Mediatek Soc DRM (vdosys0) support for mt8195
> -
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=608548
> [2] Add MediaTek SoC DRM (vdosys1) support for mt8195
> -
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=604065
> ---
> 
> Regards,
> Jason-JH.Lin
> 

Hello everyone,

I think that all the drm/mediatek and soc/mediatek patches in this series
are safe and ready (and also tested for regressions on older SoCs).

Feel free to pick them in your trees.

Cheers,
Angelo



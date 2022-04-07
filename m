Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223EA4F79C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbiDGIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbiDGIdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:33:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7651624B2;
        Thu,  7 Apr 2022 01:31:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 033AA1F4557A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649320257;
        bh=6e8HenrGm7ueDzpKsobNNpLOHDIySrUgYBvMNTWkXV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ai2pKUULO/Q4bNNaYxGOfgX9yE0r4mBHrfh9sOznK3UT3kXoxwYq35TL5YUwWUqZg
         qzLiEAbruH8URXZvTvEK1Mt3fdMt9+BFQ2klTx0/MMe2S6avCtRMUHsVRVmi8EFzVj
         sV0extkjPfZNaCOGIoHF3wrqr4qQVIDy1GkE8X2pcD3yO4w7QIDp5ndi6SGPjio/uT
         jVCUwMCWj+bwOVMXdTXasjgyrsOxlftY41FLngMAvVZ96tXJOpYji8ugZ/5k8MF3Cs
         8uCdIGjgKhuqaB4+TDb5c5d0nzFTgixeCibhSSwQIkUr/WJKyKkdUBLqa0wQqjgc4G
         ixlLMGjssk+Fw==
Message-ID: <5337d925-b904-6f05-8fc9-2ff5f429c447@collabora.com>
Date:   Thu, 7 Apr 2022 10:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND v17 2/7] dt-bindings: arm: mediatek: mmsys: add mt8195
 SoC binding
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        postmaster@vger.kernel.org, hsinyi@chromium.org,
        fshao@chromium.org, moudy.ho@mediatek.com, roy-cw.yeh@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
 <20220407030409.9664-3-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220407030409.9664-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/22 05:04, jason-jh.lin ha scritto:
> In the SoC before, such as mt8173, it has 2 pipelines binding to one
> mmsys with the same clock driver and the same power domain.
> 
> In mt8195, there are 4 pipelines binding to 4 different mmsys, such as
> vdosys0, vdosys1, vppsys0 and vppsys1.
> Each mmsys uses different clock drivers and different power domain.
> 
> Since each mmsys has its own clock, they could be identified
> by the different name of their clock.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44BE49DF68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiA0K1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiA0K12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:27:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A8C061714;
        Thu, 27 Jan 2022 02:27:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AB1741F44FF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643279245;
        bh=1pHBK+qOfKgSkn2nYNSNhU9hK3UyhbI/pSuMBl+2Jgc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GXCEFQEttXLRZlKiLfPCGvgiQJeFii+EA73219Rq3p71mQ6V/BRSl+97zM/J4i/QI
         XkcJHZjt8qS7+lqQqXW9J5RBzeC+WMNY3VhMnw8fMaR9P0oLW1g465nC/Q+VdoRzz3
         EZzhACVcHHFhjM0k9f6PoGuVwL6PCPN28zVr2YIP+honKpGkiChr/MniAb5UdInETg
         WUBdk0riz991ynPs8vqX8PH3sxHWP6S2D8IQh6UfWJFdlheGHJFzeFYTiu+t5boE60
         JhJSJxyB0AcKBOwCiJMKnKjBf9CW3VvGHis36oAXWD//RYWTXHIG+VsW4bVfbW3NlM
         /a5awB9ZcNv0A==
Subject: Re: [PATCH v15 10/12] drm/mediatek: add DSC support for mediatek-drm
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com>
 <20220126071932.32615-11-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <b5e3d5a9-9997-fce5-9201-bccba1af6c7a@collabora.com>
Date:   Thu, 27 Jan 2022 11:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220126071932.32615-11-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/01/22 08:19, jason-jh.lin ha scritto:
> DSC is designed for real-time systems with real-time compression,
> transmission, decompression and display.
> The DSC standard is a specification of the algorithms used for
> compressing and decompressing image display streams, including
> the specification of the syntax and semantics of the compressed
> video bit stream.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

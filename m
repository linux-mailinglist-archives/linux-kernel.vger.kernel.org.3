Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3B47EDAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352200AbhLXJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:19:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352181AbhLXJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:19:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0DEB21F41087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640337589;
        bh=Dd16QanSlYA1tBVffT0FvMZpvgakJI8nT31xHJoXEAY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oDQC+LOrMg5QF+R8JR/PTi8Ifb4idiM9mqjKcMNdNXjOfo6hlwmJum2ySGAB3AfKh
         cOEFVCfmZnCAvs+QZy27b2DBsVPt9BcNG/Sc17cFkxnMm3rt1Z1dsvYOcTF2HHiYm9
         QMxYgY9MG/4kTXcezSlOVF+bX9fDHTH+i0XEhWE5xdd4scyyMcWpzix9mU9QB0UJSQ
         uBzjUvHTiAg+3R6KX4CAGODMjnoY5qjHakecPIexaci3RN64AGMXvgyWs31k7HGX3f
         /3zD6SQTSb2TbfMc7TMtPhYh8qHS9OIxHUF+3psS7n3mCOmTR6Bl86GAYEFWg+N0N1
         l2TbYFoQ0xhZg==
Subject: Re: [PATCH v7 1/4] dt-bindings: arm: mediatek: add mt8195 pericfg
 compatible
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        broonie@kernel.org
Cc:     bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <6f16c605-713b-5318-eeea-ba9810245a25@collabora.com>
Date:   Fri, 24 Dec 2021 10:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211220121825.6446-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/12/21 13:18, Tinghan Shen ha scritto:
> add mt8195 pericfg compatible to binding document.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



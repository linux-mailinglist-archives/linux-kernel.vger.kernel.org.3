Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71E547EDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbhLXJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:26:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35064 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbhLXJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:26:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5E3BD1F45CB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640337998;
        bh=BXFgTWFlZLjIHyV2DG0s0M4PU98Sx4Sf7sp7gLh0MFw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S1m8ancCIzOmDMa2zl87l8CaPUrf1LsHEu80kWFB8Nlc0ith1YyzcQW33xYJjaBjO
         +83NE8Vqkm9jaEyAdq0Pw9n7gCkvaFStnytcn0N4oW8fkak8aTqeBn/77r9az2CgOT
         LOEn+rZhzlMT3uun2w91W7KgR3jhOJzi+eC+Oh76u5iWFM7uysoVPulb74ofqAg7DI
         AbdSz8ytJpUZ8feeSAIwUS8z74ZKzpNpKHprVfeRnAtEJlMD9HsUNv2UQXKV3HkFxS
         rnVn41qoxvi56CFgv0nbdmjprWII4RO3LoIv15QoojTYQ03+UgcL6z0ngZ4cc1CYtv
         usMerIPt59oYQ==
Subject: Re: [PATCH v7 4/4] arm64: dts: Add mediatek SoC mt8195 and evaluation
 board
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        broonie@kernel.org
Cc:     bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Seiya Wang <seiya.wang@mediatek.com>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-5-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <18a3ee82-c295-ead6-3fef-6ca3afa81d71@collabora.com>
Date:   Fri, 24 Dec 2021 10:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211220121825.6446-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/12/21 13:18, Tinghan Shen ha scritto:
> Add basic chip support for mediatek mt8195.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599D3483ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiADJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiADJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:05:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF8C061761;
        Tue,  4 Jan 2022 01:05:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E59141F42D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641287150;
        bh=LKHYs6cNRjJodREjyWXR9U6nFRgqGcHVmkVWUWSF8Wo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T57fmN1aV+VEjBJZF3unAIRoCILKIDjrVV2dmGpTZ2tIVcniUChypoEHcvauTAlaf
         akuxrTMQOdRGUXM6nJXXEu+gP5MNnU8AR/c6il31bn+7hM5QfAMzgXbRW38QnBKgcB
         WL9H06wTTKdhyDbw6c1YIz0Md6a2QlfMAW5lt+wUPtXMSsItG44YbiGWN3UcMkjUwo
         h4SuJwixl1Y0GSI9nv6qjyIekwD86vH+lpXZJ2STy3hEp2ARohLqmmt01PgCiOe2Ec
         OgM+HVu6igZ1fwpAsGj+goeDprqqX+dfEcJBYTRbJ0XusZA3fKPj9UAPgtrRmCoK8k
         VBIYYQOGgHnCw==
Subject: Re: [PATCH 2/2] dt-bindings: mediatek: add compatible for MT8186
 pwrap
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211230114913.9829-1-johnson.wang@mediatek.com>
 <20211230114913.9829-3-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <e5992de7-2570-8610-8acf-78313ff74718@collabora.com>
Date:   Tue, 4 Jan 2022 10:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211230114913.9829-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/12/21 12:49, Johnson Wang ha scritto:
> This adds dt-binding documentation of pwrap for Mediatek MT8186
> SoCs Platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>   Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index d74a7a5ae9f2..214a34633824 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -27,6 +27,7 @@ Required properties in pwrap device node.
>   	"mediatek,mt8135-pwrap" for MT8135 SoCs
>   	"mediatek,mt8173-pwrap" for MT8173 SoCs
>   	"mediatek,mt8183-pwrap" for MT8183 SoCs
> +	"mediatek,mt8186-pwrap" for MT8186 SoCs
>   	"mediatek,mt8195-pwrap" for MT8195 SoCs
>   	"mediatek,mt8516-pwrap" for MT8516 SoCs
>   - interrupts: IRQ for pwrap in SOC
> 

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5144895E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbiAJKBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:01:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34640 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbiAJKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:01:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 457071F43727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641808876;
        bh=sCbXhyaML9yHLR6eOlxKHATu7/M/ieT6rftGRXxPcvs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VcTCvAr6h2ngNSpA4KSiENz4jlKUdD8W5M6Da9YQ0wZTS9frVuM8S9mn9ua6wyzf4
         L6AQnSXUTcHCeRE1vbBTL9STlrdHgtRbf5ZlH5h+BaXhsH1Kie4VabwWx10fDANhJ+
         Ohe9z5OdAvg0MC21100rjvRlm/fhYJXCdBMp8+Tzj+Phs5nRYcqfVHrYI5bqTrtCpP
         tTxLswO3cmMXMY1APQXv6L04iEj0iNuGCBo/TlyoxITGbH9YVrPq1Js3LIvty9Omjd
         1NNmiqNwE6+sxccRP7A+8qJmb4QKnZ8bUsvNJ102y+VK1uX27d7ZIEA+J9NlXfK3Sw
         Qfk3MJsYFpEcg==
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add compatible for Mediatek
 MT8186
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110084841.575-1-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <02a18741-2015-73d2-9a5c-a28c1b15894f@collabora.com>
Date:   Mon, 10 Jan 2022 11:01:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110084841.575-1-guodong.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 09:48, Guodong Liu ha scritto:
> This commit adds dt-binding documentation of auxadc for Mediatek MT8186 SoC
> Platform.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index b939f9652e3a..65581ad4b816 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -34,6 +34,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8183-auxadc
> +              - mediatek,mt8186-auxadc
>                 - mediatek,mt8195-auxadc
>                 - mediatek,mt8516-auxadc
>             - const: mediatek,mt8173-auxadc
> 

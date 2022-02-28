Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8274C6A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiB1LYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiB1LYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:24:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682DD40A11;
        Mon, 28 Feb 2022 03:23:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v21so14872140wrv.5;
        Mon, 28 Feb 2022 03:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Xad/Cm1Xa8M0hODEJ4dnGwbaNUheLGcG/djLON/KIs=;
        b=DM0SjBIp2rOGaNtM39pEiIUszAfjIHUZMKGIcQjO3F+1g8JNd6oucb2caysFVNecr2
         880kyAJYSq5XZxOuIqZVlZi1Vw8TL0FbK47XSiPDz5KswKn0nyFHW7kBKAmwBmyKd3j5
         NGes1i6mVKRX6OjYj4nzZp36qCA3OOORYpQWLweWomp8mqdxkF6d7VR3jG5f9nU1wdJX
         ronv6A3YVSIbPwdcWvlojPcE3AmUu/RFvNEZ6I5BZqU0843QctZrYqbQ3jQYeh4L6LfX
         4p1h57jTGbcLfXpqYm/dmP1bT/oaYCkKOLVX7fBcovmV0389jDwOgTL6MgGimH1kevSJ
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Xad/Cm1Xa8M0hODEJ4dnGwbaNUheLGcG/djLON/KIs=;
        b=xVkM8RKxMDvkWqLtLR8UVzu3FJaYc8bNzJszFTzqLlThuhHXB3SvHO8wJuLbJ1Yd7M
         0j0uGOpIrod5aj9dd3yEspRjcTcbMmsFhHufCt+nQlCKr4k2ETNwOfYK0F2KvMb+8GCJ
         1VzL6yILUL0wYfm+V6QZ3XQSIqWtVE0cLsXTKPpnCRc70hDXkM4SxHFvcqQcCtJ7erYR
         rNnsAiGCKWoOV5+e/TOZbngYkpO09OTjJxD3hU4p00h06yCpuNIQr03s1jmMnBCjwm5X
         8p4RFj/WHT34ZWVmgSki438ysrJFeuAbpDM9DCWV3n6hQSlHWOXs0DgJ+3P27rEzZ3CA
         K8pA==
X-Gm-Message-State: AOAM532DFNgAdE0T25M0z1lpF2sBtm/CNEtGlgaCsQwcIFhWm8H6u8ps
        DWjwQEzE/gTjHjGXkjEkxdI=
X-Google-Smtp-Source: ABdhPJzP+xqwrYyWQvMzSTg/Q1fH/gj9WcdWurTxPtGzl7RjAQC95IedNOQ1iLc69P0VmDAsZQferw==
X-Received: by 2002:a5d:6148:0:b0:1ed:b74e:508a with SMTP id y8-20020a5d6148000000b001edb74e508amr14871735wrt.90.1646047430977;
        Mon, 28 Feb 2022 03:23:50 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00380e3225af9sm11015593wms.0.2022.02.28.03.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:23:50 -0800 (PST)
Message-ID: <4df2ddd0-2114-f874-d661-bb7020f56f72@gmail.com>
Date:   Mon, 28 Feb 2022 12:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] arm64: dts: mt8183: jacuzzi: Fix bus properties in
 anx's DSI endpoint
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220214200507.2500693-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220214200507.2500693-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2022 21:05, Nícolas F. R. A. Prado wrote:
> mt8183-kukui-jacuzzi has an anx7625 bridge connected to the output of
> its DSI host. However, after commit fd0310b6fe7d ("drm/bridge: anx7625:
> add MIPI DPI input feature"), a bus-type property started being required
> in the endpoint node by the driver to indicate whether it is DSI or DPI.
> 
> Add the missing bus-type property and set it to 5
> (V4L2_FWNODE_BUS_TYPE_PARALLEL) so that the driver has its input
> configured to DSI and the display pipeline can probe correctly.
> 
> While at it, also set the data-lanes property that was also introduced
> in that same commit, so that we don't rely on the default value.
> 
> Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

applied to to tree v5.17-fixes

Thanks
Matthias

> ---
> v2: https://lore.kernel.org/all/20220201174643.843102-1-nfraprado@collabora.com
> v1: https://lore.kernel.org/all/20220120224204.773117-1-nfraprado@collabora.com
> 
> Changes in v3:
> - Added missing Reviewed-by
> 
> Changes in v2:
> - (thanks Rob) Use proper format when refering to commit in commit
>    message as pointed out by checkpatch
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 8f7bf33f607d..e8f133dc96b9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -171,6 +171,8 @@ port@0 {
>   
>   			anx7625_in: endpoint {
>   				remote-endpoint = <&dsi_out>;
> +				bus-type = <5>;
> +				data-lanes = <0 1 2 3>;
>   			};
>   		};
>   

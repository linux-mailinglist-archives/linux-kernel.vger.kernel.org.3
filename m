Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95D84BA330
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiBQOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:41:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiBQOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:41:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6408F2B1A92;
        Thu, 17 Feb 2022 06:40:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0380C1F4598A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645108843;
        bh=o7M37NRjUzyT1SEEw8QEv+OQorYXKUUvT1lprkZEPDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lyfIa822zgsumKInOeSFVIxYdBA40JLhTin+IhAc/pXMOJljeoF4s+oOZlSYJ/eSH
         /7KTlL4yml3t32SDDDsx953Ml+vQKZKiSQWkSqV6RjGDbqS7uIoyMHT0E4Psfedxik
         m3rw9y/x3NgRNL4mElYjdClK+j9he4LBZtu5deC4zQk7PsHTAFQ+kpt7zggPZiU0nq
         sIWYFrhr4jsIScQbwVHrQLoquXWAI4qRIpzYnGfESrYe4N9xNRBRtsvX93GGg4F12G
         /74tbymUv6mYvH3kM2Ptz4mcLg8LnS8nxsUFRIROrVUJ/yMt/qOZmQFvWSL+1/2n6R
         zGhyMssm2PqWg==
Message-ID: <10a101b4-293e-19c8-d241-5357a947acef@collabora.com>
Date:   Thu, 17 Feb 2022 15:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] dt-bindings: phy: Add compatible for Mediatek MT8192
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Min Guo <Min.Guo@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220217135620.10559-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217135620.10559-1-allen-kh.cheng@mediatek.com>
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

Il 17/02/22 14:56, Allen-KH Cheng ha scritto:
> This commit adds dt-binding documentation of T-Phy for Mediatek MT8192 SoC
> Platform.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index d279ba222316..7b2e1bc119be 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -81,6 +81,7 @@ properties:
>                 - mediatek,mt7629-tphy
>                 - mediatek,mt8183-tphy
>                 - mediatek,mt8186-tphy
> +              - mediatek,mt8192-tphy
>             - const: mediatek,generic-tphy-v2
>         - items:
>             - enum:
> 


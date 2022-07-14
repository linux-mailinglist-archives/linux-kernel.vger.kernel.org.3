Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8C574DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiGNMbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbiGNMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:31:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B26069A;
        Thu, 14 Jul 2022 05:30:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1EB96601A3D;
        Thu, 14 Jul 2022 13:30:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657801805;
        bh=JVzIn5i13DB3/LDAuFTquEfvgf4d0MOmVf70FJzjMJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OoAviENdLmUSvVXKjtV8pZcO9HKH6GmHsSHPis+lTpAkyhs422g+PIZEeVDWzySig
         ueTEMOkXaenWoQSWRpkl7mU9zOOn7NaXh7bnnBtSyHL58YaJhaYzYbjDicIfWIRdcA
         y95lrdbjBDfOx7y/r1rlAGzfzR1AhdMcsOZ4VLVYYPqh6OZfI7707HzBfj0Rs/WxId
         NunmwCi+DVC6y+3MZCDj/+m3LphY6H/GlG01fnw/WzUCKYvU2BnJXZ7jCD9FzZuYiD
         P2bpxjTDLHSUyMh+PgEFbtxK5ChjnPv5sWMc1RjBhiOy+BbVeq4NiBV+6TjQVcPzSm
         2uxIivKlaPlQA==
Message-ID: <468507bc-e10d-0d7c-aa77-bab4769efbcf@collabora.com>
Date:   Thu, 14 Jul 2022 14:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dt-bindings: uart: update bindings for MT8188 SoC
Content-Language: en-US
To:     kewei.xu@mediatek.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, liguo.zhang@mediatek.com,
        caiyu.chen@mediatek.com, david-yh.chiu@mediatek.com
References: <20220714104149.23343-1-kewei.xu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220714104149.23343-1-kewei.xu@mediatek.com>
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

Il 14/07/22 12:41, kewei.xu@mediatek.com ha scritto:
> From: Kewei Xu <kewei.xu@mediatek.com>
> 
> Add a DT binding documentation for the MT8188 soc.
> 
> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>

This file doesn't even exist anymore. I've converted it to json-schema, check
out commit 22b10b33b9c6e76bc08f64e52862e68c4dc76052

Regards,
Angelo

> ---
>   Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 113b5d6a2245..e5094e1db7b4 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -21,6 +21,7 @@ Required properties:
>     * "mediatek,mt8173-uart" for MT8173 compatible UARTS
>     * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
>     * "mediatek,mt8186-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
> +  * "mediatek,mt8188-uart", "mediatek,mt6577-uart" for MT8188 compatible UARTS
>     * "mediatek,mt8192-uart", "mediatek,mt6577-uart" for MT8192 compatible UARTS
>     * "mediatek,mt8195-uart", "mediatek,mt6577-uart" for MT8195 compatible UARTS
>     * "mediatek,mt8516-uart" for MT8516 compatible UARTS
> 


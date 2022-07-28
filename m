Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F0583D66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiG1L33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiG1L3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:29:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA76214;
        Thu, 28 Jul 2022 04:29:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2839A6601B43;
        Thu, 28 Jul 2022 12:29:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659007763;
        bh=uNWcE5HfgFGFIQScfXTCaroVaJZ+sGnKlroMwrEXQRc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fhPaUsX32oN2Zv+HMQErEyWkgFTSLph5msyPBzP5gXlQodELxkRpJmMQW6bGUsLn3
         Qpiw3k1mxW+S1ZJI1K4JyNT6zWYicwdubvggyLSplfHCBAlFAu5DsgaydNwM8g6cfl
         BnuHxCvPkY+78d+ccyYmKYueWEkONobkIZd34M4MZt+JacksXUB880jqoWJCL5n6Dx
         DEGkHvfJ+2HTkEbsiOtLKy7UdINeDvN8+kH4GOA188+cKTWeoeJg5YWPCKIUKP0hj2
         +3wVDUgm54X8LJPim0kcg3Rs2eUJ0C+OLo0oSs+2AOxxOf5lbboiuylVnyIn9XojL1
         8yoqdAEAveNYQ==
Message-ID: <d0d24ba1-e870-2ba0-8259-c405cb029d2f@collabora.com>
Date:   Thu, 28 Jul 2022 13:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: spmi: add compatible for mt8188
Content-Language: en-US
To:     Sen Chu <sen.chu@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Hui Liu <hui.liu@mediatek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220726103729.24525-1-sen.chu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220726103729.24525-1-sen.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/22 12:37, Sen Chu ha scritto:
> Add dt-binding documentation of spmi for Mediatek MT8188 SoC platform.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> index 2445c5e0b0ef..05801e0199f9 100644
> --- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> +++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> @@ -20,6 +20,7 @@ properties:
>     compatible:
>       enum:
>         - mediatek,mt6873-spmi
> +      - mediatek,mt8188-spmi

I think that you'll be adding a SPMI node that will have:

compatible = "mediatek,mt8188-spmi", "mediatek,mt8195-spmi";

Which means that this is actually wrong, so, please fix it by
adding items...

Regards,
Angelo

>         - mediatek,mt8195-spmi
>   
>     reg:
> 


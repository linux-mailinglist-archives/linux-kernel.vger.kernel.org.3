Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C21577F08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiGRJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiGRJwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:52:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8AB1ADB6;
        Mon, 18 Jul 2022 02:52:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B72466019EC;
        Mon, 18 Jul 2022 10:52:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658137922;
        bh=DwirXspN3Y3vFBnvNC+gMPwdHPw3dxPtlLcTkFzaP3M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j1/vkC4OKV5+d+kGyTUqlm1aRo5n/yStDLapB2Nu23DqLAxq/V8B2NyNEUYMBumTN
         FVGqkZ7+3xd4if9vEm1UNEx1Epb9w86rmefaRY5n7zOiCtW0rH5PTP2zb+ONP8V6V7
         v/3NncWTF6AiJ7T/TFTMLHhlWmxQGmTk4BZVUOMYc+40FSPbC8cl9/Dg6i120dRxE2
         NqirQABTSh387G92VSoFpQhdlDImR2dFhXL3LN5RXxIViQ3Ax522G2FzlIkG4lnfUV
         qoh62m3IxP1hI4VisTdKX91AKSt1SrA0FAF7CZ4fPPm1Idb5XM6wcgwpHYg58Q4sQQ
         PeVaLiVQcd6cw==
Message-ID: <9e1b51df-6d4e-5767-3111-dd1232ad22ad@collabora.com>
Date:   Mon, 18 Jul 2022 11:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] dt-bindings: media: mediatek: vcodec: Add encoder
 dt-bindings for mt8188
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220716093808.29894-1-irui.wang@mediatek.com>
 <20220716093808.29894-3-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220716093808.29894-3-irui.wang@mediatek.com>
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

Il 16/07/22 11:38, Irui Wang ha scritto:
> Add encoder dt-bindings for mt8188.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>   .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index d36fcca04cbc..66901118d346 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -22,6 +22,7 @@ properties:
>         - mediatek,mt8183-vcodec-enc

Please keep alphabetical order.
Add it here instead.

>         - mediatek,mt8192-vcodec-enc
>         - mediatek,mt8195-vcodec-enc
> +      - mediatek,mt8188-vcodec-enc
>   
>     reg:
>       maxItems: 1

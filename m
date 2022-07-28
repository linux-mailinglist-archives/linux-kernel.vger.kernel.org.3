Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A579583CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiG1LBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiG1LBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:01:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690FD63925;
        Thu, 28 Jul 2022 04:01:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A32F66601B41;
        Thu, 28 Jul 2022 12:01:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659006096;
        bh=2Gf8nY7WN8C7IH2RQ1ZvuEwtQ2J2d47oOyVP2UjzX0U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D0ve+y61ACPxexiD5k+nJUzMQxkgPGYCCiP3FRnIqqm0OEgYR6QVsTOLSSWVVgya7
         2VQIRR7GSCMIfIjUGDf6Q3F8UY0Y28mIwpwO+eBgiHO/UmrMvU663MjrSI8DVQedRJ
         sFblSS3X6ERr6lHz2XWrbyBssnQjFdLESVHTHB3dEGlF6Cj8fGFh1Fqo/9rquom8M4
         Msj/HaqYXRKgdtlxNQQ0aiB4Go6lAq9/vMs4K7J0IlBLxYl3R1nYQomgfxZ09osUGH
         HFNs4LzTczSDfMROi8bMDUiWZGVJ2bCRE9mYEDKzrQqz3jka6SpJJxIrh+h/B/wkzG
         Cyzdi2hQFY9Jg==
Message-ID: <c6c649ab-d147-a5b0-f95f-71b0ab0e8344@collabora.com>
Date:   Thu, 28 Jul 2022 13:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] dt-bindings: memory: mediatek: Add mt8188 smi
 binding
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220727104541.7309-1-chengci.xu@mediatek.com>
 <20220727104541.7309-2-chengci.xu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220727104541.7309-2-chengci.xu@mediatek.com>
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

Il 27/07/22 12:45, Chengci.Xu ha scritto:
> Add mt8188 smi supporting in the bindings.
> 
> In mt8188, there are two smi-common HW, one is for vdo(video output),
> the other is for vpp(video processing pipe). They connect with different
> smi-larbs, then some setting(bus_sel) is different. Differentiate them
> with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>         |                   |
> SMI_COMMON_VDO       SMI_COMMON_VPP
> ----------------     ----------------
>     |     |   ...       |     |    ...
>   larb0 larb2 ...     larb1 larb3  ...
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


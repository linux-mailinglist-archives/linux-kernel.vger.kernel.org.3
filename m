Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B154647F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348327AbiFJKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346898AbiFJKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E22D5144;
        Fri, 10 Jun 2022 03:44:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 422356601739;
        Fri, 10 Jun 2022 11:44:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654857840;
        bh=lj3xJzmaDU78TbJW5AGp9pDhMJpFS3zOXR4DFORJC/o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UMQAlCbCfhbIPqzRMhPGJb1SqrWj3HOitsoqbGqHp3nWiByj6+axMzjkvhn9DE70d
         heZPb7PukrKwW5NBWaygsK0BdSoOR9yX9tni8Ek66w1WTl+sdJl/xrGurQJc18y9aS
         iQnb57xgmNqjOV5VqN1sAIzZgVZVazwwCDgGnWzPjxM9tm3ATp6OLhPt9zT+PYMKmi
         KHGL0a7QgGfEgeflmKV3J9VzkGa4hV65jcX46MTG53lzAnY0LG/+/QeAcfWsMjy0p+
         Yo3oLCErdkycCv2DqaHRzhKQ0ciJbwomwwuzcfAVK/Xub8CYznloaXRYCaKextDKcg
         TGS2Sc+Urijpw==
Message-ID: <4e452af8-e96d-fb06-7800-707f3bf75155@collabora.com>
Date:   Fri, 10 Jun 2022 12:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220607140556.6278-1-johnson.wang@mediatek.com>
 <20220607140556.6278-2-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220607140556.6278-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/22 16:05, Johnson Wang ha scritto:
> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Georgi Djakov <djakov@kernel.org>
> ---
>   .../bindings/interconnect/mediatek,cci.yaml   | 141 ++++++++++++++++++

Uhm, I've just noticed that this is being put in the bindings/interconnect folder.
The mediatek,cci is *not* an interconnect driver, but a devfreq one and is not
using any ICC APIs.

Shouldn't this go to bindings/devfreq/ instead?!

>   MAINTAINERS                                   |   1 +
>   2 files changed, 142 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> 

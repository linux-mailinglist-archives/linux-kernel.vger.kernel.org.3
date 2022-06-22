Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9C554C57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358068AbiFVOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358035AbiFVOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:12:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42FB210;
        Wed, 22 Jun 2022 07:12:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g25so34505628ejh.9;
        Wed, 22 Jun 2022 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
        b=CQTnUj+3r1Tmk+T0IjuiHB1Hr4poYEqyzqY7e1KiKmdVMECfrXc4U5GEg0+HGYFtGK
         /63ZwSp/BIYc8pDjJQdAhJjVDxcvfs6MUrDxMOe3vyLpx3UjbS6NpkQTLniUIVmX4u9k
         la5+rQMbRD/KXjJML7sUQ573tQDMVpUt7frQWfL6v426debfnOw1gfnGXdzDh0wyC8QP
         bfGGXiL6G5Udv3dYc36Rgf7BiPgTaTD4g1UvxWwtPv+9vzPLSUSF4T8vIVvVTogpBJd6
         wOhbWPDWKTxaYUcyRxH8AXk1DGtjFpgk5+fcwKfl89uNIaiCFB7sR0oPLENO7/FMMx5C
         m3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
        b=tZzXohYEpi10NrajFxobRXEoHyPxwPu49oucdjMtk4iwm3jMuTHn7ad5zs01LnPK52
         D81cz77/KYX/ZQ2yEsWo6YX2++lj9Uhsnvhtv/iFeRgcSEgvyoRU2TGT9gD8JuuEYs7i
         nFLwzYZTMBxRY5EfZ/nPaXl/8qQfyFY15WOBFwcvttaeZdcF2zHTCM9zUUT0kTLHNXia
         bDCsOUGN63uyxgZRd0DyhO38aXJhNZkcAbrJnNk/57HhvVFQ8dPOeYPh9G+5hkhZNWVY
         A5Wcpu1yi3rLJ07Q8f5BMw9UZkbW4GuZVKgHisDNvlO/GOlJUJXLiu6h0A1Gwz2NiYQh
         KrhA==
X-Gm-Message-State: AJIora/aiNgXVpCsSomgemE0tfq+C6OqlvyyGFEiuqlRcspD1vHexf7s
        i11VnAFVfKJnM4VcIprSg70=
X-Google-Smtp-Source: AGRyM1tjj8BA36t5S7r9EYwBFt3Kn2rjeOb1UXCuXZaNTZE7evzeCkF4MwXZS/VBuSfPIwoVJ7nfIg==
X-Received: by 2002:a17:907:86aa:b0:722:d5b2:fca2 with SMTP id qa42-20020a17090786aa00b00722d5b2fca2mr3277139ejc.264.1655907171611;
        Wed, 22 Jun 2022 07:12:51 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090632ca00b00722e7919835sm2332703ejk.111.2022.06.22.07.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:12:49 -0700 (PDT)
Message-ID: <45a6ab4b-bc43-2c98-4f94-be6e4e9fc445@gmail.com>
Date:   Wed, 22 Jun 2022 16:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and
 pericfg
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <YrMc2EUBDIxnoWiB@8bytes.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <YrMc2EUBDIxnoWiB@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 22/06/2022 15:44, Joerg Roedel wrote:
> On Thu, Jun 16, 2022 at 01:08:25PM +0200, AngeloGioacchino Del Regno wrote:
>> AngeloGioacchino Del Regno (5):
>>    dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
>>    iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
>>    arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
>>    arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
>>    iommu/mediatek: Cleanup pericfg lookup flow
>>
>>   .../bindings/iommu/mediatek,iommu.yaml        | 17 +++++++
>>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
>>   drivers/iommu/mtk_iommu.c                     | 50 +++++++++++--------
>>   4 files changed, 49 insertions(+), 21 deletions(-)
> 
> Applied, thanks.

I wanted to check if you took also 3 and 4, as these should go through my tree. 
Unfortunately you haven't pushed your tree (yet). In case you took the whole 
series, can you please drop the dts patches. I'll apply them now on my 
v5.19-next/dts64 branch.

Regards.
Matthias

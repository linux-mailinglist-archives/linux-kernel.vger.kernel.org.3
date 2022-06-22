Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2724554C54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358030AbiFVOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358015AbiFVOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:12:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4345108;
        Wed, 22 Jun 2022 07:12:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id cw10so10813523ejb.3;
        Wed, 22 Jun 2022 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
        b=DeOw2wN9IdijMC2unWkJBkn+F0tt1mYIyrxsmxR8zGIsx8/cjJnRnFkZjEYZR5v9Jn
         xz5LX66Z3YY5K4Zz3g8/bTlx4BWJohVZrld5+reQtujgrYk74t0a8x+Q11wcVAt+C3tx
         cPZO1WbrXhdHJI/4y6hmqzkZZDkM9BftULJwtglLO5v3H2TNVmFKjzegwg4PT/m03Dmi
         QXifV5FRRtVHRu5BFg6Ex0yCvBeViPdV3ntO12SIXDgEDa7+MghdN4/m9+20iyyIubTq
         +2YVHcgzLL0A3ljn87Q3x3JTVG8xnYWswRkIg6KCbStGL2xY4cS4jYioPHz8LNfR1EVN
         DKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
        b=xeIRDWFVgqckA1iFdfdLD2X7sSAsXSREkT1OnbPWiP24vqCVvZCSynyEThn4LN73yA
         N0U+9aNp/92iDIm2qbuFqBHgsKB7L3QogFBFE6g54ZoNLyECJoLMbx2U/JTxqGHQvBxs
         iBOuXxb2ILmt8m9KZwOLb1uOq2WRCUEybVsdm8zI70lmAy8LAybeU0Xec13f+88f4RF+
         n6EkPjO0rESREIwnz3QXht7dgVqiU0Za5WyfIoGoAvUoHLgCRWOwnn3qahCNyn9aunqR
         KoYi5fqVtBxv+C7i0xongob68iYo+WjG94GKOxndMKxXKozWr4oMO1m0ocj8hDq6uRjI
         y3YQ==
X-Gm-Message-State: AJIora+W8KDmZMamNNNfl4jVUDpNjfRXD6ot0zfq80GrIE8YJ23dO9z/
        0wW/LR9NxB0rF4jelwTZP0Y=
X-Google-Smtp-Source: AGRyM1t0OvYHeXsCleYG7c+Bdl+xwzqiXlEMNOW8mbHHHkBOXkEEbMYHepKrU1rP9EliZy/8YVZE+Q==
X-Received: by 2002:a17:907:7b8a:b0:707:59d4:14a3 with SMTP id ne10-20020a1709077b8a00b0070759d414a3mr3351002ejc.51.1655907170343;
        Wed, 22 Jun 2022 07:12:50 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090634c500b007041e969a8asm9257889ejb.97.2022.06.22.07.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:12:49 -0700 (PDT)
Message-ID: <4023cf19-601c-a2ba-85b0-450fb2df9401@gmail.com>
Date:   Wed, 22 Jun 2022 16:12:47 +0200
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

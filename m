Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC450B980
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448337AbiDVOJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448222AbiDVOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:09:56 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6861FA48;
        Fri, 22 Apr 2022 07:07:02 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e68392d626so3642414fac.4;
        Fri, 22 Apr 2022 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3V7/FkjgPIImwE7vieGYRnxFo4xm+FPjV5H1CZWqMaI=;
        b=RjQQZasrIq59WD1uHnAp2UmSfFySylFa8OTx7/1Z1+ZImPZ89ndttGKkXFpckhx/Bk
         yS5aG0OklHvD1OxkRhc1KQ0pfHuUsxJVeNn0EIjR/ezEM4UWrcQVi8m0X9mhDhmyk2/V
         obTBkAEM/Gse/y53TipttERUGI3o91AGFcfBLpD7ATqq4v/iRT/avCUTKiVBqNIGcCWJ
         HVDFJQV4SqiKj6PPevjznWTiS2E4TbyWD1ygRPdUQ6oTWSqla0yOurbHZj2PTLuHVbut
         mHde9GCVMDUGU0t7tRhoi9jLG6aYKEAR96dPrY4Ryvzi8CMYwppDUqunWil+XkilijxK
         bbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3V7/FkjgPIImwE7vieGYRnxFo4xm+FPjV5H1CZWqMaI=;
        b=yfviwoPW8P6JPsrH1YycDLSYkS2G+ZXr1l/YmssKcw/4afy2MQk3WKKLi/ChJzb0N6
         Xigr/v9uV5IMRGAKReZrD8fvVTSIXZyY7D+Cw+Z/0l+JI26XFN+aD2CLBEtdtTYyB7lT
         hhYOK3+YW1xhsfYnW6Bx+tXxwUZNq6k7HcJB17Vl/DgdpcgCuy6ro8kZEVwztswzlupl
         CegMCsS7/s4ag9hlipvs1HxHZGB10MpNhLnUvmpHNvpBAKIWuUi+PUoSe7JZhm8YvhzG
         mflLINz1+SSfhsk1YJLUYJ5yJDUCtjkn+9cxpLTwgNLVpPbFtBLOmBYfJxE9bVSj8xuc
         EFAA==
X-Gm-Message-State: AOAM532vPZXcLJb7Kze8mf3aq4W3fnV8WRb5Cy5Gk8DV3WoWy5cA8dhn
        bv9tmhesly+q7UWntpAMmx8=
X-Google-Smtp-Source: ABdhPJzCQ/gkh1glXSZsTTs2riuKFOrVud0Csh7Rl0iPN7oYbY27y6gk7hPGyxdC7M5eXtYemSt4Uw==
X-Received: by 2002:a05:6870:c222:b0:e5:b047:5a03 with SMTP id z34-20020a056870c22200b000e5b0475a03mr6111660oae.219.1650636421788;
        Fri, 22 Apr 2022 07:07:01 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o16-20020a4a3850000000b0033a3c291f3esm839301oof.40.2022.04.22.07.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:07:01 -0700 (PDT)
Message-ID: <ced3772a-a965-23b1-83b0-f4f8a634450c@gmail.com>
Date:   Fri, 22 Apr 2022 16:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: arm: Add compatible for Mediatek MT8192
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220419092030.30519-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220419092030.30519-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 11:20, Allen-KH Cheng wrote:
> This commit adds dt-binding documentation for the Mediatek MT8192
> reference board.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index ab0593c77321..3a9b92ee915b 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -131,6 +131,10 @@ properties:
>             - enum:
>                 - mediatek,mt8183-evb
>             - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8192-evb
> +          - const: mediatek,mt8192
>         - items:
>             - enum:
>                 - mediatek,mt8195-evb

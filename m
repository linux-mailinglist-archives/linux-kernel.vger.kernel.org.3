Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A884152370A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiEKPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343539AbiEKPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:20:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802E224684
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:20:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z2so4776168ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=geKshak1zwJUIf6OJmXvrC7YdZBGtitn11Vxo6ekyyA=;
        b=l20H3mA7oW2a+08LERco53HKdKbo219aB2WAapCII+6f+y9IzHx4HswyXM1KzGYjvO
         bzH58mV2hjC7NGckBKnwPYTxLnai4AVKm610If4TLKWKSBjeDLKw45Ih/1OOwktZPb4J
         tttTyazCCkuV0Udgr/mC7OfZiv4pt1gs0XPZNq51YAN7PnsJ8t5FOw+KlyUK8CKP7QlZ
         oB85sNr0d9Ww/tDpirsFMJX6WRtjgAEQe7MWx+rCxBO/4kj4kLuWryMRhb/x1bKFn1dh
         CU2j1xYQKKPrr5rZmW3Wo0UtPGq5M/m4zb83+fuiFaR8i5j5rV3o3gOzFoMRcBv4QOxY
         7GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=geKshak1zwJUIf6OJmXvrC7YdZBGtitn11Vxo6ekyyA=;
        b=Eyn+PXcaK00K6Krb0IIrvBSU5jzXsUglhp5SGS9oYL3HUIxaiWdiIhRlsVr8SKgKrt
         G5O3TJB77v5FoDVcFiWeQ08SHCH/5CBUEK5d6HShy0cBsxc0pBzdKTGpbhffnO+5Q02e
         Ls3HS/R2tf1O7FwJIvlqR2mq6oqhKnv5nOzH1w5wxRDewXKSMa9iNCNSf5/NK9BAwJCJ
         lTNX5AQeItvQ84tWFFFP1AtO7eV+DLzM1TpCA2ort0SQC0Anrv1kmTswfzGDnjqwYI9m
         HKvYtF2PTi5RZvbYIaIIeIx4/yRe0OjxgNjPfSBY9sbRkVEHZrB9VFQ0i2Y3OK7azotR
         2eCQ==
X-Gm-Message-State: AOAM533cqdLBY9qYEPPrUJgUy4C7vlSC0xyeXgYTDks3BZi7PogF3e+S
        9LnxtAPg/oh+/hCXg6ZuVOEJI1fA2N1QBEfv
X-Google-Smtp-Source: ABdhPJzp4+SiFl11hXg8UOEugmLgp6eOUHjNYxsYVthXNxpX+8C9Ahj3caDgh9Ngw0AFLp/1Je3bpQ==
X-Received: by 2002:a17:907:7e99:b0:6fd:c2a2:9620 with SMTP id qb25-20020a1709077e9900b006fdc2a29620mr6120374ejc.554.1652282428949;
        Wed, 11 May 2022 08:20:28 -0700 (PDT)
Received: from [192.168.0.154] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m4-20020a1709060d8400b006f3ef214e2csm1079710eji.146.2022.05.11.08.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:20:28 -0700 (PDT)
Message-ID: <78cc1d8a-e8c4-bb6a-1058-ab912b90ebe4@linaro.org>
Date:   Wed, 11 May 2022 17:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/3] dt-bindings: nvmem: mediatek: document deprecated
 efuse property
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
References: <20220510132637.5864-1-allen-kh.cheng@mediatek.com>
 <20220510132637.5864-3-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510132637.5864-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 15:26, Allen-KH Cheng wrote:
> From: Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
> 
> We mark mediatek,mt8173-efuse and mediatek,efuse as deprecated to
> prevent them from being the single compatible in the future.
> 
> The mediatek,efuse compatible should be used as generic fallback for
> all MediaTek chipsets.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/nvmem/mediatek,efuse.yaml | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 529f5888d93f..04ecf5980b2e 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -16,16 +16,18 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> -      - enum:
> -          - mediatek,mt8173-efuse
> -          - mediatek,efuse
> +      - const: mediatek,mt8173-efuse # Don't use this in new dts files
> +        deprecated: true
> +      - const: mediatek,efuse
> +        deprecated: true
>          description:
> -          Only mt8173 SoC-specific compatible with generic fallback should be
> -          used
> +          Please use mediatek,efuse as generic fallback to enable the MediaTek
> +          eFuse support.

Now I see the change, it's a bit surprising to have it in separate
patch, but ok. In such case, in your first patch don't add this
description. There is no point to add a description which immediately
you change in next patch.


Best regards,
Krzysztof

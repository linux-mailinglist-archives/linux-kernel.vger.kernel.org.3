Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C55236ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245685AbiEKPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiEKPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:17:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30F1F9A3F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:17:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id be20so2898057edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mJWH/lfuqaU5M9ClCLXzwM3OtS13pgUbIbBqib9/b5Q=;
        b=ddJhLrfYUIgcxyKQaBI/0k415nx1UNPNu98YhvgC0QlOY0Ocgejj86nL2/rEb0bAn9
         c40Yx3zPRL28IYuLwUjNLLft35OstKwrmM1bYiJS/ZqFPkRcJtw4MJBo83nyKMYzUqDS
         qV0lGZKiLfZRCZMFLb5Ng9Qa+IAi04kOv5+cudFwOhDVUjd4mC9stNMAqP60/Y31f2oY
         4azTzrSqzsYxT1GynXLkRdUKqN8WX1sQqqK5qxqLOMSWKVeQ3FQDcEO2pDnsqqpoY1GL
         kiHTYB6eyaV3HXxFPi2MidsBU/g+yN4NFoKHXHgVFoAiokwxrrPKlC5DmjDlLnG05rGU
         YBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mJWH/lfuqaU5M9ClCLXzwM3OtS13pgUbIbBqib9/b5Q=;
        b=LWFWcKvn4V3JAum1WWrIWrtQz7i9UrW6qwWvGTEcpe6OqVpNaKfsSlzwmPt830W4GJ
         It4TfrKrpTmXloD4nYMjjbGHh4HIDAw/dV64ZAxptxeiQqrFbNU9wT8VXcOMR29IVRsm
         vWYXcrrbZ1AD6GZsLoAJV08+NqpCJQfsBjjfjjLOuRVo/MoJS2qQHgijn8tdVYK3j122
         zZwnonD4hlunA01aQo1JUh4mGU1ZIEAEQx5E2JR0kSEKBkO+o1u40xll4UXlzq8hLET5
         IWFKcq6cguywviYgpywbbdO9Yr6qJFogXlL1lLzzSCBQUQCITMebHYq2d4EdSmL5fGCn
         y4QQ==
X-Gm-Message-State: AOAM5307KCX2cACAnBmU7ioOsaIjvcUMa5GY+CAB9wbWZhkZZYXrlyQF
        kwlnMCuCo0xkX/KGSMb+Tbzrcg==
X-Google-Smtp-Source: ABdhPJyf1gmEybUdj3DMvkaOP9NhT9SQ+0nnD2P+TaFDr2QIgSiYzka959iRA8NSpHNx7pCTN/VgTQ==
X-Received: by 2002:a50:a6c8:0:b0:428:5b3a:6c99 with SMTP id f8-20020a50a6c8000000b004285b3a6c99mr28532674edc.222.1652282219761;
        Wed, 11 May 2022 08:16:59 -0700 (PDT)
Received: from [192.168.0.154] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bw6-20020a170906c1c600b006f3ef214dc7sm1123249ejb.45.2022.05.11.08.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:16:59 -0700 (PDT)
Message-ID: <53da6771-b7cf-3050-abee-33d78c2ada7f@linaro.org>
Date:   Wed, 11 May 2022 17:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] dt-bindings: nvmem: mediatek: Convert efuse
 binding to YAML
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
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220510132637.5864-1-allen-kh.cheng@mediatek.com>
 <20220510132637.5864-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510132637.5864-2-allen-kh.cheng@mediatek.com>
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
> Convert MediaTek eFuse devicetree binding to YAML.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../bindings/nvmem/mediatek,efuse.yaml        | 57 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 --------------
>  2 files changed, 57 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> new file mode 100644
> index 000000000000..529f5888d93f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek eFuse
> +
> +maintainers:
> +  - Lala Lin <lala.lin@mediatek.com>
> +  - Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt8173-efuse
> +          - mediatek,efuse
> +        description:
> +          Only mt8173 SoC-specific compatible with generic fallback should be
> +          used

I don't see changes here after our v2 discussion. In the past several
comments were not implemented in new versions (filename, title). So this
is one more case where you receive a comment and send a next version
without implementing it.

Can you please focus on the received comments and not loose pieces of them?

https://lore.kernel.org/all/0169c4ac-fdce-29b7-553a-14dc7df532d1@linaro.org/

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100E64F9091
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiDHITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiDHITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:19:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6625C9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:17:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k2so9158058edj.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yuQFl788i69gkuHZnfVhALt8fZsIexOSaYwO7DsFL54=;
        b=gx8vkxt3S763Ala7vzwT1kODYsT4g6h9F/zXUPb23Kp7SxBqah2MLv/qepESsLFEk6
         I0ssg1XGAfLpTdDwbWD4XOyGCf1OaXP7MTUwFge2EkjWfCqDuI9cbnBKQghpKTSNb+FZ
         qQiXqB5C+6GD7/kuW52bYq8t0iaiLUOwEH2Gy5BwrGYXzXXkp7NTwGQcZ2MpnvUUOoRE
         8UllVY1p3GkIjUo9lvPFKOrk+3+oTIFWk3jYgmGy2leoAdfs+MGwaRimWw+KYJ0Gamjn
         j+cp3u90dmMQdHjdkVO7f2J+JL8VKRUppRdrEM545wEFGS7/HXzUyxt2c1TjJNQuTQQ1
         yHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yuQFl788i69gkuHZnfVhALt8fZsIexOSaYwO7DsFL54=;
        b=rGsJkcifl5Y1W9q0iZKMwSrN0At5Yc3WRF3gEQIukKh31g0VMzo2H+07MtDhVFpWf+
         fZgAUpLo/GzHYSyc/7BcT0WhP8ww7pNujIJVGT6Hq3l6FqweB44+VUH8pt5p03SorPbf
         EtFBwouohoLGmKAB+bYi7oxvm2ENvmymiWyp+VIaBbTXAXhq88s2KnfnQrW0hUy3qU4I
         vDDlq9A6Xq12A/VIluC0iX1ZVAwJPIuCfoCe1Ou0A78MG/sHMFGfpLLUE5Wht5oG96Hi
         JIvKYq9olkocYNMsrsrtTR7jZYVrQ8YClrCY8J4sCnHwgujBni7Qsl5jat4ymPQg8lbD
         wkNw==
X-Gm-Message-State: AOAM533PM6wRkv0TmwAgSwr+tOEC6gzA2MCyQnPpUKlAmgBh9f/oJ1A3
        u9pYVn+KDtRt96PwbI509Hcovw==
X-Google-Smtp-Source: ABdhPJx+VdDdTFo570Fvyfw4GeKW7zvLGZVHe5kAq6tSIeQZxQjNGhr1a2UD5tZKmhXqwhMA9rkmDA==
X-Received: by 2002:aa7:d287:0:b0:41d:79:73ca with SMTP id w7-20020aa7d287000000b0041d007973camr8932500edq.142.1649405848011;
        Fri, 08 Apr 2022 01:17:28 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm6167691eja.38.2022.04.08.01.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:17:27 -0700 (PDT)
Message-ID: <855d7daa-45d1-d6d8-32bd-51778cf58392@linaro.org>
Date:   Fri, 8 Apr 2022 10:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: mediatek: Add mtk cci
 devfreq dt-bindings
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
 <20220408052150.22536-2-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408052150.22536-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 07:21, Johnson Wang wrote:
> Add devicetree binding of mtk cci devfreq on MediaTek SoC.
> 

Thank you for your patch. There is something to discuss/improve.

> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>  .../devicetree/bindings/devfreq/mtk-cci.yaml  | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mtk-cci.yaml

Filename with vendor prefix, so something like:

mediatek,cci.yaml

Also please put it in the "interconnect" directory.

> 
> diff --git a/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> new file mode 100644
> index 000000000000..ef4ea951025c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/mtk-cci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Cache Coherent Interconnect (CCI) frequency and voltage scaling
> +
> +maintainers:
> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> +
> +description: |
> +  MediaTek Cache Coherent Interconnect (CCI) uses the software devfreq module

Do not reference software implementation (devfreq).

> +  to scale the clock frequency and adjust the voltage. MediaTek CCI shares
> +  the same power supplies with CPU, so the scheduling involves with CPUfreq.

The same - cpufreq.

Instead, focus on the hardware, what do you describe here?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8183-cci
> +      - mediatek,mt8186-cci
> +
> +  clocks:
> +    items:
> +      - description:
> +          The multiplexer for clock input of CPU cluster.
> +      - description:
> +          A parent of "cpu" clock which is used as an intermediate clock source
> +          when the original CPU is under transition and not stable yet.
> +
> +  clock-names:
> +    items:
> +      - const: cci
> +      - const: intermediate
> +
> +  operating-points-v2:
> +    description:
> +      For details, please refer to
> +      Documentation/devicetree/bindings/opp/opp-v2.yaml

No need for description. Just "operating-points-v2: true".

"opp-table:true" could stay. My previous comment about its removal was a
wrong advice, because opp-table is used for a table being a children of
this device node.

Best regards,
Krzysztof

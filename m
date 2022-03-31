Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50454ED806
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiCaK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiCaK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:56:11 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388340909;
        Thu, 31 Mar 2022 03:54:24 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-df22f50e0cso7664843fac.3;
        Thu, 31 Mar 2022 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r9MO9CjxH2HfDd+vRxfevxhMbQ63nHf2fy/t+/G6Jc0=;
        b=h937QY9LPyg4HH13nvZYx0qmQ5VKURkH9NHhO0hnEC+biUZ+nzMTp/8e3pQinIJXwv
         EvZ9QNhsFAkQAmmvtrAS0O2/qHbG52mf6mXI8r8j+Ohj03nodEL2WOp15IgT01muDFZg
         C3GHkS+2anejUbnNYOlZCIJIwShD9B7RbJ8gc2MdIPMY1eNbEZldItXyrzWZr76yZZ2U
         cBUtZwRL81QmxRuMdkT86/YTIhvs4lyPM+xMFx0ZCiejG9OD7ofSg3Wfrk+gdW+l1c3R
         wXOB/XEzjBb5LPo8OslS452WzlI6ZjmNyBoTAb+AI1NhBNXlpSND8K+WT4l5jCrbdZ9z
         Etgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r9MO9CjxH2HfDd+vRxfevxhMbQ63nHf2fy/t+/G6Jc0=;
        b=GR1zWbNzv24uyPN3UvfysUso3I6ZDyD2u7JNS0TXyTsXhxwnSCSwI+SG8xq+6H4P1q
         qXixo+hDlfa55S4oZjfBR4ycHKyD3kFsi4UbtyFjiGxLgBQaPOutCwV5FXakXqriPd0L
         JXK9Yui4tT3rAo7hbfFCAZChEpO3/2n63u7hBl+0MyNl8ydxNH+jz29wyGR2Yg7IVLxe
         qofzmZR3u1/TbMjko8aVYwKwlYqBQJLjNhiLnkmmT+wu42fuBtNWACTJfNIATcNe9jbs
         FY7BWcWYVDsrkZZJj4ZO96HGd01DCLcKYI8Xjvi5ZF3WYVfBRzvhjmE1wJs2A1Ewc8Sq
         ab1Q==
X-Gm-Message-State: AOAM533rRLetMv+dV9j3YVKYw85x3eOvnfQXgyWD+EJM7xjevCaf5XrE
        EsHYBcIMJdZ8TXqrkktA7DN/pNJG/R8=
X-Google-Smtp-Source: ABdhPJzeYp620vLruglmRKCzBWwVvuiTG66YWc4vci+zzvBDZ356PQ8IORZSh2k5wvNENuSDBoGD4w==
X-Received: by 2002:a05:6870:c154:b0:dd:986c:afa9 with SMTP id g20-20020a056870c15400b000dd986cafa9mr2318919oad.160.1648724063688;
        Thu, 31 Mar 2022 03:54:23 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm12352123oth.27.2022.03.31.03.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 03:54:21 -0700 (PDT)
Message-ID: <aebbb5c8-1d27-5e66-e18a-e2b647bc8cb4@gmail.com>
Date:   Thu, 31 Mar 2022 12:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 1/2] dt-bindings: mmc: mtk-sd: increase reg items
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220330094532.21721-1-tinghan.shen@mediatek.com>
 <20220330094532.21721-2-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220330094532.21721-2-tinghan.shen@mediatek.com>
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



On 30/03/2022 11:45, Tinghan Shen wrote:
> MediaTek has a new version of mmc IP since mt8183. Some IO registers
> are moved to top to improve hardware design and named as "host top
> registers".
> 
> Add host top register in the reg binding description for mt8183 and
> successors.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 297ada03e3de..2a2e9fa8c188 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -40,7 +40,10 @@ properties:
>             - const: mediatek,mt8183-mmc
>   
>     reg:
> -    maxItems: 1
> +    minItems: 1

 From my understanding adding minItems is correct, but you need to add also 
maxItems: 2 as there can't be more then two register entries.

Regards,
Matthias

> +    items:
> +      - description: base register (required).
> +      - description: top base register (required for MT8183).
>   
>     clocks:
>       description:
> @@ -168,6 +171,16 @@ required:
>     - vmmc-supply
>     - vqmmc-supply
>   
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: mediatek,mt8183-mmc
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +
>   unevaluatedProperties: false
>   
>   examples:

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752FD52B5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiERJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiERJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:16:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C9813FA7;
        Wed, 18 May 2022 02:16:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t6so1783093wra.4;
        Wed, 18 May 2022 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AJ/PeRbastM8KtwKP00d5Dtpk6YYbHWpbi26hK6kis8=;
        b=Sb6MUDzpI3Do12SoVOog4trxfn9HkOWzjeJE76NDXkSoA5+fRAmSg1quRuL0EaHHMq
         m6AxmVYU7qZ4kUOuIhQsD2r+4H7X/eY9MdaLsZClCj+chZ/DoiVRhX9q9MC9cVk+qB2u
         rKLz50JW6LMpRFFumwP9Jdf2NLUMxYBb39/m7I1paORnMA76t7UYktiptr2D7kQNW9fM
         Ilp+EyfIAquY2zUojfnFJBq50LF3ol0dyv8ykoL/ce1uU9ZpB3AJf2RGUb5yvijmFIHy
         vhOOAZG3Pzx1dZuw2baXFhCQfbnqUvTEPayqaYHkt2lviWQdjqQoRKNEAeblCa+BKcYt
         CR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AJ/PeRbastM8KtwKP00d5Dtpk6YYbHWpbi26hK6kis8=;
        b=a4XKxsy+u8fWQHs+030ujNOLIKQvfKHQcOX5dwthkazViDlEgysV0a+cQHNED8iIOe
         bDsguvUsALfhzx9cyDVL49kyb8mGRtFc27P7t70/k6rNDXX6Ttv0KEGo9M/E/xIcWfv0
         TXd8Gr4rJKBn7/gVF779S5tIAA+jzZ8WgsyaoD2Cel8PUaPrc1XsAPWQFyOxq3pU3jkg
         gYGI8yeGAPEfrxTWVIobtniHX6+aDcunIgKcRX+0tJAIFQL3g+p3YiV+pvFzMeBsg+Tk
         WSSW7jIjNl5gihA/1jM8Jj1QHItbWGLsOxa9DFlABgPrEbKlPApUTl823LDCW6Ng/n7g
         fb3g==
X-Gm-Message-State: AOAM530syC9Z2OKC14XH7X+G15H2l2UwDbGPgYNPdTUObMl9n7NHkoWr
        /W7Jj4EG1aQF+tKtiEnpsv6vg65sFt4=
X-Google-Smtp-Source: ABdhPJwEWT0S1cQNRyp2Os4DAQEhukNT425BpsOswVM115DyQwaHDTQ4H/1aAl9xuumtGy5hK18drg==
X-Received: by 2002:a05:6000:1a45:b0:20e:6164:d86c with SMTP id t5-20020a0560001a4500b0020e6164d86cmr1405752wry.561.1652865390262;
        Wed, 18 May 2022 02:16:30 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c1d9200b00397122e63b6sm1227595wms.29.2022.05.18.02.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 02:16:29 -0700 (PDT)
Message-ID: <ad4aac8a-ef1b-d4eb-7045-a46bd39ad3fc@gmail.com>
Date:   Wed, 18 May 2022 11:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/8] dt-bindings: iommu: mediatek: Add mediatek,infracfg
 phandle
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 15:21, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..78c72c22740b 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -101,6 +101,10 @@ properties:
>       items:
>         - const: bclk
>   
> +  mediatek,infracfg:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: The phandle to the mediatek infracfg syscon
> +
>     mediatek,larbs:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
>       minItems: 1

I think we can squash patch 7 in here. Same holds for pericfg

Regards,
Matthias

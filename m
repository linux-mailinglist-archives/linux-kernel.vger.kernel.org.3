Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628AC50BEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiDVRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiDVRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:33:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DAE2B2F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:30:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 21so11251657edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HNZdGuTlB4ZyqdNx0zZ57VA5IMyL05uRbRN7pIK/unU=;
        b=Cpl1dt70H22hHb3a2k1F/gZybtWw8PyK4eyMjsQQl0/ADKOTqNg2NeU3zNTfbl72Mi
         RFz6P9DN+6K2ISa+Al6MARv2R6WgSTO+ScXPKeDRNEzeGHrSIVYBdykS//l8W8Jmld75
         xX20GzzptN1Wq7caPyUSIX2LosdIWn3JaaXt/SzsrV23qvimMx90F6gaQiY6wd6Y4789
         TFkVxrJEEublyn1TvmLSC/WmlH2eVPq9Ynp4dQ36X6QRA7AbFbh8GhiwkqrTCif1WXAO
         QFBkGmWaozknYFoz1garLCKHmerRkgk5+voQnFGvZlkziiZpjMhHZ04gYNP+JVt21KNT
         t7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HNZdGuTlB4ZyqdNx0zZ57VA5IMyL05uRbRN7pIK/unU=;
        b=hgfNCWOQaYpB7k/jpFtZb7ixN9Ad7nbJerA6l43VB3PjjZk/twTxGyHYlcsZox7/oD
         19LD0hL5tAFoukhSd+eUC2fpJVYAOXQWaW9vODs6AZe7ZjNeUXhZsM94+WiEi5sIHx8P
         zVbOgOCCEHvCMgWn2EtHGG+TRYjDHkcbgokuPgbLvRdGaqWIW0cRU6V6eOh57GAqJAlA
         mrj+zxuavtJmfuT9PKmxRcXCY9DyVFycJj79lYKLqFJ5oa7gZE8PWUrzs2t8RXJQ+zoz
         7QcYPYcdItEQha0MiBfIca56YDW33+nSDnP6ACi3aBsZMxX56pE6yWM9DjwXDctT03ll
         Ftsw==
X-Gm-Message-State: AOAM533I1Z8pXASB3KllQrVJuDlLRNBM5ceWE5jU4pldDXihwMEBEiiD
        LuwTElCctvBL2xC3L3fPZG2Paw==
X-Google-Smtp-Source: ABdhPJwuFz3R4GDMR+B6w7XF06kzjDOus8Sj9fbqhs9sCpzbm0EvLdbLOHqYo8h0m41JFU4Qqn4CYg==
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id g12-20020a056402090c00b00415d3404ae2mr6053079edz.331.1650648402270;
        Fri, 22 Apr 2022 10:26:42 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm944012ejt.50.2022.04.22.10.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:26:41 -0700 (PDT)
Message-ID: <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
Date:   Fri, 22 Apr 2022 19:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 01/14] dt-bindings: cpufreq: mediatek: Add MediaTek CCI
 property
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422075239.16437-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 09:52, Rex-BC Chen wrote:
> MediaTek Cache Coherent Interconnect (CCI) uses software devfreq module
> for scaling clock frequency and adjust voltage.
> The phandle could be linked between CPU and MediaTek CCI for some
> MediaTek SoCs, like MT8183 and MT8186.
> Therefore, we add this property in cpufreq-mediatek.txt.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt         | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index b8233ec91d3d..3387e1e2a2df 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -20,6 +20,11 @@ Optional properties:
>  	       Vsram to fit SoC specific needs. When absent, the voltage scaling
>  	       flow is handled by hardware, hence no software "voltage tracking" is
>  	       needed.
> +- mediatek,cci:
> +	MediaTek Cache Coherent Interconnect (CCI) uses the software devfreq module to
> +	scale the clock frequency and adjust the voltage.

Devfreq is a SW mechanism, it should not be part of bindings description.

> +	For details, please refer to
> +	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml

Since the file does not exist, I have troubles reviewing it. First of
all, you already have "mediatek,cci-control" property in DT, so why
using different name?

Second, it looks like you want to put devfreq into bindings instead of
using proper interconnect bindings.

Best regards,
Krzysztof

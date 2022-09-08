Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA25B14E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIHGoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIHGoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:44:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BBD074A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:44:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bj14so11055782wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=b1chxNIA9RagmiiPQ3s0ZgKMM+t+BegCoFA6aXi2sCQ=;
        b=jeKC50xikkVr+XUBcWVw7YZKtH76yHzg6jBpUlm2TN2zSwcymPnD85WGsIDmQw/Bsf
         RBeosEnMZJr4LV/hmfDDMEzkAJwkg1UgmAnzNZBSGKDhXaj+KExW+G0BxqAWNWzupZZb
         /imLfb3UJzBFk4qm5eGD+CcvrXqPRwa7FubEsU6ATiS12x5ryfeuG1MxmJb6RmlY9Fpt
         U8JmDuCFaNRzxqSMxqtAVgZoVSgWs147QP0C1uvlR+oua8f63fB3CcM6pqIEYo7dT8kI
         0TIQOdE3XDeSb+97TyIvDtlqRAUrDsKIKWhPy5UjYW1EJ5l4Q7SibZdFCjz+iAR82bDN
         FfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b1chxNIA9RagmiiPQ3s0ZgKMM+t+BegCoFA6aXi2sCQ=;
        b=3h95vtdrU5nLGBuWN0Viwg/lLguiZk/Lsj4VF8Yz4TNVWrKgX/3YO+MwnHhn8emTSA
         eFBT3m6HGprEKmalx7qY5G3oS0p2OiPc8G4WFeQIVhFq3Hw5qxg1pjMAmIRG++/khhlq
         cHSKXblffj9bNUNK0OwjIZhyP/rV42RF+Mw3juir5tdNPzKrdaG2RS/F86H+nXdX/WHa
         ba387KE1njDsnHj1QD3Y6SXMtlI0uvUWPVRI4CfbqiFuOP69P0Cro5RJAYwTyu9mXl3g
         gZ01ICEPe2vdJ7iVohnbUXTb7nddQIZj4EYI2r/b1J3L4UN60MyZ0S57TOdxpjStfTwu
         6Cgg==
X-Gm-Message-State: ACgBeo24oFsezqM1rsUN9l47bXCBwgukGfcHBTda8OrI/IoZGrHCSpr7
        ajFqZzWt5iih8Zj/dOY+2n9xhvj9haCQVg==
X-Google-Smtp-Source: AA6agR7Cp81jZgWnP23GY49qR/Z2d7YmFLYivEyV79iG3OySTF/7KPstfBIxLMAITgWkKhp/wsdIKg==
X-Received: by 2002:a5d:4d0a:0:b0:228:d9c0:5abe with SMTP id z10-20020a5d4d0a000000b00228d9c05abemr4213510wrt.693.1662619441727;
        Wed, 07 Sep 2022 23:44:01 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id v16-20020a5d5910000000b00228a6ce17b4sm13414688wrd.37.2022.09.07.23.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 23:44:01 -0700 (PDT)
Message-ID: <1f0f036d-2e8c-d95b-5cfb-81a1b538642a@linaro.org>
Date:   Thu, 8 Sep 2022 07:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: allow compile testing without
 QCOM_RPROC_COMMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220826093711.1059319-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220826093711.1059319-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2022 10:37, Krzysztof Kozlowski wrote:
> The Qualcomm common remote-proc code (CONFIG_QCOM_RPROC_COMMON) has
> necessary stubs, so it is not needed for compile testing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied thanks,

--srini
> ---
>   drivers/slimbus/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 1235b7dc8496..2ed821f75816 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -22,7 +22,8 @@ config SLIM_QCOM_CTRL
>   
>   config SLIM_QCOM_NGD_CTRL
>   	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
> -	depends on HAS_IOMEM && DMA_ENGINE && NET && QCOM_RPROC_COMMON
> +	depends on HAS_IOMEM && DMA_ENGINE && NET
> +	depends on QCOM_RPROC_COMMON || COMPILE_TEST
>   	depends on ARCH_QCOM || COMPILE_TEST
>   	select QCOM_QMI_HELPERS
>   	select QCOM_PDR_HELPERS

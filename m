Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4251E6B9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 13:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446304AbiEGL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 07:56:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD284EF63
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 04:52:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so18799345ejk.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 04:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ajtsBto4M6/1BH0JjBBk2nEBGrSVElvTMA5sakoQJlc=;
        b=u3vFVBJbgUKqlTx5RX3kzq8CO3pJ4eeecZFI6XghIayebNTFYI4u4Ywfh51fV10dmH
         /S2vwbYTsJRDRx2qO3Hgh6KGDtzqPVUDa3E8YKpCT4gXTpShiBdTiYMoJ2MgdNHyIIUD
         Rg9KwKur5RhaMBAkAY2OodhJYWrs0cftlR6jgotwFueu2HHvmvK8mSS310A5xCiK948X
         rPefSyx24ohvDk1bY7BsQ4spFvQ8+MdxIgbAyhasgvqwz0Jt0vx9NR5HtwPv07MmvOm3
         YZLCCU/Ss0eiupJ1Vhi7kT/l0pIQQq6CQCJ8O8pcR/WlNqDKZ/fF1eNoWaxWAxzKQbQ1
         pJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ajtsBto4M6/1BH0JjBBk2nEBGrSVElvTMA5sakoQJlc=;
        b=cqWS/CgPibMWhT4ew6A3xdMOvWx2O9dB2oQZ+eHF5Lg2tlKZl00JzwzYL+R3kz7SbP
         GSXWe5crSWohKCfI2B5i+TZ+YPy1d8PrdI19LupYFvb0SoksrHbgqrdVgtZWRn28BbXf
         gAo8FJxYotXl50NDUp0KR51D/r16CrcB5u8mCCvUmJg8yVmJ7ae/q0jKrG5xm3HWxRBu
         phj4SYJ7gK/mAw30HhBvdUhf1jNvgek0BkhjUWE6K+InM/h+a+x4c5lPbbYh0GVyJAbo
         oo+pgcYJ8Bt+9XSnGyQIGqmkcWMIdmNUHqSab1vVQoap318D/8zLvI+UqI0W8FVVeWqR
         Qbbw==
X-Gm-Message-State: AOAM533qNJ2/XbBCY+aYMLQVj+e5BF8dEJEZHWMqUkgXCNSgEcUMxydh
        qE1i4VHCqcvdLoYFkfqFtZOCqg==
X-Google-Smtp-Source: ABdhPJyeYvSqSNs3aZ9gaHsp/pCMclyImzTF2IRZgx996MzZPFR936QCgO/EnELruocqivY9DSnUyw==
X-Received: by 2002:a17:907:3e0f:b0:6f4:5cfd:e6bb with SMTP id hp15-20020a1709073e0f00b006f45cfde6bbmr7050817ejc.38.1651924337783;
        Sat, 07 May 2022 04:52:17 -0700 (PDT)
Received: from [192.168.0.231] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060dd600b006f4512e7bc8sm2925688eji.60.2022.05.07.04.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 04:52:17 -0700 (PDT)
Message-ID: <a5b88103-16e2-1dda-3469-78887f91c88c@linaro.org>
Date:   Sat, 7 May 2022 13:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220506154116.365235-1-matthew.gerlach@linux.intel.com>
 <20220506154116.365235-2-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220506154116.365235-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 17:41, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add device tree bindings documentation for the Intel Hard
> Processor System (HPS) Copy Engine.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3:
>   - remove unused label
>   - move from misc to soc
>   - remove 0x from #address-cells/#size-cells values
>   - change hps_cp_eng@0 to dma-controller@0
>   - remote inaccurate 'items:' tag
> ---
>  .../bindings/soc/intel,hps-copy-engine.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel,hps-copy-engine.yaml

There are no files laying around in bindings/soc. Each is in its own
vendor subdirectory, so let's don't introduce inconsistencies. Intel
should not be different/special.

Best regards,
Krzysztof

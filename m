Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC54F0491
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357379AbiDBPrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiDBPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:47:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188B160465
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:45:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qh7so1627364ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hia4z0mt/UHcbuh1pWZ9Sjm78iTsXdI9nBZvSUy1WP0=;
        b=XhSEwRAKPqWTxlKJGeWlipGwbyoDCbUjcpakjyHczOKOzlsnAXL6KcslWCIIJIOlhS
         6H/9SJ6zm2fi1G3LmhCsaOtKN8ZyfFZskoIp6dVT/HkM9dGNLps8oaMBZ/EhLgn8lYZ7
         aaupip/PipRa9Oa2Ad3tg0Z9jA3rjw3peZ01c8ExU7JVX1zgs+brrO8DlZjapyXREGpZ
         pRklrWaQBGdS43sfF4apVOxSoVelb6lAtJ+IcPg+Eo3gwJ4UIns3Aj9tGYsFyR3lmZbH
         UgT/WO4dYneIUWGFJRu/z6/yo95K2bRi2qxA4j47jhY4yl3HRigPXGcBvMVDULPi5Ui1
         rADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hia4z0mt/UHcbuh1pWZ9Sjm78iTsXdI9nBZvSUy1WP0=;
        b=PJKhMmuk2RP6Y/T86l4rOlkziaTtzoGAOwN8smWtMjUSJoQI94SANtmVdIqsNitcLP
         QAB6xQ2qsaz+SGrWPY1S6j7MdczU92GFPrU0kQ22S80S77/V36v/KV8DWg8jO2M0uhwc
         auRyG4VyJOvLPWNKXOKLdOw51yoqS20y0ItGnAxD1OjytuaiwI/3VUAMvqePc+er6m2O
         x/SZ1inVv7k6QUsdJSfF7pQ5Eapl5TPGscKPg1nZoeg35ibCqzJH5V79ptQMbsVUfDnW
         phZBrJ5DO0EqcqSaKVPdN3L9mq7+ap19EvpA2wrTDPd8GsmjzAAC6kqHYg+vt9Yncvvd
         bzGg==
X-Gm-Message-State: AOAM530T1zcxALchSqarD5zKpPMSH88zQuzDFF1T36kP+2DFIPLsHN1c
        vECxIFzyBG4dBE8aqUyhDwte8A==
X-Google-Smtp-Source: ABdhPJxPiHzMs0OqQ1LDOy3rGnJTT0bKNrBQ43F2LR5JkJdjTY7SITk36isFMjj3uA87WjfxuskqoA==
X-Received: by 2002:a17:906:6a81:b0:6da:d7e5:4fa with SMTP id p1-20020a1709066a8100b006dad7e504famr4303477ejr.223.1648914338465;
        Sat, 02 Apr 2022 08:45:38 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fq31-20020a1709069d9f00b006e4b8ca9675sm2254416ejc.19.2022.04.02.08.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 08:45:38 -0700 (PDT)
Message-ID: <07291648-9541-c559-eb47-0936e17ff254@linaro.org>
Date:   Sat, 2 Apr 2022 17:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: soc: qcom,smp2p: convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20220401171035.1096670-1-krzysztof.kozlowski@linaro.org>
 <1648907211.818465.903498.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648907211.818465.903498.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 15:46, Rob Herring wrote:
> On Fri, 01 Apr 2022 19:10:35 +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm Shared Memory Point 2 Point bindings to DT Schema.
>>
>> Changes against original bindings: enforce only specific names of child
>> nodes, instead of any names.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/soc/qcom/qcom,smp2p.txt          | 110 -------------
>>  .../bindings/soc/qcom/qcom,smp2p.yaml         | 145 ++++++++++++++++++
>>  2 files changed, 145 insertions(+), 110 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
>>

I'll fix it in separate commits.

Best regards,
Krzysztof

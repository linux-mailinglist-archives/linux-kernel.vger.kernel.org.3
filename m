Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7E5A90F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiIAHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiIAHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4711BE0E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:43:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k18so10599908lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k9XuDD0vqkOIaKi+LeJ32PQTkTXPXsRWyVWQBX1lDD8=;
        b=xY3EhlHSJKPQvJOOODqNP4JsAWNN+CtXBoSImVMQ87lYvqVSnIEivhogqrAQ1ESr6Z
         sHlBkXKiSc8NNf/6Ozl22W79LCLLbkgW/2GvS4KLZw0iIsBMMM4baWRCNvgggW2i1FQw
         osKOHCkO95GdXo1HgmLOuXFjKUz3ntGZbgAP/FFneOvfSbGSVW9Ttzg6gdmRFp8sNIUd
         vflxjZgJspDDzvkXzY8B42qnEqrnfYL+Fe5qyeqSRWGSdfM14SKUF3WV+tBCcOz97aOb
         Q01cNDgRmBSjsam8C+/mAXvuaRrkWRN9enuC2UWvEu19KMV4meia3r8Xr8zyBkUkOteQ
         ezfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k9XuDD0vqkOIaKi+LeJ32PQTkTXPXsRWyVWQBX1lDD8=;
        b=lM4hxq8RnZdWSRa0aUfCGgSNlQq8TZUjHM5gC9kflf09GzLPE98w5VhDRqQeqJ8L1+
         7Z8+fYZZiJdir8Zd1O+2l6xlc2l3SKM7kcMi5qioeDfcU8g13P9qtZvzR4oCDGbN7Hya
         5ZZHpKuPTOAlZiURYq19Ia/gDh7MWEYx3d5ywdEwalxp9xvkgb+Iga0+V68T+T4nKUnz
         JgF26fXw2O+hU3n8psBJ0ZJhJdlh2gLrVit/6+RH+EJzgA8WRG9yBpK2C9rYj6kOp3EM
         dai32s4Oqkp6k4hLs5FdTagLoYzg4KEylrHE7wqOj/fF8a3isVWnaaZZ5E9ANw/jqhCm
         IFqg==
X-Gm-Message-State: ACgBeo3O8jesvD3ImI0M66F7K4lJabwaG2bRTneiRaG6peNpWNtsAldf
        2UOKP6+rkoxVZydP52FqtY0+iw==
X-Google-Smtp-Source: AA6agR6sfrEyLEdWFHZ17zqLJU/xs7tzndddd+05d3j98ti/W9UYi4/DVjj9fgaCYXu7f6gLdbnQvw==
X-Received: by 2002:a2e:84c7:0:b0:265:1210:c31d with SMTP id q7-20020a2e84c7000000b002651210c31dmr5017607ljh.333.1662018225894;
        Thu, 01 Sep 2022 00:43:45 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 6-20020a2e1446000000b00262a156db77sm2388476lju.56.2022.09.01.00.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:43:45 -0700 (PDT)
Message-ID: <37fbaf34-d811-633e-44db-6cec7a2262c4@linaro.org>
Date:   Thu, 1 Sep 2022 10:43:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: i2c: qcom,i2c-cci: specify SM8450 CCI clocks
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20220901074218.21108-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901074218.21108-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 10:42, Krzysztof Kozlowski wrote:
> Document clocks for SM8450 Camera Control Interface I2C controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Based on:

Explanation: by "based" I meant what clocks should be on SM8450. There
are no dependencies so this patch can go straight to I2C tree.

> 1. https://lore.kernel.org/all/20220901073504.3077363-1-vladimir.zapolskiy@linaro.org/


Best regards,
Krzysztof

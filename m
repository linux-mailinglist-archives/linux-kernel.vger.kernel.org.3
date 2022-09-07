Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AE5B01DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIGKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIGKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:24:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CBD9B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:24:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l12so6972404ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sjy4Jxxxofr/CNtkGo5BunwXXx20LZ0tjJE5uoNvdEQ=;
        b=OGIExj4MjF/TqRB81wkACNnrGKX0bsArf1wuHu+JuLcWpZFBEH/FUO3li6w7en8MOc
         BLUuPzWcKWHu0qkvn4tyyDD35IMJCiPA7kKPIJK/exdObqV1PKYINtL6jklXYs+e6dXj
         F7o1U4W5BNFBcwAv+6CnfLHtMwchNpTO7HnZ87n+zxPlDjZf3x7Ik2H8iWNpXE4+7hmg
         Z7aY3wk5FxM2z9e+KwbcGpO5nUaxq0kXVWtnC3vuSoEEzfC3GF5dDBe6LEvvKCxH/28x
         tQqe4FM+4AdMY5NY0TA5lHOQNZN+Ssm8LnTdaSKmCeGKektk437RS3cB6F/hiOs8LzRd
         igag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sjy4Jxxxofr/CNtkGo5BunwXXx20LZ0tjJE5uoNvdEQ=;
        b=W1IuwENWEfF/gdV3TZ6gdyQDmaNjqv+ZTU8RNjst/dSxl/9Fc7+uZBoo0E4BBUl2On
         m5A/Z6nIsr2cegivluMCqYu2wYCupAAwLtjt0hncdjf465k0N7se4CevkSna3+tW/KdV
         QXQGgIrOELssVUE+Xl3tiqHJMtRzM7tax8CIZSRd8XvLLboHJ0YFYUx+NYfdEOy4lLI7
         juWIyRnLrwaYULAIplvNHmxcHssE/R0ceL/AMBMpXsjzjSWy7jBiqTq/fs/XSzN9ZgQD
         dFHXqjyY+BNIUY4fY/ahjNjeiXAjhXciU+xj1VNKhgw4UjkuTb1OnHYkTd8MzDzg2aa5
         Yfbw==
X-Gm-Message-State: ACgBeo29Q3CgnDKEIIo3ux85Ya5Hbt4VaXSpU4rK6ompB6EBv5Fln4qw
        /9+6wVWE16z8dDi5FMerZICcjQ==
X-Google-Smtp-Source: AA6agR7LrS6Wpr0G0GMNseZ4mqfHBTC8LHNpanhfuhXUqUCYOVOmftOUiwx4o+SwlUSvSCvYDrDtOQ==
X-Received: by 2002:a05:651c:1542:b0:249:5d86:3164 with SMTP id y2-20020a05651c154200b002495d863164mr784613ljp.500.1662546274641;
        Wed, 07 Sep 2022 03:24:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25111000000b004946c3cf53fsm2375739lfb.59.2022.09.07.03.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 03:24:33 -0700 (PDT)
Message-ID: <115bb541-57d1-23fa-d365-4e239f933d1b@linaro.org>
Date:   Wed, 7 Sep 2022 12:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v12] dt-bindings: misc: fastrpc convert bindings to yaml
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20220907074301.3996021-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907074301.3996021-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 09:43, Abel Vesa wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Use compute-cb@ subnodes instead of just cb@. Add qcom,glink-channels and
> qcom,smd-channels missing properties to make sure dtbs_check doesn't fail
> right off the bat. Correct the name of the parent node in the example from
> smd-edge to glink-edge.
> 
> Since now the qcom,fastrpc bindings document is yaml, update the
> reference to it in qcom,glink-edge and also use $ref.
> 
> Also update the MAINTAINERS file to point to the yaml version.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

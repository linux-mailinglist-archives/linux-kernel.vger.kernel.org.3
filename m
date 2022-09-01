Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71925A9173
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiIAIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIAIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:00:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292382CE1A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:00:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q7so23229617lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TynraYZmwvnsyP0c6khsKu+S/6tBJIR8e5bMKJ6KpQI=;
        b=oKVyHkYfy/f5Lcd+nOZsgltMvSyQfK5wgnQxF5IPy9427BkVcPGdX0QF1PNeaheT8Q
         NxO+wERj0tuhG3azt88PDrCol16RwmrUyVUm8Tehd0lHorjXfRhIzmWf8IYTStBpxMhI
         bqRJW0DYEUsZB2A8uyqkVKKmEuO3uaYTNpwoTlfnqGse+th9WPwMB+6wbNj7yCpCxyHC
         z4KGo7VDS3Zw9zP9Zs04KQbYSAqPl80AwOP+odz95CUmqm/ds2/72SmGDMilKSpkNQpN
         D2I1/b47jOJbxbOIRhmpD2wc41J/Iniwb24SLZSkrkoVc0mJtMyHdxT2A7aSq355vOfk
         hIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TynraYZmwvnsyP0c6khsKu+S/6tBJIR8e5bMKJ6KpQI=;
        b=gCCPho10SEDUvB1+J2YxS1LObAhJKMZ+MhZ+NMFzrJuUJq9XtYgB5b+4CwG9Jna6ur
         n/lL/MzzHL/hIAs/MZBavNbpJ4BgN46/1svqUtb95QxE6IRQlMftui0ne7HTnLWb6KVF
         WFR+dJbveNqnD0oX5B1OUWQuZ36DK6PcxMMWoFt2l7m5xVV7wuUnhRz1DTnD78lXKx5n
         GfK5BU61ArtMCBL4vHHp74o76H2Dkc2rgAcgXxlmFMf25wex8X1MsnbfWV05KYfL92uD
         k77a+GudGIDmXbyXTX3rxSgZu652snJ33AcFoEeM4iWaMpYq/aamTXcWjfibkkYLA3pa
         9cng==
X-Gm-Message-State: ACgBeo1g6BPL4TTxnAMpUlzWRGFPevq3mdaMUkdzHcCSLuReBeDXg9HZ
        HBuQSuXKYD5EeCE/3G58fipEFA==
X-Google-Smtp-Source: AA6agR7VAAayYfcPKyaCg7MjMFPpUP5L/6MhupsHausfoFm+pP4AMIV8Lu0e9pqjqsjz5Ad30138dA==
X-Received: by 2002:a05:6512:1043:b0:48b:2d4b:a13e with SMTP id c3-20020a056512104300b0048b2d4ba13emr9855805lfb.19.1662019221504;
        Thu, 01 Sep 2022 01:00:21 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t7-20020a056512208700b0048b13d0b896sm1413866lfr.141.2022.09.01.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:00:20 -0700 (PDT)
Message-ID: <2f77e732-eb67-5b26-e695-610072c48976@linaro.org>
Date:   Thu, 1 Sep 2022 11:00:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for
 Xilinx Versal QSPI
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     git@amd.com, michal.simek@amd.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, akumarma@amd.com
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
 <20220901054731.7705-7-amit.kumar-mahapatra@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901054731.7705-7-amit.kumar-mahapatra@xilinx.com>
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

On 01/09/2022 08:47, Amit Kumar Mahapatra wrote:
> Add new compatible to support QSPI controller on Xilinx Versal SoCs.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index ea72c8001256..b28a8c8f5e11 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -14,7 +14,11 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,zynqmp-qspi-1.0
> +    oneOf:
> +      - items:

This does not make any sense... oneOf consisting of one item, list
consisting of one item as well. I think you wanted here only enum.

Best regards,
Krzysztof

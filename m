Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A105B17EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiIHJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiIHJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:00:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE87C59D6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:00:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c10so9592648ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bRBzDNDZLzv9UJCk3Wx7AYfPsPJcVru5b+XWpQnJujA=;
        b=OJ0kd7y4Qk25sLvJTzNs4SVpFXy+mKQnfTPJTf4vhSfmZT2hIMrpSl5l2I2GMpmlRD
         czVVP+j5N00m16aJvNLfrOEM7LyI3as3BgR0pMDuqFKNsnKOpcj3C0A3DeUgBo574tXC
         Q+mzj9q14thP6K1Nv+AkSKKS9VGxbPh4UXzH9obICdjhghD2bj/JE0D7Ag+a/XBqMj+x
         N7667lk8ON+EXm1AKFarqrKuXScH7uvtMPgjcE3YqQMxdGaXATlev/vTkcJ25m7ZE4IS
         rM8S/qit/gygz+cyyZ+REeZgv42AVXF03w6g93ogFFIJfkb4wLmDyLkjNg/d2FaTtqU3
         iyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bRBzDNDZLzv9UJCk3Wx7AYfPsPJcVru5b+XWpQnJujA=;
        b=7CTrcGfkDMXKhLi4wrVI8yH//56cx8++GjsQ5ObInRkIIQbf2qzTWXoULEse04g8Pl
         0SoMAn5aCOvjVeZ8cCVdY4iK3m5GJbfnU3QMsqXfrBSTQZr2D77o0xAF+5qrKvO8JaBc
         KnB7D7t5q/PgOae9nE68fjHc/9J8OzMd73u+eq0I8wDjISodbc+L3IsLiJpI67okimhC
         nkwFJeHUxqKiv3oApLwqY5nR2TN/3P3QZ+jq1GwR5hTdikGUXGUdUg0WZBO66MmxEMrD
         TvLjRVPRI3/DR3eEw0/YBLwKktIewmPJeMTVRDw/PVUUYKA9T4bu7SJazhofIEpo4C7E
         VASA==
X-Gm-Message-State: ACgBeo1zDHLFnAyjXPVVCla2QB9IHHV5mdYf7SXO/UA1LtPLjEbybch8
        cXfbwxJOC2UBHeIE0heLhXK3rQ==
X-Google-Smtp-Source: AA6agR6GeXAe2u8wJTc0nXwkpyaYe9UEo7apCpdZRtFIjJbJvFB2a5guBfWf1wyUWLKqY7mQgGdF8w==
X-Received: by 2002:a2e:bf21:0:b0:266:2be3:61e8 with SMTP id c33-20020a2ebf21000000b002662be361e8mr2085789ljr.383.1662627642649;
        Thu, 08 Sep 2022 02:00:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a25-20020ac25e79000000b00497a3e11608sm1135167lfr.303.2022.09.08.02.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:00:42 -0700 (PDT)
Message-ID: <2a20836c-f8de-6705-cdda-6fea929a0212@linaro.org>
Date:   Thu, 8 Sep 2022 11:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] arm64: dts: qcom: sa8155p-adp: Remove unused properties
 from eth node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
References: <20220907204153.2039776-1-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907204153.2039776-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 22:41, Bhupesh Sharma wrote:
> The 'snps,ptp-ref-clk-rate' and 'snps,ptp-req-clk-rate' properties
> are not supported by the stmmac driver currently, so remove
> them from the sa8155p-adp ethernet node as well.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

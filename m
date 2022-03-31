Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41774ED56E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiCaIZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiCaIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:25:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F0AA023
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:23:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bi12so46557277ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dq8MH9owPalNoE790NJ78mjvgtH3i7GUOFDcmGYkiNI=;
        b=zC8J+jsCP8GBgIV1dg4280d051BMUkw14jvIAPX6FX74XfgmGOMhC/3EvKZ4n/D2Ev
         ifoEWb6tBG0tjvI6DVcScsUdHXd+vPk//ix25xmT9zRiE6RPIdeWGDZxRD8KdKx8w7y8
         Okuav+yBIaSWElVnAFlvdB2jE1ik2unSGchHkh3fKOn03GEul2H/42YENDooCXCX881E
         Et+tIpD8Bwzpkubd2mON0a+dfgIgKYz4okqH+J1bLpYztup6hDh9EutizHteTXeY2gmz
         H66kJZptha0LGozRz9qClrRQTCCMd7GO9/JmG+rfnzzWmJOmalus3xD/zjF9wVbBhN5j
         rPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dq8MH9owPalNoE790NJ78mjvgtH3i7GUOFDcmGYkiNI=;
        b=YJhGoX3Lg2pZAMRGOJcia0cuN/5hCCBX5hJV8Ccq4+cy2DOIgsXWys+uyuMoNp+rHd
         MlXDKmgioS8HWjeFfX+l7Qf+TLDpbV9NywxWmpDjL2jjB/3FodCCgYQOtdUfTRsL035J
         +cUZ7kVym3EWr5MUKDaRoVaQj+YbIdZLi/j9U+3pFy49l9k4g+tUT2/IJRAEfCqlsSWo
         0AlaCeCW13KMe7v7z/nQ0NQVbET8fHQpsTQqtIlsrmyn6CN5RmdEd1Vz9BHlWgPFrcVi
         qBygfp2U6MMEg4opnEGzquyL4wfgwjhlb69eGdPJo7mQV4lj1t4PpgYuuCRCVJe6ChSy
         to/g==
X-Gm-Message-State: AOAM531dxwdms28OoQ3be9qhd4vu/5p1Xql4Bd6/Qb9oGCji1s2ItiW+
        Znu9G3R3rAIf0ytvw310od9hCQ==
X-Google-Smtp-Source: ABdhPJxa9OvJVcjcn0Ko1P15Ke3xBtXhTgUulbtKmsRbDdYifKKquk9+NHcrPDRyT7IoQqmrxLFOMQ==
X-Received: by 2002:a17:907:3f07:b0:6e0:2fa0:2482 with SMTP id hq7-20020a1709073f0700b006e02fa02482mr3857385ejc.766.1648715004854;
        Thu, 31 Mar 2022 01:23:24 -0700 (PDT)
Received: from [192.168.0.165] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm10709564edb.27.2022.03.31.01.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 01:23:24 -0700 (PDT)
Message-ID: <15b3d34f-2a91-6dd3-8335-9ccd0d5ec70e@linaro.org>
Date:   Thu, 31 Mar 2022 10:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] thermal: exynos: fix masking value for exynos7
 temp_error
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220331071833.115732-1-hypmean.kim@samsung.com>
 <CGME20220331071809epcas2p472298073d4aed0a8026d4b08967c5de5@epcms2p5>
 <20220331072843epcms2p5c9e7ee4756d1aa267cf4af56b0ca22fc@epcms2p5>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220331072843epcms2p5c9e7ee4756d1aa267cf4af56b0ca22fc@epcms2p5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 09:28, Sang Min Kim wrote:
>  

Unneeded empty line at beginning of msg.

> Modify mask value for the temp_error in the sanitize_temp_error() function.
>  
> Fixes: aef27b658b43 ("thermal: exynos: use sanitize_temp_error() in exynos7_tmu_initialize()")
> masked temp_error2 with EXYNOS_TMU_TEMP_MASK(0xff) value even in the case
> of EXYNOS7.
> In addition, when entering the if statement, both temp_error1 and 2 are
> masked with EXYNOS_TMU_TEMP_MASK(0xff).
>  
> By modifying to use the previously declared local variable tmu_temp_mask,
> the mask value suitable for the SOC can be applied.
>  

Fixes tag goes next to other tags, so usually before Signed-off-by.
Check some existing commits for examples.

> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>

You received by Reviewed-by tag, so you should include it in v2. Don't
skip them.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> ---
>  V1 -> V2: Add fixes tag
>  
>  drivers/thermal/samsung/exynos_tmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  

Best regards,
Krzysztof

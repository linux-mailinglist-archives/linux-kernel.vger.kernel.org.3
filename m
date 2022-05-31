Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE5538EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbiEaKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiEaKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:24:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DAC8723F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:24:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b8so8905292edf.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cnCfdad+VcUS50IP3p3NEnuKjW89LxUxStJ50/hSvN4=;
        b=nNI2nsKNIpJPEgTlVDq/ZTSXRxUjC285aNzD1WitJuQxr4hMT0rO/SrQ6Y5UlNWjC7
         qKhe9NgwAtI2LtTFBSQvCXTQrdt2udPDb6ehbUa/z70LuOFsVCWBa+/x8+9vM4/BspWI
         NyfhxPWDD2o4U3QLkORsy5RutrHYE9tLQq5xtJAWJEf5vtVu0rWiMGWXchlnG8xvw7wp
         xQEeAKjAMpg7ib+QUtD1tSVDL+qsk1C+2B/+Zo37Qa/jFvq9NLows1BsffZ+Wp5p3l6n
         XUcPx/eLwJeaWBAPrT5xFa5PIykt4WqJYlqervFiMeWfCMLY6n/eIA9+Wi6XX4QCor+B
         TSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cnCfdad+VcUS50IP3p3NEnuKjW89LxUxStJ50/hSvN4=;
        b=I0Dd+BFyBqSEybotYhcDS6905eXiiFtIBgShXLhj3HDC0b1L+EXwbuU3e2fvsN+MeX
         lkOP5AAjXt5dfLlAlvg5miB4KQ8uZyBAw/0b5x9sPhhHGgVZEgu8si2Kcur/CiXFVaP8
         1/GB8ljwhqlHz1lcXvQ58HTBz5KmneKdmoXK5hC4mxCkp9piaC+Yli8O0mHCfRoCmAAH
         xua1WBbdVOOH8d8/R2d/S7qlXG3izgV6vF760K84YCUuouO+PgO1jw4JfJxZwsuB3N1b
         EY4NkzV0hCFrQ11ejqX9qD3zSzZ1pYvOIb4L6zL5SJFcHTgou8as18CJVOloqBQakWmm
         XAtw==
X-Gm-Message-State: AOAM532rMs+CObTuN4cLd5UWCOEUxFGrRnPO/855mzbiSO2/pKYrzCa1
        GAhT5TKexi5lrMFL6SUxZQ2HlQ==
X-Google-Smtp-Source: ABdhPJxiDq0/QyjibXCTbjYzPdFsMl1RouluIDWCVsu0lyMedCWYB/ACIv4o/RytfzJU+zQHz7tVxw==
X-Received: by 2002:a05:6402:500a:b0:42d:d109:b7da with SMTP id p10-20020a056402500a00b0042dd109b7damr10772915eda.289.1653992682088;
        Tue, 31 May 2022 03:24:42 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906590600b006feece1e053sm4845614ejq.90.2022.05.31.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 03:24:41 -0700 (PDT)
Message-ID: <1f2c1d29-11ef-0c9d-b0ba-21cb619ca55c@linaro.org>
Date:   Tue, 31 May 2022 12:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/3] dt-bindings: vendor-prefixes: document jabil
 vendors for Aspeed BMC boards
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220531011100.882643-1-David_Wang6097@jabil.com>
 <20220531011100.882643-3-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531011100.882643-3-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 03:11, David Wang wrote:
> Added Jabil vendor prefix for Aspeed SoC based BMC board manufacturers
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 169f11ce4cc5..013ea02fb39a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -638,6 +638,8 @@ patternProperties:
>      description: Jiandangjing Technology Co., Ltd.
>    "^joz,.*":
>      description: JOZ BV
> +  "^jabil,.*":

Still not properly ordered. "a" is before "o" in latin alphabet, so
please put the new entry in appropriate place.

> +    description: Jabil Design Service Branch (Sanchong)




Best regards,
Krzysztof

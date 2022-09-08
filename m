Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33C05B1C88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiIHMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiIHMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:13:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062BEE55B4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:13:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w8so27323635lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CdTbzayCWTpd5wt/KieqkvbzD1bEPUGBRGGODsZ9rls=;
        b=DiH1e9VsgX7T95VSZ2Z9aEMHESPF3rbmT++m2zbpKfSg12yOg5KQkmFf+wkMJUKmKy
         GmDUo/FLJ/Z/h5E5muTlVudD3kjLuOo14UAdm38OCGGVEU6nKIURxSeSusgbvm97yeGO
         DfN921K/VOud1cuajk+Lvetf8nSqVJkuwpACimFczoraXc/e2slbOkdGH/I7wNkYtagL
         KIEVmh+ywzO/+aExdEGVMTWUUWFJINX6L/A1ihT2cd1DcP/qB48zJ2KiVvKPCJwhIqef
         pnLLSVS1rpuHUnmrU3ZaTPiotpMM50s76orGpG9fBXdnA8WJ8q8UJCwHbX2Gyu471U+e
         Nx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CdTbzayCWTpd5wt/KieqkvbzD1bEPUGBRGGODsZ9rls=;
        b=aZ1oHiP7v5Ry8N7A2Y8mnB/92wxmtwiMCvwPKzgEvhSj9JSQqono7EItZ2w8eSkJi1
         Sb97cDbr11G/iFMVfTX0MUUN0NN8CAxkeuVaKnLGAvSrF0YTvBXeKaCwYnfvnIhtZY1V
         9YCAMfTV85zNhyhvSZ2w0QI7FiVr5RBf0k1QB6JQbeTdtTyFZpf2uDExEno0loqwmibq
         N0K4btHiwodpzfbYSCDBl/vDWZJPw+03hSiMZaKtMOfBHHdWn4H7YSu086YApfd5fg/C
         PSK3nCCQVkKSfONuueuh+oZk1AOhrOuinUI2sPt97eWoRoicErGyM2qRiVlYtI/KUqwh
         MDWw==
X-Gm-Message-State: ACgBeo3aZkI+83yQLDl5YX8hetzMBuxc35uibK+m1dKNZzOg+0mTs3/t
        NXaQnT5zq0qDZlC1zEen1zGpmYAPgkjG8A==
X-Google-Smtp-Source: AA6agR4ROtO1banKCTqX6GzhOCTGZsXNy9bx/yMxFW8AkEFsUDy2TxCY1EHHk1Udcg/9Ec4uBnr9+Q==
X-Received: by 2002:a05:6512:1112:b0:494:6e1c:f889 with SMTP id l18-20020a056512111200b004946e1cf889mr2436191lfg.423.1662639215402;
        Thu, 08 Sep 2022 05:13:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v4-20020ac258e4000000b0048ae518364dsm173890lfo.148.2022.09.08.05.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:13:34 -0700 (PDT)
Message-ID: <75d5e29e-7418-3b8f-f549-6a69fd479852@linaro.org>
Date:   Thu, 8 Sep 2022 14:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] dt-bindings: pwm: tegra: Add compatible string for
 Tegra234
Content-Language: en-US
To:     Sandipan Patra <spatra@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, kyarlagadda@nvidia.com
References: <20220907062545.30203-1-spatra@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907062545.30203-1-spatra@nvidia.com>
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

On 07/09/2022 08:25, Sandipan Patra wrote:
> Tegra234 has 8 different PWM controllers and each controller has only
> one output. Add a device tree compatible string for Tegra234.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index 74c41e34c3b6..331c1e66e8fa 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -9,7 +9,7 @@ Required properties:
>    - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
>    - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
>    - "nvidia,tegra186-pwm": for Tegra186
> -  - "nvidia,tegra194-pwm": for Tegra194
> +  - "nvidia,tegra194-pwm": for Tegra194, Tegra234

The commit msg suggest it is different. Are you sure they are exactly
the same? If not the same, but compatible, you should use fallback.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EBC53A705
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353982AbiFAN5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353713AbiFANyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:54:33 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6208F880D9;
        Wed,  1 Jun 2022 06:54:16 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e5e433d66dso2793793fac.5;
        Wed, 01 Jun 2022 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=50YiMVCaHxbvsoevu/L/Gf+lnMf24rl9MFtsvJQjpng=;
        b=aQHApTJUSvi2Zf+BjPlqI1i02ehiMQAVRc1uj1cNodTSdVpWmkgphqaPj0ruJ8bsyA
         34Y6yTT/NA+OICNaDrMN2vF68dvLZShbcsMPvdsnSBQaZRXGzl+ocae8iMWk9IN7yXZ6
         obfkVsqo50Aia1EY2G/v2i+iXOFCPmQEMg5PnaV+5Bl6s9iksGR98B/aJr9S4ZASTR0w
         chdDghnoZ3mEuJKKWatzOtQj/YE4rskA5O8NdeJSZcU4kGa0QX6hbEgBRejHdrmecf6B
         +TCO19SBZblragEU+p/1UT3cvNzmw96De4F9ulSwqt+E2KOpjmLl6ugI/7vvM3OsgVda
         5J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=50YiMVCaHxbvsoevu/L/Gf+lnMf24rl9MFtsvJQjpng=;
        b=iE6RoUOMGWHzbWP6UYQKezOtIx04AKeOO4D2sB3bq3KWllp40k7R6jnRKtJYPVzdSC
         UktLuX06W6sSBRnU66TvBiDBS/v0RGfJtp8Qabat9p6Dns9JT/+K5B9iioPLsgbKyakh
         D4ZF7NfbWzQt7ONQVT6pQF0MkQWYswUfe7YoqwmgHyrTP8y26z8gUulNPCG5jezgcL+I
         AVPT8v+uatqk4eIsa3k6ZX9zWQHEcR4TZfN2DlylPOIq+8yFz8ibPKJA8Fdw6lTHhaNx
         FEzH45pSnJ7fCvFlH2bAaZ4i1r0yA0QocTGx+jRYKAczbboiSJNQVEX53g/pzKIkaEww
         Jh/g==
X-Gm-Message-State: AOAM533AAALuUnV/CkSOCmnRdxw9+VgggvrmLghnSAwvuNSkSFKE4orc
        HqUHkHiH9VvhQ8dfMjfv4RQzYb3uFXc=
X-Google-Smtp-Source: ABdhPJxLdWwFf3XQYgQrNRPd/KDBoMKbLpPPmVP74Zh9DBdhkpFy4FtSOwyYJDJfAFELGzHiQO1Ntg==
X-Received: by 2002:a05:6808:13cc:b0:32c:7414:1d76 with SMTP id d12-20020a05680813cc00b0032c74141d76mr5140801oiw.91.1654091587850;
        Wed, 01 Jun 2022 06:53:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a056808158400b0032b7b588f3asm874798oiw.46.2022.06.01.06.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:53:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b8d280ed-b04f-e69c-8a0f-81ccaf43b895@roeck-us.net>
Date:   Wed, 1 Jun 2022 06:53:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/11] dt-bindings: watchdog: Add binding for Qcom SDX65
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
 <1654080312-5408-10-git-send-email-quic_rohiagar@quicinc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1654080312-5408-10-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 03:45, Rohit Agarwal wrote:
> Add devicetree binding for watchdog present in Qcom SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 16c6f82..e0acbc1 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -20,6 +20,7 @@ properties:
>         - qcom,apss-wdt-sc7280
>         - qcom,apss-wdt-sdm845
>         - qcom,apss-wdt-sdx55
> +      - qcom,apss-wdt-sdx65
>         - qcom,apss-wdt-sm6350
>         - qcom,apss-wdt-sm8150
>         - qcom,apss-wdt-sm8250


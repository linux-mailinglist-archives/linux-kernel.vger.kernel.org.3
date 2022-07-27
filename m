Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8958207C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiG0GwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiG0Gvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:51:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB227B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:51:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t22so19378667lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KThI0uCmJ8VFeIfgHwbGO9Wzrwr+0ZhRGvJSBLZEH1w=;
        b=CaMGf0M5o5HVCv8jgdo62PzIo8UmzAq31sWCwVXHEBwaGRITzMyV04W5lSiyOVJ5UZ
         FrnHXbBEcUgGBlpYrfJkEiPTsTZKPetQz2YaiaKIJomcyF8s3hUJ+zaBcDUW9laYjRYl
         yRPYY7D8Az1aJfM/hRqJbE9pw/10Pfz11RSabOAotOAbrqcmWlJAXzGXApiQeAB5d8rT
         qmPBPR5PsOE0Sa7gZ7OFwnzE3/EN6gNtNr1kBJb0qds6UBLncqz99uDyj20YwGNn8WQ/
         f5V45iLJea6jNVJGWnb2wxw22VcNr7j4ra60wEcWeuLXi6gBtuWU+DJ55gZJDUT9OZ2z
         essg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KThI0uCmJ8VFeIfgHwbGO9Wzrwr+0ZhRGvJSBLZEH1w=;
        b=GJ1YAQdCeHUQGF2RLc9IO+T7czraEk0+Q57k7F17bjmsqz2qf0WqN8xDWGmAEDviZU
         oUsgBI+Ol6Q0BDcvPxrIA3KbJY8LsGDcKC2Fjooy1hfWFJT0MqOewXzT1P5Fe3Guq4iR
         ZN5ON8M1fbpxKAZ+m/ycM0RnXY3d+Oo4kIygn/b9YuZ36KB8oiMaWJWNyOAtQGJNatFZ
         dKaYqQCVfotHsMHufvGro/ufJhqHcufZG5NGFBsBxbxjyeknFEh2iZUiQe3PTTT9YKTU
         sdRBiikR0tOMHdDBj+qx+DezXnAupbnsVogkI6ib1oGzZPYJaVFEKIeuLNtPqDIeZOz3
         VrbA==
X-Gm-Message-State: AJIora/TIPJPAc5qVpA+HMx+qFnm5549c4a1HU27ACKOvqbAyht1NDQ9
        JBjy7cCEe2w42i8xfCyUtWDpVQ==
X-Google-Smtp-Source: AGRyM1sO/g7SO5uuuQqlIZPdHnH2W8AQ3FzlUTOdbdU5G7u13dt96c3psUBhZRx1/+tuXoYAAf0DoQ==
X-Received: by 2002:a05:6512:1328:b0:489:e2c1:f309 with SMTP id x40-20020a056512132800b00489e2c1f309mr8515238lfu.555.1658904706689;
        Tue, 26 Jul 2022 23:51:46 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651234c100b0048aa3c9a16dsm722539lfr.255.2022.07.26.23.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 23:51:46 -0700 (PDT)
Message-ID: <15d40d97-e575-e1df-d96c-e58745ce7fa5@linaro.org>
Date:   Wed, 27 Jul 2022 08:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
 <20220726150609.140472-2-krzysztof.kozlowski@linaro.org>
 <CAA8EJppMNUV0eEF7BV6=7RgQK_XUEsqcLpmf_zu0XjSRLTLQ6w@mail.gmail.com>
 <a9356472-0fef-d500-837c-ad6d9ed27b94@linaro.org>
 <YuAqOArv4hUdaG6D@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YuAqOArv4hUdaG6D@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 19:54, Stephan Gerhold wrote:
> On Tue, Jul 26, 2022 at 07:30:12PM +0200, Krzysztof Kozlowski wrote:
>> On 26/07/2022 18:49, Dmitry Baryshkov wrote:
>>> On Tue, 26 Jul 2022 at 18:06, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> Enable Qualcomm drivers:
>>>> 1. socinfo driver to provide some basic information about the
>>>>    SoC being used.
>>>> 2. Remote filesystem memory driver (used in MSM8974).
>>>> 3. RPM Power domain (used in MSM8226).
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  arch/arm/configs/qcom_defconfig | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
>>>> index 5cd935ee148a..f02448187eac 100644
>>>> --- a/arch/arm/configs/qcom_defconfig
>>>> +++ b/arch/arm/configs/qcom_defconfig
>>>> @@ -247,12 +247,15 @@ CONFIG_QCOM_COMMAND_DB=y
>>>>  CONFIG_QCOM_GSBI=y
>>>>  CONFIG_QCOM_OCMEM=y
>>>>  CONFIG_QCOM_PM=y
>>>> +CONFIG_QCOM_RMTFS_MEM=y
>>>> +CONFIG_QCOM_RPMPD=y
>>>>  CONFIG_QCOM_SMEM=y
>>>>  CONFIG_QCOM_SMD_RPM=y
>>>>  CONFIG_QCOM_SMP2P=y
>>>>  CONFIG_QCOM_SMSM=y
>>>>  CONFIG_QCOM_RPMH=y
>>>>  CONFIG_QCOM_RPMHPD=y
>>>> +CONFIG_QCOM_SOCINFO=y
>>>
>>> please add:
>>> CONFIG_QCOM_STATS=y
>>
>> I was considering it, but it seems none of ARMv7 DTS use it.
>>
> 
> Some MSM8916 boards are used on ARMv7 (due to firmware limitations)
> and the msm8916.dtsi has it. :)

OK, thanks!


Best regards,
Krzysztof

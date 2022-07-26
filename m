Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8295818BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGZRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:43:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5106CFE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:43:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bf9so23621936lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IVS4DgcWZYQaIrs6t/dVjSMv1czaJ0LlQOtvhPD5qyM=;
        b=wYVfnInCga3CZQybQl4hcD1uvNsCKdXTjnTyTUdQ1CacVhjl4AxTHwcMlAOev6hGt+
         3B1VoFftj4YnOD+OGBGM/wWU10vVUpYbz3uImD1sB6QzwCC4FsWWRhC/yvBvAWsVjeDe
         V7991zR8eJsebayM7rnvgraIYE3MpRTCqVbNDNdZvzuaMuCKNRad7AcfVpsbBfQphug8
         JkeE6Jna9wFwBMlIFocbN0IDxc19v7AZoJYl4Izv/AuMdlEuTfrEPn/sSxbgoBkOiSsx
         aavFeid8nL+UHmUshZMmL2O9FF1CfnPJdRKczFhODtpGzKWqhJXxiOI1sUdyfYP2Spdq
         Wplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IVS4DgcWZYQaIrs6t/dVjSMv1czaJ0LlQOtvhPD5qyM=;
        b=M8a6aCMI0njIljO2BZtCpYRu7OEP9qVl+fg/+pNGuNRM4PQR4Dn+GcKC2eY7cepEeq
         pMGTIHoe7nmjOy2pjPuCxMlL5oifddKXLRoSfHEZ8b4/c4qeXiwXOUP+rP9y6pQUP3Lf
         cfK4dBodhKyGaX3kmlhhhdr+L+FcZA77V/vgD+upO1x6fgCUI33fHXItCFyUWHA/Jrtg
         CIPfTj7D3K83RULBVMeEBX0PBxhc8rTftG4nJKo8FpGEUD2rUcncnE3fVWOcZmVKzKbI
         KlWEf0ojbo48s3Qi+d13IqTtnQ98UOPaA4qcY7Km4wWU1Rc26o48fPAGVSMPn3WGCKxD
         26Ag==
X-Gm-Message-State: AJIora9Tf16jsrF4n2drPWYtm0SCWzaLg+kFk5PRneaRHqVfbgJT90/2
        XhA6EJOeIMLC52Gweb5F35tXTQ==
X-Google-Smtp-Source: AGRyM1sYLQcD0sBHzkqjq/CphzNqCX7S2Vc4c3wXkL8oc8F/zFvuT7emzuxogCpcRdtTTR6KU64Y7g==
X-Received: by 2002:a05:6512:131b:b0:48a:26dd:d823 with SMTP id x27-20020a056512131b00b0048a26ddd823mr6643983lfu.661.1658857410642;
        Tue, 26 Jul 2022 10:43:30 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d22-20020a056512369600b0048a9f1933f2sm536038lfs.247.2022.07.26.10.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:43:30 -0700 (PDT)
Message-ID: <76bf4b19-54e8-c8cc-be71-356233b1cd57@linaro.org>
Date:   Tue, 26 Jul 2022 20:43:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <a9356472-0fef-d500-837c-ad6d9ed27b94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 20:30, Krzysztof Kozlowski wrote:
> On 26/07/2022 18:49, Dmitry Baryshkov wrote:
>> On Tue, 26 Jul 2022 at 18:06, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> Enable Qualcomm drivers:
>>> 1. socinfo driver to provide some basic information about the
>>>     SoC being used.
>>> 2. Remote filesystem memory driver (used in MSM8974).
>>> 3. RPM Power domain (used in MSM8226).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   arch/arm/configs/qcom_defconfig | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
>>> index 5cd935ee148a..f02448187eac 100644
>>> --- a/arch/arm/configs/qcom_defconfig
>>> +++ b/arch/arm/configs/qcom_defconfig
>>> @@ -247,12 +247,15 @@ CONFIG_QCOM_COMMAND_DB=y
>>>   CONFIG_QCOM_GSBI=y
>>>   CONFIG_QCOM_OCMEM=y
>>>   CONFIG_QCOM_PM=y
>>> +CONFIG_QCOM_RMTFS_MEM=y
>>> +CONFIG_QCOM_RPMPD=y
>>>   CONFIG_QCOM_SMEM=y
>>>   CONFIG_QCOM_SMD_RPM=y
>>>   CONFIG_QCOM_SMP2P=y
>>>   CONFIG_QCOM_SMSM=y
>>>   CONFIG_QCOM_RPMH=y
>>>   CONFIG_QCOM_RPMHPD=y
>>> +CONFIG_QCOM_SOCINFO=y
>>
>> please add:
>> CONFIG_QCOM_STATS=y
> 
> I was considering it, but it seems none of ARMv7 DTS use it.

Argh. The driver has support for 8974 and 8084, but nobody has wired 
that up. I'd still suggest marking it as =y/=m. I'll send dtsi patches 
in parallel.

-- 
With best wishes
Dmitry

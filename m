Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8A57BB72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiGTQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiGTQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:33:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B24C602
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:33:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bf9so31083586lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Iai1eytOrQZlCvAc0K2WrCmPc3ieYaIb+taHkGUkP1A=;
        b=Q8Msrl8vduLlwvBtAT7aZgB7Pk3L38LfUPyL0t+24MK90ZbhzFzgWdlO0fnBm353mp
         anSSnaQXlBcAhGhVLYu2E/l+is9kW47xecmpQDxpIrxPBafOJry3Z1Rk00+qi9BTb7ME
         5nPG9sRAT6olaLhsz93dB7KiI+mhevivKZ+SgBxeT0+d7GzCtneAbVuV+Bj2+ZDtUTtm
         H4J7yEl7iIoNZcToQXSibNnJCR4/q56m4O64fBk7DAyvZhbucJD3VfyUexQlu04xDg3Y
         eQQ4THSqlte583HQyP3RL/Le+3ZDgxJ3tP9QV87s1d92gk2J3V5/cz22cOlLkMV7Bhs3
         Gwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Iai1eytOrQZlCvAc0K2WrCmPc3ieYaIb+taHkGUkP1A=;
        b=HS7XObRb8FsNdtedlSdvIi+kLT3n56bLLp5+gixyq4DLmgJgcPktjmS1d6Cl7ptVl8
         csR+yHKNffALRTiivS7y56EXo5oBWdxXJCpWfpgzQMAMWSUrXFxZFSVBV+r1OhRMZobx
         9s30lRQJOPIFUEM1sUVc40wBfQ/OxTuSejaDu5yPuu1jvPdcESB0fSiUzzcsvcibgZeX
         zxr+Xc7dWIjD+HroUkI7yDPFYVOH7hUMGBFDWFmDvIF0gRI/2olz7u1caRDkMd/o34JA
         Ugf0YUTkLDrwCqd0TZq5VtuA0bRyugCVf8978IbGRtEnVMobU3DkW5f5vONq+Zm/jeim
         J0Mw==
X-Gm-Message-State: AJIora8zusQ6igXDqo4RGI/qYKSapznOt4o3xDgxFp/cNeI2TqIih+Ru
        iAFhpISTTscH2CBXrf8UB2PAFA==
X-Google-Smtp-Source: AGRyM1uw8E4tMjJdAZWZjxB7WZIYF/SOSXF+hiufu0KrGm1hBrl+U1q9pEbSaEb3tLYjTKtKB4jIHw==
X-Received: by 2002:a05:6512:10d3:b0:489:cc6f:f7fe with SMTP id k19-20020a05651210d300b00489cc6ff7femr20488878lfg.384.1658334817046;
        Wed, 20 Jul 2022 09:33:37 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id f19-20020a056512361300b00489d485ace3sm3895682lfs.62.2022.07.20.09.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:33:36 -0700 (PDT)
Message-ID: <5229adbc-ec5f-259f-0fd1-1df6e979c9bb@linaro.org>
Date:   Wed, 20 Jul 2022 18:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] dt-bindings: qcom for v5.20, version 2
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20220628092253.21905-1-krzysztof.kozlowski@linaro.org>
 <Ytgf7ejB/2usK4uW@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ytgf7ejB/2usK4uW@builder.lan>
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

On 20/07/2022 17:31, Bjorn Andersson wrote:
> On Tue 28 Jun 04:22 CDT 2022, Krzysztof Kozlowski wrote:
> [..]
>> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>>
>>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-bindings-qcom-5.20-2
>>
>> for you to fetch changes up to 062529700fdb843eee921961eb3cbc6a51419491:
>>
>>   dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board compatible in example (2022-06-28 10:28:50 +0200)
>>
>> ----------------------------------------------------------------
>> Devicetree bindings for Qualcomm for v5.20
>>
>> Cleanup, fixes and additions of missing pieces for Qualcomm bindings.
>> These are address dtbs_check warnings and do not bring new hardware
>> (new compatibles are added for existing boards/hardware).
>>
>> ----------------------------------------------------------------
>> Krzysztof Kozlowski (25):
> 
> Many thanks for gathering these patches in a pull request!
> 
>>       dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
>>       spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
> 
> This,
> 
>>       dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
>>       dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
>>       dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
> 
> this,
> 
>>       dt-bindings: leds: qcom-wled: fix number of addresses
> 
> this


Although it is preferred that such subsystem patches go via subsystem
trees, but subsystem maintainers sometimes do not pick up DT binding
patches. Maybe they expect Rob will pick them up or sub-arch maintainer.
I don't know. I just see the result that they wait for months (like [1]
was waiting for ~1.5 months)

If you don't want to take them, even though these are fixes, I will try
to poke the maintainers.

> 
>>       dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
>>       dt-bindings: arm: qcom: fix Longcheer L8150 compatibles
>>       dt-bindings: arm: qcom: fix MSM8916 MTP compatibles
>>       dt-bindings: arm: qcom: fix MSM8994 boards compatibles
>>       dt-bindings: arm: qcom: add missing MSM8916 board compatibles
>>       dt-bindings: arm: qcom: add missing MSM8994 board compatibles
>>       dt-bindings: arm: qcom: add missing SM8150 board compatibles
>>       dt-bindings: arm: qcom: add missing SM8250 board compatibles
>>       dt-bindings: arm: qcom: add missing SM8350 board compatibles
>>       dt-bindings: vendor-prefixes: add Shift GmbH
>>       dt-bindings: arm: qcom: add missing MSM8998 board compatibles
>>       dt-bindings: arm: qcom: add missing MSM8992 board compatibles
>>       dt-bindings: arm: qcom: add missing QCS404 board compatibles
>>       dt-bindings: arm: qcom: add missing SDM630 board compatibles
>>       dt-bindings: arm: qcom: add missing SDM636 board compatibles
>>       dt-bindings: arm: qcom: add missing SDM845 board compatibles
>>       dt-bindings: arm: qcom: add missing SM6125 board compatibles
>>       dt-bindings: arm: qcom: add missing SM6350 board compatibles
>>       dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board compatible in example
> 
> and this does however need to go through respective maintainers' trees.

However this one last should go via your tree, as expressed by Rob (and
acked by Viresh) in [2]. It fixes the issue which is exposed by
dt-bindings/arm/qcom change (not caused by visible because of).

[1]
https://lore.kernel.org/all/20220505154702.422108-1-krzysztof.kozlowski@linaro.org/

[2] https://lore.kernel.org/all/20220627195040.GA2840123-robh@kernel.org/


Best regards,
Krzysztof

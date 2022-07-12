Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F12571272
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiGLGrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiGLGrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:47:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DE4B0DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:47:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t1so8804713lft.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jMuRcrjE7BdyitlsbzjBTLs0XHaQgX+9YW3636oyPpA=;
        b=rGaxi11FZcV17/AmY/XXSQakC2aoNyn09A4wYTzxBLTuUk6SH4pZMO4LLGabGqoVxa
         3SlJ8hsmjq+OoPUJAjPO6JjfoOrfsi79JwY2UcDs3q66EL/LH2EnRqgfn1Zg/jK1cB9i
         ckRieC3iYDCruJaoCbuIw3bmoEIFDFa0G+Y6s5luIaB0mMHEPXr4KJd7Rcsagz+4LmEk
         q/PeUa1vCV/uHj98uvIJCx2+t7FnkzXQdrzAZtJu1TQCODz4TlBshN5xUfHApQuG4o5f
         UYuOFsFb/QqURLQpMP7sjKwA2ZFJFkC9WPyS5n/4QwblS5WfJV2FmUyAcVgE9vIM86fV
         uR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jMuRcrjE7BdyitlsbzjBTLs0XHaQgX+9YW3636oyPpA=;
        b=sjySf2nMrrI5Z4EOaM7JqsLFss8It51s7D8hr6nSRAzF5P10GhZmY+VbhjM4Ikc5Ac
         6InixA66ZVSPFUL6qzSfx9GOQCgSyinUcl5o/sUWKZhCrvq8C1XJKElXcm2VpBDym82I
         7S7kz8pP0xgIwrwQqkALFRhTYcl0AiijhEYPUW+bJVW3nSBp50DGc27RqzrtfwrZbPlH
         5jmCQjlPMIWRWPaq08RGJm4CiTfp6VVhWxoKrXOuF7yllcNzzOBQfhPXTPE7fnqckrVr
         szUHJ88/QEY0ZAsfKsSyGkqhuAcOZBxqplHA0oOtuQxohO54rbQqWi+f+IJz80xyu6NW
         Demg==
X-Gm-Message-State: AJIora8/E/sQRLQ7k1V25VwNYDEyor9x6K2crUqR6AplrZ1Q9VGgwUKs
        FkmvuJihunBHSON9I/M94la2Ng==
X-Google-Smtp-Source: AGRyM1u/RLfflARYY940Xxjm3/t52ojyKVUi1YPU8bjt5W5WTYcRfzbQy2HB2eCLRiMk5r4kkF9oqw==
X-Received: by 2002:a05:6512:3b0a:b0:489:da13:180a with SMTP id f10-20020a0565123b0a00b00489da13180amr7313675lfv.489.1657608433934;
        Mon, 11 Jul 2022 23:47:13 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id l18-20020ac24312000000b004785b0dfba4sm1993959lfh.195.2022.07.11.23.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 23:47:13 -0700 (PDT)
Message-ID: <6ebdb95a-6458-b77e-e14c-e89539c51b3f@linaro.org>
Date:   Tue, 12 Jul 2022 08:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] mmc: sdhci-msm: add MSM8998 SDCC specific compatible
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
 <20220711082709.39102-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
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

On 11/07/2022 17:08, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 11, 2022 at 1:27 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Add a MSM8998-specific SDCC compatible, because using only a generic
>> qcom,sdhci-msm-v4 fallback is deprecated.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index e395411fb6fd..bb169c1c2b5e 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -2447,6 +2447,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>>         {.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
>>         {.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
>>         {.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
>> +       {.compatible = "qcom,msm8998-sdhci", .data = &sdhci_msm_mci_var},
> 
> FWIW I'm _against_ this change.
> 
> In my mind while it is correct to specify both the specific and
> generic compatible string in the device tree, the driver itself should
> rely on just the generic compatible string until there is a reason to
> use the specific one (like we needed to for sdm845 and sc7180).
> 
> I think I pointed that out before, but somehow all of the specific
> device tree strings have snuck their way into the driver without me
> paying attention. :(

I thought it's existing practice for some time, but it's a fresh commit
466614a9765c ("mmc: sdhci-msm: Add SoC specific compatibles"). I agree
that it does not make much sense to add each compatible to the driver,
so how about reverting 466614a9765c?

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D4F55060F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiFRQMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiFRQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:12:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791715725
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 09:12:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gl15so13825291ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IXQqZXKsIahRiMlAn7GqcvzltiNlbsf4wn/WAu8+tIk=;
        b=dE6crysc+U1uJUov643h9mjqC3OXf4w+yGe23fvpmNE7Aqo64PJzbcxMAe6FmdzAsx
         RFVEKII7nfr/HKlxVT5dqe3a8THvDLkvX7GaFVPSHTx5YR9duXJzX+H6rvFBGSSWOcCx
         BUaMGlMteuBj5Ggymc3E0RGuVzbn6DB224MR6rRdGcOotGv+NwtyFCq1jBxNdn0l4Tmi
         rTP8GONalahQRmQ70whOv50DR9XTx4XMUkiPg53kY4Z1Mnpmb3PhJ8jqfmQAHhq99rT4
         C6Drwqe4Li7dd9vmoc/Bl6tJsNfkA238v1mICn0lsE/BS7rYEe73z+5ebmXOZr4hxzRm
         mzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IXQqZXKsIahRiMlAn7GqcvzltiNlbsf4wn/WAu8+tIk=;
        b=VeCXtj4NZZNFLKO+3rDgxQZNFs5mghbDL9E5XlkUJ39QcBjB0gAgKKRMp1v6MTKEb0
         LrqPB6aezLer2Ghq7Fn52QbhAiP8fzuo7di0+EWnkGz/bxkbBTBGV82TdIfSo5MTHWYZ
         dCP1N+LabAzh7dp6x4lw3XIHHZjhB+XUtF/YcW64NOe+vtJUgt3lRPGaSzKykKEBVArl
         6II1ZYtMDlVpDQgcylREfLLc8E79aowKOZsCZ4wazUMyvCy8AxKWUc1DF1182nCwmTV8
         guMOwBbCCQwOQooI6wjhAY38b3OlFD6oSGb3vHG6vQKClxawRPC8pZ5nKgJbVWgdlUZq
         DD2Q==
X-Gm-Message-State: AJIora8DtOuUQSuBjTEzDNRbL6SK3Okd9Q0xxfVS4zMmy3quIc4sL4V3
        UMqaWCtkTGqsxO0D0+h7hZy6HQ==
X-Google-Smtp-Source: AGRyM1umvz/p/Iyjm5mTDqNqRqa6aA5gagfMz4fkcyiE2LZTANOh7xe4b8+2ErJKXXhpB7wPudp3dg==
X-Received: by 2002:a17:906:6a1a:b0:711:ec13:b7bc with SMTP id qw26-20020a1709066a1a00b00711ec13b7bcmr13912025ejc.688.1655568730833;
        Sat, 18 Jun 2022 09:12:10 -0700 (PDT)
Received: from [192.168.212.234] (92.40.170.45.threembb.co.uk. [92.40.170.45])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b006febc1e9fc8sm3568253ejc.47.2022.06.18.09.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 09:12:10 -0700 (PDT)
Message-ID: <0289abc2-c9f2-c798-6247-e3d8e4231945@linaro.org>
Date:   Sat, 18 Jun 2022 17:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v14 00/10] iio: adc: introduce Qualcomm SPMI Round Robin
 ADC
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220618140913.49fd1dc2@jic23-huawei> <20220618141757.625f86c4@jic23-huawei>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220618141757.625f86c4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/2022 14:17, Jonathan Cameron wrote:
> On Sat, 18 Jun 2022 14:09:13 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Fri, 29 Apr 2022 23:08:55 +0100
>> Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>> The RRADC is responsible for reading data about the current and
>>> voltage from the USB or DC in jacks, it can also read the battery
>>> ID (resistence) and some temperatures. It is found on the PMI8998 and
>>> PM660 Qualcomm PMICs.
>>>
>>> The RRADC has to calibrate some ADC values based on which chip fab
>>> the PMIC was produced in, to facilitate this the patches
>>> ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
>>> and ("mfd: qcom-spmi-pmic: read fab id on supported PMICs")
>>> expose the PMIC revision information and fab_id as a struct and register
>>> them as driver data in the Qualcomm SPMI PMIC driver so that it can be
>>> read by the RRADC.
>>>
>>> The first 3 patches add support for looking up an SPMI device from a
>>> struct device_node, as well as introducing support for looking up the
>>> base USID of a Qcom PMIC, see patch comments for more details. These
>>> Address Bjorns comments on v2.
>>
>> Hi Caleb / All
>>
>> Rather than waste time going for a v15 for the 3 minor issues in reviews
>> I've just fixed them up whilst applying.
>>
>> As spmi or mfd maintainers may want an immutable branch I've
>> just pushed one out at
>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git immutable-qcom-spmi-rradc
>> that has the first 5 patches. I assume the dts changes will go via qcom -> arm-soc
>> as normal.
>>
>> 0-day should run on that branch shortly but I'll be optimistic and pull it
>> into my testing branch in the meantime (mostly so I don't forget about it and
>> can mark it applied in patchwork :)
> 
> Gah.  Merge into IIO doesn't build because of dropping of.h from includes
> in iio.h.  This driver should directly include property.h directly.
> 
> New 'immutable' branch with same name pushed out.  Guessing no one picked
> it up in the minute or so previous version was available for!
> 
> I'd advise that Lee / Stephen don't merge this for a few days at least so
> any other issues have become visible and I can fix them up without making
> for complex history.
Hi Jonathan,

Thanks so much for picking this up and fixing those last few issues. And 
thanks for all your help with this series, I really appreciate the time 
you've taken to help me get this to a mergeable state and teach me about 
IIO.

You've really made my week with this :)

Kind Regards,
Caleb
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>>
>>>
>>> Changes since v13:
>>>   * Address Lee Jones' feedback on the SPMI patches.
>>>   * Pick up Jami's patch to enable the RRADC on the OnePlus 5
>>>
>>> Changes since v12:
>>>   * Apply Krzysztof's suggestions to rradc DT binding docs.
>>>
>>> Changes since v11:
>>>   * Remove debug logging which was left in ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
>>>   * Picked up Dmitry's Tested-by and Reviewed-by tags.
>>>
>>> Changes since v10:
>>>   * Don't inline spmi_device_from_of()
>>>
>>> Changes since v9:
>>>   * Add back missing copyright, this driver is originally derived from
>>>     downstream (Thanks Manivannan).
>>>
>>> Changes since v8:
>>>   * Drop Reported-by for the bugfix on previous revision reported by LKP
>>>   * Apply Jonathans suggestions
>>>   * Rework patch 2 ("expose the PMIC revid information to clients") to
>>>     handle PMICs with a single USID (thanks Dmitry)
>>>
>>> Changes since v7:
>>>   * Addressed Jonathans comments
>>>   * Fixed bug reported by LKP
>>>
>>> Changes since v6:
>>>   * Fix printf format warning in rradc
>>>
>>> Changes since v5:
>>>   * Add missing EXPORT_SYMBOL_GPL() to
>>>     ("spmi: add a helper to look up an SPMI device from a device node")
>>>
>>> Changes since v4:
>>>   * Addressed Jonathan's comments on v4
>>>   * Reworked the qcom-spmi-pmic patches to properly walk the devicetree
>>>     to find the base USID. I've tested this on SDM845 which has two PMICs
>>>     (pm8998 and pmi8998) and I'm able to look up the PMIC revid from all
>>>     4 USIDs.
>>>
>>> Changes since v3:
>>>   * Split PMIC patch in two, rework to support function drivers on a
>>>     sibling USID
>>>   * Completely rework RRADC driver to make use of the modern IIO
>>>     framework. This required re-arranging a lot of the equations and
>>>     results in some lost precision, where relevant I've left comments to
>>>     explain this. I don't think any of it is significant enough to
>>>     justify doing post-processing in driver.
>>>     Thanks a lot Jonathan and John Stultz for helping me out with
>>>     this
>>>
>>> Changes since v2:
>>>   * Add missing include (thanks kernel test robot :D)
>>>   * Rework some confusing function return values, specifically
>>>     rradc_read_status_in_cont_mode and rradc_prepare_batt_id_conversion
>>>     both of which didn't correctly handle "ret". This also bought up an
>>>     issue as the previous implementation didn't actually wait for the
>>>     channel to be ready. It doesn't seem like that's strictly necessary
>>>     (same data is reported if I wait for the status to be good or not)
>>>     but I've included it anyway for good measure.
>>>
>>> Changes since v1:
>>>   * Rework the RRADC driver based on Jonathan's feedback
>>>   * Pick up Rob's reviewed by for the dt-binding patch.
>>>   ---
>>> Caleb Connolly (9):
>>>    spmi: add a helper to look up an SPMI device from a device node
>>>    mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
>>>    mfd: qcom-spmi-pmic: read fab id on supported PMICs
>>>    dt-bindings: iio: adc: document qcom-spmi-rradc
>>>    iio: adc: qcom-spmi-rradc: introduce round robin adc
>>>    arm64: dts: qcom: pmi8998: add rradc node
>>>    arm64: dts: qcom: sdm845-oneplus: enable rradc
>>>    arm64: dts: qcom: sdm845-db845c: enable rradc
>>>    arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
>>>
>>> Jami Kettunen (1):
>>>    arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
>>>
>>>   .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   51 +
>>>   .../boot/dts/qcom/msm8998-oneplus-common.dtsi |    4 +
>>>   arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
>>>   arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
>>>   .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
>>>   .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
>>>   drivers/iio/adc/Kconfig                       |   12 +
>>>   drivers/iio/adc/Makefile                      |    1 +
>>>   drivers/iio/adc/qcom-spmi-rradc.c             | 1021 +++++++++++++++++
>>>   drivers/mfd/qcom-spmi-pmic.c                  |  272 +++--
>>>   drivers/spmi/spmi.c                           |   17 +
>>>   include/linux/spmi.h                          |    3 +
>>>   include/soc/qcom/qcom-spmi-pmic.h             |   61 +
>>>   13 files changed, 1372 insertions(+), 90 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
>>>   create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
>>>   create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
>>>    
>>
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2178A573AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiGMQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiGMQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:07:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9878BD99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:07:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y11so13314112lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f4uaObWWNXPp5U219pPbduTuGgXfEfl6t1YiDSAeW2w=;
        b=o4WoL0O2zA/fw6V30nknwceTVBp2UJDNwqomXVWrg0aaviu5uaExwNqGI2xn67hVYq
         yXHuLF7zf96rbDMYFCqATj7ark/i3JiXbla9sEX76ybkkSutPHsOw0j4bdeka+s55ggU
         ZqbVt9vbe9NGrRPfZeiqej+b5JBb2WSlADyxYITbOD9ysO7q9AbbVEoIbFoOUkOUcV+p
         mdmHCMUP8Bn4sVWi18Ipb/J3BLeK8bkYUXqRd72FJPn6iYPSBdCo9ZdT1DgvrUm94rFg
         cG9bbeNrjJ5k1hHs2ND0OtQcHB5ydjReeBmBOght4PHgFSqFwssbLOhyZnzJVpH19D1X
         NslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f4uaObWWNXPp5U219pPbduTuGgXfEfl6t1YiDSAeW2w=;
        b=jy9aGL/KSnJcVf27akGjPao8r86JPa+MGu8eEaQahK2usBBFGUEfM0QM3M/82WL0Km
         6QPJZKK/LM+9iFxMjiWgVauztnD4s6eExMTb7s60TXFFcXGPmwBBxseIbVyUJ6C0S+gh
         629kG4y9w6GLQ/yj2ua+bTt6xW4hrSbW2u/BmyuQnzljt70arCxp8agyxBWuNhbXI0tq
         AtVP3aMgMUR4wzMwBntH0flh7/7hw3xxtasEgOQ5njnNmh9cIAjmOMoObzClq/2mecEp
         yKcfzZdcoHd1DgXB1Hx4T5PblBBqYmDgVWeGOKLNyHLeyDozuDW2N6KxibBaGq90JETe
         q6QA==
X-Gm-Message-State: AJIora9MaTQXJBni0kOQhtKK/jRXd51V50vm6Cq7Bya8ND/D6yue4NTw
        0s6nFunWYpySdExmCZwIy3fJ/g==
X-Google-Smtp-Source: AGRyM1uM3uQVqr1DYFsJ8qJmc3t0U98qT2y3kigwqhVCsaVCX1P1CW+6rO7K6Rj7LzHdXwvlKGJ42w==
X-Received: by 2002:a05:6512:b82:b0:488:6aa6:509b with SMTP id b2-20020a0565120b8200b004886aa6509bmr2480520lfv.637.1657728431936;
        Wed, 13 Jul 2022 09:07:11 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s21-20020a056512315500b00478fe3327aasm2863046lfi.217.2022.07.13.09.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:07:11 -0700 (PDT)
Message-ID: <996a49ea-5fba-3885-09ca-5b9a92b840e7@linaro.org>
Date:   Wed, 13 Jul 2022 18:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] mmc: sdhci-msm: drop redundant of_device_id
 entries
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
References: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org>
 <20220712150219.20539-4-krzysztof.kozlowski@linaro.org>
 <CAD=FV=VPHwkKUjanLtaM+cXdp+VGPExJ_XDe=-O8j=ayGNtnVQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VPHwkKUjanLtaM+cXdp+VGPExJ_XDe=-O8j=ayGNtnVQ@mail.gmail.com>
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

On 13/07/2022 17:57, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 12, 2022 at 8:02 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> This reverts three commits:
>> 1. Revert "mmc: sdhci-msm: Add compatible string check for sdx65"
>>    This reverts commit 953706844f0f2fd4dc6984cc010fe6cf51c041f2.
>>
>> 2. Revert "mmc: sdhci-msm: Add compatible string check for sm8150"
>>    This reverts commit 5acd6adb65802cc6f9986be3750179a820580d37.
>>
>> 3. Revert "mmc: sdhci-msm: Add SoC specific compatibles"
>>    This reverts commit 466614a9765c6fb67e1464d0a3f1261db903834b.
>>
>> The oldest commit 466614a9765c ("mmc: sdhci-msm: Add SoC specific
>> compatibles") did not specify what benefits such multiple compatibles
>> bring, therefore assume there is none.  On the other hand such approach
>> brings a lot of churn to driver maintenance by expecting commit for
>> every new compatible, even though it is already covered by the fallback.
>>
>> There is really no sense in duplicating of_device_id for each
>> variant, which is already covered by generic compatible fallback
>> qcom,sdhci-msm-v4 or qcom,sdhci-msm-v5.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Personally, I would have taken the extra step and added a comment in
> the code to prevent someone from doing this again. Maybe like this:
> 
> /*
>  * In the device tree, all boards are required to have _two_ compatible
>  * strings listed: a SoC-specific one followed by a more generic one.
>  * Normally we can just rely on the generic string, but we always
>  * include both so that if we ever find a bug on a specific SoC that
>  * we need to workaround (like in sdm845/sc7180) that we can quickly
>  * work around it without any changes to the dts.
>  */

This actually does not instruct the developer not to add new variants to
the driver, so how about something like:

/* Do not add new variants to the driver which are compatible with
generic ones, unless they need customization. */
?

The problem is that this applies to several such drivers on several
platforms (Qualcomm, NXP - these for sure use such pattern), so we would
be documenting something obvious, IMO.

> 
> In any case:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8855B17D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiIHIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiIHIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:55:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CBC6943
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:55:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q21so12374854lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C5KNVGsjWvUeDKSq3LjZlenEv9vb29toHV4Rmgebsro=;
        b=qI6gupLwkGLXp4h61TVhWU/l08zkHVbj64MDbF8omA+94eQv3aL8aI2S6qWbEAVXsB
         zqBZIVUkAJZIkg6AsjyNxPFRgh4YW5iHTR4mdzGmCB3k/fZ1M+ThVdBSzN6Vsw2TNylL
         NK6xSYos3lrNGA9fdoAWEeHo/f1aJMOCcFFd5W83NmtYqbcLce9k5Y3GeYIWiLJlbP/6
         DGnIF3mkMXjGhXsZKEP435xh84kWKPSdP1+aDPxx/3EoIYSfgd7I+KegGtPYqtq/pS7B
         h2NVhreDcrHPlY/7Bt0hoXKyc+z7gGgVXS83TGoLHSrgOcxMUsJboBtV272XPRhMHZ9V
         /9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C5KNVGsjWvUeDKSq3LjZlenEv9vb29toHV4Rmgebsro=;
        b=FPfU4BQjDrNxRNaQ9vdW0zi/mQ+W84ARIsSf8DxUhXq7IMaaLtFlvDTg72jadUNJAn
         5s5F5yd+KRZrck41F3C1Mj/BSWtPQpV80X+07jgWdA62ilbgkC/RqQacV2fzF/U3MKR0
         dFqE5l5Imo0EgqhxVNyjR4/J22q2c7xKoG86KSod0OlkwrqRMYVN8G5OH96nP3/ucZf/
         tYx9BLoiLxQKL9sPyap6OyL3zo15yCyuhDkUC/A7DZr5+xR0Jt401MLjZmZPPS5Iq1Mp
         XBTJaz4baqX2VuCG5QaYc8fItNvhtK2aOneaSfh7O8w6qGkbmzOZsTkbDG5Eg9hjxtFg
         mKcA==
X-Gm-Message-State: ACgBeo0/VrlA3Lxc5lwBdHewpxvZXDIVmGFBH2Ua9RTtDHM22L4PAA5Y
        lcUbA8OeUG0UXGH5p9H7stwuJA==
X-Google-Smtp-Source: AA6agR4YRFajrwiiGqsuxOEYNGDXHyymQaVlGyWoA0UE3adCCxSYJsz9ihBn42XerAKsW4kSjA7IVg==
X-Received: by 2002:a05:6512:1694:b0:48a:9d45:763f with SMTP id bu20-20020a056512169400b0048a9d45763fmr2255149lfb.662.1662627325558;
        Thu, 08 Sep 2022 01:55:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w30-20020a197b1e000000b00497aa5852a9sm763306lfc.296.2022.09.08.01.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 01:55:25 -0700 (PDT)
Message-ID: <a9514c01-199d-80bc-46a1-f199f4f56196@linaro.org>
Date:   Thu, 8 Sep 2022 10:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
 <CAE-0n50x=h_rBaWAcTk_BBCMLpD=XQ6=BKLGp5+m8i4Lvn4fyg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAE-0n50x=h_rBaWAcTk_BBCMLpD=XQ6=BKLGp5+m8i4Lvn4fyg@mail.gmail.com>
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

On 07/09/2022 23:33, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2022-09-01 21:35:11)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 13d7f267b289..a839ba968d13 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3275,6 +3275,82 @@
>>                         };
>>                 };
>>
>> +               pmu@9091000 {
>> +                       compatible = "qcom,sc7280-llcc-bwmon";
>> +                       reg = <0 0x9091000 0 0x1000>;
>> +
> [...]
>> +                       };
>> +               };
>> +
>> +               pmu@90b6000 {
> 
> This unit address
> 
>> +                       compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
>> +                       reg = <0 0x090b6400 0 0x600>;
> 
> doesn't match this one. Please fix.

Thanks for catching it. Patch was applied, so I will send a follow up.

Best regards,
Krzysztof

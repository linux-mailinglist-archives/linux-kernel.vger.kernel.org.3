Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D11567F02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiGFGz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGFGzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:55:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819891CFDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:55:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t19so23659778lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 23:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qi/HzfCRWKKbzy7uAxJ2wy7Sd2F4DwDWD93n1e7b+Tc=;
        b=N4r+vDEttCJfEoxvR/u99LGStE2n////g6PJKpqQIKTaIwvLn8AXYs8hqZBlvYpkDl
         eyOLQBzIW7O0B6T3kT5fKYR+Y8//FFHM/SMIShQqLOzZOPlrXupLlVYUn1VlnLYvmxFZ
         iNerWocy49Jul7Dkzmj3EZYcRNXcZUWR9RoSmVLomGo+KBEQ/+IXUGbWacbzp4bjQcQA
         2r+LvnWAUUYmkNj/mpLtvweY84+02vOCr+XbTU9YddzlYy8lpdHH3S6AtI8/vys34Jmi
         txWa9n2NwOo0wxhrhr9XAERVDe8r6PpcqfiSSXe+H3by/LngaIh54sKx8hGS0l/ZzZ28
         +tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qi/HzfCRWKKbzy7uAxJ2wy7Sd2F4DwDWD93n1e7b+Tc=;
        b=3g8m1XLHKU1YsBwmK31qGjvR/wIwUQC1kx52sntciiE44mgvSYnPMqyXZXUuP3x4YL
         GG9vn0R+XXlvg2PCrJ5kAOWIvrdYk2P4sou22V5tLBcUN4ssqPFzzdonDUbibPMY3mF/
         Jjy4FIjVhKQ9QygWtSjOW1nykexAlCyU7zc8Qr4J0yMMor/CRycpCHg/js6MgRgcyJ3u
         zS9sr0zBhgFLSuVI5yGEndVKHSmwQcNXnKP8KpaO12xJykVtTje8Bjz04D3nc6eA9BTW
         tzPWMbZJ12iNcQN2iq2NH4rZ2DrI5Z6lbAnAz7Tdq+l97cAHuIF2XZjL0sggUPD2iEW6
         64IQ==
X-Gm-Message-State: AJIora/MSGqVheNKslzNZt4XLED4nj+r1yNNIlVNns+Vv0ObqP/gTro+
        zaVq926TtyT0s5NY2laFJ14jhj7JsxL3SQ==
X-Google-Smtp-Source: AGRyM1tVdXaVsQm7jLPm4SWsUXJ32TvoCX8tMg8AnAhTDvikIGvlqTGiIIAzYYTV6UyDSGye5umtjw==
X-Received: by 2002:ac2:5a03:0:b0:47f:90ee:4c9 with SMTP id q3-20020ac25a03000000b0047f90ee04c9mr26352628lfn.319.1657090519863;
        Tue, 05 Jul 2022 23:55:19 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512114400b00478772eb18esm6127941lfg.92.2022.07.05.23.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 23:55:19 -0700 (PDT)
Message-ID: <3f4f62da-302f-c6cb-0c32-73f4e36e5022@linaro.org>
Date:   Wed, 6 Jul 2022 08:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] dt-bindings: qcom: document preferred compatible
 naming
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20220705161301.493364-1-krzysztof.kozlowski@linaro.org>
 <1657048737.406960.2471232.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1657048737.406960.2471232.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 21:18, Rob Herring wrote:
> On Tue, 05 Jul 2022 18:13:01 +0200, Krzysztof Kozlowski wrote:
>> Compatibles can come in two formats.  Either "vendor,ip-soc" or
>> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
>> DT schema file documenting preferred policy and enforcing it for all new
>> compatibles, except few existing patterns.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v3:
>> 1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
>> 2. Add ipq806x entries to list of exceptions.
>>
>> Changes since v2:
>> 1. Narrow the expected pattern to be followed by dash '-' after model
>>    number (msm8996-) or by two letters and a dash (sc8280xp-).
>> 2. Add qcom,apss-wdt-xxx to list of exceptions.
>> 3. Use comment instead of description in the oneOf list.
>>
>> Changes since v1:
>> 1. Add schema instead of readme (Rob).
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Alex Elder <elder@linaro.org>
>> Cc: Robert Foss <robert.foss@linaro.org>
>> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>  .../devicetree/bindings/arm/qcom-soc.yaml     | 63 +++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.example.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
> 	'qcom,qcs404' does not match '^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$'
> 	'qcom,qcs404' does not match '^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$'
> 	'qcom,qcs404' does not match '^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,qcs404' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,qcs404' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,qcs404' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,qcs404' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,qcs404' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,qcs404' is not one of ['qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
> 	'qcom,qcs404' is not one of ['qcom,ipq806x-nand', 'qcom,ipq806x-usb-phy-ss', 'qcom,ipq806x-usb-phy-hs']
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 

This is fixed by:
https://lore.kernel.org/all/20220627143340.477120-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20220628092253.21905-1-krzysztof.kozlowski@linaro.org/



Best regards,
Krzysztof

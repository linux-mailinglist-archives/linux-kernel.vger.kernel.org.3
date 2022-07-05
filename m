Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D7566600
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiGEJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiGEJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:23:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0424658C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:23:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g11so4287139lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=azfm5IkOFbR/Ne2mZUDNcaxYCwj/Vq0LQkRHTreQXb4=;
        b=mNldFiLMMGfjxisxs8Cl/hQAEuKcZmzhvX2/xD5tWUGZYC2EHa1W5kdkl7SsxL/7dI
         7W89GKjaZTVu+k46O3HkHIgmV2akMEW5E87hS0fyg7jvs4nHHp1kmWwlP+5Zgc7T3+zG
         LS+07jtuFCt0fAEpmvSvJsqRCU6UWr+ejWdZ9kPVVmqwmACJySGTt8TEkLK/ZXL8RJeQ
         mYewAEVD0RAgXpsdIjyxAY9J3dHMCTSmdMlhr0NAhquCPY0jQNW6UOE8TmyWBdXBYrDP
         4TttBsWFEErwCR3FHQdQIYr1mX80QdVZw0aI/nNJHiIfbVMb7iIyxGNFL0umMhMa74/N
         Le1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=azfm5IkOFbR/Ne2mZUDNcaxYCwj/Vq0LQkRHTreQXb4=;
        b=VUO6UuhX4I1jRW4m3j/dpwH8Ytial+oiaUwLAtBsdr5HD4nDX5DNa+YkFaUkwJswRd
         jvCWY0AsvrLszx/+iNl+eomDrDMwaKKq+hrktFHcVBW7X7pMvBdpIo8tdLmeJtZ/7aHq
         8s4Wu46iwx36BzCgftTpXcWMwozX/nBhmckiey2MbMLV0eVllnHqR7G676i1L9QNy3wf
         vZvkT9yxRHn49/gcEE6+Scjdz2aNEgw2xkZWD9DLkIqB2B8sUgD9CPBBego9v0a6O69f
         GplIbw6yb09zPWik3r5CwtUvBJL808VurN/PPqZuTK7o2DLrUtg1rck31WAcAHn/bCDH
         JI9A==
X-Gm-Message-State: AJIora+Yz+6LESVIa+au8Of0NwnsTmn8qeI5WetT/YDSRSTc9XeYsvMi
        Vhfq2Mm+JIVxqcnAj0DmVyI1Jw==
X-Google-Smtp-Source: AGRyM1tZmoSAtoAUoG2iVV6RJV8G+vjL+wLv3WVd22vxSOgB1LjIy1pqq6+eSqfYqalrW9Aut7or0Q==
X-Received: by 2002:a05:6512:3d1a:b0:47f:79df:2ea8 with SMTP id d26-20020a0565123d1a00b0047f79df2ea8mr23969340lfv.610.1657012992047;
        Tue, 05 Jul 2022 02:23:12 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id o15-20020ac2434f000000b00478a8b7ab1csm5595746lfl.150.2022.07.05.02.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:23:11 -0700 (PDT)
Message-ID: <1e16394d-42e7-2163-377f-a42fc531cd6e@linaro.org>
Date:   Tue, 5 Jul 2022 11:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dt-bindings: qcom: document preferred compatible
 naming
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20220704101823.82122-1-krzysztof.kozlowski@linaro.org>
 <1656982255.085936.640432.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656982255.085936.640432.nullmailer@robh.at.kernel.org>
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

On 05/07/2022 02:50, Rob Herring wrote:
> On Mon, 04 Jul 2022 12:18:23 +0200, Krzysztof Kozlowski wrote:
>> Compatibles can come in two formats.  Either "vendor,ip-soc" or
>> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
>> DT schema file documenting preferred policy and enforcing it for all new
>> compatibles, except few existing patterns.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
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
>>  .../devicetree/bindings/arm/qcom-soc.yaml     | 55 +++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dtb: watchdog@208a038: compatible: 'oneOf' conditional failed, one must be fixed:
> 	'qcom,kpss-wdt-ipq8064' does not match '^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,kpss-wdt-ipq8064' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,kpss-wdt-ipq8064' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,kpss-wdt-ipq8064' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,kpss-wdt-ipq8064' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,kpss-wdt-ipq8064' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> 	'qcom,kpss-wdt-ipq8064' is not one of ['qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom-soc.yaml


I'll fix it.


Best regards,
Krzysztof

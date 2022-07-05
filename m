Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7355677A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiGETTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiGETTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:19:08 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D920F43;
        Tue,  5 Jul 2022 12:19:07 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id v1so4670602ilg.11;
        Tue, 05 Jul 2022 12:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jTxl5HhQ1EHwkX7hjTWK1v+9qwbhzKvOp5HOmYTqR9s=;
        b=Dx5mgunt9O9geSoOpnx0ondGBESCafqJjfZ8nZvxAL1TTNuSo6gxcGSukwrpf1Hrku
         ImaPl0awPwfuE5Zh/1ql7CvGjzNd3sI61Eh9ONH9oV8hNOqirx5gpEvWQMMzgpM7wUIq
         IMj9EfgndyfGl43cMrHJz6TARwVFYAbIwEOhp546aJwD7SOQ33/zwKMkbicti7SNsmVE
         Qw+AoRRsNl40EfA/i3nqA+48DrE7lUrq6b8VZ/rC9cUK2mpLT/9ZsNyzrC4T8tF3CYQ6
         TGBM+qpO4S3fnSUgoC0/Q9n244ClDSEPo+3/OL40bX7xWi0XJRfU4KxiQhw7KdYgVDHB
         eoZw==
X-Gm-Message-State: AJIora+BHQNxaYHFbaoVwRD4EIbCeJh8uYYoRGD0/QT1XBSqcwdHwcLA
        O9kdcbkZchMbuF08xwbGkKYZ8h1exA==
X-Google-Smtp-Source: AGRyM1tKSR6yEqXJ3Y3wA7863KnAkPiSf8wzj0xQy1WNVfh2oUq4S8o6zzeBIJRmcWeow2I9xMZeXQ==
X-Received: by 2002:a05:6e02:18c5:b0:2da:df7e:2a09 with SMTP id s5-20020a056e0218c500b002dadf7e2a09mr16311399ilu.83.1657048746360;
        Tue, 05 Jul 2022 12:19:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b18-20020a92c852000000b002dc251040besm1012900ilq.46.2022.07.05.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:19:06 -0700 (PDT)
Received: (nullmailer pid 2471233 invoked by uid 1000);
        Tue, 05 Jul 2022 19:18:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20220705161301.493364-1-krzysztof.kozlowski@linaro.org>
References: <20220705161301.493364-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: qcom: document preferred compatible naming
Date:   Tue, 05 Jul 2022 13:18:57 -0600
Message-Id: <1657048737.406960.2471232.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022 18:13:01 +0200, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> DT schema file documenting preferred policy and enforcing it for all new
> compatibles, except few existing patterns.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v3:
> 1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
> 2. Add ipq806x entries to list of exceptions.
> 
> Changes since v2:
> 1. Narrow the expected pattern to be followed by dash '-' after model
>    number (msm8996-) or by two letters and a dash (sc8280xp-).
> 2. Add qcom,apss-wdt-xxx to list of exceptions.
> 3. Use comment instead of description in the oneOf list.
> 
> Changes since v1:
> 1. Add schema instead of readme (Rob).
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.example.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,qcs404' does not match '^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$'
	'qcom,qcs404' does not match '^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$'
	'qcom,qcs404' does not match '^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,qcs404' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,qcs404' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,qcs404' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,qcs404' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,qcs404' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,qcs404' is not one of ['qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
	'qcom,qcs404' is not one of ['qcom,ipq806x-nand', 'qcom,ipq806x-usb-phy-ss', 'qcom,ipq806x-usb-phy-hs']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom-soc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


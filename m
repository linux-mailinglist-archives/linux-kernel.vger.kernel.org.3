Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F73572175
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiGLQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGLQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:57:19 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA5BA3B7;
        Tue, 12 Jul 2022 09:57:17 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id d4so3961276ilc.8;
        Tue, 12 Jul 2022 09:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bO4cis7Fu6e3Sp6G9HzdVn/dbSUsSia8XAXEeOC2q4I=;
        b=xbK8nX1ZdjvY7EExhvh3jXrfuUV+Kt2Y/qxtDFQiFk/P/k3oRfzKDu36G62pI0Jde8
         HqSrFBeYHg4HEqBXw5RQ0lClSn5oE/RtlvowdKqdhYKMqxBKejrnjSuy4vqiwsY+nNEn
         7nctk7xz/OCfXMmIgLfGq/RmvoIZZ0NKJ2qpL0wZ21hGrR9A6ZQ01+zQaKOFsyVQUnyp
         EsM5m8DSn2g9Z+oEC2oA+o6ZFjZypM3Rmek9TPZ2QpFoOV7eOD91OdpuXDkKTmdBvV2d
         p+m4QUEsxFHCLCToQtCcL3e0o1L8hhuc/KFSMrm6LZRkm05DVIuloqzCStA/I2gqB0zd
         hgEA==
X-Gm-Message-State: AJIora+wQ3AmdnC+mezDuzatOStj5lTvaBFtSPWjhl9pE/KPgd1XHVV7
        iZhSP4G+/msJE/9XhsR9Zg==
X-Google-Smtp-Source: AGRyM1udMn8pbyabNzTUkhKwpXdRhSD4MzQfo0is+Z0Sw1A4/pvUbtI9AS4iImStQlQEGGNVMit23A==
X-Received: by 2002:a92:cda2:0:b0:2dc:7060:ef14 with SMTP id g2-20020a92cda2000000b002dc7060ef14mr8871282ild.56.1657645037165;
        Tue, 12 Jul 2022 09:57:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n9-20020a056e021ba900b002d3ad9791dcsm3880957ili.27.2022.07.12.09.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:57:16 -0700 (PDT)
Received: (nullmailer pid 2015943 invoked by uid 1000);
        Tue, 12 Jul 2022 16:57:15 -0000
Date:   Tue, 12 Jul 2022 10:57:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v4] dt-bindings: qcom: document preferred compatible
 naming
Message-ID: <20220712165715.GD1823936-robh@kernel.org>
References: <20220705161301.493364-1-krzysztof.kozlowski@linaro.org>
 <1657048737.406960.2471232.nullmailer@robh.at.kernel.org>
 <3f4f62da-302f-c6cb-0c32-73f4e36e5022@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4f62da-302f-c6cb-0c32-73f4e36e5022@linaro.org>
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

On Wed, Jul 06, 2022 at 08:55:18AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 21:18, Rob Herring wrote:
> > On Tue, 05 Jul 2022 18:13:01 +0200, Krzysztof Kozlowski wrote:
> >> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> >> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> >> DT schema file documenting preferred policy and enforcing it for all new
> >> compatibles, except few existing patterns.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v3:
> >> 1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
> >> 2. Add ipq806x entries to list of exceptions.
> >>
> >> Changes since v2:
> >> 1. Narrow the expected pattern to be followed by dash '-' after model
> >>    number (msm8996-) or by two letters and a dash (sc8280xp-).
> >> 2. Add qcom,apss-wdt-xxx to list of exceptions.
> >> 3. Use comment instead of description in the oneOf list.
> >>
> >> Changes since v1:
> >> 1. Add schema instead of readme (Rob).
> >>
> >> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Cc: Vinod Koul <vkoul@kernel.org>
> >> Cc: Alex Elder <elder@linaro.org>
> >> Cc: Robert Foss <robert.foss@linaro.org>
> >> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >> ---
> >>  .../devicetree/bindings/arm/qcom-soc.yaml     | 63 +++++++++++++++++++
> >>  1 file changed, 63 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.example.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
> > 	'qcom,qcs404' does not match '^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$'
> > 	'qcom,qcs404' does not match '^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$'
> > 	'qcom,qcs404' does not match '^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> > 	'qcom,qcs404' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> > 	'qcom,qcs404' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> > 	'qcom,qcs404' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> > 	'qcom,qcs404' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> > 	'qcom,qcs404' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
> > 	'qcom,qcs404' is not one of ['qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
> > 	'qcom,qcs404' is not one of ['qcom,ipq806x-nand', 'qcom,ipq806x-usb-phy-ss', 'qcom,ipq806x-usb-phy-hs']
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > 
> 
> This is fixed by:
> https://lore.kernel.org/all/20220627143340.477120-1-krzysztof.kozlowski@linaro.org/
> https://lore.kernel.org/all/20220628092253.21905-1-krzysztof.kozlowski@linaro.org/

Okay, as long as those are applied together:

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E920566046
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiGEAvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiGEAvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:51:00 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F109DFBC;
        Mon,  4 Jul 2022 17:50:59 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id p18so1323521ilm.4;
        Mon, 04 Jul 2022 17:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=89KjpwQSZh9LmuprYfos6M0tURXh9vtVeeMCEAAc88E=;
        b=dZefZlpMa2koHl/O1LgkSpdqzpme36St9t8yEd+B828f8baad+K5FXsAotQi38/nFj
         D8jy1okRhmSCXY0AJghGkFz3rWns21YBT1mEuNgbiz4oBEOtFnQJitx/M+vdjsbaKKDX
         LRVE6z/ER2wv29stOXU+Y2DkcjutPSwTIzGIDWtd4LC/SJYlW59hT1R5cj+CG34fZMGU
         rysvUgekqLa3tvVALLBnYKB8fZekcxQ6uPdYoG7T2WXFyqBdLA5XiebxY302vuuUtSD3
         3MG8JII1QbfC3vs4EpKwnOGmdxgZE6EqUB91PgZ5IzH3L3yhC7JCYGblwh5ub5wbY9wP
         dwXQ==
X-Gm-Message-State: AJIora/d6UlYooe/HXijZ/KQkeeG9YteVnoMPVqBDKuGNdIQVyjLVk0t
        ceS4Z2vduHF1r0QbanGAwQ==
X-Google-Smtp-Source: AGRyM1vDyHROdsxLCVYcOzTaNLFF7Pwc9YmEHy7OjjQooH8K7rUKTpN5WKSyWyIP8HJAAoj31GkV3w==
X-Received: by 2002:a05:6e02:1708:b0:2da:9eef:5bc8 with SMTP id u8-20020a056e02170800b002da9eef5bc8mr19172259ill.153.1656982258663;
        Mon, 04 Jul 2022 17:50:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 15-20020a92c64f000000b002dc07e2165dsm2491410ill.78.2022.07.04.17.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 17:50:58 -0700 (PDT)
Received: (nullmailer pid 640434 invoked by uid 1000);
        Tue, 05 Jul 2022 00:50:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20220704101823.82122-1-krzysztof.kozlowski@linaro.org>
References: <20220704101823.82122-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: qcom: document preferred compatible naming
Date:   Mon, 04 Jul 2022 18:50:55 -0600
Message-Id: <1656982255.085936.640432.nullmailer@robh.at.kernel.org>
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

On Mon, 04 Jul 2022 12:18:23 +0200, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> DT schema file documenting preferred policy and enforcing it for all new
> compatibles, except few existing patterns.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
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
>  .../devicetree/bindings/arm/qcom-soc.yaml     | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/qcom-wdt.example.dtb: watchdog@208a038: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,kpss-wdt-ipq8064' does not match '^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,kpss-wdt-ipq8064' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,kpss-wdt-ipq8064' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,kpss-wdt-ipq8064' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,kpss-wdt-ipq8064' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,kpss-wdt-ipq8064' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$'
	'qcom,kpss-wdt-ipq8064' is not one of ['qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
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


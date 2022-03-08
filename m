Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85F4D0D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbiCHBIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbiCHBIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:08:44 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3227FE3;
        Mon,  7 Mar 2022 17:07:43 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso2984102otj.0;
        Mon, 07 Mar 2022 17:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AXhk87B4/bnkMfjopxc1BmeoKxcuO0tvUc8hpwm05to=;
        b=sL/+hXxGxheb/N1yMwVYhc2l48Ih+1TFGtxq0zNT+tpz2TfdjgLsuIwEQa0z2+XTai
         YcC3haZVsPvvKubxGNaQsyWF7Js59VOxAabF7mCzm9NBTXUAzgdzYq95MtSQGgnkfI5o
         TsOJ10txDbN/RIbtOkhS9nMis1Vc17a9S6Ps317nKN2b4tDBnf9c8Wz6iAVhAZEn4zNh
         eENigG29zO/2JGWxFBdkuDac9FEKO5pUcZFzakNSCmv2oXwfIZL0ArVwhs34W78ewglB
         SfuWeIcZYIupZJvtUcdllJfCWEjnwml0nh6zRcYgFpDpPutT8WxPjmKtd87cIqd7gqpJ
         b/3w==
X-Gm-Message-State: AOAM533ghzcKO5r0+9bsBXhjqbbAeyUFc722/lxXn3qim9Tb+C0OshyT
        C6swhd5rp2DL5MEdS4YxTXD3gDQmRg==
X-Google-Smtp-Source: ABdhPJzn4SS8H2D3LcuArY1ilEzraCp1I+bYiZd0tC9ud0GA56WPW8s5KAZk8MQKW5CA6TpzwpbTsQ==
X-Received: by 2002:a9d:6f82:0:b0:5af:1555:5a9b with SMTP id h2-20020a9d6f82000000b005af15555a9bmr7680357otq.289.1646701663016;
        Mon, 07 Mar 2022 17:07:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a54470d000000b002d9b7fa03e1sm3218336oik.12.2022.03.07.17.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:07:41 -0800 (PST)
Received: (nullmailer pid 3624765 invoked by uid 1000);
        Tue, 08 Mar 2022 01:07:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     viresh.kumar@linaro.org, angelogioacchino.delregno@somainline.org,
        rafael@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20220307064531.47678-2-manivannan.sadhasivam@linaro.org>
References: <20220307064531.47678-1-manivannan.sadhasivam@linaro.org> <20220307064531.47678-2-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
Date:   Mon, 07 Mar 2022 19:07:40 -0600
Message-Id: <1646701660.877031.3624764.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022 12:15:30 +0530, Manivannan Sadhasivam wrote:
> Convert Qualcomm cpufreq devicetree binding to YAML.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 201 ++++++++++++++++++
>  2 files changed, 201 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: reg: [[305397760, 4096]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#freq-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#performance-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1601894

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


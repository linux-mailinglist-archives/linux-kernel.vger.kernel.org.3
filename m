Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED94F02DB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355676AbiDBNsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiDBNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:48:47 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01B15D3B5;
        Sat,  2 Apr 2022 06:46:53 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so4042719otj.1;
        Sat, 02 Apr 2022 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=HYiZb3WrZ7CUV91tcHRmrgto4b3G284hWI6pzO7rQDE=;
        b=wQSB4J6OUa0VVRS/UNiHQI1bogfYEqF7BdWV7xQmZyKBA370B69Y7ZR6uMnyT4ldO7
         86rkahdDU3mLat0W5O1Y8qRrkoXve2VDu1UU7uldtQPpBbIrrMDMkswj9NybimXcLxsI
         eLUcgq9ROM0iVc2FvNDhkD5LYwE7R93PV8V/KMb5mxJDgFZHTrRzG/GXn0X+vJZqejpW
         RWkmewmook18xdtM48btThwulFBx30kfGiUXigiMDi22Xu1+6IW6j7mu+Wn9vFL+pmUa
         xD9cmsHhdT8PYLc+k8+86RdPFqiu9bNnGxZ7L2CA2onio4uvXXfEjQA8LcbE+jzfMsC7
         E/ow==
X-Gm-Message-State: AOAM533mhJEArCiddFU85LXXSBRwoI8wflxc8ZJTlAhpk/bIjrVKWP9U
        2A0/WczgVhDyMOs2PtarbB87avHdfg==
X-Google-Smtp-Source: ABdhPJyLrYk/9AnSO+95mMbuL74a0TK/kgxxJaJ3MXMZa/yl/BWUGYF5cAh3jDSgGq9lskMa8xPJ8w==
X-Received: by 2002:a05:6830:2684:b0:5cd:bb2f:a5bf with SMTP id l4-20020a056830268400b005cdbb2fa5bfmr8837891otu.383.1648907212737;
        Sat, 02 Apr 2022 06:46:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c12-20020a9d75cc000000b005b24b061940sm2357258otl.33.2022.04.02.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 06:46:52 -0700 (PDT)
Received: (nullmailer pid 903499 invoked by uid 1000);
        Sat, 02 Apr 2022 13:46:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20220401171035.1096670-1-krzysztof.kozlowski@linaro.org>
References: <20220401171035.1096670-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom,smp2p: convert to dtschema
Date:   Sat, 02 Apr 2022 08:46:51 -0500
Message-Id: <1648907211.818465.903498.nullmailer@robh.at.kernel.org>
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

On Fri, 01 Apr 2022 19:10:35 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory Point 2 Point bindings to DT Schema.
> 
> Changes against original bindings: enforce only specific names of child
> nodes, instead of any names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,smp2p.txt          | 110 -------------
>  .../bindings/soc/qcom/qcom,smp2p.yaml         | 145 ++++++++++++++++++
>  2 files changed, 145 insertions(+), 110 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'qcom,local-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'qcom,remote-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'qcom,smem' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'oneOf' conditional failed, one must be fixed:
	'mboxes' is a required property
	'qcom,ipc' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/qcom,ipa.example.dt.yaml: smp2p-mpss: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom-ipcc.example.dt.yaml: smp2p-modem: 'qcom,local-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom-ipcc.example.dt.yaml: smp2p-modem: 'qcom,remote-pid' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/qcom-ipcc.example.dt.yaml: smp2p-modem: 'qcom,smem' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


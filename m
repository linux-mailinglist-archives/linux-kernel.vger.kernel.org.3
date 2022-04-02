Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA64F02DA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355704AbiDBNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbiDBNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:48:47 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3F415DABB;
        Sat,  2 Apr 2022 06:46:54 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id b188so5462633oia.13;
        Sat, 02 Apr 2022 06:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PYegHaEuhlY2VhKGl3I3pW9pPdgl7qRkG8VHF5n6JTw=;
        b=FYPHnBWqroeBrbArtZQBD1Q3KEmj8oF0r9EHenL1v5o1HGQ5GSL+IF7sNvBSBaKidb
         /Ak5Ra8JWE9owNnc0cK+diNu9keodYYrq2RE71FIYbEQps9FFXB89bzj/OoDE65qsDCm
         aYTfcMuW7GZ2w5mAdEI7iMYq2XX18oTnB1rLBp1znY3cf+pMET8pXpIskMIKjtxBfZ2q
         9RN2/u3y0HOla1VzI94nk0ybRBhT147OMgI37dWlXzeyaxbk113HRQZql/SUyvsVvI4I
         UTDRCiPoXvjlI8F8+558ksDn9QNR3BgGlisZoJnqIdiHvw3x2z9k/ojT+7oZGYwazI2S
         eCyQ==
X-Gm-Message-State: AOAM532Reml2u8bo2nLFA9CLp5A0+Jydykh0Yqw+0y7Z+bVjZB39Lc2n
        d7BRaV+6YjSb50wGHttRjGo48YS13Q==
X-Google-Smtp-Source: ABdhPJx1x7E35z39ft+D4POeguSDa0gubfQC2fnl4EmTmsyuU+lI7tGV/uos8UwZuGXiMoWb3u+Qsg==
X-Received: by 2002:a05:6808:2008:b0:2da:5b12:83ff with SMTP id q8-20020a056808200800b002da5b1283ffmr6521278oiw.216.1648907214036;
        Sat, 02 Apr 2022 06:46:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l12-20020a056870d3cc00b000ddeb925982sm2101659oag.38.2022.04.02.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 06:46:53 -0700 (PDT)
Received: (nullmailer pid 903502 invoked by uid 1000);
        Sat, 02 Apr 2022 13:46:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20220401201035.189106-9-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org> <20220401201035.189106-9-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 08/10] dt-bindings: soc: qcom,smd: convert to dtschema
Date:   Sat, 02 Apr 2022 08:46:51 -0500
Message-Id: <1648907211.831405.903501.nullmailer@robh.at.kernel.org>
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

On Fri, 01 Apr 2022 22:10:33 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory Driver bindings to DT Schema.
> 
> Changes against original bindings: enforce only specific names of child
> nodes, instead of any names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../regulator/qcom,smd-rpm-regulator.yaml     |   2 +-
>  .../bindings/remoteproc/qcom,q6v5.txt         |   2 +-
>  .../bindings/remoteproc/qcom,wcnss-pil.txt    |   2 +-
>  .../bindings/soc/qcom/qcom,smd-rpm.yaml       |   4 +-
>  .../devicetree/bindings/soc/qcom/qcom,smd.txt |  98 -------------
>  .../bindings/soc/qcom/qcom,smd.yaml           | 137 ++++++++++++++++++
>  6 files changed, 142 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smd.example.dt.yaml: rpm-requests: 'clock-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
Documentation/devicetree/bindings/soc/qcom/qcom,smd.example.dt.yaml:0:0: /example-0/shared-memory/rpm/rpm-requests/clock-controller: failed to match any schema with compatible: ['qcom,rpmcc-msm8974', 'qcom,rpmcc']
Documentation/devicetree/bindings/soc/qcom/qcom,smd.example.dt.yaml:0:0: /example-0/shared-memory/rpm/rpm-requests/clock-controller: failed to match any schema with compatible: ['qcom,rpmcc-msm8974', 'qcom,rpmcc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


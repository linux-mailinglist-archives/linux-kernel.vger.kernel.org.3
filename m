Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102A156704D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiGEOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiGEOGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:06:25 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04139237EF;
        Tue,  5 Jul 2022 06:54:40 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p69so11132696iod.10;
        Tue, 05 Jul 2022 06:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=C0Erhk9To/7rIjjiO+9MuSp924KsHFPnMjsP3V7msnQ=;
        b=py5ruxiv5LHEpm1Oq3v+y+btfJf1wI/QCHFEMuaBei11VJeHNVXLeYgLMe8lRLCsYD
         o9rLyIM0eldgC/K8uKW1jMuK8MjwFHdKGlAfy2jtTnomRlm7YYwyacLo+fDgxwwPkTCZ
         ynmCh0LrNtAGmu91KNGDb3vHWssKegcNEVSdbN9SMi8VHu3dph8jDkcQ5azu/6xDearr
         GDP94u0HMunH7MFDAQ3yBukxjjpN11RQdfi7hihAmiLA12+JrfBBlEbK4piykEjPAt00
         AMg+d4xQJnqYgxmR4Y+IOY2rc5lO2DGMqaWjBGJVK4r73H4cd/HSPVoFLD+dzOu29to6
         2rTQ==
X-Gm-Message-State: AJIora/0qk6RKtP8JAq5n3qC3E1LM24Q5gM2OZyRcp4/tdR46xZ8Xq2u
        huL65NPqrjh75gnkz9YLBQ==
X-Google-Smtp-Source: AGRyM1seMsK4ptpqLHhWfEoLMLQgP0++6s7fhJZFk+zA/SDMjQenWTm0BiPdQRIK/XyX+gBz4/C5BA==
X-Received: by 2002:a6b:fb05:0:b0:657:655e:a287 with SMTP id h5-20020a6bfb05000000b00657655ea287mr19384229iog.211.1657029279231;
        Tue, 05 Jul 2022 06:54:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o27-20020a02a1db000000b00339ef592279sm14613515jah.127.2022.07.05.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:54:38 -0700 (PDT)
Received: (nullmailer pid 1999999 invoked by uid 1000);
        Tue, 05 Jul 2022 13:54:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, konrad.dybcio@somainline.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, swboyd@chromium.org,
        mathieu.poirier@linaro.org, agross@kernel.org
In-Reply-To: <1657020721-24939-2-git-send-email-quic_sibis@quicinc.com>
References: <1657020721-24939-1-git-send-email-quic_sibis@quicinc.com> <1657020721-24939-2-git-send-email-quic_sibis@quicinc.com>
Subject: Re: [V5 1/2] dt-bindings: remoteproc: qcom: Convert SC7280 MSS bindings to YAML
Date:   Tue, 05 Jul 2022 07:54:31 -0600
Message-Id: <1657029271.238790.1999998.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Jul 2022 17:02:00 +0530, Sibi Sankar wrote:
> Add a separate YAML binding to act as a superset of the PAS and non-PAS
> compatible for SC7280 MSS PIL. This also serves as a way to increase
> readability.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> Depends on Krzysztof's remoteproc cleanups and improvements:
> https://patchwork.kernel.org/project/linux-arm-msm/cover/20220517070113.18023-1-krzysztof.kozlowski@linaro.org/
> 
> Previous discussions on PAS vs non-PAS bindings:
> https://lore.kernel.org/lkml/YUps1JfGtf6JdbCx@ripper/ [Bjorn]
> https://lore.kernel.org/lkml/CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com/ [Stephen]
> 
> v5:
>  * Improve phandle-array schemas [Stephen/Rob/Krzysztof]
>  * Add more details to the firmware-name/memory region string array [Stephen/Rob]
>  * Drop 'items' from label [Rob]
> 
> v4:
>  * Remove older bindings [Matthias/Krzysztof]
>  * Misc. Fixes [Krzysztof]
>  * Rebased on v2 of Krzysztof's bindings cleanups
> 
> v3:
>  * Re-ordered clock list, fixed pdc_sync typo [Rob/Matthias]
> 
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  31 +--
>  .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 266 +++++++++++++++++++++
>  2 files changed, 268 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,glink-edge.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.example.dtb: remoteproc@4080000: glink-edge: False schema does not allow {'interrupts-extended': [[4294967295, 2, 0, 1]], 'mboxes': [[4294967295, 2, 0]], 'label': ['modem'], 'qcom,remote-pid': [[1]]}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


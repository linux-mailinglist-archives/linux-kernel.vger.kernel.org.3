Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181BF5AF301
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIFRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIFRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:46:51 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D176EF1C;
        Tue,  6 Sep 2022 10:46:45 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11ee4649dfcso30087966fac.1;
        Tue, 06 Sep 2022 10:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HzG5COCo19lT3oBLgm1nvDwcIQQgyJlzuG7SNbHTaDU=;
        b=EfqvCJv4EJGQHW2EngMd2R2Spen4DloQpQ/TVy3FXX+OcC4HEH/9A0TD01GIZVq9iE
         FdA9FrMSRcdFJkTgMVTXbJLQheTBNdNTq0l5pPKyk/J06QcUHHBDrLLZoIsuScKx/KLZ
         5qelH67uJdEjIBWm5Rtwgbw3SHA/SrIFf8x+Mo0AxcGLVcgsT0oytuOSRKMZcf4hZsKn
         Rx9umggsKQyxNSBYLQUz2aqh7Osp+fNHzzpiuM931VIC9cs0P/+KTZjg9Cx4Ux773RSW
         DP+4eBBmvl62FZ7B519rTgm1kTpNjrNLEcBlp0FAC9n7xXJ4ufFZLIK1xjOP/WQjj2gT
         13XQ==
X-Gm-Message-State: ACgBeo1GnHzqDaHPUzUiyIFH5P66Mg0/fyanwbiVfW50mBSncs2DznOy
        4WJnM9KH+lZeG/hnCcLhx+oMuoLYWw==
X-Google-Smtp-Source: AA6agR6RDLZuCPdeXtZwiyPUodQixHiTacheiSfTh+HaN2WJ01ett6hG3ahw/odd+L270KgcOrJkyA==
X-Received: by 2002:a05:6870:430b:b0:101:3d98:ba41 with SMTP id w11-20020a056870430b00b001013d98ba41mr12501688oah.46.1662486404036;
        Tue, 06 Sep 2022 10:46:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 22-20020aca0916000000b00344adbc3492sm5583872oij.24.2022.09.06.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:46:43 -0700 (PDT)
Received: (nullmailer pid 780017 invoked by uid 1000);
        Tue, 06 Sep 2022 17:46:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220906121655.303693-10-krzysztof.kozlowski@linaro.org>
References: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org> <20220906121655.303693-10-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 09/12] dt-bindings: soc: qcom: apr: correct service children
Date:   Tue, 06 Sep 2022 12:46:42 -0500
Message-Id: <1662486402.667876.780014.nullmailer@robh.at.kernel.org>
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

On Tue, 06 Sep 2022 14:16:52 +0200, Krzysztof Kozlowski wrote:
> The APR bindings were not describing properly children nodes for DAIs.
> None of the DTSes use unit addresses for the children, so correct the
> nodes and reference their schema: clock-controller, dais and routing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,apr.yaml           | 38 +++++++++++++------
>  .../sound/qcom,q6dsp-lpass-clocks.yaml        | 16 ++------
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 16 ++------
>  3 files changed, 35 insertions(+), 35 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.example.dtb: gpr: service@1: '#address-cells', '#size-cells', 'apm-dai@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


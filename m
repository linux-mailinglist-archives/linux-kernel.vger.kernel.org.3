Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008C5ABA1D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIBVec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiIBVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:34:28 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9310A6;
        Fri,  2 Sep 2022 14:34:27 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11f34610d4aso7876511fac.9;
        Fri, 02 Sep 2022 14:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XXjP8cgiaYw1PqhWIGrRkQJ366WMJ28RuFPXWF5wiYY=;
        b=Xohw6WOKydHeUjUzINi7qJMpswv8fCRqKPT3htN8dHYht0eSpLd57Sa10zUGCZ1/z3
         CEBLlStKEsVGFJ8BOzSSEYYR2D5I+ailRXU0PRWwamspSRwoXxchoNuoG+51miNjK2Pc
         cfWp8BmLCgpEjlTGff8QVg77TvhWLVO5O30ZbvCZZPn8csCzC/uHIdUIHxZ//Md/R9Al
         wV5lyEB16Abczbb4k3v+aHFcNJoeq8Y4IuEbL2AOdRXZxUjS0or3OifwiX47AyYds9yW
         OLKabLJoc14LcM6tJaOBnOmslXlyxCxJiDg6zl1+OTNkLY4QUsAK5MdyjY7aK8AoiTGi
         uXIw==
X-Gm-Message-State: ACgBeo2qJ2tAxPXXM/PmE6qjo0VCsrOvmdTd93x3y9tcLITYlqZ0EGba
        65643Zcu5ZFE9/jTSdz3hQ==
X-Google-Smtp-Source: AA6agR5MrliGH4/f0zSChYbho79KSE2oXFvKHQsWTmYQTKWOiMRQWDjOZm8zWMidzrHnWhrZZqaIXw==
X-Received: by 2002:a05:6870:c0c1:b0:10d:96:737f with SMTP id e1-20020a056870c0c100b0010d0096737fmr3329609oad.101.1662154466229;
        Fri, 02 Sep 2022 14:34:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf15-20020a056808190f00b00344eb5a9416sm1415354oib.55.2022.09.02.14.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:34:25 -0700 (PDT)
Received: (nullmailer pid 454796 invoked by uid 1000);
        Fri, 02 Sep 2022 21:34:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, johan@kernel.org,
        konrad.dybcio@somainline.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        robh+dt@kernel.org
In-Reply-To: <20220902185148.635292-2-ahalaney@redhat.com>
References: <20220902185148.635292-1-ahalaney@redhat.com> <20220902185148.635292-2-ahalaney@redhat.com>
Subject: Re: [PATCH 1/3] regulator: dt-bindings: qcom,rpmh: Use additionalProperties
Date:   Fri, 02 Sep 2022 16:34:24 -0500
Message-Id: <1662154464.752050.454795.nullmailer@robh.at.kernel.org>
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

On Fri, 02 Sep 2022 13:51:46 -0500, Andrew Halaney wrote:
> Right now, running make dt_binding_check results in this snippet:
> 
>     /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml: 'additionalProperties' is a required property
>             hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
>             from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>     <snip..>
>     /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml: ignoring, error in schema:
> 
> Which results in the schema not being properly evaluated. Swap out
> unevaluatedProperties which doesn't seem to be doing anything for
> additionalProperties.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb: pm8998-rpmh-regulators: 'vdd-l7-l12-l14-l15-supply' does not match any of the regexes: '^(smps|ldo|lvs)[0-9]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


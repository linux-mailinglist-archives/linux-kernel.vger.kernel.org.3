Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CAC5912B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiHLPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiHLPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:13:57 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A658A347F;
        Fri, 12 Aug 2022 08:13:56 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id g18so618012ilk.4;
        Fri, 12 Aug 2022 08:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=qrYMH+Kwic0lNNdXlyACBjAld7jR6Z8oVCf9ilB6udQ=;
        b=esgETDHhTHHR2fsrlkrokpNO1tyKLmQ2Oh2Chii8sddOYhR+H/fodCZuQthG0p8c3F
         yDQlPKL3m27wnBn/K4rfxV8y9qWVmaf7ytdd92jsCPSzwranrtdh5jqSMY7L7A0snbVF
         Bmm/0qoGSpCEAEbsPJ1YD0dq0Lpis9YV42a1xmDCz2HRre77R4VDGpsTGZdOoVtaUKvo
         CM9l33vXh7VxOZiuurO9lO2nwRQsXixkAz1FdYrNTYf0CeWIiLTWztyGKjfKhttdeKVy
         Rv8FcFnFkmZ7AusloiuDOuk7TiQsXbJLcdMtbzqEbaoOiz7ONG2VrR6rQrkHpFkY3j7l
         HAAA==
X-Gm-Message-State: ACgBeo1HVqRmKnYgpt7JRsQghE0eBayIGKV5ItqBzVMki7PJeTZVL03s
        cHMiBhwJ8c/tBfMeXsJZTJYADRashQ==
X-Google-Smtp-Source: AA6agR4LIkp2IQh8Xf1gwt2+DMWiriYNLrEfpR8rav2W8/cROciO1rzAEhb1njHS4Nnbwm7Gm0KzRg==
X-Received: by 2002:a05:6e02:19cc:b0:2dd:ad68:7443 with SMTP id r12-20020a056e0219cc00b002ddad687443mr2092242ill.141.1660317235332;
        Fri, 12 Aug 2022 08:13:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bq12-20020a056638468c00b00343617e8368sm793015jab.99.2022.08.12.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:13:54 -0700 (PDT)
Received: (nullmailer pid 168973 invoked by uid 1000);
        Fri, 12 Aug 2022 15:13:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        devicetree@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220811040121.3775613-2-bjorn.andersson@linaro.org>
References: <20220811040121.3775613-1-bjorn.andersson@linaro.org> <20220811040121.3775613-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: Add binding for SC8280XP MDSS
Date:   Fri, 12 Aug 2022 09:13:53 -0600
Message-Id: <1660317233.413609.168972.nullmailer@robh.at.kernel.org>
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

On Wed, 10 Aug 2022 21:01:19 -0700, Bjorn Andersson wrote:
> Add binding for the display subsystem and display processing unit in the
> Qualcomm SC8280XP platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/display/msm/dpu-sc8280xp.yaml    | 284 ++++++++++++++++++
>  1 file changed, 284 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.example.dts:21:18: fatal error: dt-bindings/clock/qcom,dispcc-sc8280xp.h: No such file or directory
   21 |         #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


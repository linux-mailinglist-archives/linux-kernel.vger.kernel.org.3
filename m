Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBB561B98
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiF3Nos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiF3Nog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:44:36 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB021E24;
        Thu, 30 Jun 2022 06:44:35 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id a7so7320413ilj.2;
        Thu, 30 Jun 2022 06:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Z8mDVlSbha4NdYxU5YsfGzmYXWYXqbErOwEMSX5LHIo=;
        b=Kt1YL+mHJf9hunzIk06S/vuOAaHV1oN1Relr6yOdAxDZAxWzg8vS6dQSum237ZZkw3
         imGkYIlbJQZYxJdL7JC7Hw/zSHuKAy4w+F+vwDzTFKfqXgCyAXR41xw8MdV+ofqdv4NM
         oMQVN8Sl02AOVjfKPfhhG6+g8iiRrtnfg0uTQs4CUaOqrsdO4WAiDmjshIB5UW846v6O
         bQce6c4q2H/Tsr3fwQLH/C+qAQu3FegTf9N4+78A86SYKNssZxcFbuDiBBHbSVKEetvk
         PF/SE64wS/ONeTue1n1zPbJYVNxsRg81MGHv6A8+sIoNqtvZe3ccQQEifpnNNxM3nje4
         lthg==
X-Gm-Message-State: AJIora+GyJd8oZyDz8zLFsdnB3cQY8CxSYVUrvRoBRkfoe/PauB2CHRk
        QLsmAITtc31kD2Gr2VTt8rmhvdss1g==
X-Google-Smtp-Source: AGRyM1tlQIGr5JGSVoI87FnOiPSjS4ia/0L+AMvFUefhs/Wa7Rl13mcyD5e+BKaQY8PCnBB7mUdC6g==
X-Received: by 2002:a05:6e02:1b84:b0:2da:656a:ce11 with SMTP id h4-20020a056e021b8400b002da656ace11mr5403437ili.261.1656596674821;
        Thu, 30 Jun 2022 06:44:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r25-20020a02aa19000000b0032e71f31487sm8596290jam.31.2022.06.30.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:44:34 -0700 (PDT)
Received: (nullmailer pid 2569464 invoked by uid 1000);
        Thu, 30 Jun 2022 13:44:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220630055723.704605-2-leo.yan@linaro.org>
References: <20220630055723.704605-1-leo.yan@linaro.org> <20220630055723.704605-2-leo.yan@linaro.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: interconnect: Update property for icc-rpm path tag
Date:   Thu, 30 Jun 2022 07:44:25 -0600
Message-Id: <1656596665.853599.2569463.nullmailer@robh.at.kernel.org>
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

On Thu, 30 Jun 2022 13:57:18 +0800, Leo Yan wrote:
> To support path tag in icc-rpm driver, the "#interconnect-cells"
> property is updated as enumerate values: 1 or 2.  Setting to 1 means
> it is compatible with old DT binding that interconnect path only
> contains node id; if set to 2 for "#interconnect-cells" property, then
> the second specifier is used as a tag (e.g. vote for which buckets).
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,rpm.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml:49:11: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/interconnect/qcom,rpm.example.dts'
Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml:49:11: did not find expected key
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/interconnect/qcom,rpm.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml:49:11: did not find expected key
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml: ignoring, error parsing file
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


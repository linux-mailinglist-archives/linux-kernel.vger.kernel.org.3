Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0455912CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiHLPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiHLPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:14:05 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A19A722F;
        Fri, 12 Aug 2022 08:14:05 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id l24so1019977ion.13;
        Fri, 12 Aug 2022 08:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ONt5nx2+29vl7Qr6xNunvQr9OJIHCb4OXvsiVQGITMk=;
        b=377bRkpo961e/4QBLuAtI1vN2rDsCsv9fvRrPb+yxmL8q8DTxK4rKPQvLnm7bBj7pT
         J/C3hprJLBlqzm4eNJwyAUATw6lSyHG9MNmRcWk6TIeCjnf6O6BPJ+MCjIyvqN4JKjds
         vCFTH6JqH5IgTi6UAS0h3oqIUKzp8bn11NX4/l5gMKj2gIN83FJhEuaWdv5bdVuQ4SID
         tXGGLi/7fdegGV8nfE51cDUgzWV8heeEX+ho8r/elPrMkPGlyRpMqBnkJ7NET7G5WrRG
         yIe3xjha0pnq1j7wHeU+yz/f4RgGeg9M9tARmUVyrPlJuHWeKcUG+LpmcZt4+Wz4vBcq
         5Eag==
X-Gm-Message-State: ACgBeo1lrEeQquY9EDSre/VFRkVhKZl8uEKFSo0/MjgD/GPyPnKsa1ap
        q7W7Zm4MNXurxcmhxMcqMg==
X-Google-Smtp-Source: AA6agR6/k7i13MbTw9Ucz8u/ZYHR2+EJuvxKe8322+8bMQWkeANhkN3kZnqAKLFsDE7qtOs+P0Gi/g==
X-Received: by 2002:a6b:690c:0:b0:681:c99a:c197 with SMTP id e12-20020a6b690c000000b00681c99ac197mr1837877ioc.92.1660317244503;
        Fri, 12 Aug 2022 08:14:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e20-20020a056638021400b00342919722e7sm1051849jaq.174.2022.08.12.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:14:04 -0700 (PDT)
Received: (nullmailer pid 168976 invoked by uid 1000);
        Fri, 12 Aug 2022 15:13:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20220811041211.3825786-2-bjorn.andersson@linaro.org>
References: <20220811041211.3825786-1-bjorn.andersson@linaro.org> <20220811041211.3825786-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
Date:   Fri, 12 Aug 2022 09:13:53 -0600
Message-Id: <1660317233.422992.168975.nullmailer@robh.at.kernel.org>
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

On Wed, 10 Aug 2022 21:12:10 -0700, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has two display clock controllers, add a
> binding for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |  98 +++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  | 100 ++++++++++++++++++
>  2 files changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.example.dtb:0:0: /example-0/clock-controller@af00000: failed to match any schema with compatible: ['qcom,sc8280xp-dispcc0']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


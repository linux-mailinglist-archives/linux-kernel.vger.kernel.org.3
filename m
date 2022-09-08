Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88645B1D33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiIHMff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiIHMfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:35:05 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C6D50066;
        Thu,  8 Sep 2022 05:35:05 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1274ec87ad5so29014915fac.0;
        Thu, 08 Sep 2022 05:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vnk2kmYZ3L8C5KCTqpPPUG7hyhwp27VEk77h0rszQd4=;
        b=C1yjxj6kldtS8qFemh++O6rrArLrU5RY0drFJRfaNocF3yWgaxOobT66g2kcYGNYIs
         L6fikAwRhhuYwElU8Npa/C0Ix5R13x2X9GX8HS078ga7PF7YNcHE5MhIxaX7wFWeQK40
         FTBVSM/ku1D8hZMso0YGhXCK7R6Ukvkc3tvsoG5m53Tf5PZaLKiuBhUY9zySwoCnQANU
         JjZR2LpgovHQ9aO0l8E5tLqQpfCUi1oc7OEaF9kRAbk47MKNoSv2fY7B/XhJRDY4pgFO
         QzFx5zbSkC0wwOEpVoFawqdRUn35sIWZZTvEF8YKbS1LRJX48kGKGJmTWt5kPmTi35KZ
         NVvg==
X-Gm-Message-State: ACgBeo0M3X6aFr9vYHEj7CA1koUnSwc4RLCLMVB/MX7GWY0nGsZcbgCQ
        dsfWaPytfPEz9GZlkMSWdg==
X-Google-Smtp-Source: AA6agR547RDckaER1SUhvyzHa7cBzOeBMsKy7yLjFX8KFz+NX2wWuncKLlRAUghlvhqxp+V2alwPww==
X-Received: by 2002:a05:6808:1281:b0:344:d85a:9f38 with SMTP id a1-20020a056808128100b00344d85a9f38mr1376194oiw.207.1662640504692;
        Thu, 08 Sep 2022 05:35:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f205-20020aca38d6000000b003449ff2299esm7455663oia.4.2022.09.08.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:35:04 -0700 (PDT)
Received: (nullmailer pid 2262541 invoked by uid 1000);
        Thu, 08 Sep 2022 12:35:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jian-Jia Su <jjsu@google.com>,
        Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220907232914.243502-3-jwerner@chromium.org>
References: <20220907232914.243502-1-jwerner@chromium.org> <20220907232914.243502-3-jwerner@chromium.org>
Subject: Re: [PATCH 3/4 v2] dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
Date:   Thu, 08 Sep 2022 07:35:00 -0500
Message-Id: <1662640500.327192.2262539.nullmailer@robh.at.kernel.org>
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

On Wed, 07 Sep 2022 16:29:13 -0700, Julius Werner wrote:
> This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
> existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
> needed for topology description, so other properties like timing
> parameters are omitted. They can be added later if needed.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                |  4 ++
>  .../memory-controllers/ddr/jedec,lpddr4.yaml  | 36 ++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr5.yaml  | 47 +++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> 
> Changelog:
> 
> - v2
>   - removed minItems
>   - moved `$ref` below `maintainers`
>   - renamed example node from `lpddr4` to `lpddr`
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.example.dtb: lpddr: Unevaluated properties are not allowed ('manufacturer-id' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.example.dtb: lpddr: Unevaluated properties are not allowed ('manufacturer-id' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


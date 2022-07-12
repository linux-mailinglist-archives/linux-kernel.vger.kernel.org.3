Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE29572954
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiGLW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiGLW3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:29:42 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD98BD683;
        Tue, 12 Jul 2022 15:29:41 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id b12so5718205ilh.4;
        Tue, 12 Jul 2022 15:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6TlAEBKdUnbeLY0JBRbgAGQSjQ3GM7mg+m6GgP7m7Xs=;
        b=1EeQs9Th7Caj3+WhOdmDmGBYC9EK3uSZHBsj4BwWYSRWBAnMmDStVA+MDDDc9LoEVW
         isbM2aKdgKwqpE0wsnJ4B5Je0a0tBJfyXibHGOuk75wNv+DBouanWP8dGSAwo5JgYMgg
         xLaH1fnuflK9amyz+CZL2GWsstqOqajASKVFi11f8bpkVWWy5qaDh6MuKAQ0Icph4f5k
         xZjpL4XeBivolsxaFSUiPCEVJDoKG6kMCs2Jnvl5AhjFG0BKsXCfCEi2gUb2YhGk7ZRj
         6I0hF9ofU7uF069AsnCcYNmEbJZT+mC3bib0qvrF/fas/RAKsTlZd59469Sijfrg4qdD
         wZ8Q==
X-Gm-Message-State: AJIora9/nI0uT18tNR8cwhvn6i0+efVHRyx4MA1jLr+ixKEXbkqDcFli
        fkti9iXLxOGG34geCUYzng==
X-Google-Smtp-Source: AGRyM1tQ6vLyVx8CeViibTv6d2c/M4uPa1qXqvqlwqIN7YowfkhSvUSPNEKqgcjgixJw+JJK1jc3Yg==
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr236312ilm.310.1657664980547;
        Tue, 12 Jul 2022 15:29:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d78-20020a6bb451000000b00669ceb1d521sm5470544iof.10.2022.07.12.15.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:29:40 -0700 (PDT)
Received: (nullmailer pid 2476656 invoked by uid 1000);
        Tue, 12 Jul 2022 22:29:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-media@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220712163349.1308540-6-tommaso.merciai@amarulasolutions.com>
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com> <20220712163349.1308540-6-tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH v6 5/6] media: dt-bindings: ov5693: document YAML binding
Date:   Tue, 12 Jul 2022 16:29:35 -0600
Message-Id: <1657664975.862137.2476655.nullmailer@robh.at.kernel.org>
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

On Tue, 12 Jul 2022 18:33:48 +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the OV5693
> CMOS image sensor from Omnivision
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v1:
>  - Fix allOf position as suggested by Krzysztof
>  - Remove port description as suggested by Krzysztof
>  - Fix EOF as suggested by Krzysztof
> 
> Changes since v2:
>  - Fix commit body as suggested by Krzysztof
> 
> Changes since v3:
>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
> 
> Changes since v4:
>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
> 
> Changes since v5:
>  - Remove dovdd-supply, avdd-supply, dvdd-supply from required properties
> as suggested by Jacopo
> 
>  .../bindings/media/i2c/ovti,ov5693.yaml       | 103 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb: camera@36: Unevaluated properties are not allowed ('port' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A94BFAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiBVOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiBVOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:23:10 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB0CC3C26;
        Tue, 22 Feb 2022 06:22:45 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso17730027ooi.1;
        Tue, 22 Feb 2022 06:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=duotqgpfYkJR3rbAMtFGAN9TYcSBj0vnwFmaV5CSvtk=;
        b=5bGLNg6yPpSAa7Os4QqGPTQ24a+SfKg859JwLDtzoiTq+0/3DArrrwCeAhKmGDnbzi
         kMZwRNOIGRGlhANwbDam4lVgbccZhnbA6A6tHpkOxvq5CFz7fdw4a04AUKbMrDlVFk5f
         ErYgmm3aSSAQT5IJUaBiPRYgNi/mL+AA1dj8Eafk4HImVxu4LsK60Gg9QOWn2jq7Vb41
         AyoxKDyq932NBpMmqBqzgKwVBxLtiouMPXPOa5VDQznJvKHA5JeF3lcfiz/nod6boO2D
         CO+7P6E1c/QGKvNgp1I/4ZCRQlVXn7rqo2qOt5bl/CPH9RJSYAeQMQZ5ky6DY4XWPzeS
         QPtg==
X-Gm-Message-State: AOAM530u8rC+jH0MfBBd1bMG6DsyXXd+Ak7Hal7J1pe8WaqOq158MWly
        2MPEl8l77qsxum/uRGVgDg==
X-Google-Smtp-Source: ABdhPJwE6tKFVG0cvwF6+HecJ1I8I3GNERldYB4YrFiT+QZlMk0YmfLf2j4/NfuK/5LdJaYsakvkKQ==
X-Received: by 2002:a05:6871:4096:b0:d3:41b9:5350 with SMTP id kz22-20020a056871409600b000d341b95350mr1727027oab.124.1645539764869;
        Tue, 22 Feb 2022 06:22:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d18sm8932139oiw.18.2022.02.22.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:22:44 -0800 (PST)
Received: (nullmailer pid 3016151 invoked by uid 1000);
        Tue, 22 Feb 2022 14:22:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     maz@kernel.org, arnd@arndb.de, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, broonie@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de
In-Reply-To: <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
References: <cover.1645413746.git.qinjian@cqplus1.com> <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021 clock driver
Date:   Tue, 22 Feb 2022 08:22:43 -0600
Message-Id: <1645539763.057346.3016150.nullmailer@robh.at.kernel.org>
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

On Mon, 21 Feb 2022 11:29:16 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  52 ++++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.example.dts:23.38-39 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1595308

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


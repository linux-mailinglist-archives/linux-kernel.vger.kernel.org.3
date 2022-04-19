Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D4506C16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352083AbiDSMQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352057AbiDSMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:15:56 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E920BEE;
        Tue, 19 Apr 2022 05:12:51 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so2998572ooj.2;
        Tue, 19 Apr 2022 05:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Oi2UyeV7FTiASy8kn59y+2VbputKPdQLR2c1Xa4PCvM=;
        b=qE5pdal0NSwnzu+Eg9PTWPSmXX43O1jT27Lr5UNLyNLR+o4UWJhqQSu5NNoZOkOb0b
         /A9SpouUuw2bvH0r2RYYIhpxXdAAqY4KL22kEzKwX0J5Bm+6TYW/ZYJjDD2gFcRIF4+n
         nZpPRhKLSmlvvYVgVTVcfOR44zknIjVaQBgwrMrZeKUuoTl5TPgQisihFXvLJbkY62VF
         5u3o3ZBBIywsA8ADzM+Yqgd+ZMWLHk7BPyE4Mq6xCwjSBfTL8DfRReu18XWLvVjIllq6
         QF9rLomewLxeOuI77iKEu7EvKsQqsSFnCY7aTj0p/KPAqAe1MvyGSYzfJ8fMm/HdqqBk
         9FyQ==
X-Gm-Message-State: AOAM531qgiKKzM4goCSivMIKPiC6oJSBrYRuX7j257bqBC+oEphOxHGA
        rkCQ/nm6V1hQVtsbMuo9jQ==
X-Google-Smtp-Source: ABdhPJz03tF+Z0gbQlUo469ixMVFxZOJrb9wmBz9B2zJ2fy8b50/S3xhK9Nm11m18gcVWFfnChv6Jw==
X-Received: by 2002:a05:6820:555:b0:324:b7c5:d7b2 with SMTP id n21-20020a056820055500b00324b7c5d7b2mr5230585ooj.1.1650370371052;
        Tue, 19 Apr 2022 05:12:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o133-20020acaf08b000000b002ef7562e07csm5027600oih.41.2022.04.19.05.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:12:50 -0700 (PDT)
Received: (nullmailer pid 1977872 invoked by uid 1000);
        Tue, 19 Apr 2022 12:12:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20220419093506.135553-2-cosmin.tanislav@analog.com>
References: <20220419093506.135553-1-cosmin.tanislav@analog.com> <20220419093506.135553-2-cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add AD4130
Date:   Tue, 19 Apr 2022 07:12:43 -0500
Message-Id: <1650370363.604220.1977871.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 12:35:05 +0300, Cosmin Tanislav wrote:
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 263 ++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dts:35.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


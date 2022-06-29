Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3619955F344
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiF2CKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiF2CJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:09:58 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490A2EA21;
        Tue, 28 Jun 2022 19:09:56 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id a16so9378431ilr.6;
        Tue, 28 Jun 2022 19:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+E+IwrlF8yVm8FNfRDWHfRgRNf789XE4MP3pOdLVg04=;
        b=gQXe4CFY2nT0W0nEh8W8yEUFHDYwMLoVpa0B5Il9W/+t9vq9mPKVd1qtHE2mfP8MXE
         VH+ffus6s0aMxUEekFY0igYBwxUzaYDSca9PH8WU2FyBQDjpdYRTzwZAcV98WSBDr5/2
         0NgjVkCE6eGHSRZNDpWsXuALco4goIF4XHqljUkH/ERvQLgh6GxaKvvdlASM1Da7WarL
         L7QFCHIKeLWE9goLEdWnnMlYf5nxcN5j+fV+0IHf1w2QwL8zrCbgJ8dSd9HLOUoMugcT
         BMF3gzfLePuu69kJ4phW2oue+b3AuijqpTX8QGC1VMM3IIP4CEWfuBDxEiZ0/qiQXPwr
         Cs9w==
X-Gm-Message-State: AJIora+SbXrBJNev0T2Y4BOw7ZKmVPTETSXVeupBDY2/XJCWfn6UNGXF
        A20oAXD3GN4KxS3+DLSOfQ==
X-Google-Smtp-Source: AGRyM1vOfFiGO+DjQDQmIuMMu0i0Dd2Uu/SlNrumhi5j6JrS/pttau9aR1iYNwMFpZXBciwfjZR7Kw==
X-Received: by 2002:a05:6e02:198e:b0:2d9:5a65:6ce1 with SMTP id g14-20020a056e02198e00b002d95a656ce1mr645556ilf.50.1656468595932;
        Tue, 28 Jun 2022 19:09:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z19-20020a05663822b300b00331f1f828adsm6789737jas.16.2022.06.28.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:09:55 -0700 (PDT)
Received: (nullmailer pid 1403674 invoked by uid 1000);
        Wed, 29 Jun 2022 02:09:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220628184137.21678-2-ansuelsmth@gmail.com>
References: <20220628184137.21678-1-ansuelsmth@gmail.com> <20220628184137.21678-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Tue, 28 Jun 2022 20:09:39 -0600
Message-Id: <1656468579.892280.1403673.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 20:41:34 +0200, Christian Marangi wrote:
> Convert qcom,krait-cc to yaml Documentation.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
>  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermistor@:properties:adi,excitation-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-nanoamp
Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb:0:0: /example-0/spi/ltc2983@0: failed to match any schema with compatible: ['adi,ltc2983']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


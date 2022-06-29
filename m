Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B055F336
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiF2CKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiF2CJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:09:56 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C922E693;
        Tue, 28 Jun 2022 19:09:54 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id a10so14657826ioe.9;
        Tue, 28 Jun 2022 19:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Pfdx1DG++eeQ9f88Yf9zJSvLAXaN5qhIxHUV61QIvq0=;
        b=lYinyOOsqzrhyP1Gh1tN4WqH+l0QudrucWLQDJeOPo24KK7w1u0vj0rcSTdPblcFpi
         RcAoRcboKaGYFuezFxXKvZ0SLoTRQUDN2CkBQnrfnofeezAPZvj+Ts30UwuiYn0C1Dyz
         YTro9lq8JuR/vvCHgXRiKKAddRlkq2X0uj9L7/igrnZgBrudw9ytMB0+YjT4CbOG3Qeo
         Bfgtdh4LgtLkC54a1itSfr6d7wonO5iXTQVCQuOdnuzGNa3RHiygZ/zf7y77icKAOyT6
         /IHZkhHqe+z98jwhqyvsZtZkwa18cJCbsp75xj7rfRZkR8lxNLIIZG9fPbcRbJoSkXXy
         jQcw==
X-Gm-Message-State: AJIora8L01QSGq77AT3UxlpmrGv6fIDJDJ6ByuhAzkPcqLbDiEd+w7cP
        UTuHlafhWOHdqooHjXssQCnpUJVC9w==
X-Google-Smtp-Source: AGRyM1vAWmfh3bBfOBlNOWTpWFWm2NtKTDQ0d9fYOiounHB3FO8+5FTxtZagC3j+tabqYYcWv2jrjg==
X-Received: by 2002:a5d:83c7:0:b0:66c:cc68:2f2d with SMTP id u7-20020a5d83c7000000b0066ccc682f2dmr562412ior.74.1656468593682;
        Tue, 28 Jun 2022 19:09:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q35-20020a056638346300b0032e802256a9sm6764591jav.163.2022.06.28.19.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:09:53 -0700 (PDT)
Received: (nullmailer pid 1403678 invoked by uid 1000);
        Wed, 29 Jun 2022 02:09:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220628184137.21678-4-ansuelsmth@gmail.com>
References: <20220628184137.21678-1-ansuelsmth@gmail.com> <20220628184137.21678-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Tue, 28 Jun 2022 20:09:39 -0600
Message-Id: <1656468579.908105.1403677.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 20:41:36 +0200, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation.
> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
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


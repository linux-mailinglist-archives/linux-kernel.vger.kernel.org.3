Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA9587DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiHBOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiHBOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:01:46 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0021F63F;
        Tue,  2 Aug 2022 07:01:45 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h16so7020880ilc.10;
        Tue, 02 Aug 2022 07:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=9HP6RV14iyBefsrq7UF+VvvWbuNYrykxC6shEJNRhLs=;
        b=hi0/xOhNNlk4J6q80W7+ZkwaENZUk+bSMIlOnw1aeaCvDRbOEtTgwq6vRs5nOxAKwd
         B3e5aXjPdmCUD9PkEedUeMb53ZpJlFXA3CmSvmr5WJl4anEegbe4SsF9yM469rouKPQy
         3pMEx2LZLC4b0/DJxkM+Gjliv2Dtlrg7Npoz2E3flQ8jEpD6An0aPtoOnNgqVqiHNYcW
         b+0P51brZoY1NpWxHDYbEFU2BSf+Wc7KO3kMj62BtbeaUOrti529WcLm7vzCBfEzJJ8G
         wIG19cHiChwoD/+KbiWOJzc9fx4NQey2O/wLj2y/xjwQLeXoOqzl6hIPvueYx0Nh7RQa
         YAbQ==
X-Gm-Message-State: AJIora9jpe43rEgcbj6d0/tIjrr1NRygKV4JvFGCHEJy1/IClW0T67eU
        VK4wFEIBSBbul52z6ZY5Ww==
X-Google-Smtp-Source: AGRyM1ub8jaiVWjVciNr9MeONH5WR1JVir2IcYCFMPoECG21PeM+dvGSFRA95dWXDvCDiilDY4VB2Q==
X-Received: by 2002:a92:ce50:0:b0:2dd:dc8e:1f36 with SMTP id a16-20020a92ce50000000b002dddc8e1f36mr8814976ilr.34.1659448905241;
        Tue, 02 Aug 2022 07:01:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n5-20020a056638110500b0033f0589eb52sm1897615jal.2.2022.08.02.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 07:01:44 -0700 (PDT)
Received: (nullmailer pid 8420 invoked by uid 1000);
        Tue, 02 Aug 2022 14:01:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, andreas@kemnade.info,
        dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        alistair23@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org
In-Reply-To: <20220802125827.34509-3-alistair@alistair23.me>
References: <20220802125827.34509-1-alistair@alistair23.me> <20220802125827.34509-3-alistair@alistair23.me>
Subject: Re: [PATCH v8 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Tue, 02 Aug 2022 08:01:41 -0600
Message-Id: <1659448901.672444.8419.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2022 22:58:25 +1000, Alistair Francis wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb: touchscreen@24: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


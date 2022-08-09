Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F158E3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiHIXWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiHIXWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:22:11 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB06E89C;
        Tue,  9 Aug 2022 16:22:10 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id o2so10864200iof.8;
        Tue, 09 Aug 2022 16:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=WKgX6OwnJvslqRDDK7OwdRHlwGBrq/rnVAIRLno0eKk=;
        b=rgHJxJmIuUW7b8nxO0USQv48D9yrBymKkBYeMvQhRDevk/YEcDYcJY2tfvnlBhPfoe
         k83FJMxqS7redvl+uJQiM8Omwlzy7OFAtalgyT+BZpkuyx6Wl8ppELo1JGqJlmsZHIB6
         8z3cKRvm1X7pr/mDFUvpMM7M+9cjR7Rbh/vUa+w/3xjh5HOpo4NE6lKm5TUehHzqKUhW
         uARiP26eVvZTcUm9usx4Pc/3hJOESOBcr5wGfhP8Axhk9nbpwcR5b0H4t27oAEz+QE4f
         wBBPSFRUQPatLgH/ZtpSNePiUb39JqqpONoIqRoRYod9uqMppE0Cedqt6bPRxlK49Tuc
         ngxQ==
X-Gm-Message-State: ACgBeo1IF9/sSqf11fP0Z+BOw+RfoFKnF+MNp+GIZZlTjzMlmEiDf8Sf
        FnhNUqxwK976hU76JCS9dQ==
X-Google-Smtp-Source: AA6agR5QFg4qxoRQtr79qrPZn1JaCwglNPErhIuT1Uu88akqQwP9BtBHPUYP4k7Bfn8OgjZ+21s6tA==
X-Received: by 2002:a02:cc6d:0:b0:342:82b1:c73b with SMTP id j13-20020a02cc6d000000b0034282b1c73bmr11769610jaq.290.1660087329552;
        Tue, 09 Aug 2022 16:22:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j16-20020a056e020ef000b002df7e3c40fbsm1557389ilk.6.2022.08.09.16.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:22:08 -0700 (PDT)
Received: (nullmailer pid 2675463 invoked by uid 1000);
        Tue, 09 Aug 2022 23:22:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Parks <danielrparks@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
In-Reply-To: <42d04e9ec43d10f978cee1dd974bbfdccf121d85.1659985696.git.danielrparks@ti.com>
References: <cover.1659985696.git.danielrparks@ti.com> <42d04e9ec43d10f978cee1dd974bbfdccf121d85.1659985696.git.danielrparks@ti.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: crypto: ti,sa2ul: add pka subdevice
Date:   Tue, 09 Aug 2022 17:22:06 -0600
Message-Id: <1660087326.225301.2675458.nullmailer@robh.at.kernel.org>
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

On Mon, 08 Aug 2022 14:12:50 -0500, Daniel Parks wrote:
> The PKA (aka eip29t2) is a subdevice of the SA2UL on k3.
> 
> Signed-off-by: Daniel Parks <danielrparks@ti.com>
> ---
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml:68:1: [error] duplication of key "patternProperties" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/crypto/ti,sa2ul.example.dts'
Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml:68:1: found duplicate key "patternProperties" with value "{}" (original value: "{}")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/crypto/ti,sa2ul.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml:68:1: found duplicate key "patternProperties" with value "{}" (original value: "{}")
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml: ignoring, error parsing file
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


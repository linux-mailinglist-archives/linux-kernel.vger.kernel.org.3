Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1021158E3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHIXWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHIXWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:22:14 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214BE6E8B4;
        Tue,  9 Aug 2022 16:22:13 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id g18so7406965ilk.4;
        Tue, 09 Aug 2022 16:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=0gqfclkM9w96CKNu+kWPE5mtyoud9Rxaii1uoxzqUi8=;
        b=ZLAl9cfvKvhkYYW4nWnD41fCULkFp7zsU+RrLc0mZPBRIY81impmWcRaR1Geb+H8dD
         TDBwmVEcldejXCBtAsZGz7M6DjY3ohamqZA9shRHL87544xre6BQ3fbRUlA8SHTFtyTt
         HjyB9K+IJB234n4T2I1za5uO8Cl07jMCSUpf+/9Yi/XPXjdtlAh8Rvi4vRemBrPbjomN
         btWdwRYLqpBzpu2ZbdspwisR39a/Xd5fen+9nAli7BW5CHycEOo/BxPPoXpDemTSk4dx
         rk+50jnGjxZ4XuBERMtXrginWI5xZEkPTtr3PExte6HWl9xPOd+nvZmlfLXiFW95N0PR
         6XBA==
X-Gm-Message-State: ACgBeo3Y7fO1gIDpQcaL7E0GzFhtQEyED4uwZuF+qhvMmUyVfROaGY/i
        WicmBfAxHqtlvKdmIcipHw==
X-Google-Smtp-Source: AA6agR6EzvkqHRmTfVQEyJwp0EiSnaqiLgSo4zvnnjVg/5k6vTEczrItSmgXtcXf3D8tBH7d/dL/mA==
X-Received: by 2002:a92:b742:0:b0:2de:14d8:e801 with SMTP id c2-20020a92b742000000b002de14d8e801mr11952646ilm.105.1660087332355;
        Tue, 09 Aug 2022 16:22:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s23-20020a0566022bd700b006849908ca7dsm1667845iov.36.2022.08.09.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:22:11 -0700 (PDT)
Received: (nullmailer pid 2675473 invoked by uid 1000);
        Tue, 09 Aug 2022 23:22:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Parks <danielrparks@ti.com>
Cc:     linux-crypto@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <856cbf3a002b5d400bbbdb7aa914ab5b8681a96e.1659985696.git.danielrparks@ti.com>
References: <cover.1659985696.git.danielrparks@ti.com> <856cbf3a002b5d400bbbdb7aa914ab5b8681a96e.1659985696.git.danielrparks@ti.com>
Subject: Re: [RFC PATCH 2/6] dt-bindings: crypto: add binding for eip29t2 public key accelerator (PKA)
Date:   Tue, 09 Aug 2022 17:22:06 -0600
Message-Id: <1660087326.267606.2675470.nullmailer@robh.at.kernel.org>
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

On Mon, 08 Aug 2022 14:12:51 -0500, Daniel Parks wrote:
> The PKA is a mmio-only asymmetric crypto accelerator available on
> certain K3 devices.
> 
> Signed-off-by: Daniel Parks <danielrparks@ti.com>
> ---
>  .../inside-secure,safexcel-eip29t2.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip29t2.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip29t2.example.dtb: pka@40920000: reg: [[0, 1083310080], [0, 8192], [0, 1083326464], [0, 32768]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip29t2.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


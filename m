Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA14AF568
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiBIPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiBIPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:35:12 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13307C0612BE;
        Wed,  9 Feb 2022 07:35:15 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s185so2847187oie.3;
        Wed, 09 Feb 2022 07:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=87D9xgRPVhpkd0CiBsmaPizvX+fSKhfflYptts+iImg=;
        b=E2qcqOo0dafLx8B6g9pc8RNNiI4F4qvSteSGFpUFtfBfYdBWkBCVvVW52Z5BmIunMz
         P2N2CXfS6Pyde6YnN7dJUiRqHHhF2pnvQ2GPl0J3GKwWaecKScEwo4XdrtcAi8P0ZhXC
         duHMuelrLqLX4RnkoS0+b4R/XWzLtwwqsfOuaHP2OG8Vvv1WWeQACmVgDk8Qt56Z5u/Y
         LIUSbkdbBl4DZz1OiocR/60lh+UpwKELf9IdeA82Q8mHl1NfqQaQr0DyESRe6DjeO7Rb
         Qt6hjiVB7XtCaL1atXrjAhAtxy0FRttkX7U9GHAN9FRIX/dJz4C/rfnfqAv/x2LEnc2n
         lL9w==
X-Gm-Message-State: AOAM530WUI0iTckb2iqJKnqUZVD5YxDrsiGOK+hF4bAWe1JeP7UaR+K+
        Mj+vs677OxDNKDJomtaGHQ==
X-Google-Smtp-Source: ABdhPJyPtWLE9p5DCJLdWQMRseTeW96RxJVjhB+AI0HAGDUEn+OIKwknd3fnEw5Ei7fB18SrxNWNag==
X-Received: by 2002:aca:1b05:: with SMTP id b5mr1554068oib.289.1644420914112;
        Wed, 09 Feb 2022 07:35:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s11sm6498640otq.69.2022.02.09.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:35:13 -0800 (PST)
Received: (nullmailer pid 391815 invoked by uid 1000);
        Wed, 09 Feb 2022 15:35:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heiko@sntech.de, robh+dt@kernel.org, linux-crypto@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, davem@davemloft.net,
        linux-rockchip@lists.infradead.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220209124725.2080986-1-clabbe@baylibre.com>
References: <20220209124725.2080986-1-clabbe@baylibre.com>
Subject: Re: [PATCH] dt-bindings: crypto: convert rockchip-crypto to yaml
Date:   Wed, 09 Feb 2022 09:35:08 -0600
Message-Id: <1644420908.395763.391814.nullmailer@robh.at.kernel.org>
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

On Wed, 09 Feb 2022 12:47:25 +0000, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  .../bindings/crypto/rockchip-crypto.yaml      | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/crypto/rockchip-crypto.example.dts:22.25-26 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/crypto/rockchip-crypto.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1590370

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF84EACAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiC2LwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiC2LwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:52:16 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BBDE0B1;
        Tue, 29 Mar 2022 04:50:32 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so3045750oof.11;
        Tue, 29 Mar 2022 04:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yuvwzw+NPlzU064huZNX24SkiRaX81wKTyH2T/53Ev8=;
        b=QICnIc4BanTYZgboW6PxHIVFNkb6JaDo5dpX6P2c9h1iQ9mc5rGhPj+iBD2YuK/Toi
         ubiAJ/ofHEMZKcsMeKO0tELihFNqTkZ2MdE2Ljlp9k51LH420pxShF4FGDAur3xLWwYm
         Pd5RlhxoAJLRHzhT1IPzUeLp7q2gxMjlJzvTqOyar2dyCB6J2SUUXKQCLqjQU6ycRoeW
         +vSb17XaKN+QF5Y28yzjNuT09sXs9eew9LmCgioJ9uyRkLUJddXv+pFCpBvYzuaeoM0P
         HAOKIX/L9Ydr4GzHkYupVzQtxHUWs+zb4V1pG2UwsgiKGmiPM8WSrqthRqEBeT+DwcgA
         0BHw==
X-Gm-Message-State: AOAM532P1QEiNMEv/+q4AX77EEWyS9BIvG1MQsMHtr+8B/rJlmPxldUK
        XZ7Bps+R1PHXdn1uTDjfSw==
X-Google-Smtp-Source: ABdhPJwmR/a0AlYIct99XZbVh2WM6/sYPiNZPnX2sfuAxKga/UBtw/wMHWh9AAsLInOrS4ej0s0RZQ==
X-Received: by 2002:a4a:d254:0:b0:324:b1bf:da28 with SMTP id e20-20020a4ad254000000b00324b1bfda28mr834035oos.49.1648554631484;
        Tue, 29 Mar 2022 04:50:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d2903000000b005cda765f578sm8641220otb.0.2022.03.29.04.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:50:30 -0700 (PDT)
Received: (nullmailer pid 350363 invoked by uid 1000);
        Tue, 29 Mar 2022 11:50:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, huziji@marvell.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220329000231.3544810-3-chris.packham@alliedtelesis.co.nz>
References: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz> <20220329000231.3544810-3-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Date:   Tue, 29 Mar 2022 06:50:29 -0500
Message-Id: <1648554629.870840.350362.nullmailer@robh.at.kernel.org>
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

On Tue, 29 Mar 2022 13:02:31 +1300, Chris Packham wrote:
> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
> in-tree dts files don't validate because they use sdhci@ instead of mmc@
> as required by the generic mmc-controller schema.
> 
> The compatible "marvell,sdhci-xenon" was not documented in the old
> binding but it accompanies the of "marvell,armada-3700-sdhci" in the
> armada-37xx SoC dtsi so this combination is added to the new binding
> document.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> Notes:
>     Changes in v4:
>     - Add review from Krzysztof
>     - Squash in addition of marvell,sdhci-xenon with an explanation in the
>       commit message
>     Changes in v3:
>     - Don't accept ap807 without ap806
>     - Add ref: string for pad-type
>     Changes in v2:
>     - Update MAINTAINERS entry
>     - Incorporate feedback from Krzysztof
> 
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 276 insertions(+), 174 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.example.dt.yaml: mmc@aa0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['marvell,armada-3700-sdhci'] is too short
	'marvell,armada-3700-sdhci' is not one of ['marvell,armada-cp110-sdhci', 'marvell,armada-ap806-sdhci']
	'marvell,armada-ap807-sdhci' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.example.dt.yaml: mmc@ab0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['marvell,armada-3700-sdhci'] is too short
	'marvell,armada-3700-sdhci' is not one of ['marvell,armada-cp110-sdhci', 'marvell,armada-ap806-sdhci']
	'marvell,armada-ap807-sdhci' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1610447

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


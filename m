Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7D4C473D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiBYOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiBYOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:16:42 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07A52177C0;
        Fri, 25 Feb 2022 06:16:09 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id y7so7563499oih.5;
        Fri, 25 Feb 2022 06:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dRIJc0Yk3FXYXz/Yh0SUlf/wEonYpjpvZAyiUC72gd0=;
        b=d+8+Nvy2Zb04T/6bCKwgdBkKywjqy9iE7LXkjY4BpDFrSIgsHA+L2aMDftXmnpuzvM
         NJ2BudlEJGBsrHW0tk//IWRhBPao98MdZZcQU5Tq20WOMYUwAiGLLh5YQeHyGN8CxX38
         fVyfz9jdosDTDKSAyNqhHGlcLJBvDsm643jY0Zh6TL+oDAbLKDYiqaSawBApwPwA63Y9
         UQ4Y6Z2Z6p3ocawwwbEjGCRJ8k7D7i5EU9dEODd70UTBqzMfcIJzE8hi39E/U4g3EtML
         J9duYuRZenn06SWyDWrI2/rLuBCMXo2wNFoAX5JyoLl47t3rWFdfiV/WQ3wQxYUlgdPM
         leSw==
X-Gm-Message-State: AOAM533FrpQaFETy1hwN8XWqTRm/Rnua+Vvst65yO/dP/Q2ZeGulnmoR
        hKlWsqq9lY5vIxIazuX8UAVUB1U0wg==
X-Google-Smtp-Source: ABdhPJxSQW0T+fA1EUjigvVZ/2B3NsbrmJxB00stlugFweRHMzUXPV47lSjGLz5Z6t+WIOER0M4VkA==
X-Received: by 2002:aca:5b45:0:b0:2bc:8362:b053 with SMTP id p66-20020aca5b45000000b002bc8362b053mr1612054oib.36.1645798569028;
        Fri, 25 Feb 2022 06:16:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id lc4-20020a056871418400b000c8a240183csm1202630oab.25.2022.02.25.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:16:08 -0800 (PST)
Received: (nullmailer pid 857884 invoked by uid 1000);
        Fri, 25 Feb 2022 14:16:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, joel@jms.id.au,
        devicetree@vger.kernel.org
In-Reply-To: <20220224225635.40538-2-eajames@linux.ibm.com>
References: <20220224225635.40538-1-eajames@linux.ibm.com> <20220224225635.40538-2-eajames@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Add documentation for IBM Operation Panel
Date:   Fri, 25 Feb 2022 08:16:07 -0600
Message-Id: <1645798567.321012.857881.nullmailer@robh.at.kernel.org>
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

On Thu, 24 Feb 2022 16:56:34 -0600, Eddie James wrote:
> Document the bindings for the IBM Operation Panel, which provides
> a simple interface to control a server. It has a display and three
> buttons.
> Also update MAINTAINERS for the new file.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../bindings/input/ibm,op-panel.yaml          | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/input/ibm,op-panel.example.dts:27.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/input/ibm,op-panel.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1597387

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


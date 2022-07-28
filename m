Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB93584049
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiG1NrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG1NrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:47:16 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498E8624A3;
        Thu, 28 Jul 2022 06:47:15 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id x64so1419834iof.1;
        Thu, 28 Jul 2022 06:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=z/W+enaupbkegvbEDRlhZGtG6b7D/kXPx1TKEn5BI3s=;
        b=5vFY8mFDjFdI7pEA3KPZ7J4IFmuS9hitF+SPc1kh5klguTwrLG3z61/IiscadIcrsu
         zde5WHIvQPHwVNBqdtYqzyCLeZm9N8gVSoE9195Douez0zzz0vhiWoA8jZuMVWnXs22W
         sD0EyhgbUKW8i9v3k5CjIubRSksSUijuWl2W/0x+vljoqazPRaJbhTjcSGbYQBbapX48
         rmx347Q8LRAMG0pKqxYTRxA9CMYdPuscc8m46AJG3UgKrcXRkeRcjdwm6+MYrRtRX1qH
         tO4R7YAXs6lXZr14FW/pGVKtsIy7jHrXujvEZh02Fxq3BcdflwKcwlO/iEyg6uM56t/c
         gQuw==
X-Gm-Message-State: AJIora91ajUYYHNzjOPjpbIqQgyHJUWiN50CjNFg73vJHkpbls7FI3dN
        icyoiBniZXFl2xeg+QrGVQ==
X-Google-Smtp-Source: AGRyM1vnN5JBFltZQ5clBLXtY/PaNiw6vObuIjwvoFtMJqjVNj4jWE1UNeF8RUb+hywHn30jJvQEag==
X-Received: by 2002:a05:6602:2b88:b0:67c:aca7:2f73 with SMTP id r8-20020a0566022b8800b0067caca72f73mr5984371iov.108.1659016034497;
        Thu, 28 Jul 2022 06:47:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q28-20020a02a99c000000b0033a29ec646dsm404093jam.4.2022.07.28.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:47:14 -0700 (PDT)
Received: (nullmailer pid 779712 invoked by uid 1000);
        Thu, 28 Jul 2022 13:47:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Martin_Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jeffrey.l.hugo@gmail.com, hemantk@codeaurora.org,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, mani@kernel.org, saravanak@google.com,
        Michael.Srba@seznam.cz, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, elder@linaro.org, linus.walleij@linaro.org
In-Reply-To: <20220728091712.13395-2-m.zatovic1@gmail.com>
References: <20220728091712.13395-1-m.zatovic1@gmail.com> <20220728091712.13395-2-m.zatovic1@gmail.com>
Subject: Re: [PATCH RFC v1 2/2] devicetree: bindings: bus: add Wiegand driver documentation
Date:   Thu, 28 Jul 2022 07:47:12 -0600
Message-Id: <1659016032.636583.779711.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 11:17:12 +0200, Martin Zaťovič wrote:
> Wiegand write-only driver requires definitions of two GPIO lines
> in the devicetree. This adds the documentation of their
> definitions.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../devicetree/bindings/bus/wiegand-gpio.yaml | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/bus/wiegand-gpio.example.dts:22.47-48 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/bus/wiegand-gpio.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
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


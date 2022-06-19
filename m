Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C32550C56
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiFSRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiFSRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 13:20:21 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A6D63BC;
        Sun, 19 Jun 2022 10:20:20 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l81so11157157oif.9;
        Sun, 19 Jun 2022 10:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xkwVv8V4b5np7XYTkDScjgOmxgXLUCZhN9zsm7qCOtI=;
        b=5UpWJNWh/v7ZIjvFoeV7I3V8Sdi22ZnpkpNubUuvuJtljZMr/xusKCHZQ3IcDyFqBy
         yHBofFVTnjqDi1Z1gQSUGigtJAJDJ43pw+It9sXeTJ4NbOlPRMCNN9mLFJLnl0/HUQyd
         uv5yUPKC/Xl5rAH+0DmJCZomMcvhI6OoR8gWeMsMfWfWtHGyCnTZAsbjrGpluYtnqa2x
         Ii1qr1nH63xegZpwor4mGkvWiG0ND+KWbXXrcpBJJHVqK9lFyUP8oy3LJBFlBhAf0D67
         lRFKm+NfUInGlA2EC+TMdLFws6DY5/HX5o7/qsw7I4hJU7SKODNvOFAMI/rqPG+30+br
         OHaA==
X-Gm-Message-State: AOAM531ywOQIIUbwDzGxmE4w7aTWfVPqODtRvqvUnohp2RVr0C9XFgPd
        TpJdc/Zxj+FrtZHorR3jqg==
X-Google-Smtp-Source: ABdhPJxrsYzSMBA8xa42ADd8FzzuHAkNGJSKJk3lpF+uEUMxnXDyXZICiwp2ff0TOwQGSpLF5Qd2uA==
X-Received: by 2002:a05:6808:1204:b0:325:7ce2:77f6 with SMTP id a4-20020a056808120400b003257ce277f6mr15063203oil.165.1655659220507;
        Sun, 19 Jun 2022 10:20:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id bj11-20020a056808198b00b00325cda1ffb4sm5978865oib.51.2022.06.19.10.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 10:20:20 -0700 (PDT)
Received: (nullmailer pid 1922483 invoked by uid 1000);
        Sun, 19 Jun 2022 17:20:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     broonie@kernel.org, brgl@bgdev.pl, rafael@kernel.org,
        wens@csie.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        quic_gurus@quicinc.com, michael@walle.cc, sre@kernel.org,
        lee.jones@linaro.org, lars@metafoo.de, jic23@kernel.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, lgirdwood@gmail.com,
        linux-iio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-gpio@vger.kernel.org
In-Reply-To: <20220618214009.2178567-7-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-7-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v3 06/16] dt-bindings: gpio: Add AXP192 GPIO bindings
Date:   Sun, 19 Jun 2022 11:20:15 -0600
Message-Id: <1655659215.223742.1922482.nullmailer@robh.at.kernel.org>
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

On Sat, 18 Jun 2022 22:39:59 +0100, Aidan MacDonald wrote:
> The AXP192 PMIC is different enough from the PMICs supported by
> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> driver also supports interrupts and pinconf settings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.example.dts:18.26-23.11: Warning (unit_address_vs_reg): /example-0/gpio@0: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


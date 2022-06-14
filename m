Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905754B3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354578AbiFNOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbiFNOxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:53:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7C33E29;
        Tue, 14 Jun 2022 07:53:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c2so12020028edf.5;
        Tue, 14 Jun 2022 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i002CZ3kNshSLiBB0Sk9zUBde6XACnITYgh2VJAFDjw=;
        b=YrA/W4Q3CQqJGcPLjWQrYFy4qhMY19avMEq6Zb2Ty68Oc6r3CiV1vZe7TQxnFDLT78
         +Onq+uNaU+1CGbg4MQ1u1gh0Y5fCaiZNT2jnjupmZNcogDhVGo0aRS8WeniWu//5sfaa
         43sc2lKlY3W0yORugNFYzW3jWKYnWxJ7X3zKyl2lhxUHrHcfE0drTVBPHVCS27BQzs4T
         yVjvN7eH3/YwiEUqomyL4QcULTM1nNk15dANKNpOSdAVMFUbyeby/+X1c7rT4gjokGYn
         9Z9P3PGsrEfjTvI0Tp+XNHIdQpbzPDLKDPrt2c7JAQZYiQuSHOfNOLN1Ixb8FrxRoqLs
         c8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i002CZ3kNshSLiBB0Sk9zUBde6XACnITYgh2VJAFDjw=;
        b=oD6Tr7GtYDy/kI1lyiYOztAts136uJfXztbQC4wTUMX6lZoAdaqWeYPpDR52kXVBGj
         By5ow7GdRrQmDus0FRD8lgjUUmVm9MsOykiu0p4lCd3sTulpFsRMdfX2iRdsAPmWED2U
         hNY7EvDJVogfi+RcwaESPO89PKcrMM09aVYQnsZE63wC7LCX8oGVFJl8jL6xEYgJdxIH
         z+6iznJYHd6Inw1TJMr/vpMU6KajjGAqjAsbTwld9+kUn+TPRrqUd+7PyGzJuh0/qXww
         s9+Psp2O4/ksF6EKpxijSfOsyhKjkJ7epKp6REF1Qd5oIiztt+oYyyTKWZDeKcTg4HKn
         E3XA==
X-Gm-Message-State: AOAM531AtQD0VlwQirs3qlzMSkVGUro36l2oYa0Iunk+sehmAN8Nfw5D
        pVnYRu9EiOzL9yq7WqXW9veQ94rZ4xhxjdLBCjs=
X-Google-Smtp-Source: ABdhPJx3Bq0wNrqEF8lSyUCZ5VshuSRqgNgGBod/kPv3JOjHRqHmbA/j/c4PBm2AG1qjWMfzhi5Ygd4Az6pMkuDLlvQ=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr6640987edq.178.1655218430432; Tue, 14
 Jun 2022 07:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220614142704.155496-1-jjhiblot@traphandler.com>
In-Reply-To: <20220614142704.155496-1-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 16:53:13 +0200
Message-ID: <CAHp75Vd29e55B7MFfg5A4RLkCzhKbE3FxcnESV2hNxYLA+OWGw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add support for the TLC5925
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 4:27 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> This series add the support for the TLC5925 LED controller.

adds

> This LED controller is driven though SPI. There is little internal logic

through

> and it can be thought of as a deserializer + latches.

> The TLC5925 itself drives up to 16 LEDs, but multiple TLC5925s can be
> chained to drive more.
>
> The first patch describes the dt bindings.
> The second patch implements most of the driver and supports only
> synchronous brightness setting (brightness_set_blocking).
> The last patch implements the non-blocking version (brightness_set).

Much better, I have a few comments and I believe next version will be final.

> changes v3->v4:
>  * add missing MODULE_DEVICE_TABLE(of, ...)
>  * use dev_err_probe() to avoid spaming the log in case of deferred probe

spamming

>  * use bitmap ops instead of direct mem access + lock

memory

>  * sort headers and a few other cosmetic changes.
>
> changes v2->v3:
>  * fixed the yaml description of the bindings (now passes dt_binding_check)
>  * renamed shit-register-length into ti,shift-register-length and specify its
>    type
>
> changes v1->v2:
>  * renamed property shift_register_length into shift-register-length
>  * add a SPI MODULE_DEVICE_TABLE structure
>  * fixed the yaml description of the bindings (now passes dt_binding_check)
>
> Jean-Jacques Hiblot (3):
>   dt-bindings: leds: Add bindings for the TLC5925 controller
>   leds: Add driver for the TLC5925 LED controller
>   leds: tlc5925: Add support for non blocking operations
>
>  .../devicetree/bindings/leds/ti,tlc5925.yaml  | 107 ++++++++++
>  drivers/leds/Kconfig                          |   6 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-tlc5925.c                   | 191 ++++++++++++++++++
>  4 files changed, 305 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
>  create mode 100644 drivers/leds/leds-tlc5925.c
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko

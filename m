Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8A4664D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhLBOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:01:35 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36458 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLBOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:01:34 -0500
Received: by mail-oi1-f170.google.com with SMTP id t23so55640537oiw.3;
        Thu, 02 Dec 2021 05:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Df6A8ZCj8jAntS5m/T7MbnScF8iQqMky7Mr+fltLqXo=;
        b=a7NJG7fsVPQJRcfOYrl+QeEHUTU3aRvWk8x0CVg0CoPdX/Y7+YkMHBoYldPreu3Ei9
         /mA+//TZwcuTRwOlTbtWVQin+p2QQctx1ERMYWqViRhiS03Vxhfm5y8YExzd+HN1nsL1
         uo+eIDK7VcbvJr+z1pKtkrjVMEBUo8xLZzZlM1B9cWy3bdH+rMQFvRlixIa+9U8U4rw/
         J35xDJBwPfDEIb8LjCZMXIueErSnr3UspU6QNvj/uChb0nXdn03NZydNWzXWKTH8Js2G
         2LuUqL7/qZpvIih3g07ghM+vT7Oz11OkBl01FSjZtMWhuCRQiPqUjEhJvmXDEwXs9ZCR
         +feQ==
X-Gm-Message-State: AOAM530YQXun4mnbQvdY9w8GMqDgwCZNWfSc8tbDwQsIfGPG88ntPNhV
        7d1LOz5DVGaiT27xiOnxLA==
X-Google-Smtp-Source: ABdhPJxVMtzg5mG1HA6ZHixHwfv25SBNbtvJ/MS50AjJUTNe2/cadboBU/e6WW4F5ChRbYM82qbBpA==
X-Received: by 2002:a05:6808:4d2:: with SMTP id a18mr4465310oie.99.1638453491230;
        Thu, 02 Dec 2021 05:58:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v19sm1154298ott.13.2021.12.02.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 05:58:10 -0800 (PST)
Received: (nullmailer pid 3736889 invoked by uid 1000);
        Thu, 02 Dec 2021 13:58:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linus.walleij@linaro.org, andreas@kemnade.info,
        linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org, rydberg@bitmath.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>
In-Reply-To: <20211202122021.43124-3-alistair@alistair23.me>
References: <20211202122021.43124-1-alistair@alistair23.me> <20211202122021.43124-3-alistair@alistair23.me>
Subject: Re: [PATCH v3 2/4] Documentation: DT: bindings: input: Add documentation for cyttsp5
Date:   Thu, 02 Dec 2021 07:58:09 -0600
Message-Id: <1638453489.512611.3736888.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 22:20:19 +1000, Alistair Francis wrote:
> From: Mylène Josserand <mylene.josserand@free-electrons.com>
> 
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> Message-Id: <20170529144538.29187-3-mylene.josserand@free-electrons.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:37.26-39.19: Warning (unit_address_vs_reg): /example-0/i2c/touchscreen@24/button@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:41.26-43.19: Warning (unit_address_vs_reg): /example-0/i2c/touchscreen@24/button@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:45.26-47.19: Warning (unit_address_vs_reg): /example-0/i2c/touchscreen@24/button@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml:0:0: /example-0/i2c/touchscreen@24: failed to match any schema with compatible: ['cypress,tt2100']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1562669

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


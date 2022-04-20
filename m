Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8878508815
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378481AbiDTM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353130AbiDTM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:28:19 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D61C91D;
        Wed, 20 Apr 2022 05:25:33 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h4so853249ilq.8;
        Wed, 20 Apr 2022 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRURk4DN2eZqCTEqfyXp6e+58OlcNywvCaEhVw8AW1k=;
        b=NhfhqCCs3Hf2EcKb/RtIq/hjv48Ps2GXEYJ25dNCUTbtl1svXYZdaLXsrgj7QWWPdM
         3oPVrUA81IyvWsn6DwAwMq/wFx4wtiCNIZ4QMETSQs8O1/Ye+puhovoY8VYUq1iH/jXX
         XrqVbKAbZpXr39qKer3R/EqS37otJinwycoykfbrxTXYCCQpBa/ljq9oFdjT6hziWSS7
         9D1VG3znG9Hyl+SjpRiJLYwyJ/6/CFz0ltHThGbWLEEy6Bpf4OHCM43Hf1lncvlyeP2v
         t9bW6z6eQS1zHeK4eOBVQWQoY/2TdPvuLDlrwSEql08qeayxkYpHay7K4KcQoTyPt6vf
         HlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRURk4DN2eZqCTEqfyXp6e+58OlcNywvCaEhVw8AW1k=;
        b=fifMWz89yuIEqxuYDnpGPu4HwuFKgu3v7UnJ+ANgAwCEsrUUd0d922k/2/YYQfpFwU
         P48RZYdYZKbhQh7F5YgvQq7NSC8n1uqQh8WXXpnD/unK3s7RZ2dStE0EmpvuH6BvFCsX
         8hz6xLmb5BjbWnvJcRZkbWwuvNFPhFIFovvpdOSGZYVehaWZ2MYkb/1/P7rzUqEmfzPX
         KZepdddMAA0A79aOi1AiFDjd+LZurzDzkLKmiesIJSHTQVV6FytknjehsxcaENiwz9VA
         VpAygZbCqeP48f6Nv46jMQs44wlYI/u0GkbCNcnVUe/ISs9el81aXqNu9f6xqPzyvvP9
         P+5A==
X-Gm-Message-State: AOAM533H9j9G9utLPNz7zLKtA3dxhHq/3q0DR+5ruvmuBwYKH7YXaR2A
        ZKgG2vFCPZw8YGdMQs80L7A59xLPdHwTYzg3INQ=
X-Google-Smtp-Source: ABdhPJxR05XY11iOWutfHq8oz3L83XIEM/5S8NVV9L7I7mrKegnWO3BlDIq1sHEfoLPpDNiMs/wLF6X1KXkixVdCtjk=
X-Received: by 2002:a92:6012:0:b0:2bd:fb5f:d627 with SMTP id
 u18-20020a926012000000b002bdfb5fd627mr8766792ilb.86.1650457532838; Wed, 20
 Apr 2022 05:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220323120021.361137-1-alistair@alistair23.me>
In-Reply-To: <20220323120021.361137-1-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 20 Apr 2022 22:25:06 +1000
Message-ID: <CAKmqyKP5CRDx4acc6yg9SwADaGTNqKmDUrBs2ODXR30OZuunoA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add support for the Cypress cyttsp5
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:00 PM Alistair Francis
<alistair@alistair23.me> wrote:
>
> This patch series builds on top of [1] and adds support for the cyttsp5
> touchscreen controller for the reMarkable 2.
>
> I first tried to add an I2C HID device. Although the cyttsp5 has some HID
> looking aspects it is not HID compatible. Just in trying to probe the device
> I found:
>  - The HID descriptor has extra padding
>  - The HID descriptor sets the high bytes of the descriptor length
>  - The HID descriptor has extra unrecognised tags
>  - The HID reset command doesn't appear to work
>
> I don't think there is a way to use the I2C HID framework with the cyttsp5.
> For anyone interested you can see the work here [2]. In that branch though I
> can only obtain a HID descriptor, nothing else works without more core
> changes.
>
> So instead I rebased the series from [1]. Converted to the new yaml DTS
> documentation, added regulator support and fixed a x/y miscalculation bug.

The DT bindings have been reviewed, any comments on the driver
implementation? It has been tested on a few different devices

Alistair

>
> 1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@bootlin.com/
> 2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid
>
> v7:
>  - Fix device tree warnings
> v6:
>  - Use reg for the button properties
> v5:
>  - Address review comments from v4
>
> Alistair Francis (4):
>   Input: Add driver for Cypress Generation 5 touchscreen
>   dt-bindings: input: Add Cypress TT2100 touchscreen controller
>   ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
>   ARM: dts: imx7d-remarkable2: Enable the cyttsp5
>
>  .../input/touchscreen/cypress,tt21000.yaml    | 101 ++
>  arch/arm/boot/dts/imx7d-remarkable2.dts       | 100 ++
>  arch/arm/configs/imx_v6_v7_defconfig          |   1 +
>  drivers/input/touchscreen/Kconfig             |  16 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++
>  6 files changed, 1121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
>  create mode 100644 drivers/input/touchscreen/cyttsp5.c
>
> --
> 2.35.1
>

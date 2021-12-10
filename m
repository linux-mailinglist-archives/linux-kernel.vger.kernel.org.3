Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325E470270
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhLJOLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhLJOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:11:30 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31429C061746;
        Fri, 10 Dec 2021 06:07:55 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r26so13356691oiw.5;
        Fri, 10 Dec 2021 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efi5YPskIPAQItI1z28rAsydjETkO5P0a3fdiWWyGao=;
        b=DoDy0slgWAFCGlcqZSiJyt/Ig64ICzJGK5VkEsmphbnwYq3viqEW+F3IqoxobH0xiw
         fdgpwg3rvTtwF2b/eE10P/HEBm2H9r7eeNkyg7pIgPTC0rAJAyLMOlk6NaDSe1Hr+QFb
         1h0ILvQFWz8tZdm1UYjzFOnvznER2ViNvS4eOvQYiAWhaJxDi7ZHNip8ndBYTQtfgwN7
         EGS0H9qhoZdmjz7k9yXEizGJHgsfXP8T4nIGb9obUNAYJRMkLTSjX/HriR4yhdnyR3QV
         8PdryMLQBTGc6wqYFXMqNgZZSd/d1QRq+0oGiSH6N2aBxUZuBwKgAWo9V6d2+AADgAs9
         Bp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efi5YPskIPAQItI1z28rAsydjETkO5P0a3fdiWWyGao=;
        b=iulEHxQ4MvfkxWOsWXTCgFJPjSBY7dBbvLd/aDAGq/Qezw9RD8l1qlRQZq4kdnQbbT
         blfz8btL1Y3EnWwEomBBsJxG2028DFYpTb3oZcih6HuNjt+Sm5hXo9kYTwxv/Alj63BH
         /2Hl4e6ThragLZy70QlKW4ptgMX8x3cTIqWb8nVSXEEKw5QY6vGsj64iF4oN+YEchg/g
         t6FsYRLPh2t1TQnayuy9IJiyz65KaTadxug8A3Cqz1WMZQmUlOjFthdfwvqFJYrIPc4m
         DDqLiXWdl/kuGZ1BuZqDOlWzow83zd8vDEPHPCjeT2qcnvlp41cT8VPMq9tZSD91nFcG
         DARg==
X-Gm-Message-State: AOAM533kZCvsypeHK48aL3vyfyrI5IDtTiVA+hW8SUBRRF/TIZz9jzxf
        DWXDfoVmMwdLbHVUfGdgW4AVm2vXzaTPIbIZFrz5nk4q
X-Google-Smtp-Source: ABdhPJzQw8YMdNJFDSjbgmMRNZ+J5xIRiWQHpxMdISfSUi8FEdOFC5Wodk980GUGwT6w6RirYGv7y8K4T4SRf27i/VM=
X-Received: by 2002:aca:2207:: with SMTP id b7mr12746627oic.24.1639145273996;
 Fri, 10 Dec 2021 06:07:53 -0800 (PST)
MIME-Version: 1.0
References: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
 <1638850665-9474-2-git-send-email-wellslutw@gmail.com> <CACRpkdaBV81OCwHuFCObwv_t55B9ANHaF5jEc=oorZdjpey0Ug@mail.gmail.com>
In-Reply-To: <CACRpkdaBV81OCwHuFCObwv_t55B9ANHaF5jEc=oorZdjpey0Ug@mail.gmail.com>
From:   =?UTF-8?B?5ZGC6Iqz6aiw?= <wellslutw@gmail.com>
Date:   Fri, 10 Dec 2021 22:07:43 +0800
Message-ID: <CAFnkrskptpWwhKzBegUH8--sJJe5MJpJEnGSwQ2t1aj8i1CR2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Wells Lu <wells.lu@sunplus.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-send this email because it was rejected due to the wrong email format!

Hi Linus,

Thank you very much for your review!

Please see my answers below:

> > Add dt-bindings header files and documentation for Sunplus SP7021 SoC.
> >
> > Signed-off-by: Wells Lu <wellslutw@gmail.com>
>
> > +patternProperties:
> > +  '-pins$':
> > +    if:
> > +      type: object
> > +    then:
> > +      description: |
> > +        A pinctrl node should contain at least one subnodes representing the
> > +        pins or function-pins group available on the machine. Each subnode
> > +        will list the pins it needs, and how they should be configured.
> > +
> > +        Pinctrl node's client devices use subnodes for desired pin
> > +        configuration. Client device subnodes use below standard properties.
>
> I don't understand this if type object stuff here, Rob, help...

I'll remove "if type object" stuff next patch since
pinctrl node has no properties with "-pins" suffix.
except sub nodes.


> > +      properties:
> > +        pins:
> > +          description: |
> > +            Define pins which are used by pinctrl node's client device.
> (...)
> > +          $ref: /schemas/types.yaml#/definitions/uint32-array
>
> Why can this not $ref the standard binings in
> Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
>
> See for example
> Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
> for a nice example of how to use this.
> Yours,
> Linus Walleij
The pins' types and control of SP7021 are a bit complex.
Let me explain:

SP7021 has 99 digital GPIO pins which are numbered from
GPIO 0 to 98. All are multiplexed with some special function
pins. There are 3 types special function pins:

(1) function-pins:
    For example, if control-field SPI_FLASH_SEL is set to 1,
    GPIO 83, 84, 86 and 87 will be pins of SPI-NOR flash.
    If it is set to 2, GPIO 76, 78, 79 and 81 will be pins of
    SPI-NOR flash.

    For example 2, if control-bit UA0_SEL is set to 1,
    GPIO 88 and 89 will be TX and RX pins of UART_0
    (UART channel 0).

    For example 3, if control-bit EMMC_SEL is set to 1,
    GPIO 72, 73, 74, 75, 76, 77, 78, 79, 80, 81 will be
    pins of an eMMC device.

    The driver defines properties "function" and "groups"
    to select this kind of pins-function.

(2) fully pin-mux pins:
    GPIO 8 to 71 are 'fully pin-mux' pins.
    Pins of peripherals of SP7021 (ex: UART_1, UART_2,
    UART_3, UART_4, I2C_0, I2C_1, ..., SPI_0, SPI_1, ...
    GPIO_INT0, GPIO_INT1, .., RMII_of_Ethernet, and etc.)
    can be set to any pins of fully pin-mux pins.

    EX1 (UART channel 1):
    If control-field UA1_TX_SEL is set to 3, TX pin of
    UART_1 will be routed to GPIO 10 (3 - 1 + 8 = 10)
    If control-field UA1_RX_SEL is set to 4, RX pin of
    UART_1 will be routed to GPIO 11 (4 - 1 + 8 = 11)
    If control-field UA1_RTS_SEL is set to 5, RTS pin of
    UART_1 will be routed to GPIO 12 (5 - 1 + 8 = 12)
    If control-field UA1_CTS_SEL is set to 6, CTS pin of
    UART_1 will be routed to GPIO 13 (6 - 1 + 8 = 13)

    EX2 (I2C channel 0):
    If control-field I2C0_CLK_SEL is set to 20, CLK pin
    of I2C_0 will be routed to GPIO 27 (20 - 1 + 8 = 27)
    If control-field I2C0_DATA_SEL is set to 21, DATA pin
    of I2C_0 will be routed to GPIO 28 (21 - 1 + 9 = 28)

    Totally, SP7021 has 120 peripheral pins. The
    peripheral pins can be routed to any of 64  'fully
     pin-mux' pins. So total combinations are:
           120 x 64 = 7680
     This is why we cannot enumerate all combinations.

(3) I/O processor pins
    SP7021 has a built-in I/O processor.
    Any GPIO pins (GPIO 0 to 98) can be set to pins of
    I/O processor.

Property 'pins' is defined as uint32 array. Each item
defines a pin as below:
Bit 32~24 defines GPIO number. Its range is 0 ~ 98.
Bit 23~16 defines types: digital GPIO pins (3), IO processor pins (2)
or fully pin-mux pins (1)
Bit 15~8 defines pins of peripherals which are defined in
'include/dt-binging/pinctrl/sppctl.h'.
Bit 7~0 defines types or initial-state of digital GPIO pins.


Best regards,
Wells

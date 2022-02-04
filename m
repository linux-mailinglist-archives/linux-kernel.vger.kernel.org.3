Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0764A9EB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbiBDSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377380AbiBDSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:09:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C56CC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:09:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so626649pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5GJVqdK9AZJLVzh5THjIdv7Tb4wUElki413J5iZNmTM=;
        b=HX/d5JdjvzattE8CDmmyZ7MPKQWBzw6CS4rweJoHjNvR26Mi/E3AeSnf2Qdi4PBkxe
         F/YpYZWCkAbovrkgsEghglG/A9KpdOiXRXrJwHsc1oR+R8IwHBCzYBjdQIW2lsDwugye
         /cpAQ3UJxW5aNIBFAVcbCmefpO4ofSixhKAFBt6jl/bOsRo5XW+bD8R/ML814CRWS+Jk
         IAn4IkIOCEImsV64jEiMr2DLsIsWasuZMKldqSrEEwT1eI9PsHmu9+C96nMPh9/3aiXZ
         4vJ88Mo3+fxokgxrL8bm/VaUuu3z3qC8MaDGS0p577cBt809JXVnwQDVslOiXlSLHOvu
         y5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5GJVqdK9AZJLVzh5THjIdv7Tb4wUElki413J5iZNmTM=;
        b=H7SWXnDYqqBRQS3S6p5bdrbGnSrUcLgxOpIMzoF1RhG12CyamT4en+bQy1Z3hkDizI
         ry2TLTRSLy52wDv5HtMz6i6um01iUVrhuCBL1tLH8lIPfZVvYR4WeDGI5AFlPMseQ2iC
         HpT47kxBYFt06iGPveKReBRKeQCck+UjXvt+l/u25CgksDkqT1PQTj9k3gaDVpOyr1L1
         FQxVSFI0/a3T5tYR60pqBFOgZYQlKkIqtfZfXwtBwWsvj273evW3EGt85u5SZalGoLJb
         F+EO8d6uS1+2n32MSFz+RMT67IJALyZn8ECPBjEfDxTYE80lCqVz4bose4wxKx6yrdOT
         qBNA==
X-Gm-Message-State: AOAM5303Yso00i8hxtl0VJeZi7vjt/LDhYVmjqPM2bi8O+3Ti8vuVZ+5
        /KwnYDPM6ohS7bsdcw8BZBro6Q==
X-Google-Smtp-Source: ABdhPJwq5eAXGJ3elIXn36dtCEJkNMZyb4zlD13QPFCAjEzIcC3itN/YiwwtnCDGtGpB44AxXeb1hw==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr4327588plo.78.1643998188528;
        Fri, 04 Feb 2022 10:09:48 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id kx11sm2720754pjb.1.2022.02.04.10.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:09:47 -0800 (PST)
Date:   Fri, 04 Feb 2022 10:09:47 -0800 (PST)
X-Google-Original-Date: Fri, 04 Feb 2022 10:09:09 PST (-0800)
Subject:     Re: [PATCH v5 00/12] Update the Icicle Kit device tree
In-Reply-To: <20220131114726.973690-1-conor.dooley@microchip.com>
CC:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org, krzysztof.kozlowski@canonical.com,
        bin.meng@windriver.com, heiko@sntech.de, lewis.hanly@microchip.com,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, Atish Patra <atishp@rivosinc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     conor.dooley@microchip.com
Message-ID: <mhng-2b6f8784-4c0c-432f-a6e7-97052ab900e7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 03:47:15 PST (-0800), conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> This series updates the Microchip Icicle Kit device tree by adding a
> host of peripherals, and some updates to the memory map. In addition,
> the device tree has been split into a third part, which contains "soft"
> peripherals that are in the fpga fabric.
>
> Several of the entries are for peripherals that have not get had their
> drivers upstreamed, so in those cases the dt bindings are included where
> appropriate in order to avoid the many "DT compatible string <x> appears
> un-documented" errors.
>
> Depends on mpfs clock driver binding (on clk/next) to provide
> dt-bindings/clock/microchip,mpfs-clock.h
> and on the other changes to the icicle/mpfs device tree from geert
> that are already in linux/riscv/for-next.
>
> Additionally, the interrupt-extended warnings on the plic/clint are
> cleared by [1] & [2].
>
> [1] https://lore.kernel.org/linux-riscv/cover.1639744468.git.geert@linux-m68k.org/
> [2] https://lore.kernel.org/linux-riscv/cover.1639744106.git.geert@linux-m68k.org/
>
> Changes from v4:
> - dont include icicle_kit_defconfig, accidentally added in v3
> - drop prescaler from mpfs-rtc & calculate the value instead
> - use corei2c as a fallback device for mpfs-i2c
> - drop spi dt-binding (on spi-next)
>   commit 2da187304e556ac59cf2dacb323cc78ded988169
> - drop usb dt-binding (on usb-next)
>
> Changes from v3:
> - drop "mailbox: change mailbox-mpfs compatible string", already upstream:
>   commit f10b1fc0161cd99e ("mailbox: change mailbox-mpfs compatible string")
> - fix copy paste error in microchip,mpfs-mailbox dt-binding
> - remove whitespace in syscontroller dt entry
>
> Changes from v2:
> - dropped plic int header & corresponding defines in dts{,i}
> - use $ref to drmode in mpfs-musb binding
> - split changes to dts{,i} again: functional changes to existing
>   elements now are in a new patch
> - drop num-cs property in mpfs-spi binding
> - dont make the system controller a simple-mfd
> - move the separate bindings for rng/generic system services into the
>   system controller binding
> - added an instance corei2c as i2c2 in the fabric dtsi
> - add version numbering to corepwm and corei2c compat string (-rtl-vN)
>
> Conor Dooley (12):
>   dt-bindings: soc/microchip: update syscontroller compatibles
>   dt-bindings: soc/microchip: add services as children of sys ctrlr
>   dt-bindings: i2c: add bindings for microchip mpfs i2c
>   dt-bindings: rtc: add bindings for microchip mpfs rtc
>   dt-bindings: gpio: add bindings for microchip mpfs gpio
>   dt-bindings: pwm: add microchip corepwm binding
>   riscv: dts: microchip: use clk defines for icicle kit
>   riscv: dts: microchip: add fpga fabric section to icicle kit
>   riscv: dts: microchip: refactor icicle kit device tree
>   riscv: dts: microchip: update peripherals in icicle kit device tree
>   riscv: dts: microchip: add new peripherals to icicle kit device tree
>   MAINTAINERS: update riscv/microchip entry
>
>  .../bindings/gpio/microchip,mpfs-gpio.yaml    |  80 ++++++
>  .../bindings/i2c/microchip,mpfs-i2c.yaml      |  57 ++++
>  ...ilbox.yaml => microchip,mpfs-mailbox.yaml} |   6 +-
>  .../bindings/pwm/microchip,corepwm.yaml       |  75 +++++
>  .../bindings/rtc/microchip,mfps-rtc.yaml      |  58 ++++
>  .../microchip,mpfs-sys-controller.yaml        |  72 +++++
>  ...icrochip,polarfire-soc-sys-controller.yaml |  35 ---
>  MAINTAINERS                                   |   2 +
>  .../dts/microchip/microchip-mpfs-fabric.dtsi  |  25 ++
>  .../microchip/microchip-mpfs-icicle-kit.dts   | 115 ++++++--
>  .../boot/dts/microchip/microchip-mpfs.dtsi    | 262 +++++++++++++++---
>  11 files changed, 683 insertions(+), 104 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
>  create mode 100644 Documentation/devicetree/bindings/i2c/microchip,mpfs-i2c.yaml
>  rename Documentation/devicetree/bindings/mailbox/{microchip,polarfire-soc-mailbox.yaml => microchip,mpfs-mailbox.yaml} (82%)
>  create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
>  create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi

Looks like Rob still has some feedback that still needs to be addressed.  
I'm happy to take these via the RISC-V tree when the bindings are set 
(assuming the DTs match whatever gets agreed upons), but also fine if 
someone else wants to take it so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Either way, I'm going to drop this (and the v4, which was at the top of 
my inbox) as it looks like there'll be at least a v6.

Thanks!

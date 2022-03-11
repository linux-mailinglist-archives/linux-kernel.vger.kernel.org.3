Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59E4D5CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiCKIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiCKIBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:01:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4891B7573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:00:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r22so11025400ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H61304/5/aT6zo++RCxPy8xIpo0rtqBkReH7sc0wAzE=;
        b=h5dAHKLnDA5s5TgYxQRR61i78Pt7G77hFIU5nu1TkkshOv5UTcUu5pHiA97t0OMmM/
         KFOYCMSzYWh9PmKC0MtlXy1dAWxlPC5ypG+zrJTrBI7tbLTGshzjvOqf18FB+xLXEs6K
         3LWNqZnuDRDE5FxInfTGzLOO6NCMnF8YolVleJDRAt6wM4i6UYXxiE+7hLDcUSkWur/q
         Y7zIgZVaEa9s96eguO71Q6zZZ5CZ8EF2bpGi78b8f6plkWBLJkt/9z0eScly552vQvHQ
         1HelRv2TDnxxfblGdhEw6hDP8Yeim147XA+5GEE/KKzgZSggKwiUs4UI8cHOi1un1+8v
         5P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H61304/5/aT6zo++RCxPy8xIpo0rtqBkReH7sc0wAzE=;
        b=As0R6CrEq+f4PLe1dzkWzOTEA2w0q4pmEB9mKNNXVbDVAiN8TRxA/kkA++JHJ95H7g
         Dqsok6858/Bvlpx91ZfKzOWYNaZIGqXpgzsF7NTfXGL+ZqwlMjxnPhJf4w2tLfEVNtM6
         0ESZRnj1ZWMfbz4eqqGCtXS+Tp/jq0ZsDcV9gcMNAdYB7/uWKdxXck2U7mb2kHf7Dp/x
         yDTk9C2YiWMQtAvE9qYMmfkHSlOpzs8bPjZv1VizSdaqHrgySS+7N9JKvp2YjsCtnM+d
         0dwXukfQXuBZxZ9k9UE1aEVsRTO37MFNYoYdVrPj1LpQWOqyZO8sMZ+s3B6NnDeeunYA
         /0xQ==
X-Gm-Message-State: AOAM533FwvNueJM8dwT33PdtEMNdheA2/zI6v7jqoBFWYyzAh9OkE4Az
        ggs5UDyN8laQeQc3/NWA1LBBCt1Od7StgOOFCnYQDA==
X-Google-Smtp-Source: ABdhPJxcwCfZeFWYSZ32b2nQjvwKVc2ZY4EDXoS35U8GTSd1gnKcH9gkwSMudZGRcPEkXsc1kxUSFuwWP8v7nXAC1rw=
X-Received: by 2002:a05:651c:552:b0:249:1a87:a4a6 with SMTP id
 q18-20020a05651c055200b002491a87a4a6mr1967934ljp.516.1646985600099; Fri, 11
 Mar 2022 00:00:00 -0800 (PST)
MIME-Version: 1.0
References: <mhng-bb42ad9f-5772-4749-97e1-9f6c511654f6@palmer-mbp2014> <e9287c9b-6ac7-dcb3-3b03-98bc83bbf119@microchip.com>
In-Reply-To: <e9287c9b-6ac7-dcb3-3b03-98bc83bbf119@microchip.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 11 Mar 2022 15:59:49 +0800
Message-ID: <CANXhq0rPVKSF64Hwd9+jD3ut0y7VCE940V5do0Hn8=mnoX97yw@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Update the Icicle Kit device tree
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>, Lewis.Hanly@microchip.com,
        Daire.McNamara@microchip.com, Ivan.Griffin@microchip.com,
        atishp@rivosinc.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        Rob Herring <robh+dt@kernel.org>, jassisinghbrar@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        Lee Jones <lee.jones@linaro.org>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 3:35 PM <Conor.Dooley@microchip.com> wrote:
>
> On 10/03/2022 07:07, Palmer Dabbelt wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Wed, 23 Feb 2022 12:48:16 PST (-0800), mail@conchuod.ie wrote:
> >> On 14/02/2022 13:58, conor.dooley@microchip.com wrote:
> >>> From: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> This series updates the Microchip Icicle Kit device tree by adding a
> >>> host of peripherals, and some updates to the memory map. In addition,
> >>> the device tree has been split into a third part, which contains "soft"
> >>> peripherals that are in the fpga fabric.
> >>>
> >>> Several of the entries are for peripherals that have not get had their
> >>> drivers upstreamed, so in those cases the dt bindings are included where
> >>> appropriate in order to avoid the many "DT compatible string <x> appears
> >>> un-documented" errors.
> >>>
> >>> Depends on mpfs clock driver binding (on clk/next) to provide
> >>> dt-bindings/clock/microchip,mpfs-clock.h for the device tree
> >>> and on the other changes to the icicle/mpfs device tree from geert
> >>> that are already in linux/riscv/for-next.
> >
> > So that's causing this to not build, as I can't build without the
> > header.  I went ahead and put these on top of that patch, resulting in
> >
> >     * 48e8641c2bf0 - (HEAD -> riscv-microchip, palmer/riscv-microchip) MAINTAINERS: update riscv/microchip entry (2 minutes ago) <Conor Dooley>
> >     * 528a5b1f2556 - riscv: dts: microchip: add new peripherals to icicle kit device tree (2 minutes ago) <Conor Dooley>
> >     * 5b28df37d311 - riscv: dts: microchip: update peripherals in icicle kit device tree (2 minutes ago) <Conor Dooley>
> >     * c5094f371008 - riscv: dts: microchip: refactor icicle kit device tree (2 minutes ago) <Conor Dooley>
> >     * 72560c6559b8 - riscv: dts: microchip: add fpga fabric section to icicle kit (2 minutes ago) <Conor Dooley>
> >     * 6546f920868e - riscv: dts: microchip: use clk defines for icicle kit (2 minutes ago) <Conor Dooley>
> >     * df77f7735786 - dt-bindings: pwm: add microchip corepwm binding (2 minutes ago) <Conor Dooley>
> >     * 735806d8a68e - dt-bindings: gpio: add bindings for microchip mpfs gpio (2 minutes ago) <Conor Dooley>
> >     * 4cbcc0d7b397 - dt-bindings: rtc: add bindings for microchip mpfs rtc (2 minutes ago) <Conor Dooley>
> >     * b435a1728c9f - dt-bindings: soc/microchip: add info about services to mpfs sysctrl (2 minutes ago) <Conor Dooley>
> >     * 213556235526 - dt-bindings: soc/microchip: update syscontroller compatibles (2 minutes ago) <Conor Dooley>
> >     * 2145bb687e3f - (clk/clk-microchip) dt-bindings: clk: microchip: Add Microchip PolarFire host binding (6 weeks ago) <Daire McNamara>
> >     * e783362eb54c - (tag: v5.17-rc1) Linux 5.17-rc1 (7 weeks ago) <Linus Torvalds>
> >
> > sboyd: IIRC it's OK to consider clk-microchip as a stable branch?  If
> > not I can just wait until you send your PR to Linus and send this later
> > in the merge window, no big deal on my end.
> >
> > I've put this on for-next.  If that's a problem let me know and I'll
> > delay it.
> Great, thanks! Probably worth mentioning that I've deleted the dma node
> that Zong Li is modifying in his pdma patchset.
>

I guess I could re-sent the next version based on top of for-next, or
delay my patch set until the next tag. What is your perspective?

> >
> > Thanks!
> >
> >>>
> >>> Additionally, the interrupt-extended warnings on the plic/clint are
> >>> cleared by [1] & [2].
> >>>
> >>> [1] https://lore.kernel.org/linux-riscv/cover.1639744468.git.geert@linux-m68k.org/
> >>> [2] https://lore.kernel.org/linux-riscv/cover.1639744106.git.geert@linux-m68k.org/
> >>
> >> Hey Palmer,
> >>
> >> dt-bindings should be set now, so if you're still happy to take the
> >> series via riscv, that'd be great. i2c, spi & usb patches ended going
> >> via the sub-system trees (and have been dropped from the series), in
> >> case those generate warnings for you.
> >
> > Something went off the rails in email land and #0 and #2 didn't end up
> > in my patch queue but the rest did.  Luckily enough made it through that
> > it didn't get lost, and lore's pretty great so this sort of thing isn't
> > that big of a deal these days.  That said, email is a bit of a black box
> > so figured I'd give you a heads up.
>
> Huh, interesting. I do check after sending that I can see the mails in my
> other email's inbox & they're there. Guess good thing that I sent the follow up.
> Thanks,
> Conor.
>
> >
> >>
> >> Thanks,
> >> Conor.
> >>>
> >>> Changes from v6:
> >>> - Dropped i2c patch, as its in i2c-next
> >>> - Added ack on gpio, reviewed-by on rtc
> >>> - Dropped child nodes from sysctrl binding entirely, added a link to
> >>>    the online documenation for the services the system controller can
> >>>    provide
> >>> - Dropped the #pwm-cells and replaced with a ref, a la Krzysztof's
> >>>    series
> >>>
> >>> Changes from v5:
> >>> - reworded the descriptions in the pwm binding to (hopefully) add
> >>>    clarity
> >>> - added -mask to the custom properties and made them 32 bit
> >>> - renamed the i2c binding to corei2c, since it is not mpfs specific
> >>> - removed the child nodes of the system controller in example/dts &
> >>>    will create them in the driver.
> >>>    @Rob, I assume keeping them documented is the correct thing to do?
> >>> - removed the dependancy on the clock binding from the examples
> >>> - reformatted rtc interrupts as per Rob's suggestion
> >>>
> >>> Changes from v4:
> >>> - dont include icicle_kit_defconfig, accidentally added in v3
> >>> - drop prescaler from mpfs-rtc & calculate the value instead
> >>> - use corei2c as a fallback device for mpfs-i2c
> >>> - drop spi dt-binding (on spi-next)
> >>>    commit 2da187304e556ac59cf2dacb323cc78ded988169
> >>> - drop usb dt-binding (on usb-next)
> >>>
> >>> Changes from v3:
> >>> - drop "mailbox: change mailbox-mpfs compatible string", already upstream:
> >>>    commit f10b1fc0161cd99e ("mailbox: change mailbox-mpfs compatible string")
> >>> - fix copy paste error in microchip,mpfs-mailbox dt-binding
> >>> - remove whitespace in syscontroller dt entry
> >>>
> >>> Changes from v2:
> >>> - dropped plic int header & corresponding defines in dts{,i}
> >>> - use $ref to drmode in mpfs-musb binding
> >>> - split changes to dts{,i} again: functional changes to existing
> >>>    elements now are in a new patch
> >>> - drop num-cs property in mpfs-spi binding
> >>> - dont make the system controller a simple-mfd
> >>> - move the separate bindings for rng/generic system services into the
> >>>    system controller binding
> >>> - added an instance corei2c as i2c2 in the fabric dtsi
> >>> - add version numbering to corepwm and corei2c compat string (-rtl-vN)
> >>>
> >>> Conor Dooley (11):
> >>>    dt-bindings: soc/microchip: update syscontroller compatibles
> >>>    dt-bindings: soc/microchip: add info about services to mpfs sysctrl
> >>>    dt-bindings: rtc: add bindings for microchip mpfs rtc
> >>>    dt-bindings: gpio: add bindings for microchip mpfs gpio
> >>>    dt-bindings: pwm: add microchip corepwm binding
> >>>    riscv: dts: microchip: use clk defines for icicle kit
> >>>    riscv: dts: microchip: add fpga fabric section to icicle kit
> >>>    riscv: dts: microchip: refactor icicle kit device tree
> >>>    riscv: dts: microchip: update peripherals in icicle kit device tree
> >>>    riscv: dts: microchip: add new peripherals to icicle kit device tree
> >>>    MAINTAINERS: update riscv/microchip entry
> >>>
> >>>   .../bindings/gpio/microchip,mpfs-gpio.yaml    |  79 ++++++
> >>>   ...ilbox.yaml => microchip,mpfs-mailbox.yaml} |   6 +-
> >>>   .../bindings/pwm/microchip,corepwm.yaml       |  81 ++++++
> >>>   .../bindings/rtc/microchip,mfps-rtc.yaml      |  58 ++++
> >>>   .../microchip,mpfs-sys-controller.yaml        |  40 +++
> >>>   ...icrochip,polarfire-soc-sys-controller.yaml |  35 ---
> >>>   MAINTAINERS                                   |   2 +
> >>>   .../dts/microchip/microchip-mpfs-fabric.dtsi  |  25 ++
> >>>   .../microchip/microchip-mpfs-icicle-kit.dts   | 115 ++++++--
> >>>   .../boot/dts/microchip/microchip-mpfs.dtsi    | 254 ++++++++++++++----
> >>>   10 files changed, 591 insertions(+), 104 deletions(-)
> >>>   create mode 100644 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> >>>   rename Documentation/devicetree/bindings/mailbox/{microchip,polarfire-soc-mailbox.yaml => microchip,mpfs-mailbox.yaml} (82%)
> >>>   create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> >>>   create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> >>>   create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
> >>>   delete mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
> >>>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
> >>>
>

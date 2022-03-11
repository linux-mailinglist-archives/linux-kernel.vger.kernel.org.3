Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52F24D693F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351119AbiCKT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbiCKT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:58:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E61CF0A5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:57:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c192so5720444wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hyHFdMu5+sDMX2FabVDzHh3nvTbk2iDwWgSCYauJ5LM=;
        b=App1+65z5XOBrhAKeiDdnq7Tl9pLK8rvdlav6iMyD4bmdsMMutsQPAGkKezmR3oiws
         uHZpXEmk/56Xe0gVRdVF9f3CbIFP+aDNU2MFB2ajlwd8LDY3zyqEePomlN/iSiVcsTIU
         RPYQYXdQgm9n3AJ1+vKXN79PLzEjLrl28l2w57/lJXTbTlFN/utHHatVRl2xHQyultSN
         QA5wOIIsU/X50VKXyLul+EmL4GroIPapmJcJRe4iA/gbbgSWWBLBwgBmhBOzTtyjdtpZ
         eLSzMPo6UuVIgLI1XFJyijPwofz9voR90MTlJ4OGpz8kMmepfUYR8bVRlN5FYXw0I2Yn
         URQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hyHFdMu5+sDMX2FabVDzHh3nvTbk2iDwWgSCYauJ5LM=;
        b=54620D/whyfUnTiM/itXMM8Ox9gXbY5OzZCcuF9U5RiNu0UxKJRYVWa6MrbVnPmXoc
         b5F4rgs8izVsIs0zrRA5OYoWYCiQT6uixwPSlvxRccScutFaq3V5MEVXABHiF8K/jlyb
         vUNJkwOAi6nFo04VfZwbXVihEkf7xSLktguDWdIpnapMoJ6SBSKXIkYDU5c5ucendMla
         QRiEMB3LyObsqshEjkJsadTjvMPh1rW1MjSuZZYjSdWD5D3XOmYaUbxQjjzxIIs5gOa4
         G4GF46TQipUaNbrCFK++tCkAShYSV9+sOv3uixA06oUMA9R7lElrxv5BZxm3BNI+rNkO
         pT5Q==
X-Gm-Message-State: AOAM532OnVFvEpvQMtPmQ+YsZP+mJsSSgghI1JGSdo0R64WekVG8vhTr
        KbV0AZ/l/+8T/Tx9eLZqw7aTPw==
X-Google-Smtp-Source: ABdhPJyfcz6JQlr/qzmlbw18c4zbQShcJ+zFmYG81nNEPwjxlj9hg0tSW/T0xVZo7ONXtDqgW/WguQ==
X-Received: by 2002:a1c:2904:0:b0:37b:ea53:4cbf with SMTP id p4-20020a1c2904000000b0037bea534cbfmr8788549wmp.46.1647028622112;
        Fri, 11 Mar 2022 11:57:02 -0800 (PST)
Received: from [192.168.2.222] ([109.76.4.19])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b00389cc36a3bfsm10091830wmp.6.2022.03.11.11.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:57:01 -0800 (PST)
Message-ID: <66d64241-d2bc-d25a-4204-56f10521ad6c@conchuod.ie>
Date:   Fri, 11 Mar 2022 19:56:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 00/11] Update the Icicle Kit device tree
Content-Language: en-US
To:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Lewis.Hanly@microchip.com, Daire.McNamara@microchip.com,
        Ivan.Griffin@microchip.com, atishp@rivosinc.com,
        linus.walleij@linaro.org, brgl@bgdev.pl,
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
References: <mhng-bb42ad9f-5772-4749-97e1-9f6c511654f6@palmer-mbp2014>
 <e9287c9b-6ac7-dcb3-3b03-98bc83bbf119@microchip.com>
 <CANXhq0rPVKSF64Hwd9+jD3ut0y7VCE940V5do0Hn8=mnoX97yw@mail.gmail.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <CANXhq0rPVKSF64Hwd9+jD3ut0y7VCE940V5do0Hn8=mnoX97yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2022 07:59, Zong Li wrote:
> On Thu, Mar 10, 2022 at 3:35 PM <Conor.Dooley@microchip.com> wrote:
>>
>> On 10/03/2022 07:07, Palmer Dabbelt wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Wed, 23 Feb 2022 12:48:16 PST (-0800), mail@conchuod.ie wrote:
>>>> On 14/02/2022 13:58, conor.dooley@microchip.com wrote:
>>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>> This series updates the Microchip Icicle Kit device tree by adding a
>>>>> host of peripherals, and some updates to the memory map. In addition,
>>>>> the device tree has been split into a third part, which contains "soft"
>>>>> peripherals that are in the fpga fabric.
>>>>>
>>>>> Several of the entries are for peripherals that have not get had their
>>>>> drivers upstreamed, so in those cases the dt bindings are included where
>>>>> appropriate in order to avoid the many "DT compatible string <x> appears
>>>>> un-documented" errors.
>>>>>
>>>>> Depends on mpfs clock driver binding (on clk/next) to provide
>>>>> dt-bindings/clock/microchip,mpfs-clock.h for the device tree
>>>>> and on the other changes to the icicle/mpfs device tree from geert
>>>>> that are already in linux/riscv/for-next.
>>>
>>> So that's causing this to not build, as I can't build without the
>>> header.  I went ahead and put these on top of that patch, resulting in
>>>
>>>      * 48e8641c2bf0 - (HEAD -> riscv-microchip, palmer/riscv-microchip) MAINTAINERS: update riscv/microchip entry (2 minutes ago) <Conor Dooley>
>>>      * 528a5b1f2556 - riscv: dts: microchip: add new peripherals to icicle kit device tree (2 minutes ago) <Conor Dooley>
>>>      * 5b28df37d311 - riscv: dts: microchip: update peripherals in icicle kit device tree (2 minutes ago) <Conor Dooley>
>>>      * c5094f371008 - riscv: dts: microchip: refactor icicle kit device tree (2 minutes ago) <Conor Dooley>
>>>      * 72560c6559b8 - riscv: dts: microchip: add fpga fabric section to icicle kit (2 minutes ago) <Conor Dooley>
>>>      * 6546f920868e - riscv: dts: microchip: use clk defines for icicle kit (2 minutes ago) <Conor Dooley>
>>>      * df77f7735786 - dt-bindings: pwm: add microchip corepwm binding (2 minutes ago) <Conor Dooley>
>>>      * 735806d8a68e - dt-bindings: gpio: add bindings for microchip mpfs gpio (2 minutes ago) <Conor Dooley>
>>>      * 4cbcc0d7b397 - dt-bindings: rtc: add bindings for microchip mpfs rtc (2 minutes ago) <Conor Dooley>
>>>      * b435a1728c9f - dt-bindings: soc/microchip: add info about services to mpfs sysctrl (2 minutes ago) <Conor Dooley>
>>>      * 213556235526 - dt-bindings: soc/microchip: update syscontroller compatibles (2 minutes ago) <Conor Dooley>
>>>      * 2145bb687e3f - (clk/clk-microchip) dt-bindings: clk: microchip: Add Microchip PolarFire host binding (6 weeks ago) <Daire McNamara>
>>>      * e783362eb54c - (tag: v5.17-rc1) Linux 5.17-rc1 (7 weeks ago) <Linus Torvalds>
>>>
>>> sboyd: IIRC it's OK to consider clk-microchip as a stable branch?  If
>>> not I can just wait until you send your PR to Linus and send this later
>>> in the merge window, no big deal on my end.
>>>
>>> I've put this on for-next.  If that's a problem let me know and I'll
>>> delay it.
>> Great, thanks! Probably worth mentioning that I've deleted the dma node
>> that Zong Li is modifying in his pdma patchset.
>>
> 
> I guess I could re-sent the next version based on top of for-next, or
> delay my patch set until the next tag. What is your perspective?

I'll be honest and say that I have no idea what one is supposed to do here.
Palmer?

> 
>>>
>>> Thanks!
>>>
>>>>>
>>>>> Additionally, the interrupt-extended warnings on the plic/clint are
>>>>> cleared by [1] & [2].
>>>>>
>>>>> [1] https://lore.kernel.org/linux-riscv/cover.1639744468.git.geert@linux-m68k.org/
>>>>> [2] https://lore.kernel.org/linux-riscv/cover.1639744106.git.geert@linux-m68k.org/
>>>>
>>>> Hey Palmer,
>>>>
>>>> dt-bindings should be set now, so if you're still happy to take the
>>>> series via riscv, that'd be great. i2c, spi & usb patches ended going
>>>> via the sub-system trees (and have been dropped from the series), in
>>>> case those generate warnings for you.
>>>
>>> Something went off the rails in email land and #0 and #2 didn't end up
>>> in my patch queue but the rest did.  Luckily enough made it through that
>>> it didn't get lost, and lore's pretty great so this sort of thing isn't
>>> that big of a deal these days.  That said, email is a bit of a black box
>>> so figured I'd give you a heads up.
>>
>> Huh, interesting. I do check after sending that I can see the mails in my
>> other email's inbox & they're there. Guess good thing that I sent the follow up.
>> Thanks,
>> Conor.
>>
>>>
>>>>
>>>> Thanks,
>>>> Conor.
>>>>>
>>>>> Changes from v6:
>>>>> - Dropped i2c patch, as its in i2c-next
>>>>> - Added ack on gpio, reviewed-by on rtc
>>>>> - Dropped child nodes from sysctrl binding entirely, added a link to
>>>>>     the online documenation for the services the system controller can
>>>>>     provide
>>>>> - Dropped the #pwm-cells and replaced with a ref, a la Krzysztof's
>>>>>     series
>>>>>
>>>>> Changes from v5:
>>>>> - reworded the descriptions in the pwm binding to (hopefully) add
>>>>>     clarity
>>>>> - added -mask to the custom properties and made them 32 bit
>>>>> - renamed the i2c binding to corei2c, since it is not mpfs specific
>>>>> - removed the child nodes of the system controller in example/dts &
>>>>>     will create them in the driver.
>>>>>     @Rob, I assume keeping them documented is the correct thing to do?
>>>>> - removed the dependancy on the clock binding from the examples
>>>>> - reformatted rtc interrupts as per Rob's suggestion
>>>>>
>>>>> Changes from v4:
>>>>> - dont include icicle_kit_defconfig, accidentally added in v3
>>>>> - drop prescaler from mpfs-rtc & calculate the value instead
>>>>> - use corei2c as a fallback device for mpfs-i2c
>>>>> - drop spi dt-binding (on spi-next)
>>>>>     commit 2da187304e556ac59cf2dacb323cc78ded988169
>>>>> - drop usb dt-binding (on usb-next)
>>>>>
>>>>> Changes from v3:
>>>>> - drop "mailbox: change mailbox-mpfs compatible string", already upstream:
>>>>>     commit f10b1fc0161cd99e ("mailbox: change mailbox-mpfs compatible string")
>>>>> - fix copy paste error in microchip,mpfs-mailbox dt-binding
>>>>> - remove whitespace in syscontroller dt entry
>>>>>
>>>>> Changes from v2:
>>>>> - dropped plic int header & corresponding defines in dts{,i}
>>>>> - use $ref to drmode in mpfs-musb binding
>>>>> - split changes to dts{,i} again: functional changes to existing
>>>>>     elements now are in a new patch
>>>>> - drop num-cs property in mpfs-spi binding
>>>>> - dont make the system controller a simple-mfd
>>>>> - move the separate bindings for rng/generic system services into the
>>>>>     system controller binding
>>>>> - added an instance corei2c as i2c2 in the fabric dtsi
>>>>> - add version numbering to corepwm and corei2c compat string (-rtl-vN)
>>>>>
>>>>> Conor Dooley (11):
>>>>>     dt-bindings: soc/microchip: update syscontroller compatibles
>>>>>     dt-bindings: soc/microchip: add info about services to mpfs sysctrl
>>>>>     dt-bindings: rtc: add bindings for microchip mpfs rtc
>>>>>     dt-bindings: gpio: add bindings for microchip mpfs gpio
>>>>>     dt-bindings: pwm: add microchip corepwm binding
>>>>>     riscv: dts: microchip: use clk defines for icicle kit
>>>>>     riscv: dts: microchip: add fpga fabric section to icicle kit
>>>>>     riscv: dts: microchip: refactor icicle kit device tree
>>>>>     riscv: dts: microchip: update peripherals in icicle kit device tree
>>>>>     riscv: dts: microchip: add new peripherals to icicle kit device tree
>>>>>     MAINTAINERS: update riscv/microchip entry
>>>>>
>>>>>    .../bindings/gpio/microchip,mpfs-gpio.yaml    |  79 ++++++
>>>>>    ...ilbox.yaml => microchip,mpfs-mailbox.yaml} |   6 +-
>>>>>    .../bindings/pwm/microchip,corepwm.yaml       |  81 ++++++
>>>>>    .../bindings/rtc/microchip,mfps-rtc.yaml      |  58 ++++
>>>>>    .../microchip,mpfs-sys-controller.yaml        |  40 +++
>>>>>    ...icrochip,polarfire-soc-sys-controller.yaml |  35 ---
>>>>>    MAINTAINERS                                   |   2 +
>>>>>    .../dts/microchip/microchip-mpfs-fabric.dtsi  |  25 ++
>>>>>    .../microchip/microchip-mpfs-icicle-kit.dts   | 115 ++++++--
>>>>>    .../boot/dts/microchip/microchip-mpfs.dtsi    | 254 ++++++++++++++----
>>>>>    10 files changed, 591 insertions(+), 104 deletions(-)
>>>>>    create mode 100644 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
>>>>>    rename Documentation/devicetree/bindings/mailbox/{microchip,polarfire-soc-mailbox.yaml => microchip,mpfs-mailbox.yaml} (82%)
>>>>>    create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
>>>>>    create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
>>>>>    create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
>>>>>    delete mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
>>>>>    create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
>>>>>
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ECC4C1D54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbiBWUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiBWUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:48:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D944D257
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:48:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j17so14882610wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RRu2PqFxs+FPxxXA+v25zzkAp1fkNpteo8XX4VMDfsI=;
        b=7XOoxRqb9Tv8kkCqMFJc5EqMLpdohXL6zjfTgOd7rLqoL9hjhjxLHgwcjThSa2r4uE
         cfhJDDfaXveX9Ng8Vdd47vyy4E3dPrskszcIFjovCrel9HtE+pXh0eqkbxQe7YrVSNwG
         lWNWlEEpEhvRrQZ94lu3Asx3ml1g1Dnuvl/S7WL2WiKfJkce+t1aep9NmikFKC++i2cp
         Bs3zVs+sFui9Fd+TA3gD2EPgFBykwjmGMXnsgOXu8WAJdM488/vNt/kBPuHmu9TZWYA1
         WB8Et2mwrkrO7nwEOThETi3qqzLMbHymoOesRTkLa62cCJNtfhpkK3u8hCixOa51wyKN
         7yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RRu2PqFxs+FPxxXA+v25zzkAp1fkNpteo8XX4VMDfsI=;
        b=mcqKGMGbYLA2oevgBxOQ8iQ8ZEyK7pS/St+iCiUta85Fa4m8oGAmWafaj+2b17/IjP
         WN5iDGh+/Gy7RZtCx3OMn2w2CtYNxvwoUDO13aZFtwYGrIx/TRYJbQjNM2zEKaR50rtj
         /ip/YPl5twEN1sHZdR6JnDL1i5OSNUz9i9OkgLnYEczIFwPbP7ECX/CO26zeTJNiUQd1
         VJjxJsG2MPaCBx2FTYDrUYGqh3OkZRw08qUFeFLeZp0rQRuwCykl08UCEHxeyGMXK2yD
         CddIkzh407eCjoZq2hD+fMYIsA8j8Rl4AafaX94ZjSeQ3G94t546KNiCDIpu6sVS/Tfe
         xg3A==
X-Gm-Message-State: AOAM530Bgl9ZUSBh+U6SfyGFgdXfC7D4Dpvth5N3vQSu8UbmAh1Q1zNa
        hZjoRgo3jE3HpY0U4XcWCdUbKg==
X-Google-Smtp-Source: ABdhPJwTSd3fwnBHNPVLAxW9AId4se4ijwGgW4cX5Yfawa3jAXMdmq++0LpZ4WASwNLU9EfbO/Xqmw==
X-Received: by 2002:adf:e54e:0:b0:1ea:9746:16d5 with SMTP id z14-20020adfe54e000000b001ea974616d5mr1030363wrm.186.1645649297584;
        Wed, 23 Feb 2022 12:48:17 -0800 (PST)
Received: from [192.168.2.116] ([109.76.226.172])
        by smtp.gmail.com with ESMTPSA id f7sm578561wrz.40.2022.02.23.12.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:48:17 -0800 (PST)
Message-ID: <c94f9c0a-6dbe-c1f4-daff-e4d29f3ace02@conchuod.ie>
Date:   Wed, 23 Feb 2022 20:48:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 00/11] Update the Icicle Kit device tree
Content-Language: en-US
To:     palmer@dabbelt.com
Cc:     lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atishp@rivosinc.com,
        conor.dooley@microchip.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, jassisinghbrar@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        krzysztof.kozlowski@canonical.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220214135840.168236-1-conor.dooley@microchip.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220214135840.168236-1-conor.dooley@microchip.com>
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

On 14/02/2022 13:58, conor.dooley@microchip.com wrote:
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
> dt-bindings/clock/microchip,mpfs-clock.h for the device tree
> and on the other changes to the icicle/mpfs device tree from geert
> that are already in linux/riscv/for-next.
> 
> Additionally, the interrupt-extended warnings on the plic/clint are
> cleared by [1] & [2].
> 
> [1] https://lore.kernel.org/linux-riscv/cover.1639744468.git.geert@linux-m68k.org/
> [2] https://lore.kernel.org/linux-riscv/cover.1639744106.git.geert@linux-m68k.org/

Hey Palmer,

dt-bindings should be set now, so if you're still happy to take the 
series via riscv, that'd be great. i2c, spi & usb patches ended going 
via the sub-system trees (and have been dropped from the series), in 
case those generate warnings for you.

Thanks,
Conor.
> 
> Changes from v6:
> - Dropped i2c patch, as its in i2c-next
> - Added ack on gpio, reviewed-by on rtc
> - Dropped child nodes from sysctrl binding entirely, added a link to
>    the online documenation for the services the system controller can
>    provide
> - Dropped the #pwm-cells and replaced with a ref, a la Krzysztof's
>    series
> 
> Changes from v5:
> - reworded the descriptions in the pwm binding to (hopefully) add
>    clarity
> - added -mask to the custom properties and made them 32 bit
> - renamed the i2c binding to corei2c, since it is not mpfs specific
> - removed the child nodes of the system controller in example/dts &
>    will create them in the driver.
>    @Rob, I assume keeping them documented is the correct thing to do?
> - removed the dependancy on the clock binding from the examples
> - reformatted rtc interrupts as per Rob's suggestion
> 
> Changes from v4:
> - dont include icicle_kit_defconfig, accidentally added in v3
> - drop prescaler from mpfs-rtc & calculate the value instead
> - use corei2c as a fallback device for mpfs-i2c
> - drop spi dt-binding (on spi-next)
>    commit 2da187304e556ac59cf2dacb323cc78ded988169
> - drop usb dt-binding (on usb-next)
> 
> Changes from v3:
> - drop "mailbox: change mailbox-mpfs compatible string", already upstream:
>    commit f10b1fc0161cd99e ("mailbox: change mailbox-mpfs compatible string")
> - fix copy paste error in microchip,mpfs-mailbox dt-binding
> - remove whitespace in syscontroller dt entry
> 
> Changes from v2:
> - dropped plic int header & corresponding defines in dts{,i}
> - use $ref to drmode in mpfs-musb binding
> - split changes to dts{,i} again: functional changes to existing
>    elements now are in a new patch
> - drop num-cs property in mpfs-spi binding
> - dont make the system controller a simple-mfd
> - move the separate bindings for rng/generic system services into the
>    system controller binding
> - added an instance corei2c as i2c2 in the fabric dtsi
> - add version numbering to corepwm and corei2c compat string (-rtl-vN)
> 
> Conor Dooley (11):
>    dt-bindings: soc/microchip: update syscontroller compatibles
>    dt-bindings: soc/microchip: add info about services to mpfs sysctrl
>    dt-bindings: rtc: add bindings for microchip mpfs rtc
>    dt-bindings: gpio: add bindings for microchip mpfs gpio
>    dt-bindings: pwm: add microchip corepwm binding
>    riscv: dts: microchip: use clk defines for icicle kit
>    riscv: dts: microchip: add fpga fabric section to icicle kit
>    riscv: dts: microchip: refactor icicle kit device tree
>    riscv: dts: microchip: update peripherals in icicle kit device tree
>    riscv: dts: microchip: add new peripherals to icicle kit device tree
>    MAINTAINERS: update riscv/microchip entry
> 
>   .../bindings/gpio/microchip,mpfs-gpio.yaml    |  79 ++++++
>   ...ilbox.yaml => microchip,mpfs-mailbox.yaml} |   6 +-
>   .../bindings/pwm/microchip,corepwm.yaml       |  81 ++++++
>   .../bindings/rtc/microchip,mfps-rtc.yaml      |  58 ++++
>   .../microchip,mpfs-sys-controller.yaml        |  40 +++
>   ...icrochip,polarfire-soc-sys-controller.yaml |  35 ---
>   MAINTAINERS                                   |   2 +
>   .../dts/microchip/microchip-mpfs-fabric.dtsi  |  25 ++
>   .../microchip/microchip-mpfs-icicle-kit.dts   | 115 ++++++--
>   .../boot/dts/microchip/microchip-mpfs.dtsi    | 254 ++++++++++++++----
>   10 files changed, 591 insertions(+), 104 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
>   rename Documentation/devicetree/bindings/mailbox/{microchip,polarfire-soc-mailbox.yaml => microchip,mpfs-mailbox.yaml} (82%)
>   create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
>   create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
>   create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
>   delete mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C502517846
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiEBUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiEBUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:38:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7021A6;
        Mon,  2 May 2022 13:35:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y63so16356881oia.7;
        Mon, 02 May 2022 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Wbb/YCuXfU00DfHND/DHy2kwUE+lT6TSINXYpJ/qV5I=;
        b=FLLW/uyff9Ycgsqvr7B/1rKKbYcqxPHcB/Z4Dzkise/sBahurt9MkB5d2Pwdq0mBx6
         JBZ79EtlI9uPK5x9zPokW236sVzMczhGdVx1gIMZGk636HBXuHx4CTnG4GED7AvGzHUW
         Thvss09ZX4qJwF85xOtO/5anUeLJUCJLQqE2oTAv7ob7MgOQbZ8FIG2ataSCB11SLPi/
         zWRPk8cies0VayUBETQZF0ATO7Ph0YxmHCoLhEDbHA/tOq7AD79YUjIKnbLY1pjSmHsB
         fjVxpaNMsC7JbyjvdifBLlvwCFZr+BZVQ35H0Bzt/dw9KykTjCJryLdhyJ23VfF7JeHa
         F90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Wbb/YCuXfU00DfHND/DHy2kwUE+lT6TSINXYpJ/qV5I=;
        b=ozV8FDbO8mlL5w2pcJ57nvVIUa+TRjkC1wVDhF2V35UGVtT9YlED0K4hAGo0Dx3kES
         rPmKeh6ZzkFvnZGqjmVOJkCGNYassAytxhi7kAnHYVT9no6wsMZ7VK75817MuKTaHDJE
         6rVhfuPoetwvXXN7Z4XN+SNfgMjb/2u1PuHOG3exg87uqIEqxXv+vF8qU6nif3OW4b4A
         bS8e7o54rxu+m0znTxeCQXcnqvaaznSkgq2654Dpv1ch+6GSXX8Vp2kCMHzTIPTeqUD4
         oxTBIWoj8dSXMoVeVu/09PCj8ymRvqd/5R6iM5aVeu/4iR6rBDnQQ13ltFhgBw3get+n
         a8NQ==
X-Gm-Message-State: AOAM531kngqZ9obTjKD55+i6DE0ZN6M8zie4DUrFwc93fxP7/x04Rogq
        D+p3Ou0uelVDh7XHmbokqPE=
X-Google-Smtp-Source: ABdhPJwiM/GiwIXmL7hyCptsmhhiYotg3kbrvacK9o0+PJRo8UrmYe/PJoRe3aFR7xYQMKwGGCJYVg==
X-Received: by 2002:a05:6808:1311:b0:325:bb64:ced6 with SMTP id y17-20020a056808131100b00325bb64ced6mr454522oiv.13.1651523716162;
        Mon, 02 May 2022 13:35:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a4aa602000000b0035ef3da8387sm1302819oom.4.2022.05.02.13.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:35:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c001d58e-9a78-6338-a533-d0f215b3dfd1@roeck-us.net>
Date:   Mon, 2 May 2022 13:35:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
 <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
 <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
 <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net>
 <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net>
 <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
 <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com>
 <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net>
 <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
In-Reply-To: <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 12:21, Arnd Bergmann wrote:
> On Mon, May 2, 2022 at 6:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> With v5.18-rc1-49-gcb813018b5c1, I still get:
>>
>> [    0.797668] RAMDISK: Couldn't find valid RAM disk image starting at 0.
>> [    0.805262] /dev/root: Can't open blockdev
>> [    0.805487] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>> [    0.805674] Please append a correct "root=" boot option; here are the available partitions:
>>
>> when trying to boot z2 from initrd.
>>
>> The other problems are gone.
> 
> Ok, progress!
> 
> What is your qemu command line? I see that z2 has no pcmcia device, so
> I tried booting
> from MMC, but this already fails with 5.18-rc1 without any of my
> patches, giving me
> 
> [    0.697481] Creating 3 MTD partitions on "physmap-flash":
> [    0.698161] 0x000000000000-0x000000040000 : "U-Boot Bootloader"
> [    0.702815] 0x000000040000-0x000000060000 : "U-Boot Environment"
> [    0.706541] 0x000000060000-0x000000800000 : "Flash"
> [    0.718066] pxa2xx-mci pxa2xx-mci.0: incomplete constraints, dummy
> supplies not allowed
> [    0.718501] pxa2xx-mci pxa2xx-mci.0: incomplete constraints, dummy
> supplies not allowed
> 

To boot from initrd:

qemu-system-arm -M z2 -kernel \
      arch/arm/boot/zImage -no-reboot -initrd \
      rootfs-armv5.cpio --append \
      "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0" -nographic \
      -monitor null -serial stdio

where rootfs-armv5.cpio is from my repository at github.com.

https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv5.cpio.gz

> Do  you have MMC or some other rootfs working without my patch series?
> 

I can boot z2 from mmc and flash, but I have a number of configuration
flags enabled on top of pxa_defconfig. That also works with your latest patch
series. See
https://kerneltests.org/builders/qemu-arm-testing/builds/75/steps/qemubuildcommand/logs/stdio

     # Always enable ...
     enable_config "${defconfig}" CONFIG_DEVTMPFS CONFIG_DEVTMPFS_MOUNT CONFIG_BLK_DEV_INITRD
     # Options needed to be built into the kernel for device support
     # on pxa devices
     # MTD, squashfs
     enable_config_cond "${defconfig}" CONFIG_MTD_BLOCK CONFIG_MTD_PXA2XX CONFIG_SQUASHFS
     # MMC
     enable_config_cond "${defconfig}" CONFIG_MMC_BLOCK CONFIG_MMC_PXA
     # PCMCIA
     enable_config_cond "${defconfig}" CONFIG_ATA CONFIG_BLK_DEV_SD CONFIG_PCCARD
     enable_config_cond "${defconfig}" CONFIG_PCMCIA CONFIG_PATA_PCMCIA CONFIG_PCMCIA_PXA2XX
     # USB
     enable_config_cond "${defconfig}" CONFIG_USB CONFIG_USB_STORAGE CONFIG_USB_OHCI_HCD CONFIG_USB_OHCI_HCD_PXA27X

Hope this helps,
Guenter

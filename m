Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4F4A38FF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356116AbiA3UWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiA3UWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:22:15 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE0C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:22:15 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q186so23041570oih.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z48xgPQnmnpTP4ZecfJV0DGRkK0F/UMflIrdRqqadkM=;
        b=DWDoOo/B0hU+Xr5+45kteV2slulQnD+QdXGaWFmXQDTSXgvnPQ7aWGCfw1z5BFY8dl
         h8Xt/abZuoHeIG6eV9V45bvO+83j8y8B4iHWftplNFMViKeMRrTmpC1fPWB4hP1QzB5e
         8EAqyYqCye8ZC/leBM6APjgf9jJkDGlEl2B9K1rze26Vig3rfHN7qS2k81unegaLfuUa
         KF0gbZ3JsVVagDvd0cgO7cu/+rs/muViEBYU9xrntd8Vz1Frhctf7sLuoXjN6J9izAec
         rDxWlG6Gfs6X1/aLpKk38UU4HcT5xM8Q6ZhfGPrGzIOO7r8ydijKfZMjKpgZ/BvitsyY
         MTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z48xgPQnmnpTP4ZecfJV0DGRkK0F/UMflIrdRqqadkM=;
        b=VsfGeAhsQ2vlO43xqAgl6/DdgAozLvQODidRFyYA2toY/InA5uV66HHTDxyMDJAF7O
         QenfXZvccoghj9lIAvcg6YVE5SV3r+iIxgvYdock7gxQZte9PegdrtdLGmM6X6WnIWcm
         h97s7aGi1+qqrVa3PXgA/3TEbGbinT9GYoetwk4bCdauxuaCLTxjvVHPmeCoYaN6RDJS
         mvfurMSKrMOmJHSJcaCDra/5zcqfOhARHPJrEByr1mhUmEl1aQdfVtaLWBmEBLwh0PHf
         hjETokKipe+bHqCMEMFpbp/Zvc6MlZUO3xaNNmeL0zjbO3naj0nIr5UYr2MLmugvK+z1
         Vfpw==
X-Gm-Message-State: AOAM533S17flm9OMU+BKoR5X/5pYKXYKewDU4eJP6mmSj6mbm6LhATBj
        OCeI+h4hgOXBYsBffKlGFEnzspIQbpGGpQ==
X-Google-Smtp-Source: ABdhPJy3iO/59dO5IlexHrrFs1SroykPIC1z9yJnYqZRj99OjSzxJW7oJtXn92+aLw3J1K0uUZdWZw==
X-Received: by 2002:a05:6808:f87:: with SMTP id o7mr1844304oiw.135.1643574134422;
        Sun, 30 Jan 2022 12:22:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g34sm8589481ooi.48.2022.01.30.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:22:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 30 Jan 2022 12:22:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc2
Message-ID: <20220130202211.GA3286863@roeck-us.net>
References: <CAHk-=wg4NYVVC58vBAD6Hd6MFfY4AG-aAUHtBCYQBcsKz+4XOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4NYVVC58vBAD6Hd6MFfY4AG-aAUHtBCYQBcsKz+4XOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 03:48:42PM +0200, Linus Torvalds wrote:
> Another week, another -rc.
> 
> Nothing hugely surprising here - it's a bit on the bigger side for
> being an rc2, but maybe part of that is that there's a NFS client
> merge-window pull request that got merged late due to it having been
> marked as spam.
> 
> But more likely it's just the usual random fluctuation, with no deeper reason.
> 
> The stats are a bit unusual, with drivers being just a third of the
> patch. But that's hardly due to the nfs changes - they show up, but
> not nearly as much as all the arch updates. There's just a fair amount
> of random spread-out architecture fixes - kvm updates for both arm64
> and x86, but also misc perf event updates, powerpc and mips updates
> etc.
> 
> The rest is random other noise - documentation, networking, tooling.
> The appended shortlog gives an overview of the details.
> 
> Go forth and test, please,
> 

Build results:
	total: 155 pass: 151 fail: 4
Failed builds:
	arm64:allmodconfig
	ia64:tinyconfig
	mips:cavium_octeon_defconfig
	powerpc:skiroot_defconfig
Qemu test results:
	total: 488 pass: 480 fail: 8
Failed tests:
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net,nic:net,nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:net,nic:imx6ul-14x14-evk:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:mem256:net,nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:usb1:mem256:net,nic:imx7d-sdb:rootfs
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:sd:mem256:net,nic:imx7d-sdb:rootfs
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs

Details attached.

Guenter

---

Building arm64:allmodconfig ... failed
--------------
drivers/pinctrl/pinctrl-thunderbay.c: In function 'thunderbay_add_functions':
drivers/pinctrl/pinctrl-thunderbay.c:815:29: error: assignment discards 'const' qualifier from pointer target type

Fix posted at
https://lore.kernel.org/lkml/DM6PR11MB3660804C821D7CA7329B6CAFC45F9@DM6PR11MB3660.namprd11.prod.outlook.com/

---
Building ia64:tinyconfig ... failed
--------------
ia64-linux-ld: drivers/acpi/scan.o: in function `__acpi_device_add':
scan.c:(.text+0x27e2): undefined reference to `crc32_le'

Bisect points to commit 882c982dada4d5 ("acpi: Store CRC-32 hash
of the _PLD in struct acpi_device"). Problem is that ACPI now depends
on CRC32. No fix posted as far as I know.

---
Building mips:cavium_octeon_defconfig ... failed
--------------
arch/mips/cavium-octeon/octeon-memcpy.S: Assembler messages:
arch/mips/cavium-octeon/octeon-memcpy.S:187: Error: unrecognized opcode `ptr 9b,l_exc'

... and many more.

Bisect points to commit fa62f39dc7e2 (" MIPS: Fix build error due to PTR
used in more places") which replaces PTR with PTR_WD but misses one place
in the Cavium code. No fix posted as far as I know.

---
Building powerpc:skiroot_defconfig ... failed
--------------
arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace'

Introduced with commit 1614b2b11fab29 ("arch: Make ARCH_STACKWALK
independent of STACKTRACE"). Discussed at
https://lore.kernel.org/lkml/YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net/T/
No fix posted as far as I know.

---
Building arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net,nic:net,nic:imx6ul-14x14-evk:initrd ... running .......R.... failed (crashed)

[   18.638198] Out of memory and no killable processes...
[   18.639419] Kernel panic - not syncing: System is deadlocked on memory

Bisect points to commit 721fb891ad0b ("mm/page_isolation: unset migratetype
directly for non Buddy page"). Fix (revert) posted at
https://lore.kernel.org/linux-mm/20220126211154.GA3371726@roeck-us.net/t/
but not applied.

---
Building arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs ... running ........R.... failed (no root file system)

Introduced with 8df89a7cbc63 ("pinctrl-sunxi: don't call
pinctrl_gpio_direction()"). Fix posted.

---
i386:q35:Westmere:defconfig:nosmp:nvme:net,i82562:hd:

WARNING: CPU: 0 PID: 23 at drivers/pci/msi/msi.c:1114 pci_irq_get_affinity+0x80/0x90

Only seen with i386, SMP disabled, when booting from nvme. Bisect points
to commit f48235900182(" PCI/MSI: Simplify pci_irq_get_affinity()").
No fix posted as far as I know.

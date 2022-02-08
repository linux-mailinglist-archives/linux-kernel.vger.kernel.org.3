Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F74AD68C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiBHL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356156AbiBHKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:17:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207FDC03FEC0;
        Tue,  8 Feb 2022 02:17:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5C761559;
        Tue,  8 Feb 2022 10:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED064C340F5;
        Tue,  8 Feb 2022 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644315470;
        bh=B5kPKaKPj6WPHi2c1HyJFZySKtUKUS+F4wL45+EXYc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RabgyLZ3czHUYu9eQfVMsqKQjd28oIC2eAxgZIC/cMV5+hibcqoT2NuQmD7DOvK9P
         GnRyg8wnvdKLog6dXkCzWblnagSXKBQck0iCu0oHCN3Ua0XyfVEoxg+uWlBd/oAQDt
         rHBvl98IaSWDWY6FHyzInN0UsRrhTjDnogCM9Qa7l7kp94NkYHvumML5idokK2waW/
         xrCoRrsEfriZZmjoX4JOgHOTZHMrPKXIz0qzqEElQ6EuLqleaKsW8xmLJSTvnFFVe3
         xVd+g8G1mWmnWNc6aFYJwDtirwlqQ9A8ckL6chYsh34iLWS5JfJ/LSUQVthh0Q28q+
         dxaweMMQtijaw==
Received: by mail-vs1-f41.google.com with SMTP id l14so2786942vsm.3;
        Tue, 08 Feb 2022 02:17:49 -0800 (PST)
X-Gm-Message-State: AOAM530nG/Fh3hSF6uA3ihqocqhnCuZ0SEksEqPZLmy0BjTIE2cURkX/
        vJninW//Pc1E/WVzzq2f64W3MmC4YpB5OAOw3bw=
X-Google-Smtp-Source: ABdhPJw9ojF+FsTHyx00YzSyU8RZae2avCJuBYfyZzZ4Ycd7H1q1FgS5AkGIyag/uQm+hXTMiI6TevIA1CXIxIuiWe8=
X-Received: by 2002:a67:ea4e:: with SMTP id r14mr840479vso.51.1644315468769;
 Tue, 08 Feb 2022 02:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-9-apatel@ventanamicro.com> <CAJF2gTQsSn1KBgX2bg2LiSUbCmbGD3oF5KcmK5gq2Dd49BWDBQ@mail.gmail.com>
 <CAAhSdy3Dkv6ga0ZMp5rMFa8nV9EDHgOMBwuJ4z4-w52T8EaUag@mail.gmail.com>
In-Reply-To: <CAAhSdy3Dkv6ga0ZMp5rMFa8nV9EDHgOMBwuJ4z4-w52T8EaUag@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Feb 2022 18:17:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSLmBcgUUE3VGsEq0JCWV74Yy-pkduS66rk=VPVwxk59g@mail.gmail.com>
Message-ID: <CAJF2gTSLmBcgUUE3VGsEq0JCWV74Yy-pkduS66rk=VPVwxk59g@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for
 QEMU virt machine
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 4:54 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Feb 8, 2022 at 12:16 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > Another question:
> >
> > Have you put "idle-states {" in qemu's DTS? or how do you test your patches?
>
> I usually do the following:
> 1) Dump QEMU virt machine DTB
> 2) Convert QEMU virt machine DTB into DTS
> 3) Add "idle-states" in QEMU virt machine DTS
> 4) Create QEMU virt machine DTB with "idle-states"
> 5) Use the new QEMU virt machine DTB for testing this series.
>
> Here's one of the DTS files which I used for testing on QEMU virt machine:
>
> /dts-v1/;
>
> / {
>     #address-cells = <0x02>;
>     #size-cells = <0x02>;
>     compatible = "riscv-virtio";
>     model = "riscv-virtio,qemu";
>
>     chosen {
>         linux,initrd-end = <0x8855d200>;
>         linux,initrd-start = <0x88200000>;
>         bootargs = "root=/dev/ram rw console=ttyS0 earlycon";
>         stdout-path = "/soc/uart@10000000";
>     };
>
>     memory@80000000 {
>         device_type = "memory";
>         reg = <0x00 0x80000000 0x00 0x10000000>;
>     };
>
>     cpus {
>         #address-cells = <0x01>;
>         #size-cells = <0x00>;
>         timebase-frequency = <0x989680>;
>
>         cpu@0 {
>             phandle = <0x07>;
>             device_type = "cpu";
>             reg = <0x00>;
>             status = "okay";
>             compatible = "riscv";
>             riscv,isa = "rv64imafdcsu";
>             mmu-type = "riscv,sv48";
>             cpu-idle-states = <&CPU_NONRET_DEF>;
>
>             interrupt-controller {
>                 #interrupt-cells = <0x01>;
>                 interrupt-controller;
>                 compatible = "riscv,cpu-intc";
>                 phandle = <0x08>;
>             };
>         };
>
>         cpu@1 {
>             phandle = <0x05>;
>             device_type = "cpu";
>             reg = <0x01>;
>             status = "okay";
>             compatible = "riscv";
>             riscv,isa = "rv64imafdcsu";
>             mmu-type = "riscv,sv48";
>             cpu-idle-states = <&CPU_RET_DEF>;
>
>             interrupt-controller {
>                 #interrupt-cells = <0x01>;
>                 interrupt-controller;
>                 compatible = "riscv,cpu-intc";
>                 phandle = <0x06>;
>             };
>         };
>
>         cpu@2 {
>             phandle = <0x03>;
>             device_type = "cpu";
>             reg = <0x02>;
>             status = "okay";
>             compatible = "riscv";
>             riscv,isa = "rv64imafdcsu";
>             mmu-type = "riscv,sv48";
>             cpu-idle-states = <&CPU_NONRET_DEF>;
>
>             interrupt-controller {
>                 #interrupt-cells = <0x01>;
>                 interrupt-controller;
>                 compatible = "riscv,cpu-intc";
>                 phandle = <0x04>;
>             };
>         };
>
>         cpu@3 {
>             phandle = <0x01>;
>             device_type = "cpu";
>             reg = <0x03>;
>             status = "okay";
>             compatible = "riscv";
>             riscv,isa = "rv64imafdcsu";
>             mmu-type = "riscv,sv48";
>             cpu-idle-states = <&CPU_RET_DEF>;
>
>             interrupt-controller {
>                 #interrupt-cells = <0x01>;
>                 interrupt-controller;
>                 compatible = "riscv,cpu-intc";
>                 phandle = <0x02>;
>             };
>         };
>
>         cpu-map {
>
>             cluster0 {
>
>                 core0 {
>                     cpu = <0x07>;
>                 };
>
>                 core1 {
>                     cpu = <0x05>;
>                 };
>
>                 core2 {
>                     cpu = <0x03>;
>                 };
>
>                 core3 {
>                     cpu = <0x01>;
>                 };
>             };
>         };
>
>         idle-states {
>             CPU_RET_DEF: cpu-retentive-default {
>                 compatible = "riscv,idle-state";
>                 riscv,sbi-suspend-param = <0x00000000>;
>                 entry-latency-us = <10>;
>                 exit-latency-us = <10>;
>                 min-residency-us = <100>;
>             };
>
>             CPU_NONRET_DEF: cpu-nonretentive-default {
>                 compatible = "riscv,idle-state";
>                 riscv,sbi-suspend-param = <0x80000000>;
>                 entry-latency-us = <100>;
>                 exit-latency-us = <100>;
>                 min-residency-us = <1000>;
>             };
>         };
>     };
>
>     soc {
>         #address-cells = <0x02>;
>         #size-cells = <0x02>;
>         compatible = "simple-bus";
>         ranges;
>
>         flash@20000000 {
>             bank-width = <0x04>;
>             reg = <0x00 0x20000000 0x00 0x2000000 0x00 0x22000000 0x00
> 0x2000000>;
>             compatible = "cfi-flash";
>         };
>
>         rtc@101000 {
>             interrupts = <0x0b>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x101000 0x00 0x1000>;
>             compatible = "google,goldfish-rtc";
>         };
>
>         uart@10000000 {
>             interrupts = <0x0a>;
>             interrupt-parent = <0x09>;
>             clock-frequency = <0x384000>;
>             reg = <0x00 0x10000000 0x00 0x100>;
>             compatible = "ns16550a";
>         };
>
>         poweroff {
>             value = <0x5555>;
>             offset = <0x00>;
>             regmap = <0x0a>;
>             compatible = "syscon-poweroff";
>         };
>
>         reboot {
>             value = <0x7777>;
>             offset = <0x00>;
>             regmap = <0x0a>;
>             compatible = "syscon-reboot";
>         };
>
>         test@100000 {
>             phandle = <0x0a>;
>             reg = <0x00 0x100000 0x00 0x1000>;
>             compatible = "sifive,test1\0sifive,test0\0syscon";
>         };
>
>         pci@30000000 {
>             interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
>             interrupt-map = <0x00 0x00 0x00 0x01 0x09 0x20 0x00 0x00
> 0x00 0x02 0x09 0x21 0x00 0x00 0x00 0x03 0x09 0x22 0x00 0x00 0x00 0x04
> 0x09 0x23 0x800 0x00 0x00 0x01 0x09 0x21 0x800 0x00 0x00 0x02 0x09
> 0x22 0x800 0x00 0x00 0x03 0x09 0x23 0x800 0x00 0x00 0x04 0x09 0x20
> 0x1000 0x00 0x00 0x01 0x09 0x22 0x1000 0x00 0x00 0x02 0x09 0x23 0x1000
> 0x00 0x00 0x03 0x09 0x20 0x1000 0x00 0x00 0x04 0x09 0x21 0x1800 0x00
> 0x00 0x01 0x09 0x23 0x1800 0x00 0x00 0x02 0x09 0x20 0x1800 0x00 0x00
> 0x03 0x09 0x21 0x1800 0x00 0x00 0x04 0x09 0x22>;
>             ranges = <0x1000000 0x00 0x00 0x00 0x3000000 0x00 0x10000
> 0x2000000 0x00 0x40000000 0x00 0x40000000 0x00 0x40000000>;
>             reg = <0x00 0x30000000 0x00 0x10000000>;
>             dma-coherent;
>             bus-range = <0x00 0xff>;
>             linux,pci-domain = <0x00>;
>             device_type = "pci";
>             compatible = "pci-host-ecam-generic";
>             #size-cells = <0x02>;
>             #interrupt-cells = <0x01>;
>             #address-cells = <0x03>;
>         };
>
>         virtio_mmio@10008000 {
>             interrupts = <0x08>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10008000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10007000 {
>             interrupts = <0x07>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10007000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10006000 {
>             interrupts = <0x06>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10006000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10005000 {
>             interrupts = <0x05>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10005000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10004000 {
>             interrupts = <0x04>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10004000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10003000 {
>             interrupts = <0x03>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10003000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10002000 {
>             interrupts = <0x02>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10002000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         virtio_mmio@10001000 {
>             interrupts = <0x01>;
>             interrupt-parent = <0x09>;
>             reg = <0x00 0x10001000 0x00 0x1000>;
>             compatible = "virtio,mmio";
>         };
>
>         plic@c000000 {
>             phandle = <0x09>;
>             riscv,ndev = <0x35>;
>             reg = <0x00 0xc000000 0x00 0x210000>;
>             interrupts-extended = <0x08 0x0b 0x08 0x09 0x06 0x0b 0x06
> 0x09 0x04 0x0b 0x04 0x09 0x02 0x0b 0x02 0x09>;
>             interrupt-controller;
>             compatible = "riscv,plic0";
>             #interrupt-cells = <0x01>;
>             #address-cells = <0x00>;
>         };
>
>         clint@2000000 {
>             interrupts-extended = <0x08 0x03 0x08 0x07 0x06 0x03 0x06
> 0x07 0x04 0x03 0x04 0x07 0x02 0x03 0x02 0x07>;
>             reg = <0x00 0x2000000 0x00 0x10000>;
>             compatible = "riscv,clint0";
>         };
>     };
> };

Thx Anup, but it still couldn't work for testing suspend.

# echo mem > /sys/power/state
sh: write error: Function not implemented

Why there is no ARCH_SUSPEND_POSSIBLE in the patch series?

ref arm64's:
commit 166936bace056dfc11452d794209f39a5e9b0fb4
Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Thu Nov 7 18:37:14 2013 +0000

    arm64: kernel: add PM build infrastructure

    This patch adds the required makefile and kconfig entries to enable PM
    for arm64 systems.

    The kernel relies on the cpu_{suspend}/{resume} infrastructure to
    properly save the context for a CPU and put it to sleep, hence this
    patch adds the config option required to enable cpu_{suspend}/{resume}
    API.

    In order to rely on the CPU PM implementation for saving and restoring
    of CPU subsystems like GIC and PMU, the arch Kconfig must be also
    augmented to select the CONFIG_CPU_PM option when SUSPEND or CPU_IDLE
    kernel implementations are selected.

>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

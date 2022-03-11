Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7738A4D5678
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbiCKAXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbiCKAXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:23:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE501A1280
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:22:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bi12so15793022ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CU0EaMUijc4d9W/dt+apjxHh50p1ld1eYas196Toeg=;
        b=Ljb1teyKYtUREnnQD+2qk3Sjk91n1E2ZzwuOUViAUvE3VFmrOYiD+oEWipXnWYY354
         Be/kIqxwRn5SU3HonEOP/B1/QGFSeCWED3ZZ3iEIAUtIJtW6ujjX2Ib/Ic8Qt8YkbmV2
         H1uCbdwkuMmnLheGQXj7srRHD0eptHs+W/zqI9mATsyvsBqSzKLbu7Ww3YihycR9HetY
         DH8hmPxwBV1//eafk3BpgPDHBbUVHUOWg1u2UsWhbnHGJQQZXryZvGg/jnkwvYeIcFys
         KZPKvpJI68IcyFS1wsYM5IkedkLvkxXUuZ3GZ++zu4U7f5zZMJMNVIMxNnY417LfKmYi
         j5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CU0EaMUijc4d9W/dt+apjxHh50p1ld1eYas196Toeg=;
        b=qkee1fGxtxS7ArNwdSeiMYS8+9d13oIzrZsqZCKsO+Wh5ANImuTq5blvhc6ijrQuz/
         I3VtXXeiFUZxGCRox6dzDqPGdKMkwsKlzSF+/hN23gNJr/EeDkrN9Ou494FNvGidZ+lF
         OCr0HmCObqksENoQ/viPcGYARRBhdM5c9UG/7XKzlxc0i7OmrlMuu+CBM1VYackHbQL2
         Ki5lM60w/jXkFLy+diVDkXhvPN3fHz8+rZNFlHosZxcKU7Vi+Urau3OPB5T4s81EUdGp
         fmG6W7EHEDh7xqxvrkoVMAKJMywCgIAZEyZ33HYzX6Or1sR8ATAUeklRSM/WSt3n01Kj
         1WAQ==
X-Gm-Message-State: AOAM531NHKUcSHXnVX+jz7M+hcyhk+325H82PYokzd9755CuMD2JwnGP
        ukxWEzGGC2t4CusG93dqlfgolQIi6+OirmZEYoJ+zg==
X-Google-Smtp-Source: ABdhPJwOQ4ujDK44RsajASU1tUIvdgt8hhYh7SDAOvgs+6fc4Atu5UGyNOQ6XiMrnvabqBjN8Ct7P/dPzpIDXI3vvRI=
X-Received: by 2002:a17:907:3dab:b0:6d6:a9a8:be4b with SMTP id
 he43-20020a1709073dab00b006d6a9a8be4bmr6534953ejc.34.1646958122022; Thu, 10
 Mar 2022 16:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20220222204811.2281949-1-atishp@rivosinc.com> <mhng-4593ea1e-503d-47df-8e55-d2ef06f01518@palmer-ri-x1c9>
In-Reply-To: <mhng-4593ea1e-503d-47df-8e55-d2ef06f01518@palmer-ri-x1c9>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Thu, 10 Mar 2022 16:21:51 -0800
Message-ID: <CAHBxVyHaFk6mx_uTUcOG1d+XGokT_-Y3_Y1kVJixAnGGmLjAxg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Provide a fraemework for RISC-V ISA extensions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 3:50 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 22 Feb 2022 12:48:05 PST (-0800), Atish Patra wrote:
> > This series implements a generic framework to parse multi-letter ISA
> > extensions. This series is based on Tsukasa's v3 isa extension improvement
> > series[1]. I have fixed few bugs and improved comments from that series
> > (PATCH1-3). I have not used PATCH 4 from that series as we are not using
> > ISA extension versioning as of now. We can add that later if required.
> >
> > PATCH 4 allows the probing of multi-letter extensions via a macro.
> > It continues to use the common isa extensions between all the harts.
> > Thus hetergenous hart systems will only see the common ISA extensions.
> >
> > PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
> > via /proc/cpuinfo.
> >
> > Here is the example output of /proc/cpuinfo:
> > (with debug patches in Qemu and Linux kernel)
> >
> > # cat /proc/cpuinfo
> > processor     : 0
> > hart          : 0
> > isa           : rv64imafdch
> > isa-ext               : svpbmt svnapot svinval
>
> I know it might seem a bit pedantic, but I really don't want to
> introduce a new format for encoding ISA extensions -- doubly so if this
> is the only way we're giving this info to userspace, as then we're just
> asking folks to turn this into a defacto ABI.  Every time we try to do
> something that's sort of like an ISA string but not exactly what's in
> the spec we end up getting burned, and while I don't see a specific way

I agree that this is an ABI change/improvement which is impossible to
modify later.
However, this is a Linux specific ABI. Do you think the RISC-V spec
will ever say anything about how /proc/cpuinfo is shown to the user ?

and we do have similar precedence in other arch

/proc/cpuinfo output in  x86:
flags : fpu vme .... arch_capabilities
vmx flags : vnmi preemption_timer ..tsc_scaling

/proc/cpuinfo output in  arm64:

Features  : fp asimd evtstrm aes pmull sha1 sha2 crc32


> that could happen here that's what's happened so many times before I
> just don't want to risk it.
>
> I've gone ahead and removed some of this information (isa-ext, and all
> the single-letter extensions we can't properly turn on yet) from
> /proc/cpuinfo, modifying the last patch to do so.  It's at
> palmer/riscv-isa, LMK if that's OK.
>

Few changes required on your tree:

riscv_isa_ext_data definition is no longer required

and this should be to show hypervisor extension:
+static const char *base_riscv_exts = "imafdch";

> I'm not opposed to doing something here, I just really don't want to
> rush into it as we've already got enough complexity around the various
> flavors of ISA strings.  I don't see a big pressing need to provide this
> information to userspace, but having the rest of this sorted out is
> great (and there's some dependencies on this) so I'd prefer to just
> stick to what we know is good.
>

"isa-ext" row is kind of helpful to inform the developer to verify
that a specific extension is available
without looking at extension specific dmesg logs. It proved to be
useful while developing sstc/sscofpmf.

Is it better if we just dump the entire ISA string as before so that
we know which extensions are available at least ?

> > mmu           : sv48
> >
> > processor     : 1
> > hart          : 1
> > isa           : rv64imafdch
> > isa-ext               : svpbmt svnapot svinval
> > mmu           : sv48
> >
> > processor     : 2
> > hart          : 2
> > isa           : rv64imafdch
> > isa-ext               : svpbmt svnapot svinval
> > mmu           : sv48
> >
> > processor     : 3
> > hart          : 3
> > isa           : rv64imafdch
> > isa-ext               : svpbmt svnapot svinval
> > mmu           : sv48
> >
> > Anybody adding support for any new multi-letter extensions should add an
> > entry to the riscv_isa_ext_id and the isa extension array.
> > E.g. The patch[2] adds the support for various ISA extensions.
> >
> > [1] https://lore.kernel.org/all/0f568515-a05e-8204-aae3-035975af3ee8@irq.a4lg.com/T/
> > [2] https://github.com/atishp04/linux/commit/e9e240c9a854dceb434ceb53bdbe82a657bee5f2
> >
> > Changes from v4->v5:
> > 1. Improved the /proc/cpuinfo to include only valid & enabled extensions
> > 2. Improved the multi-letter parsing by skipping the 'su' modes generated in
> >    Qemu as suggested by Tsukasa.
> >
> > Changes from v3->v4:
> > 1. Changed temporary variable for current hart isa to a bitmap
> > 2. Added reviewed-by tags.
> > 3. Improved comments
> >
> > Changes from v2->v3:
> > 1. Updated comments to mark clearly a fix required for Qemu only.
> > 2. Fixed a bug where the 1st multi-letter extension can be present without _
> > 3. Added Tested by tags.
> >
> > Changes from v1->v2:
> > 1. Instead of adding a separate DT property use the riscv,isa property.
> > 2. Based on Tsukasa's v3 isa extension improvement series.
> >
> > Atish Patra (3):
> > RISC-V: Implement multi-letter ISA extension probing framework
> > RISC-V: Do no continue isa string parsing without correct XLEN
> > RISC-V: Improve /proc/cpuinfo output for ISA extensions
> >
> > Tsukasa OI (3):
> > RISC-V: Correctly print supported extensions
> > RISC-V: Minimal parser for "riscv, isa" strings
> > RISC-V: Extract multi-letter extension names from "riscv, isa"
> >
> > arch/riscv/include/asm/hwcap.h |  25 +++++++
> > arch/riscv/kernel/cpu.c        |  51 ++++++++++++-
> > arch/riscv/kernel/cpufeature.c | 130 +++++++++++++++++++++++++++------
> > 3 files changed, 183 insertions(+), 23 deletions(-)

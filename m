Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3264DDC91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiCRPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbiCRPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:16:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0502B269
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:14:42 -0700 (PDT)
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKsSj-1noHfR3AY1-00LFNc for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022
 16:14:40 +0100
Received: by mail-wm1-f51.google.com with SMTP id 185so175585wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:14:40 -0700 (PDT)
X-Gm-Message-State: AOAM530QfFTI+E5/R5OgJ1kDyG6f8bK1l7PSjTW2Az0dVywNNKcCll/x
        9WibE6Rvvn4uY1pu1TJmh7/Rz813qAlh4PQYLNQ=
X-Google-Smtp-Source: ABdhPJyG75Va4ian/qtyVs0DtDxDOdXf1Kw2qjsALgoDol5bS7vxyzqlPO2dsFv+pN1cEkBXYiX3AvgM1nzPhb5pvtw=
X-Received: by 2002:a1c:f20b:0:b0:389:c99a:4360 with SMTP id
 s11-20020a1cf20b000000b00389c99a4360mr16133111wmc.174.1647616480413; Fri, 18
 Mar 2022 08:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220317035542.272547-1-apatel@ventanamicro.com> <f1079093-54db-bd20-3342-b06d069c5d1f@codethink.co.uk>
In-Reply-To: <f1079093-54db-bd20-3342-b06d069c5d1f@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Mar 2022 16:14:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Gt7TOT2zpNw7YNR=MNLBWVAADL5dBgY15ZL8sDW20HQ@mail.gmail.com>
Message-ID: <CAK8P3a0Gt7TOT2zpNw7YNR=MNLBWVAADL5dBgY15ZL8sDW20HQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Increase range and default value of NR_CPUS
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0u696iFwhgtQPB7cmok0FaPu+YHTMlZL2K9zWDQud7YcV/g9Ghp
 Uv/NyzpvWJwxPJm04FPTuVOpgBVMKdq5dxwPJlZEx5TUaKmFbkzqdRcZwpki4YzGyIs6g09
 X2lJzYbfRPFRv7iQJKrKE0Wbnuzbl1DY5uFserGtV+EAwpGdpJVfA48dyq4r1pihq+bhu4N
 RSMHk+J7HSJfOs2EvU8tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZTjOT3gUbc=:4jtS79mfZVxATiOoMmt/0J
 gU5WYl911jGLGxiOMclzoz2UXEwLFKdmYKEyxcC9PQhKbDpKZRela9pX0ORwrQREx/PC0AWY0
 2XnDHppQhp1e2OtD3GJYo3PkZVJwdZzvgz8aHgS6MhJObWmdz7uzgJxvC8OfevrUAfMfjaix3
 lyiXkLll81eiaeAMWfQHUhUH7OVIpb3lB4ntEV0CVhD27V8rtGVZvPKVGHJDEL+lRzMJks1xt
 u2qsk2s2XGmWtn1mEg6NRSsgXKWqNDMSDy1pNYms6R37OPQxPvS0lOVMzxAccIhUJ47g3R9Tt
 Pv4NY1hBiKZS7QyG5vzYxMStkYMEjFuF0WuATRY6rdwQZRTMaJbM96qRMVrKCgseGx5SH2KgK
 KQ2odymORHz6lGep6bmFncG7sfW/gpwKtSejXBWc0o+d2sd+TSe0TYaujrhPRxEo3x71dJKHo
 JZKRG5ZFSkA75mAvB28A9BKne0A785X0Y2NOIJQfJ8swjURogPD0wNRdbtUH8fOiV0YyBpFym
 4eb88kGugokyWAFlNWSCFCNhLhs8ArcEPRIUluMURLw7alTDIDhzTKQ1Wrd8PGCzA4hHc2YJq
 ABqhV0yL89WB962ddi0365jEYkL/pKtWnQKL+yqK/Rltldv+E8Aq/tUcTV0ve4mUwv8zy3TVB
 a6tjwQ3J1MemhEjAyUglw5q1bCe75BkHIAEv/h1x4tjHX9FqHtQW9zCCCXUGG0XABX7U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 3:46 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 17/03/2022 03:55, Anup Patel wrote:
> > Currently, the range and default value of NR_CPUS is too restrictive
> > for high-end RISC-V systems with large number of HARTs. The latest
> > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > restrictive for QEMU as well.

If qemu allows 512, what is the reason for limiting the kernel to 256?

> > Other major architectures (such as
> > ARM64, x86_64, MIPS, etc) have a much higher range and default
> > value of NR_CPUS.
>
> What's the memory overhead for increasing this?

It's supposed to be very small, I would expect three main sources of overhead:

- cpumask_t variables, those grow once you go beyond the size of
   an unsigned long (32 or 64 bits), so with the default just on the limit, this
   makes no difference.
   Note that you can run out of stack space with NR_CPUS values if
   CONFIG_CPUMASK_OFFSTACK is disabled. Should not be
   a problem for 512 or below.

- percpu variables: these are dynamically allocated based on the number of
  CPUs at boot time, so they should not have any real impact.

- NR_CPUS sized arrays, these are sometimes used in place of
  percpu data. This is only a problem if the array members individually
  are more than a few bytes. There are not too many of these in the kernel,
  as using those is discouraged.

      Arnd

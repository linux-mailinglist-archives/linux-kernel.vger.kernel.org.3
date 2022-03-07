Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F89B4D07BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiCGTbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiCGTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:31:21 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B747E0B1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:30:25 -0800 (PST)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUGyh-1nZnVL1k71-00RGq6 for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022
 20:30:24 +0100
Received: by mail-wm1-f41.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so60574wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:30:24 -0800 (PST)
X-Gm-Message-State: AOAM532En22fH5PNz366ORVcC9+Gn+xCCZZdvqFeRTuy+CPtuQmDGOxB
        06j1HC8RY3hQV3gtqjmwziMrjOCKCpuJHkgHPXQ=
X-Google-Smtp-Source: ABdhPJzwC1wafOrUrTN/FBcdX42lDRV/UD3rLIDTmZkYmHfojBK4j4wA8OQjMpEjQg43idU7UECI7Znv7Jm7JU3wl5Y=
X-Received: by 2002:a7b:c001:0:b0:381:1afd:5caa with SMTP id
 c1-20020a7bc001000000b003811afd5caamr392661wmb.35.1646681424068; Mon, 07 Mar
 2022 11:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
 <87h78a178u.wl-maz@kernel.org> <a31431bf-24bb-71ac-8f3c-f9ca19f5c4f0@linux.alibaba.com>
 <87bkyi0x53.wl-maz@kernel.org> <1b94af8b-a294-5765-4e1e-896f70db621f@arm.com>
In-Reply-To: <1b94af8b-a294-5765-4e1e-896f70db621f@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 20:30:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3zA25=iZkVGPc=V+9tqqsWgQjoD9BSS60foGZtDwsujA@mail.gmail.com>
Message-ID: <CAK8P3a3zA25=iZkVGPc=V+9tqqsWgQjoD9BSS60foGZtDwsujA@mail.gmail.com>
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in cpuinfo
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, joey.gouly@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jIto1kmAU7AjCjgGfwQNyUHLzpWXB9392WQFKNchcgIC07lV8Al
 Khbs2YMdgiaxK8SYfZOk4AXzngKil+VxJism4YD+vFd7wD03/HbWfKsUfUE2WVS0FTvOZb8
 k5VGpZrkpqEPejIuKXCkFJyDHAJtglKDWvfCvJQtSkTol3CYUgJTXljkbNLTHTsxhx/zUfA
 4FTmjc+K/JyyMbKQjqsHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N/BjVbJHkLo=:Qg4ADRpPYB6iVHgWyKxi7P
 LA89GNKUZ032lThLi67kqi10pOz4j5lxc3iA/2sMPytKHu4SDe4cfPsq8lkDsrlJKHG/R3I+v
 xq6LN2WIp5E7fib/bfjd9fEylMxehkHVgkBePi1Pp7ipNy120g+oDuHZux7kY3MWASMsJu1CT
 Eld06ZrdaBXMNDkrweBYYlq5pwg8SgUHcH3M0N4ugeexlrSufwUNh77cQYNPrRvn0oHEIB3YL
 aozFx4t2SrWILi+m89oC1Z3WQMfdkbwrpJxQi0LV2gKr8F+Cdeq9nzKhBqGot0gsw7pMKtyWI
 XZKTnczFY5uFu7mGAl4BISK4aLfpNmQDk9FqWUTQNWY1liuU4D1bg23hntkwv2R4Eokce5bsW
 SXrR2f04c3fJ4NnbsErEiY3U6V47LZTbYJh6A22WcsgWBLBkAhhtznSZ4Qdi3yfsFw/Usn7DN
 bvskl4OYfcv3Rm2JLoD1aG7VnJWQ05gkobD2DDHX7IDkNKN8SitrQp9ef4HUDeQuR5v2BrCdS
 rvg8SFQA2VarZGajbsOG4GIatqf+4HxVHrWHgBPitDj/H5zdh/Y/dZPo8fTXMIYZutXtJrQot
 F/LXWOIViAyHUKodTmMTx80LoW+HpjU1VxPLNF1EOjwmgKqSv6FDIy5cTE1Fj6eA0gI6T501Z
 NQFBQE4YNmYwGqZ00V0Mqe6XvvSYCts7J6MI59lQtAObAz95e5f8rCcO3uC9QT4zRXNWgAQgH
 1TZorE8t5CyzKVnjRdHbx0I+vQqAl7AB01TXAIoxZqv3ca7oCYwNLNlAEB/Vz9xDq2REtHeac
 Pnp+Yg4dRDHnShiGAfWu1tFyYKe7/qBwCoiO4368TGlmERYAE4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 5:48 PM Robin Murphy <robin.murphy@arm.com> wrote:

> And arguably it's not even too late, because 10 years ago this *did* say
> "AArch64". I don't remember all the exact details behind commit
> 44b82b7700d0 ("arm64: Fix up /proc/cpuinfo") - this just tickled enough
> of a memory to go and look up the git history - but I don't think we
> changed any of those fields without a real reason.
>

The patch description does state that this was done for compatibility with
32-bit architectures, which does make some sense. I suppose for similar
reasons, the arch/arm/ version of /proc/cpuinfo is now stuck at
'CPU architecture: 7', even for ARMv8 or higher in aarch32 mode.

The part that I find more annoying is how we leave out the one bit
of information that people are generally looking for in /proc/cpuinfo:
the name of the processor. Even though we already know the
exact processor type in order to handle the CPU errata, this is
always "model name\t: ARMv7 Processor rev %d (v7l)" on 32-bit,
and "model name\t: ARMv8 Processor rev %d (%s)" on 64-bit,
with the revision being the least important bit of information here...

        Arnd

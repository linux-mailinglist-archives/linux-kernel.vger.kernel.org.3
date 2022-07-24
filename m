Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1057F712
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiGXUgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGXUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:36:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C102F635E
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:36:13 -0700 (PDT)
Received: from mail-oa1-f50.google.com ([209.85.160.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N63NW-1nR1Vb1GFU-016NDr for <linux-kernel@vger.kernel.org>; Sun, 24 Jul
 2022 22:36:11 +0200
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so12472071fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:36:11 -0700 (PDT)
X-Gm-Message-State: AJIora8mZO5A17H3tz5AU4GmK3akbc8zIGlGGPdqzBLRa1VM/pzbmjSd
        Wr6um4biBe+Myb1LHHz+xOteb5zLPf6+xsm3/gc=
X-Google-Smtp-Source: AGRyM1tnVuoxBPd70oeqOmGfhtFKVZUyeBTN+CqYz+FbOrB3rGMUkpEDV43Dv/RGnkLnCN8S2/MMawjNcUf3ekkgaU8=
X-Received: by 2002:a05:6870:6195:b0:100:ee8a:ce6d with SMTP id
 a21-20020a056870619500b00100ee8ace6dmr4688274oah.155.1658694969838; Sun, 24
 Jul 2022 13:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 24 Jul 2022 22:35:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
Message-ID: <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, jpoimboe@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:voX0k2+qHWrrI/nQXi/uZX+KkWZUiMFu7CrcF7QKIg6AF6HxhjV
 oxOhNTWwCeCveeMKswvRS/etrP7JgPkVgL9/nG7oqcIdB8nvjfT2reQ75FeSVEESqF/BNb+
 fOKqCfEWe4DhBwxqrnDTOX4CCUydWI8UhH5KezXSJ485yCOvivSahKGhXpE7V7UqqdaIi1O
 wW2xyC2gct3vKZGl4GcYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Xq2HgzTWIE=:6tBDjekKsWxZ1zjJiQ0nba
 HzzUEX9A1ct0jSj3D46rG1D+1ZvpIREh1S/MYJyhXbB7FkD+Z1BtFgshQ9DKxlO1aAapKOuYm
 f+s9Oxc/WNk1lw5466eRrTQeXuLhYtdEa1gWgd/YAS98HZqTNQzmS/MpBQhB7L0ONmoC5dEXc
 SCs5W7ub6vCs9nmbM5a7s3mMrDeTiSMxWHOdZVq6sVdT9lPKWztojO2fEIAuUk48gcj4O/VUa
 ZcXcHwBriuHNMP9H3F3z74N6Oyy/I2riLVMToALq8RzS0RHsgLmjQts+FvraivlHvm6e+SfVy
 OQ3fy1Nn8+7+6SuqjoZfE8cUko7sUCJ/+sy0OBwIPAxVozRHkNs1S26oY0vDlz8uXDSNPEhfs
 EF70fVjSp4bXgXPslrBWkYjtpxE8RWdHMTpLzEjfp8tSZaPPc60dm1kU9LU4rH5zdl8NSuovN
 DMUmR3voHZ7bPXrSerIOsdF70nhbMlYsenviKmBIWdQXRNq0Jamk1kYBH0yHbGIOeyxt5sJRR
 UCchm6ilN2WCQ29xjCqitm37r/dnM1hhDezN186XhlOfK11z1Jp6fbBLNyIpnHIL8vfnAjG7p
 IDIXY+o97WdejFQzpLMIgN4uR4uIkbUK8n9sfQ2rVMywgXTOBZVxE4oQucfWv4sdZn4oDI9IS
 HAskJaus2ID+B0gGjMTEAu3o8Fyp0/ztSsnI9ALhQ6ViOmHRwBpYhtYteFVNh1rY4PJdLz07B
 z4dtZ6QhKFvbWoCtFfaI1FKHjYq/1O4cnmZYjzJh/dmRgSejA78hBynFJIRf87fJ0uUWoY+9U
 +dgvVHYyvPjHBrWaZ2s7DatuBJydlQx/d6OrwPLyiEQcmCL37m5aBx571qiKT3ewA2CHxugBk
 zgocHK7Wz3Qhk64RnfHA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 6:43 PM John Garry <john.garry@huawei.com> wrote:
>
> scripts/faddr2line has not worked by default for arm64 since 5.17
>
> Firstly, since commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO
> selectable from a choice"), CONFIG_DEBUG_INFO was not getting enabled by
> default (and this is required for faddr2line to work).

I just noticed this the other day and applied a patch for it in the
arm/defconfig
branch.

> Secondly, commit dcea997beed6 ("faddr2line: Fix overlapping text section
> failures, the sequel") caused a breakage for arm64, as reported at the
> following:
> https://lore.kernel.org/lkml/3bd9817d-1959-c081-e5d0-8b0e70b3f41e@huawei.com/
>
> Josh has sent fixes/improvements for faddr2line at the following:
> https://lore.kernel.org/lkml/cover.1658426357.git.jpoimboe@kernel.org/
>
> In this series I enable CONFIG_DEBUG_INFO by enabling
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, which seems the sensible
> option.
>
> As for merging this, I am not sure who would pick it up - any takers
> welcome.
>
> Note: this is based on next-20220722 and it may be wiser to sync the
> defconfig manually (instead of using 1/2). Indeed I am not sure what is
> the policy is of sync'ing this anyway.

I only synchronized the 32-bit defconfig files in my tree, not the 64-bit
one. However, I can't really apply your patch 2/2 because you appear
to  mix refreshing the order of the options with changes that remove
options that are gone after a 'savedefconfig', risking that we miss
other bugs as well, as seen from your diffstat:

 1 file changed, 36 insertions(+), 48 deletions(-)

I have refreshed this one as well now, which on my tree gives me

 1 file changed, 31 insertions(+), 31 deletions(-)

for a nonfunction change. I have left the other ones untouched
for the moment:

CONFIG_ARCH_BCMBCA=y
CONFIG_SECCOMP=y
CONFIG_QRTR=m
CONFIG_PINCTRL_MSM=y
CONFIG_SND_SOC_TEGRA210_OPE=m
CONFIG_MAILBOX=y
CONFIG_QCOM_ICC_BWMON=m
CONFIG_SLIMBUS=m
CONFIG_INTERCONNECT=y
CONFIG_CONFIGFS_FS=y

These should be checked manually to find out why savedefconfig
no longer shows them, it could be either a bug (a new dependency,
renamed option, a driver randomly selects another subsystem, etc)
that we need to fix, or a harmless change (driver was removed,
option is now intended to be default-enabled, ...)

If you want to help more, can you check some or all of the above
and send patches to either re-enable the options or remove them
individually with explanations about why they are no longer
part of the savedefconfig output?

          Arnd

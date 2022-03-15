Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7304D955C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiCOHfo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Mar 2022 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiCOHfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:35:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E71094
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:34:27 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M58OQ-1nV8A215Sm-001783 for <linux-kernel@vger.kernel.org>; Tue, 15 Mar
 2022 08:34:26 +0100
Received: by mail-wm1-f43.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso932017wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:34:26 -0700 (PDT)
X-Gm-Message-State: AOAM532V6lRjsb/mJ3X4DTVHaOz9UURT0Eq+O89CcJWQsYncpQOu7e8F
        SawNJGsI2WkMxrHlg4Wc7KGNp+QtxyiZW0Rimq0=
X-Google-Smtp-Source: ABdhPJyHYO6m3LYdoowEdubGuU5nRdWd7VpbXsQW08uV/nmHFpfjxqH1DRzsbc5qBQnlKneUxOmPMErXyKaFhVYZd7s=
X-Received: by 2002:a1c:f20b:0:b0:389:c99a:4360 with SMTP id
 s11-20020a1cf20b000000b00389c99a4360mr2172884wmc.174.1647329665889; Tue, 15
 Mar 2022 00:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com> <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com>
In-Reply-To: <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Mar 2022 08:34:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
Message-ID: <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
Subject: Re: [PATCH] [v1] arch: arm: configs: gxp_defconfig
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:mxjrjP1Muj+Eod3fB6cpvNijtXu7wxQEobsDJ72hxehvwL5dj6M
 n6HAtDLfOlfEzyDkc81qZCCrattvd6p85lPsdHqpTtZlTqLZI02lx7rDVlSQPoXnzrgPil4
 D3wR2EdAlAkOj5IWkjNzyCfRpGYq3Z9pJyX/HqipX+/i0M6T6xMgQVD68+VYADdqMgJEKCh
 WF44X4LbVr5e8Kikx2BoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k3cggBCJRz4=:DbKVY/ROBWA6NlsKgWjSLs
 mtX2zRMBBGlzGQrcW7xVGqADivJyHkUmKQ/F6HQEBdIk1YnBfAnOjN9DFZ3pU+n5QCP/4c4o4
 N+5vSPdjuFVjSnd6DeD9DaeTfvgkdrdoDmjL22CAYT2UxZE8DBjcgr+RRBXl23meVD1v/+aw2
 cFPpI5kNVHf/jki30OPYH0DuKCnC7GeZz3VbkJ5rbo2gMio13C/rtVGN7dtnMWmHaDo4XHOqb
 GzR6Rq8M740GpkZrTjJxB8oxyWkRYgQZSdNV+G/L7n9JRDkguAF6zvU8xFL9s4EFlEIViX77J
 hRK07t2BMXLF7TvMmdS3vFR6yz5RxqhqaROLWIHGVZvhxlEQM0WwkLBkGqIiETt595ul6L8q5
 T1e/6JsCpL5JZYWgfKTziUACFSV6VsIvi8fzjxfPrV06HaJq8uS3qV2aLUhxM4qxVfJ4j22Bn
 n2nAvUP6yiWeSHM92yXcE5AZo8gSugcYUWHqqTOKRvnj+GJViqSvdqdJO5zyQQxIt6y0U/L5a
 iZFg/u++3FTzzfnhjLQHEL+wXQzaSGFqqQLLRix0HcgbkthkjC35S6iilp7ZQXVnithxp6/FW
 7f0P7jyfri6jNqrbPqCG/EJfOzi4bzxORUYpgPsGNpHgjoEr29KT4hS9ADJDoP2Zn8h+rPQbB
 26RTNlt3BsqbP0uT4t7O7Dpq3SomFgnI5t/dx944noMdEW9AEDr7MgboHdg7cwNoP4ro=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:47 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
> ﻿On 2/16/22, 1:58 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>
> >    One bit of information that I would like to see in the defconfig patch
> >    is an explanation about why you need a custom defconfig in the
> >    first place, rather than using multi_v7_defconfig. Please also add
> >    a patch to enable your platform in the multi_v7_defconfig, along with
> >    the drivers you need (as loadable modules).
>
> I took some time to look at the defconfig "challenge". Nick has updated the multi_v7_defconfig with our GXP in a new series of patches, but this won't execute on our ASIC (compilation is ok). The challenge is that we are missing a few features which are enabled by default, and I was wondering if the community would accept to disable them by default.
>
> This is this
>
> CONFIG_PERF_EVENTS=y
> CONFIG_ARCH_VIRT=y
>
> Both of them generate unknown instruction on our platform which lead to kernel crash.

If you get unknown instruction exceptions, that is clearly a bug that has to be
fixed somewhere. Turning the options off should not be necessary, but we have
to figure out why these crash, and make sure we have correct runtime detection
in place that ensures that any driver code runs only on platforms that have the
corresponding hardware.

Do you have any more information about how and why these crash? My first
guess would be that there is something in your DT that describes hardware
that is not actually there. With a correct DTB file, the two options should
not cause any code to run that wouldn't otherwise.

> With these options disabled, we can use the defconfig and add only
>
> CONFIG_ARCH_HPE=y
> CONFIG_ARCH_HPE_GXP=y

These are obviously ok

> CONFIG_GXP_WATCHDOG=y
> CONFIG_ATAGS=y
>
> To it, as to get everything setup and get our new platform booting
> without any issues, assuming the associated code is present. The
> ATAGS is not mandatory it removed some warning messages during
> kernel boot.

Ok, good. I assume you need the watchdog driver to be built-in because
the watchdog timer is active before we enter the kernel? In this case it
is ok, otherwise it should be =m, like any other drivers for your hardware.

I don't think we should enable CONFIG_ATAGS here, the multi_v7_defconfig
intentionally only supports DTB based booting. What is the warning you see
without it?

> I know this is removing some standard feature, but, I probably can't easily fix
>  the missing instructions. I can dig a little bit if needed without any issue.
> If we want to have a working defconfig on HPE GXP platform, then we need
> to either take this modification, or change the code from perf_events and
> arch_virt to properly work if the required underlying hardware is unable to
> support these features (could be probably a dummy test to identify the asic
> at compilation time), or create a specific defconfig.

ARCH_VIRT doesn't do anything itself but only enables a couple of other drivers:

config ARCH_VIRT
        bool "Dummy Virtual Machine"
        depends on ARCH_MULTIPLATFORM
        select ARM_AMBA
        select ARM_GIC
        select ARM_GIC_V2M if PCI
        select ARM_GIC_V3
        select ARM_GIC_V3_ITS if PCI
        select ARM_PSCI
        select HAVE_ARM_ARCH_TIMER
        select ARCH_SUPPORTS_BIG_ENDIAN

Aside from the big-endian option, these all just enable the compilation
of drivers that in turn check the device tree before running any code.

Invalid instructions point to either PSCI or ARCH_TIMER, so try
disabling those first to narrow it down to one option causing the
problem, and make sure you actually run with the DTB that you
submitted, not a DTB that may contain incorrect nodes.

        Arnd

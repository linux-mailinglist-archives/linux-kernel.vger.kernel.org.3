Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC8585A49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiG3Lyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3Lyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:54:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2177518B2B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:54:34 -0700 (PDT)
Received: from mail-ed1-f42.google.com ([209.85.208.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHoZS-1oCpME3Xuw-00Es3c for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022
 13:54:32 +0200
Received: by mail-ed1-f42.google.com with SMTP id r4so817881edi.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:54:32 -0700 (PDT)
X-Gm-Message-State: AJIora/ChvoK1zn6RzxuEs/kSx5gDrXw0BoNkCPXupmme6s6RskaZEJG
        i7k5jH0KTxIKt5f/9Rv0UkMSO1I8H0z1GHAnbHo=
X-Google-Smtp-Source: AGRyM1v73P0IyG3kqmzgVDCazo8lgE57ZZmN/ORamunHWGgkSZQ+skbnI0M/mTvwXJuXPxyFsQs6T3lvsJhtn84jgCU=
X-Received: by 2002:a05:6402:1d4c:b0:43b:c85f:5c95 with SMTP id
 dz12-20020a0564021d4c00b0043bc85f5c95mr7664097edb.213.1659182072510; Sat, 30
 Jul 2022 04:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220730003846.1730265-1-balsup@cisco.com>
In-Reply-To: <20220730003846.1730265-1-balsup@cisco.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Jul 2022 13:54:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Bn9xKRX9z369zVCy6CuguTvNbtXOOPbf_OfS697cDyQ@mail.gmail.com>
Message-ID: <CAK8P3a0Bn9xKRX9z369zVCy6CuguTvNbtXOOPbf_OfS697cDyQ@mail.gmail.com>
Subject: Re: [PATCH] Allow configuration of ARCH_NR_GPIO
To:     Billie Alsup <balsup@cisco.com>
Cc:     linux@armlinux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, linus.walleij@linaro.org,
        ardb@kernel.org, rmk+kernel@armlinux.org.uk, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:63ZTioqc0R2VZiKOVFpQ98JywFOoT+GsT+n5Uh03ZDGkJ4LHLBC
 WQHZUWGzHWalwAUQZqSj1OCHIxmRJBV2rZ5V74oA2dmuLRRZcKvivebyk+IbijVJ/0EKj1c
 2d8gq6JkWsr0l5T6aNFVYvEks8V1IYOUGuaroKKhuW5SgCFAJuo9J0WuYZ6eTF0ir0tTAJp
 mMumX1u+UwgEp6104gO2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5peowXu7D4=:k65jIGMFF8C1JexY/hnxmx
 CLySAjN6jlMLeHHEAobjC/PJuK8yCfOE/09SFOsZV1SJOFuQVY2WipFdsaVLUntbfSs9I6+OU
 O9VQpfgfPBhRdIImpL8l0NcMldqGz45oG59ce0o61dSQiXSDAFROtDVHtfTgLINyRLTqTDlhD
 m79hSQb+A6ZnDQZ14K7l+cy0VpqI9JgQz8ytw7G/7wGPtAD7Jr6ZeXE5ZM7gzJexi2WqjaCLC
 UaxO1rMXd3cA+UHvto0dNcnmC88FoM7H1YQsONquL9j4pos3FB9ADtEEv5+BEfjAzV3tjMF/z
 2IE8JA1mvAQ3agdprsQ0EtCwZKAD0WMVIfikVAYR4Ufz7qKWGeCbqgud7yz3qunZPsOLsaYU9
 xsC/s6CtEpiYHZUd7697UU/wN5FclBwymgIjWkOeia2s6XRzUkEA6Ej9vZ55tXqUkEAl0b9H2
 4fdWzUEvJL0HUV3GEkYC3sMFE0W5hDROF4DjO+Vkxcp1nfox+HFMViZoc0YqiEJJst1R2GtK4
 1MrNGqEN3wiRx9b4uNnv1lc9q3TTwxuFVyuo9pTK6RGhMIbOKaoHORFD2jgFZtUJfJ1PHbE+b
 VWJ53dgCRV6SIzUSL96eh7RLqZbDqpwnAmlKjbZAwzCFwMmSBwPtnkI2rv4ohSoLQj8lPx0tK
 onUMZUKn5O5MGpp5A1W0xxDd0eVG1Fs+ahWw3JJ3q3DiIB2SVA1K1Vi/BITEIiqg2+4UM5myi
 fQZMLE4woRsuP2ONN2snYedGUR1gZjld5o4jEzcyg9ZsZujEkJ6KTKMuSGsH+Cq8+3ID4LH35
 JV0Uv5spttFukerbVnxQ5pKJZF7Mf8xzDD4SYEyeyPJ9elAnatbLyB01qg2qFuCJLCeh1f49/
 VN7bzenNnrqoo0c6gXYQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 2:38 AM Billie Alsup <balsup@cisco.com> wrote:
>
> From: Billie R Alsup <balsup@cisco.com>
>
> Problem: Some systems support a high number of GPIO pins.  Allow
> the kernel builder to configure the maximum number of pins, rather
> than forcing a large value on everyone.
>
> Impact: Once a .config is generated, the ARCH_NR_GPIO setting
> will persist.  To return to a default setting, the CONFIG_ARCH_NR_GPIO
> must be removed from .config file first.
>
> Trade-offs: It is possible to achieve similar via command line
> parameters, e.g.
>
>     make KBUILD_CFLAGS_KERNEL=-DARCH_NR_GPIOS=16384
>
> to the build. This is problematic because the setting does not
> show up in /proc/config.gz.  It is also problematic for out-of-tree
> module builds, which require similar if they invoke the API
> gpio_is_valid().  In both cases, one could envision one system
> working normally, and another failing, even though they both have
> the same kernel version and /proc/config.gz.  Therefore, it is
> better to have the setting available in .config
>
> Signed-off-by: Billie R Alsup <balsup@cisco.com>

What is the use case for manually setting this rather than deriving
it from the selected platforms?

Have you tried to use both a platform-specific option for the minimum
number of this setting, and then restictricting the CONFIG_ARCH_NR_GPIO
setting with a 'range' statement?

         Arnd

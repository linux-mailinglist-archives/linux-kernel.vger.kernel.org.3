Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9A531A55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiEWUEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiEWUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:04:43 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5F880E2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:04:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p190so450589ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1AipD1OfrmQcB3YUOaC7P4EIOVqCxquxh0+AE+xuhM=;
        b=bQzOkbeNz00bM35Ce99+u6O7FvwcbMq3CbiwHzibWAm6u6rINPbk7M+Gwf+K9Rpfqf
         Bf403twpWA0WD0G/TeiGjK7xOqCHIbbjcEyaY7BokFUQ+zKuBOPZ4uuNji6TV8e8F0C1
         OiSHL6d1UFbmnZn05rjy7t5aWkkhI9KCK9PlriUExXYqGdsnCTQfyAuJZt5YfiCD5x4p
         PKKVhF6lcNgu2psiwb4uusrHWD7/H5PDQpYT3YIO6SB5vgxXpWhixe5z1M+Sg7r5WGTG
         kStV8jBQu/gFdCpVP2vrKt9lgnlvuXrGHW8QBgL9FPZgCDY30zwKLwvPAhDhx3FPGx8x
         PsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1AipD1OfrmQcB3YUOaC7P4EIOVqCxquxh0+AE+xuhM=;
        b=EQQpdXhlhoik1rmfPqNZydlM9TC7gNmVDOiiJ1CUw0VEYR25Ddk0nI7JS5sfHm1SGe
         ehla0e7CoQ2wgdqcb82gwcmaNxgHE1WaN2urOHlllsf6suhImgIi09rulSIzQ5T7trZW
         4txSPgJ4Okv/UD0voWpL7FTCCyuWmFsnYqVEVtxPxdHGFutib0i80ZcUs0SYqAzVwoxt
         YpLCcXIBf2QKuMdGUweDlHseRGNBVj1pj0owjeAUdpAHzhuVSAkpbedNOnTThgibB1CB
         EvoHjf3LWIP2KNrY8M6OBjFB//5ww1L7bY3dAB/7GhR0k5q0fGUUm5lI/xGgbYbCCuRV
         ngOg==
X-Gm-Message-State: AOAM533yf7Gh8vwy1ghiWQxO704aY0YoQZcqwGr4UbGF9r99RuiCJA1/
        J9zGB7fuwcnseHaAgQRNjYCUlqualdQMLqi2KS/msA==
X-Google-Smtp-Source: ABdhPJzqi3uJx736pHwpoReDWxmaiJiRfwvNOrYnqDbU07+DT5iV9p+v8KIvHm54c3ZBoXT3vDZcWATWAm//Q1iK/LY=
X-Received: by 2002:a05:6902:70e:b0:64f:2e28:d64a with SMTP id
 k14-20020a056902070e00b0064f2e28d64amr23757981ybt.80.1653336279141; Mon, 23
 May 2022 13:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X> <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X> <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
In-Reply-To: <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 23 May 2022 13:04:03 -0700
Message-ID: <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 8:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, May 20, 2022 at 05:15:55PM -0700, Saravana Kannan wrote:
> > On Fri, May 20, 2022 at 5:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Fri, May 20, 2022 at 04:49:48PM -0700, Saravana Kannan wrote:
> > > > On Fri, May 20, 2022 at 4:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > Hi Saravana,
> > > > >
> > > > > On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> > > > > > The deferred probe timer that's used for this currently starts at
> > > > > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > > > > assumption being that all available drivers would be loaded and
> > > > > > registered before the timer expires. This means, the
> > > > > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > > > > worst case. But if we set the default value for it to cover the worst
> > > > > > case, it would significantly slow down the average case. For this
> > > > > > reason, the default value is set to 0.
> > > > > >
> > > > > > Also, with CONFIG_MODULES=y and the current default values of
> > > > > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > > > > drivers will cause their consumer devices to always defer their probes.
> > > > > > This is because device links created by fw_devlink defer the probe even
> > > > > > before the consumer driver's probe() is called.
> > > > > >
> > > > > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > > > > timer on every successful driver registration, with the expectation more
> > > > > > modules would be loaded in the near future, then the default value of
> > > > > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > > > > time difference between two consecutive module loads.
> > > > > >
> > > > > > So let's implement that and set the default value to 10 seconds when
> > > > > > CONFIG_MODULES=y.
> > > > > >
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > Cc: linux-gpio@vger.kernel.org
> > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > Cc: iommu@lists.linux-foundation.org
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > >
> > > > > I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
> > > > > change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
> > > > > timeout on driver registration") in next-20220520 (bisect log below).
> > > > >
> > > > > $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage
> > > > >
> > > > > $ timeout --foreground 15m stdbuf -oL -eL \
> > > > > qemu-system-s390x \
> > > > > -initrd ... \
> > > > > -M s390-ccw-virtio \
> > > > > -display none \
> > > > > -kernel arch/s390/boot/bzImage \
> > > > > -m 512m \
> > > > > -nodefaults \
> > > > > -serial mon:stdio
> > > > > ...
> > > > > [    2.077303] In-situ OAM (IOAM) with IPv6
> > > > > [    2.077639] NET: Registered PF_PACKET protocol family
> > > > > [    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> > > > > [    2.078795] Key type dns_resolver registered
> > > > > [    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
> > > > > [    2.081494] Discipline DIAG cannot be used without z/VM
> > > > > [  260.626363] random: crng init done
> > > > > qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)
> > > > >
> > > > > We have a simple rootfs available if necessary:
> > > > >
> > > > > https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst
> > > > >
> > > > > If there is any other information I can provide, please let me know!
> > > >
> > > > Hmm... strange. Can you please try the following command line options
> > > > and tell me which of these has the issue and which don't?
> > >
> > > Sure thing!
> > >
> > > > 1) deferred_probe_timeout=0
> > >
> > > No issue.
> > >
> > > > 2) deferred_probe_timeout=1
> > > > 3) deferred_probe_timeout=300
> > >
> > > Both of these appear to hang in the same way, I let each sit for five
> > > minutes.
> >
> > Strange that a sufficiently large timeout isn't helping. Is it trying
> > to boot off a network mount? I'll continue looking into this next
> > week.
>
> I don't think so, it seems like doing that requires some extra flags
> that we do not have:
>
> https://wiki.qemu.org/Features/S390xNetworkBoot
>
> If you need any additional information or want something tested, please
> let me know!

I'll try to get qemu going on my end, but I'm not too confident I'll
be able to get to it in a timely fashion. So if you can help figure
out where this boot process is hanging, that'd be very much
appreciated.

Couple of suggestions for debugging:

Can you add a log to "wait_for_device_probe()" and see if that's
getting called right before the boot process hangs? If it does, can
you get a stacktrace (I just add a WARN_ON(1) when I need a stack
trace)? It's unlikely this is the case because
deferred_probe_timeout=1 still causes an issue for you, but I'd be
good to rule out.

Let's try to rule out if deferred_probe_extend_timeout() is causing
some issues. So, without my patch, what happens if you set:
deferred_probe_timeout=1
deferred_probe_timeout=300

If deferred_probe_timeout=1 causes an issue even without my patch,
then in addition, can you try commenting out the call to
fw_devlink_drivers_done() inside deferred_probe_timeout_work_func()
and try again?

Thanks a lot for reporting and helping debug this issue.

-Saravana

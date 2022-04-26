Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A55106C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiDZS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiDZS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:26:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A5414A530
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:23:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a15so18702827pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DquimjI7WBuJalAU6LAJx471lCu4EEpIqSRlDhHHfPk=;
        b=ksL5p3RigFZPhFG5oJwg4nU6THP3LTCHRX8Zhod9tzl8bRCpVgUwGSb3NKpnBJidXJ
         cl7poYpk4vYTCJBoBb8jogM71gpJeVk1wFXGmFNqDRX8Ae8CFHNWUFjlLD0p7RwVTpc4
         RYogqvF1zA7oTpJ6/hr0xgXIBjwfkby0JjKFUOXkjHaZgczJEBpX1EpyEzXmoBqlYmb2
         DPWgnPFEoeFSKXzCdUxbG1sjapyz/P1M9U+0XW+HdR6ZqRNtn/yfgXMruWJVLYkjSp1U
         vvPF3dshkj87x6ZlgecYqTO9/J5pC8JiStHsIU0AuO34/i8s5/X4olMU7IakGfFl3rA/
         tFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DquimjI7WBuJalAU6LAJx471lCu4EEpIqSRlDhHHfPk=;
        b=wKAwe1Xo9WhsQnZ1+I+6j4pp6QcLmLgZHOggtpDlL8GusMQDP3CLR2D89znp5VzZYj
         rKTNu8B/OnA7/7HYpMaWP7v/tc51KF1Ul9Re6w6HsjhMdehSTyTrHboKJgP355sGAfCV
         Atp4qHHVdvTfGDv/NIuwOvmQ0hXgcxC2uYjySw0b1S624fiL05nGeSWepMiIwmFsGu3a
         vjjrQVtB9Z389ucHsqL9MhjHsdppaV0Qj0qZ4LOsy4lYw55Hvw28eiDulWCKmjE2V6S6
         +3D4FT5rn2/2s2EnWUi8mvzEIQbpVz1KhjsTSwbTMwFg/NBMAtEC6pw3tXcM97WiJ18H
         F+2Q==
X-Gm-Message-State: AOAM533nRKQjBE7n6KwFhJkXzqL5pPryOfNjoKNKf/AOBevGtu+un3vZ
        TEOUXN5sDrR2beKtDh0vbJkWvbN+TvaUzVvmXF5X7NoUaqnfZg==
X-Google-Smtp-Source: ABdhPJzlxLx6CVU9e5P9X9+6Dk1okldpaPNZtYs2ldyopx2xJvWGYKzTtkg4w1ivaFWYsO7uYj0paT4IXcYIOwM7baw=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr21133502pgl.40.1650997386125; Tue, 26
 Apr 2022 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220426123839.GF163591@kunlun.suse.cz> <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
 <20220426161435.GH163591@kunlun.suse.cz> <CAPcyv4iG4L3rA3eX-H=6nVkwhO2FGqDCbQHB2Lv_gLb+jy3+bw@mail.gmail.com>
 <20220426163834.GI163591@kunlun.suse.cz> <CAPcyv4jUj3v+4Sf=1i5EjxTeX9Ur65Smib-vkuaBdKYjUrh7yA@mail.gmail.com>
 <20220426180958.GJ163591@kunlun.suse.cz>
In-Reply-To: <20220426180958.GJ163591@kunlun.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Apr 2022 11:22:55 -0700
Message-ID: <CAPcyv4hr1LDaAXCOrfub1eys=OcQXAPYv2dHGzwbY7pt=_fKZQ@mail.gmail.com>
Subject: Re: ndctl tests usable?
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:10 AM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> On Tue, Apr 26, 2022 at 09:47:19AM -0700, Dan Williams wrote:
> > On Tue, Apr 26, 2022 at 9:43 AM Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:
> > >
> > > On Tue, Apr 26, 2022 at 09:32:24AM -0700, Dan Williams wrote:
> > > > On Tue, Apr 26, 2022 at 9:15 AM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
> > > > >
> > > > > On Tue, Apr 26, 2022 at 08:51:25AM -0700, Dan Williams wrote:
> > > > > > On Tue, Apr 26, 2022 at 5:39 AM Michal Such=C3=A1nek <msuchanek=
@suse.de> wrote:
> > > > > > >
> ...
> > > >
> > > > The modinfo just tells you what modules are available, but it does =
not
> > > > necessarily indicate which modules are actively loaded in the syste=
m
> > > > which is what ndctl_test_init() validates.
> > >
> > > Isn't what modinfo lists also what modrobe loads?
> >
> > It shows what modprobe would load on the next invocation, but
> > sometimes when nfit_test fails it's because the initramfs or something
> > else loaded the modules without respecting the extra/ (or updates/ in
> > your case) override modules.
> >
> > > There isn't any pmem so I don't see why production modules would be
> > > loaded before the test modules are installed. Unloading the modules
> > > first does not really make any difference.
> >
> > Ok, my first guess was wrong... would need more debug to see what
> > those other skip tests are complaining about.
>
> There was also missing parted and hostname command.
>
> However, the nfit.ko is detected as production even when I remove all
> the production modules just in case. lsmod confirms that the nvdimm
> modules are not loaded before the test.
>
> Maybe something goes wrong with the test module build?
>
> It is very fragile and requires complete kernel source for each
> configuration built. See below for the package
>
> https://build.opensuse.org/package/show/home:michals/nfit_test
>
> Attaching the log of test run which does not report any missing tools,
> only complains about nfit.ko being production.

Oh... something silly, ndctl_test_init() assumes that the out-of-tree
module directory is always "/lib/modules/$(uname -r)/extra"

                if (!strstr(path, "/extra/")) {
                        log_err(&log_ctx, "%s.ko: appears to be
production version: %s\n",
                                        name, path);
                        break;
                }

Looks like a build configuration variable is needed there to allow for
"updates/".

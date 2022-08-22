Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1279D59BCC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiHVJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiHVJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:26:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF2317045
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:26:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y4so9398205plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=afZwlyJFWi1oxAywjZJ8aFoRq/simALxdy+t/pD5S1g=;
        b=p0GZd/XZJG+l9vJANZ5ADTT4svgFLH6gATUVTUqN50UgmM70MBgX6XZIyztbgxqI4C
         BEb2TNVa1ptT708XMi5eaWgFEBiKkl1D1VHXH5vglSEI5O9lL8Six0R9jpTrWLDtaXcW
         Dylm5HwV1lf+kRw/wkZrrZM3FErmbnRX0aRZfprFIJcKd4Q+jRswyne7Ao6yHu7cp31E
         3RZWbl0CP7bwb/ZI/IYF/x9dPNJL6ia++6hfVt9brvATZXbv7+mTI98JXvN8mFIWXAr4
         COv2KFL0mAeywSG32d6wtgN3cCc4EfC9xAJ1V3QwFCV46iJ2L/l5p5M9Q6+vsUlZUGmj
         eUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=afZwlyJFWi1oxAywjZJ8aFoRq/simALxdy+t/pD5S1g=;
        b=vutmJhuvsZ5Gcgs6BG0Osb3eXjWgLom78bdfEvcyWXKBi7bzkcZfJrNIP4RUEqMx3S
         axRc88t1NaWBsOc2Tov7P7sKEbzmJVrh4k6QoyzqgFwvP27lnyVwef4Exf9Jp0e6v7cV
         K6rZPY4ljj8dO8hWYNnQn6axp4dlbsLkGo60+D1n9YJAPb+bBZxfPJTkbUaKy1ZLltsE
         3oJ45VRofpS8FEJZ+jCNfVgN1eyWwu/u1n5UZtGWaLaKcsGcJfj61cQZ+kQJZKXhqefF
         xC652O1kR7CV/wtr3bgAgEqK4VMV2PGtif8miQpeo/1V4B9o98q6/HPHYcucl9OxA0c3
         V3lA==
X-Gm-Message-State: ACgBeo0zH4bWncEbcy24Vi0FoidZYZGIVedkxVkq7DdSiDYlzs+D1zGx
        PAaGzmJQwwSDzYedQWXbfmQMsNVuik5WpW9LiGvJUQ==
X-Google-Smtp-Source: AA6agR4PTWfx6mJ4JfDP2s87MqHuEGPKmtNZbCfU8v7BsNem/96YT6tLIZvRLFXdnFduhqQo4YmT8Ok1AHREWZ1lgFk=
X-Received: by 2002:a17:90b:3b4d:b0:1f4:d1b6:cb69 with SMTP id
 ot13-20020a17090b3b4d00b001f4d1b6cb69mr22224004pjb.229.1661160394706; Mon, 22
 Aug 2022 02:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com> <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
In-Reply-To: <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Mon, 22 Aug 2022 11:26:23 +0200
Message-ID: <CAH76GKMw2rAnQOSFqReG1sEC=sdncWOJHNXn-Rp2Gx1oUZR3ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Maluka <dmy@semihalf.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dominik Behr <dbehr@google.com>, upstream@semihalf.com,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Could you please kindly comment on the above?

Thank you in advance,
Grzegorz

=C5=9Br., 20 lip 2022 o 15:15 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=
=C5=82(a):
>
> wt., 19 lip 2022 o 20:09 Rafael J. Wysocki <rafael@kernel.org> napisa=C5=
=82(a):
> >
> > On Thu, Jul 7, 2022 at 2:56 PM Grzegorz Jaszczyk <jaz@semihalf.com> wro=
te:
> > >
> > > Currently the LPS0 prepare_late callback is aimed to run as the very
> > > last thing before entering the S2Idle state from LPS0 perspective,
> > > nevertheless between this call and the system actually entering the
> > > S2Idle state there are several places where the suspension process co=
uld
> > > be canceled.
> >
> > And why is this a problem?
> >
> > The cancellation will occur only if there is a wakeup signal that
> > would otherwise cause one of the CPUs to exit the idle state.  Such a
> > wakeup signal can appear after calling the new notifier as well, so
> > why does it make a difference?
>
> It could also occur due to suspend_test. Additionally with new
> notifier we could get notification when the system wakes up from
> s2idle_loop and immediately goes to sleep again (due to e.g.
> acpi_s2idle_wake condition not being met) - in this case relying on
> prepare_late callback is not possible since it is not called in this
> path.
>
> >
> > > In order to notify VMM about guest entering suspend, extend the S2Idl=
e
> > > ops by new notify callback, which will be really invoked as a very la=
st
> > > thing before guest actually enters S2Idle state.
> >
> > It is not guaranteed that "suspend" (defined as all CPUs entering idle
> > states) will be actually entered even after this "last step".
>
> Since this whole patchset is aimed at notifying the host about a guest
> entering s2idle state, reaching this step can be considered as a
> suspend "entry point" for VM IMO. It is because we are talking about
> the vCPU not the real CPU. Therefore it seems to me, that even if some
> other vCPUs could still get some wakeup signal they will not be able
> to kick (through s2idle_wake->swake_up_one(&s2idle_wait_head);) the
> original vCPU which entered s2idle_loop, triggered the new notifier
> and is halted due to handling vCPU exit (and was about to trigger
> swait_event_exclusive). So it will prevent the VM's resume process
> from being started.
>
> >
> > > Additionally extend the acpi_s2idle_dev_ops by notify() callback so
> > > any driver can hook into it and allow to implement its own notificati=
on.
> > >
> > > Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/resto=
re
> > > hooks is not an option since it will not allow to prevent race
> > > conditions:
> > > - VM0 enters s2idle
> > > - host notes about VM0 is in s2idle
> > > - host continues with system suspension but in the meantime VM0 exits
> > > s2idle and sends notification but it is already too late (VM could no=
t
> > > even send notification on time).
> >
> > Too late for what?
>
> Too late to cancel the host suspend process, which thinks that the VM
> is in s2idle state while it isn't.
>
> >
> > > Introducing notify() as a very last step before the system enters S2I=
dle
> > > together with an assumption that the VMM has control over guest
> > > resumption allows preventing mentioned races.
> >
> > How does it do that?
>
> At the moment when VM triggers this new notifier we trap on MMIO
> access and the VMM handles vCPU exit (so the vCPU is "halted").
> Therefore the VMM could control when it finishes such handling and
> releases the vCPU again.
>
> Maybe adding some more context will be helpful. This patchset was
> aimed for two different scenarios actually:
> 1) Host is about to enter the suspend state and needs first to suspend
> VM with all pass-through devices. In this case the host waits for
> s2idle notification from the guest and when it receives it, it
> continues with its own suspend process.
> 2) Guest could be a "privileged" one (in terms of VMM) and when the
> guest enters s2idle state it notifies the host, which in turn triggers
> the suspend process of the host.
>
> >
> > It looks like you want suspend-to-idle to behave like S3 and it won't.
>
> In a way, yes, we compensate for the lack of something like PM1_CNT to
> trap on for detecting that the guest is suspending.
> We could instead force the guest to use S3 but IMO it is undesirable,
> since it generally does make a difference which suspend mode is used
> in the guest, s2idle or S3, e.g some drivers check which suspend type
> is used and based on that behaves differently during suspend. One of
> the example is:
> https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_drv.c#L2323
> https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_acpi.c#L1069
> https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_gfx.c#L583
>
> Thank you,
> Grzegorz

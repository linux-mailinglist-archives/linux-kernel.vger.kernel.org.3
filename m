Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963BE50A838
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391437AbiDUSlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbiDUSlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:41:36 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDDA369EA;
        Thu, 21 Apr 2022 11:38:44 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id f38so10331637ybi.3;
        Thu, 21 Apr 2022 11:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qclQva+dBU825L3ckBWzZRuhOlFUDZ8lHg/bUUIWmG4=;
        b=IWXa/CVA/0VcgyS/GEJ236duP8q7WoWBMfHpfuQU0M7MpXzBZY4F3djxSgVjFQSfES
         FZ8LJo49RrHj+NMZn9RA0ikFUZ03QOpYbzhkUvnGWCf15fGQgwRUxHSpKI0NYZSRzyBt
         WVdOSJtZyeshZNvbB3bJ60UzzyeNpSwEoCs4lwDTyAg1sNFNOcNgzi1bxh80thkaI2aN
         FkHibDzifPR6rXYmiojWUaHoVAWDcdefq8uLBqVJ7DshugOzISIeSSbIG82DomuIR5RO
         hw7MvJIS2s3+1R6UUbYmjY5x1Q9GH+Bq0s/6PChfbLFXvoTPTzqS1+0YHhzWBH9UDwT2
         Yflw==
X-Gm-Message-State: AOAM531D+w2TodV4PsInmzb7k1EBfJ8mBJgBSaSHkPtvYyaLqb2G7/y0
        ppQgvqYZftxvXy16FcaTGVEroMO67rbSMB5JKQRQeD+/0h4=
X-Google-Smtp-Source: ABdhPJyi++2mPz3HUP/4dSNVRdExKYA+0gwyp9mYlv7e7Mb621HN6bmKfmB8oxvznC8qvNdZZ1fsx8puGqQVOGJAxXA=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr1073961ybj.137.1650566323920; Thu, 21
 Apr 2022 11:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-5-mario.limonciello@amd.com> <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
 <BL1PR12MB5157CC5E942986945F5EF088E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157CC5E942986945F5EF088E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Apr 2022 20:38:32 +0200
Message-ID: <CAJZ5v0hFstH6goScEhUmZwBQ4gEnt5-tcp=UKgrW8Xb5zdZ_zg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 7:58 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Fontenot, Nathan <Nathan.Fontenot@amd.com>
> > Sent: Thursday, April 14, 2022 12:33
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>; Huang, Ray
> > <Ray.Huang@amd.com>; Rafael J . Wysocki <rafael@kernel.org>; Viresh
> > Kumar <viresh.kumar@linaro.org>
> > Cc: open list:AMD PSTATE DRIVER <linux-pm@vger.kernel.org>; Yuan, Perry
> > <Perry.Yuan@amd.com>; open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-
> > cpufreq when loaded
> >
> > On 4/14/22 11:47, Mario Limonciello wrote:
> > > `amd-pstate` can be compiled as a module.  This however can be a
> > > deficiency because `acpi-cpufreq` will be loaded earlier when compiled
> > > into the kernel meaning `amd-pstate` doesn't get a chance.
> > > `acpi-cpufreq` is also unable to be unloaded in this circumstance.
> > >
> > > To better improve the usability of `amd-pstate` when compiled as a
> > module,
> > > add an optional module parameter that will force it to replace other
> > > cpufreq drivers at startup.
> > >
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v2->v3:
> > >  * Rebase on earlier patches
> > >  * Use IS_REACHABLE
> > >  * Only add replace parameter if acpu-cpufreq is enabled
> > >  * Only show info message once
> > > v1->v2:
> > >  * Update to changes from v1.
> > >  * Verify the driver being matched is acpi-cpufreq.
> > >  * Show a message letting users know they can use amd-pstate.
> > >
> > >  drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > index d323f3e3888c..8ae65a2072d6 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -63,6 +63,13 @@ module_param(shared_mem, bool, 0444);
> > >  MODULE_PARM_DESC(shared_mem,
> > >              "enable amd-pstate on processors with shared memory
> > solution (false = disabled (default), true = enabled)");
> > >
> > > +#if defined(CONFIG_X86_ACPI_CPUFREQ) ||
> > defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
> > > +static bool replace = false;
> > > +module_param(replace, bool, 0444);
> > > +MODULE_PARM_DESC(replace,
> > > +             "replace acpi-cpufreq driver upon init if necessary");
> > > +#endif
> > > +
> > >  static struct cpufreq_driver amd_pstate_driver;
> > >
> > >  /**
> > > @@ -643,6 +650,7 @@ static struct cpufreq_driver amd_pstate_driver = {
> > >
> > >  static int __init amd_pstate_init(void)
> > >  {
> > > +   const char *current_driver;
> > >     int ret;
> > >
> > >     if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> > > @@ -666,9 +674,19 @@ static int __init amd_pstate_init(void)
> > >             return -ENODEV;
> > >     }
> > >
> > > -   /* don't keep reloading if cpufreq_driver exists */
> > > -   if (cpufreq_get_current_driver())
> > > +   current_driver = cpufreq_get_current_driver();
> > > +   if (current_driver) {
> > > +#if IS_REACHABLE(CONFIG_X86_ACPI_CPUFREQ)
> > > +           if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
> > > +                   acpi_cpufreq_exit();
> > > +           } else {
> > > +                   pr_info_once("A processor on this system supports
> > amd-pstate, you can enable it with amd_pstate.replace=1\n");
> > > +                   return -EEXIST;
> > > +           }
> > > +#else
> > >             return -EEXIST;
> > > +#endif
> > > +   }
> >
> > A couple of thoughts. First, should this also provide a path to restore the
> > acpi_cpufreq driver
> > if the amd-pstate driver fails during init some time after calling
> > acpi_cpufreq_exit()?
>
> I think that's a reasonable idea; it would involve exporting acpi_cpufreq_init
> as well.
>
> >
> > Which leads me to wonder, should there be a more generic
> > cpufreq_replace_driver() routine that
> > could handle this?
>
> If changing the API for this, my proposal would be that there is a flag used
> in cpufreq_driver->flags to indicate that this driver should replace existing
> drivers when calling cpufreq_register_driver rather than a new routine.
> Then if it fails to register for any reason then the old driver can be restored.
>
> Rafael, what are your thoughts on this?

IMV there need to be two things to make this really work.

First, the currently running driver needs to provide a way to tell it
to go away.  For example, intel_pstate has the "off" mode (in which it
doesn't do anything) for that and similar interfaces can be added to
other drivers as needed.

The reason why is because, for example, intel_pstate cannot go into
the "off" mode when HWP is enabled, because it cannot be disabled and
running acpi_cpufreq in that configuration wouldn't work.  So in
general you need to know that it is OK to unregister the current
driver.

Second, there needs to be a mechanism for registering a driver
"weakly" for future use, so if it cannot be used right away, it will
be added to a list and wait until there's room for it to run.

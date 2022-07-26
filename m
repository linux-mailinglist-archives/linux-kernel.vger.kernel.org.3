Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86785816BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbiGZPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGZPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:47:55 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D582C119;
        Tue, 26 Jul 2022 08:47:54 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id d124so8555737ybb.5;
        Tue, 26 Jul 2022 08:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZPNGDns+Qfzu1Eqk10wxuwO/i7doTSEULJR5ChxgVFk=;
        b=VACnp4WIU93m6phPLntWcqOd7J3Ef5zp9ykFHuc4NBcUK0Fg4Yab3Fj0WS4ci+CVm5
         HQlJkTthqpsckAgX0wR0VJSWxKEYPUZOsnewkJtjHQZ6wglPPHq7LBk2pmI1NAfToqDx
         M2/ow/uCC9dxTrtHOHrb1IcaNDl/owNhVtzsCSqdNHv58GTydUIykkvgJeJpEpDj1TIa
         i1OlVPrBn+o8qgK3QhsmV9VSJSsgrqzmUKxlUYrk+OzPFaM/nfjO/v3Jkqsw60jfDZkC
         KRQlmsY6/CCM9laTU79RJ6w1sCqLKoekX2JPzkM2dJW1PgeqbL996PrRpmkofeXiy5uD
         AnBA==
X-Gm-Message-State: AJIora9efvsD6rsm/qnooOTgcT2OlEDfkh4B1dtlITEwIbD3V1uVQzyI
        Baki8zzeazrT8qXPXFbDkwyom/ygk4Lvz7U/I17PmIyQ
X-Google-Smtp-Source: AGRyM1sgjhc1ut1Nex8zszS5zj7Oud9KgjN97RjBFYmpZVwn9GY8LQrkG5JDb3y5kgemn9rMfPcr3TWdgbmfnssno7o=
X-Received: by 2002:a25:828f:0:b0:670:22f9:f7eb with SMTP id
 r15-20020a25828f000000b0067022f9f7ebmr14480651ybk.137.1658850473683; Tue, 26
 Jul 2022 08:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220713082426.850911-1-dapeng1.mi@intel.com> <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
 <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
 <PH0PR11MB482497A0CC93F430DA208EDDCD8E9@PH0PR11MB4824.namprd11.prod.outlook.com>
 <CAJZ5v0j57iCNcz8i2P6JtkbiCHB1QS8M6QTngKoiJrm0pnkgUg@mail.gmail.com>
 <PH0PR11MB4824E26602680EED90B7FE2ACD919@PH0PR11MB4824.namprd11.prod.outlook.com>
 <PH0PR11MB482476E499FF0EE4A10F037BCD949@PH0PR11MB4824.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB482476E499FF0EE4A10F037BCD949@PH0PR11MB4824.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 17:47:42 +0200
Message-ID: <CAJZ5v0hdV=NRwiWj9-=t8jQjBA8f5S6n1pnQoGDDFNrq23p4oA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
To:     "Mi, Dapeng1" <dapeng1.mi@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
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

On Tue, Jul 26, 2022 at 3:46 AM Mi, Dapeng1 <dapeng1.mi@intel.com> wrote:
>
> > From: Mi, Dapeng1
> > Sent: Thursday, July 21, 2022 11:09 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; Arnd Bergmann <arnd@arndb.de>;
> > Bart Van Assche <bvanassche@acm.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Zhenyu
> > Wang <zhenyuw@linux.intel.com>
> > Subject: RE: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
> > in Makefile
> >
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Wednesday, July 20, 2022 6:24 PM
> > > To: Mi, Dapeng1 <dapeng1.mi@intel.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Michael S. Tsirkin
> > > <mst@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Bart Van Assche
> > > <bvanassche@acm.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Zhenyu
> > > Wang <zhenyuw@linux.intel.com>
> > > Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before acpi
> > > driver in Makefile
> > >
> > > On Wed, Jul 20, 2022 at 5:00 AM Mi, Dapeng1 <dapeng1.mi@intel.com>
> > > wrote:
> > > >
> > > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > Sent: Thursday, July 14, 2022 1:53 AM
> > > > > > To: Mi, Dapeng1 <dapeng1.mi@intel.com>
> > > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Michael S. Tsirkin
> > > > > > <mst@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Bart Van
> > > Assche
> > > > > > <bvanassche@acm.org>; Linux Kernel Mailing List <linux-
> > > > > > kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>
> > > > > > Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before
> > > > > > acpi driver in Makefile
> > > > > >
> > > > > > On Wed, Jul 13, 2022 at 10:21 AM Dapeng Mi
> > > > > > <dapeng1.mi@intel.com>
> > > > > wrote:
> > > > > > >
> > > > > > > As long as Kconfig ACPI_PROCESSOR is enabled, ACPI_PROCESSOR
> > > > > > > would select ACPI_PROCESSOR_IDLE and acpi_idle driver is
> > > > > > > enabled. But in current driver loading order acpi_idle driver
> > > > > > > is always loaded before cpuidle_haltpoll driver. This leads to
> > > > > > > cpuidle_hatpoll driver has no chance to be loaded when it's enabled.
> > > > > > >
> > > > > > > Thus, move cpuidle driver forward before acpi driver and make
> > > > > > > cpuidle-hatpoll driver has a chance to be run when it's enabled.
> > > > > > >
> > > > > > > Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
> > > > > > > ---
> > > > > > >  drivers/Makefile | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/Makefile b/drivers/Makefile index
> > > > > > > 9a30842b22c5..921ed481b520 100644
> > > > > > > --- a/drivers/Makefile
> > > > > > > +++ b/drivers/Makefile
> > > > > > > @@ -26,6 +26,7 @@ obj-y                         += idle/
> > > > > > >  # IPMI must come before ACPI in order to provide IPMI
> > > > > > > opregion
> > > > > support
> > > > > > >  obj-y                          += char/ipmi/
> > > > > > >
> > > > > > > +obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> > > > > > >  obj-$(CONFIG_ACPI)             += acpi/
> > > > > > >
> > > > > > >  # PnP must come after ACPI since it will eventually need to
> > > > > > > check if
> > > acpi
> > > > > > > @@ -126,7 +127,6 @@ obj-$(CONFIG_EDAC)          += edac/
> > > > > > >  obj-$(CONFIG_EISA)             += eisa/
> > > > > > >  obj-$(CONFIG_PM_OPP)           += opp/
> > > > > > >  obj-$(CONFIG_CPU_FREQ)         += cpufreq/
> > > > > > > -obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> > > > > > >  obj-y                          += mmc/
> > > > > > >  obj-y                          += ufs/
> > > > > > >  obj-$(CONFIG_MEMSTICK)         += memstick/
> > > > > > > --
> > > > > >
> > > > > > Well, this change doesn't guarantee loading haltpoll before ACPI idle.
> > > > > >
> > > > > > Also what if haltpoll is enabled, but the user wants ACPI idle?
> > > > >
> > > > > Thanks Rafael for reviewing this patch.
> > > > >
> > > > > acpi_idle driver and cpuidle_haltpoll driver have same
> > > > > initialization level and both are initialized on the level
> > > > > device_initcall. So the building order would decide the loading
> > > > > sequence. Just like the intel_idle driver which also has same
> > > > > initialization level (device_initcall), but as it's built before
> > > > > acpi_idle driver, it would be loaded first before acpi_driver if
> > > > > intel_idle
> > > driver is enabled.
> > > > >
> > > > > There is another method to make cpuidle_haltpoll driver loaded
> > > > > first before acpi_driver, it's change the initialization level to
> > > > > postcore_initcall. I'm not sure which one is better, but it seems
> > > > > current
> > > patch is more reasonable.
> > > > >
> > > > > There is an parameter "force" to manage the haltpoll enabling. If
> > > > > user want to use ACPI idle, it can change this parameter to
> > > > > disable
> > > haltpolll driver.
> > >
> > > That would require things to be appended to the kernel command line in
> > > cases where that's not necessary today and that's not acceptable.
> > >
> > The haltpoll driver's "force" parameter is false by default, we don't need to
> > add extra command line options in most cases except we want to enable the
> > haltpolling driver.
> >
> > > What you really seem to be wanting to do is to use haltpoll instead of
> > > ACPI idle.  Is that correct?
> >
> > Yes, I'm trying to enable guest halt polling to improve the performance of
> > some Virtual Machine. But I found the halt poll driver can't be enabled as
> > long as acpi idle driver is enabled. I tried to disable the acpi idle first, but I
> > found there is no parameter to enable/disable acpi idle driver except
> > disabling the Kconfig "CONFIG_ACPI_PROCESSOR_IDLE", and but
> > unfortunately Kconfig "ACPI_PROCESSOR" would enable
> > "ACPI_PROCESSOR_IDLE" by default. If I want to disable acpi_idle driver, I
> > have to disable the "ACPI_PROCESSOR", but this would cause acpi throttling
> > and acpi thermal are also disabled. That's not what I want. That's why I do this
> > change to make halt poll driver has a  chance to run without disable the
> > entire acpi processor functionality .
> >
>
> Any feedback? Thanks.

I've already said that messing up with Makefiles is not the way to go here.

You have to enforce a specific ordering of initialization in the code.

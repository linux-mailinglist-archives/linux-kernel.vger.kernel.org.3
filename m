Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3876E57B46F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiGTKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:24:34 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD72E6B8;
        Wed, 20 Jul 2022 03:24:32 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id f73so31100736yba.10;
        Wed, 20 Jul 2022 03:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmZJUUSv06iSFaoqgQbNFrLQMcY9cXPC++//tPskyCc=;
        b=aWKW018NnOG5uQJjPqudraPpJ7Q2b+++hqUF3mvMCaC6Kbkg2/DYP7DW35Q0VSw4M/
         3FsPN0JHi8SCwbnBs5aEL2ONsVHRpUL+TWl9Xju/aPZrbMfuPwxIhsQDfWA84Uxv55wT
         /TAP9XBKHSRi840jzV6SRT95KOB3aX6j8z42gmedwR9/rchG9NG88AKrxsVPS+ztHfd5
         vxr139p9V7lwJNH4eJjTY7lTpe/SQC8LykijM/jXRMo0gHFseTyAXpW6QmiNYOY6ko/w
         Bf8b3tq4eHJzZA4D+V9b7XrxQkCbXs99MQJ6oPTBmvnuzle9hs1gpEjHX6Bz1txOjk2l
         IiSg==
X-Gm-Message-State: AJIora+dV2TGvmacweh2QA1V52iU9oWlAruArA7GmgSfJq4nBeZ+Hpsk
        p6RbWzZ3yUMPib6uFkk4YG53a26VGJ5hKAkA97W4tNeJ
X-Google-Smtp-Source: AGRyM1tzI547gyHnjhqOynV2vuxO4TggTKKuQCyTk+sVmRGIS4zRS1p4Gschk7tmsQt4hTHFeGE0OieGFw9aGKNuy84=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr34552255ybm.482.1658312672231; Wed, 20
 Jul 2022 03:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220713082426.850911-1-dapeng1.mi@intel.com> <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
 <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
 <PH0PR11MB482497A0CC93F430DA208EDDCD8E9@PH0PR11MB4824.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB482497A0CC93F430DA208EDDCD8E9@PH0PR11MB4824.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Jul 2022 12:24:21 +0200
Message-ID: <CAJZ5v0j57iCNcz8i2P6JtkbiCHB1QS8M6QTngKoiJrm0pnkgUg@mail.gmail.com>
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

On Wed, Jul 20, 2022 at 5:00 AM Mi, Dapeng1 <dapeng1.mi@intel.com> wrote:
>
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Thursday, July 14, 2022 1:53 AM
> > > To: Mi, Dapeng1 <dapeng1.mi@intel.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Michael S. Tsirkin
> > > <mst@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Bart Van Assche
> > > <bvanassche@acm.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>
> > > Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before acpi
> > > driver in Makefile
> > >
> > > On Wed, Jul 13, 2022 at 10:21 AM Dapeng Mi <dapeng1.mi@intel.com>
> > wrote:
> > > >
> > > > As long as Kconfig ACPI_PROCESSOR is enabled, ACPI_PROCESSOR would
> > > > select ACPI_PROCESSOR_IDLE and acpi_idle driver is enabled. But in
> > > > current driver loading order acpi_idle driver is always loaded
> > > > before cpuidle_haltpoll driver. This leads to cpuidle_hatpoll driver
> > > > has no chance to be loaded when it's enabled.
> > > >
> > > > Thus, move cpuidle driver forward before acpi driver and make
> > > > cpuidle-hatpoll driver has a chance to be run when it's enabled.
> > > >
> > > > Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
> > > > ---
> > > >  drivers/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/Makefile b/drivers/Makefile index
> > > > 9a30842b22c5..921ed481b520 100644
> > > > --- a/drivers/Makefile
> > > > +++ b/drivers/Makefile
> > > > @@ -26,6 +26,7 @@ obj-y                         += idle/
> > > >  # IPMI must come before ACPI in order to provide IPMI opregion
> > support
> > > >  obj-y                          += char/ipmi/
> > > >
> > > > +obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> > > >  obj-$(CONFIG_ACPI)             += acpi/
> > > >
> > > >  # PnP must come after ACPI since it will eventually need to check if acpi
> > > > @@ -126,7 +127,6 @@ obj-$(CONFIG_EDAC)          += edac/
> > > >  obj-$(CONFIG_EISA)             += eisa/
> > > >  obj-$(CONFIG_PM_OPP)           += opp/
> > > >  obj-$(CONFIG_CPU_FREQ)         += cpufreq/
> > > > -obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> > > >  obj-y                          += mmc/
> > > >  obj-y                          += ufs/
> > > >  obj-$(CONFIG_MEMSTICK)         += memstick/
> > > > --
> > >
> > > Well, this change doesn't guarantee loading haltpoll before ACPI idle.
> > >
> > > Also what if haltpoll is enabled, but the user wants ACPI idle?
> >
> > Thanks Rafael for reviewing this patch.
> >
> > acpi_idle driver and cpuidle_haltpoll driver have same initialization level and
> > both are initialized on the level device_initcall. So the building order would
> > decide the loading sequence. Just like the intel_idle driver which also has
> > same initialization level (device_initcall), but as it's built before acpi_idle
> > driver, it would be loaded first before acpi_driver if intel_idle driver is
> > enabled.
> >
> > There is another method to make cpuidle_haltpoll driver loaded first before
> > acpi_driver, it's change the initialization level to postcore_initcall. I'm not sure
> > which one is better, but it seems current patch is more reasonable.
> >
> > There is an parameter "force" to manage the haltpoll enabling. If user want
> > to use ACPI idle, it can change this parameter to disable haltpolll driver.

That would require things to be appended to the kernel command line in
cases where that's not necessary today and that's not acceptable.

What you really seem to be wanting to do is to use haltpoll instead of
ACPI idle.  Is that correct?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDE4E191F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 01:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbiCTAUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242988AbiCTAUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 20:20:41 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABACF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 17:19:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A08AD5C0132;
        Sat, 19 Mar 2022 20:19:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Mar 2022 20:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1KWw8iPmqC/RJ7lj8
        bikVFsFdvOQq5BykeGEYNahjAI=; b=G9YOGXFFD8rH6m7jJU0rxRQo0xm5DaVIA
        T6efpmRDOU5869ufb8ywrQFme0UEpieNsl3QPn8SX5u44bdlSxYRy/k1KEURKDTJ
        3h3TJpkw2OQYsUJnQsy27kj3mpIBTHlDb6LUCcLbUzZEO4MItyuI+2azCXbcu7kk
        PaGwejMms6f600QpBvod5yOXcsAvuSbaPGRV6qdmyw7MKT80XOD3uZ4UO/khQEb1
        5bbW0qMmQLsiiOACI56fnzxkJII9DZobUSqWaEYtcstRdcPI5I7yNC3+/OYFYNm4
        CN/yT/LitBc/4bMWKqTJpR0FkNkT0In54cXP8pvEfC9y3vMOGNWLA==
X-ME-Sender: <xms:A3M2Yr-ebUyA8OjINorHIN3nQzkUVA0AfV84FBQ0zAByoC3ihX1u5g>
    <xme:A3M2YntNVknNTmOOdSKjZgXiv69mhIkPRdKalFcJdY0vryoQZWXBQ5OISCUfWvb8i
    nsC1SKkv6PfUkHPLs8>
X-ME-Received: <xmr:A3M2YpDXH9In7taJaLAEHemSmJUPpQ4osXun08WDcEio01l489B9UVtI2rUXnBEZHJg2ahKLm5rEh1nPH1_ZNcYfttY86hlzwSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:A3M2YneU3fAvXjnjYmbxX5bjLpcZyt2sozfcMySxRf4Q5XonDuRWZQ>
    <xmx:A3M2YgPlsu13AOCVdXtj-Sd_oPkc648STdzKjDkeMXhjZLgfguWwtA>
    <xmx:A3M2YpnQliiUAP_BXm7sTOMymqpIb7aUo57YuqW55oPAdZWTq4HGWA>
    <xmx:BHM2YlpQxfnBibhvu3ibT5ZUEeFIdB5tH1t2qrLdVQkArqFvmnsxAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 20:19:12 -0400 (EDT)
Date:   Sun, 20 Mar 2022 11:19:18 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT
 is disabled
In-Reply-To: <CAMuHMdVLCX0uPOCQos=cd5Z5pbm-++uVyV-fzMGyPi6oD3+SZw@mail.gmail.com>
Message-ID: <64b6d65-5d5d-23d2-dc8a-c31fc5853349@linux-m68k.org>
References: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org> <CAMuHMdVLCX0uPOCQos=cd5Z5pbm-++uVyV-fzMGyPi6oD3+SZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022, Geert Uytterhoeven wrote:

> On Sat, Mar 19, 2022 at 5:23 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
> > via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
> > via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
> > via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
> > via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
> > drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
> > via-pmu-event.c:(.init.text+0x20): undefined reference to `input_allocate_device'
> > via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_register_device'
> > via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_device'
> > make[1]: *** [Makefile:1155: vmlinux] Error 1
> > make: *** [Makefile:350: __build_one_by_one] Error 2
> >
> > Don't call into the input subsystem unless CONFIG_INPUT is built-in.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> 
> Thanks for your patch!
> 

Thanks for your review.

> > --- a/drivers/macintosh/Makefile
> > +++ b/drivers/macintosh/Makefile
> > @@ -12,7 +12,10 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)        += mac_hid.o
> >  obj-$(CONFIG_INPUT_ADBHID)     += adbhid.o
> >  obj-$(CONFIG_ANSLCD)           += ans-lcd.o
> >
> > -obj-$(CONFIG_ADB_PMU)          += via-pmu.o via-pmu-event.o
> > +obj-$(CONFIG_ADB_PMU)          += via-pmu.o
> > +ifeq ($(CONFIG_INPUT), y)
> > +obj-$(CONFIG_ADB_PMU)          += via-pmu-event.o
> > +endif
> 
> Alternatively, you can introduce an invisible Kconfig symbol that
> is y if ADB_PMU && INPUT, to control the build of via-pmu.o.
> 

There is some precent for that (DVB_AV7110_IR, PINCTRL_FALCON, 
DVB_AV7110_IR) in recent code but it's a bit of a stretch.

Adding the new Kconfig symbol would add complexity and it would only get 
used in two places.

I appreciate the general preference for declarative style over imperative. 
But is there a stronger argument against conditionals in Makefiles?

> >  obj-$(CONFIG_ADB_PMU_LED)      += via-pmu-led.o
> >  obj-$(CONFIG_PMAC_BACKLIGHT)   += via-pmu-backlight.o
> >  obj-$(CONFIG_ADB_CUDA)         += via-cuda.o
> > diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> > index 4b98bc26a94b..55afa6dfa263 100644
> > --- a/drivers/macintosh/via-pmu.c
> > +++ b/drivers/macintosh/via-pmu.c
> > @@ -1457,12 +1457,14 @@ pmu_handle_data(unsigned char *data, int len)
> >                 if (pmu_battery_count)
> >                         query_battery_state();
> >                 pmu_pass_intr(data, len);
> > +#ifdef CONFIG_INPUT
> >                 /* len == 6 is probably a bad check. But how do I
> >                  * know what PMU versions send what events here? */
> >                 if (len == 6) {
> >                         via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
> >                         via_pmu_event(PMU_EVT_LID, data[1]&1);
> >                 }
> > +#endif
> 
> Additionally, if that new symbol is not enabled, a dummy via_pmu_event()
> can be provided, so you don't need to add an #ifdef to the driver anymore.
> 

Adding a dummy function to be used in only one place seems questionable to 
me. I'm not expecting new call sites to appear outside of that ifdef.

Some of the arguments against ifdefs (reduced test and checker coverage, 
readability harm) don't really apply in this case.

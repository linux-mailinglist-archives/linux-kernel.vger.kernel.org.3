Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9F4EFA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351590AbiDAT2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351572AbiDAT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:28:36 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 38654166E23
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:26:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1648841206; h=Content-Transfer-Encoding: MIME-Version:
 Content-Type: References: In-Reply-To: Date: Cc: To: To: From: From:
 Subject: Subject: Message-ID: Sender: Sender;
 bh=PIlVbnZoKBF9L8sNxcppwl76sMV8O2PlumgtWNhmvRs=; b=YV732cGqliDaGZzGsaWNA0zatWmlAemfdugj7ugP6cRGrifMd0hXtbVCUnDI+TlEvRnob23q
 BWVsvUM1jVnvfhA1scF90FgpaPvLuEjkxwW6lyaFdzwuPzqil8/EuB9EZOZC7v8zY2ujEUTq
 DVew5wGidJooUar3UBxDzWjm/NIecof1816uybJhvEknwMkf+e7OsWk6627YzcJ9MNkz7zAH
 i+QRMAt9iOdZ/uxeyi+UohRKS0RybmhkPSmADCLMBEYlKdFPvMgaPEs/yC5QNXq/KBYw/fOD
 4gYu74PuIxkTGgi2z7mremo4gEXQJ+keiQD9UxN92qCVIwSdEkOrVw==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from [192.168.21.4] (dynamic-user.170.84.58.28.mhnet.com.br
 [170.84.58.28]) by smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 624751f40418b8d3d7029d7e (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 01 Apr 2022 19:26:44 GMT
Sender: codeagain@codeagain.dev
Message-ID: <3fbc5325e94b9ae0666a1f5a56a4e5372bfcea1d.camel@codeagain.dev>
Subject: Re: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Date:   Fri, 01 Apr 2022 16:26:27 -0300
In-Reply-To: <YkaXRpIElW1BwKGb@kroah.com>
References: <20220401050045.3686663-1-codeagain@codeagain.dev>
         <YkaW0ThT8Ah3z0wW@kroah.com> <YkaXRpIElW1BwKGb@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-01 at 08:10 +0200, reg Kroah-Hartman wrote:
> On Fri, Apr 01, 2022 at 08:08:17AM +0200, reg Kroah-Hartman wrote:
> > On Fri, Apr 01, 2022 at 02:00:45AM -0300, Bruno Moreira-Guedes
> > wrote:
> > > Currently, the VME_USER driver is in the staging tree Kconfig,
> > > unlike
> > > other VME drivers already moved to the main portions of the
> > > kernel tree.
> > > Its configuration is, however, nested into the VME_BUS config
> > > option,
> > > which might be misleading.
> > > 
> > > Since the staging tree "[...] is used to hold stand-alone[1]
> > > drivers and
> > > filesystem that are not ready to be merged into the main portion
> > > of the
> > > Linux kernel tree [...]"[1], IMHO all staging drivers should
> > > appear
> > > nested into the Main Menu -> Device Drivers -> Staging Drivers
> > > to make
> > > sure the user don't pick it without being fully aware of its
> > > staging
> > > status as it could be the case in Menu -> Device Drivers -> VME
> > > bridge
> > > support (the current location).
> > > 
> > > With this change menuconfig users will clearly know this is not
> > > a driver
> > > in the main portion of the kernel tree and decide whether to
> > > build it or
> > > not with that clearly in mind.
> > > 
> > > This change goes into the same direction of commit 4b4cdf3979c3
> > > ("STAGING: Move staging drivers back to staging-specific menu")
> > > 
> > > [1] https://lkml.org/lkml/2009/3/18/314
> > > 
> > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > > ---
> > >  drivers/staging/Kconfig | 2 ++
> > >  drivers/vme/Kconfig     | 2 --
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> > > index 932acb4e8cbc..0545850eb2ff 100644
> > > --- a/drivers/staging/Kconfig
> > > +++ b/drivers/staging/Kconfig
> > > @@ -88,4 +88,6 @@ source "drivers/staging/qlge/Kconfig"
> > >  
> > >  source "drivers/staging/wfx/Kconfig"
> > >  
> > > +source "drivers/staging/vme/devices/Kconfig"
> > > +
> > >  endif # STAGING
> > > diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
> > > index 936392ca3c8c..c13dd9d2a604 100644
> > > --- a/drivers/vme/Kconfig
> > > +++ b/drivers/vme/Kconfig
> > > @@ -15,6 +15,4 @@ source "drivers/vme/bridges/Kconfig"
> > >  
> > >  source "drivers/vme/boards/Kconfig"
> > >  
> > > -source "drivers/staging/vme/devices/Kconfig"
> > > -
> > >  endif # VME
> > > -- 
> > > 2.35.1
> > > 
> > > 
> > 
> > The problem with this change is that you just changed the
> > initialization
> > order of the drivers if they are built into the kernel.  Are you
> > sure
> > that you can initialize a vme device driver before the vme bridge
> > and
> > bus code is run?  I don't know if that will work properly, which
> > is why
> > the Kconfig entries are in the order they currently are in (we
> > preserved
> > the link order.)
> > 
> > It's not an obvious thing at all, sorry, but build order defines
> > link
> > order, which defines the order in which things are initialized in
> > the
> > kernel.
> > 
> > So I can't take this change unless you are able to prove that it
> > still
> > works properly on the hardware that these drivers control.  Do you
> > have
> > this hardware to test this change with?
> 
> Oh wait, it's the Makefile order that controls this, not the Kconfig
> order.  Sorry for the noise here, it's still early...

No problem, your previous message was quite helpful to make realize
some scenarios I wasn't considering at first. I did a more throrough
inspection of how this patch impacts everything thanks to this
observations.

I don't have the hardware so indeed I'm avoiding changes that would
need it to be tested, and as far as I'm properly aware my patch just
changes the places of things in the config targets. Build is protected
from such changes through some Makefile validations such as in
drivers/staging/Makefile:
| obj-$(CONFIG_VME_BUS)           += vme/

> 
> So this change _should_ be fine, but it would be good if you could
> prove
> it still works with some build tests.  How did you test this change?

At first I ran menuconfig and tested if it was still properly setting
CONFIG_VME_USER. Then I built with CONFIG_VME_USER=m and
CONFIG_VME_USER=n to check if it would build the module.

After your first e-mail I realized I didn't account for
CONFIG_VME_USER=y on my tests. I have now successfuly built with this
option too. Are those enough tests for this situation?

> 
> thanks,
> 
> greg k-h

While testing and checking, I have found two other things that I think
are remarkable to mention. First one is a missing `depends on` line
for `VME_BRIDGE` in drivers/staging/vme/devices/Kconfig, not visible
because they were in the same tree, but now unveiled. I'm fixing it,
do you think it's best to add it in the same patch?

Finally, not directly related with the patch, yet remarkable, I
happened to notice something. When probing the vme_user module
(compiled with CONFIG_VME_USER=m), I naturally get the following
messages on my log and command output for `modprobe vme_user`:

| [177666.590400] vme_user: module is from the staging directory, the
quality is unknown, you have been warned.
| [177666.601166] vme_user: VME User Space Access Driver
| [177666.602111] vme_user: No cards, skipping registration modprobe:
| ERROR: could not insert 'vme_user': No such device

While this is completely expected, the message about the code from
staging directory does not appear when compiled with
CONFIG_VME_USER=y, as shows a `grep -i vme` on the console log:

| [0.000000] Linux version 5.17.0lsa-t-vme_user=y-13483-gfeb94431c35c-
dirty (bruno@AN5Bruno) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38)
#7 SMP PREEMPT_DYNAMIC Fri Apr 1 14:33:16 -03 2022
| [1.974450] vme_user: VME User Space Access Driver
| [ 1.975405] vme_user: No cards, skipping registration

Do you think it would be interesting for a future patch to provide
some output when drivers from the staging tree are present in the
running kernel image?

NOTE: This message was sent earlier but due to some deliverability
issues didn't make to destinations. I apologize in advance if it ends
up duplicating.

-- 
Sincerely,
Bruno | Pronouns: they/them/theirs
IRC: CodeAgain

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DD579F59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiGSNOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbiGSNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:13:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692076B75C;
        Tue, 19 Jul 2022 05:30:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 101C95C012F;
        Tue, 19 Jul 2022 08:30:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Jul 2022 08:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658233833; x=1658320233; bh=9U1EtS+bl9
        piaVSNmdqe4t1gv74fQ46TH+YS38s6hTI=; b=DE0E3SifcrcnNFbmCZa1AaELa4
        ysDs1hTNfRFIkfw0txi80pUT8CIyxDw9kWM0NME7d7IzD39gAasl9wk3p5oqgp8x
        JAZBI8ds9n3QRr/cswlSFq2u/TowsCRn4mBjPTEzr5847AhMxhkvhGlB9LwA7qfn
        ryVNXH9OE1eptn3aJt/g43ud/UV1OufQKbhGr9BFEhsV5AO35dFPSC4Ktb1db9Pd
        s43vrfUbbZSJViClWbt36MvHCWM24hvqmBkDDdiozt8ZSAU22LfRWrVrd9yBFmrh
        3GExlLbdj/NT+0X0mkWkThAPfNN6pexKie/NhkkJUAtIleAI67bxpaKOPtrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658233833; x=1658320233; bh=9U1EtS+bl9piaVSNmdqe4t1gv74f
        Q46TH+YS38s6hTI=; b=H1OUZ9jO/J9mPC9hHUhmGMxyaj0Ob+m0tppT7JogqtnD
        PSa3GH+DMt6rnJj5MLUfsuP1KBU11GTi2G02EKDmKhN75syz7lXaO4MJ+rE2+L2Q
        UM6RD3jM9h0W9cZ01KC4VzbDXbapsdv0YxuoDuoejTGLNUsBYsU7TJptSTkVWz6Y
        6vG5Z918vG0XANAV3m3PyuWm2ldh7+AQPjhAa9Cpiggr29OSYuXfm+HY+G20Nrsw
        lzFpgjm2WzKrc7SpmiyifYuB8seJBwKG70xHyv6jdz9pX2/yIbye8Dw2eJks9o9W
        PmcfjtvK4bWMDcQLbizWSi1347XxjAlCiaoFcltT8Q==
X-ME-Sender: <xms:6KPWYs_0XZRkvumOavAm7CL-J0KN1w6DP8mxMg2HWZ6-DMAlEEdegQ>
    <xme:6KPWYktSvQ7N5HXXt2YDa8tEBJvbN6otOftY3wuZWdZy6aMEf9UQu0yk0ZGmzpuDR
    JxXQgltZPZfgQ>
X-ME-Received: <xmr:6KPWYiDEDz1o3uekzvKLLTa7MHZGx21BtZ6o-mA2U5iYAfFw9ubTq8aoTQ42>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeltddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:6KPWYsetTvxqB-9oOzoCs1IdPH-RSFSvMpap7fikPpol3n83qAX5jQ>
    <xmx:6KPWYhOMWB8L76IPijy4A8aZykqvWKMBjFKWqjosbbWntNiSJrAd9w>
    <xmx:6KPWYmlS9wJF4MjJAPAQVucIMOsghvM6LPKyewero2kh8bqO1m3NVA>
    <xmx:6aPWYom9_FCFrjCcWGSkEVbuxQuQBMyUUALWzWUV8WZ1wJJc8AayUQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 08:30:32 -0400 (EDT)
Date:   Tue, 19 Jul 2022 14:01:23 +0200
From:   Greg KH <greg@kroah.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YtadE201j+dt5jJx@kroah.com>
References: <20220718163158.42176b4e@canb.auug.org.au>
 <YtXF8TUZHNRUUyJh@kroah.com>
 <CACeCKafbgLmhLoYQiTTDkeeJ26HqFYBHXtcpwQkzOyO9LESEFw@mail.gmail.com>
 <YtZUJr4oIIALgdO+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZUJr4oIIALgdO+@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 08:50:14AM +0200, Greg KH wrote:
> On Mon, Jul 18, 2022 at 02:41:23PM -0700, Prashant Malani wrote:
> > Hi Stephen & Greg,
> > 
> > On Mon, Jul 18, 2022 at 1:43 PM Greg KH <greg@kroah.com> wrote:
> > >
> > > On Mon, Jul 18, 2022 at 04:31:58PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > After merging the usb tree, today's linux-next build (arm
> > > > multi_v7_defconfig) failed like this:
> > > >
> > > > drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_cmd_mux_set':
> > > > drivers/platform/chrome/cros_typec_switch.c:52:16: error: implicit declaration of function 'cros_ec_command'; did you mean 'cros_ec_cmd'? [-Werror=implicit-function-declaration]
> > > >    52 |         return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
> > > >       |                ^~~~~~~~~~~~~~~
> > > >       |                cros_ec_cmd
> > > > drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_register_switches':
> > > > drivers/platform/chrome/cros_typec_switch.c:244:23: error: implicit declaration of function 'acpi_evaluate_integer'; did you mean 'acpi_evaluate_object'? [-Werror=implicit-function-declaration]
> > > >   244 |                 ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> > > >       |                       ^~~~~~~~~~~~~~~~~~~~~
> > > >       |                       acpi_evaluate_object
> > > > drivers/platform/chrome/cros_typec_switch.c:244:49: error: invalid use of undefined type 'struct acpi_device'
> > > >   244 |                 ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> > > >       |                                                 ^~
> > > >
> > > > Caused by commit
> > > >
> > > >   e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")
> > > >
> > > > and commits
> > > >
> > > >   34f375f0fdf6 ("platform/chrome: cros_typec_switch: Set EC retimer")
> > > >   bb53ad958012 ("platform/chrome: cros_typec_switch: Add event check")
> > > >
> > > > interacting with commit
> > > >
> > > >   b1d288d9c3c5 ("platform/chrome: cros_ec_proto: Rename cros_ec_command function")
> > > >
> > > > from the chrome-platform tree.
> > 
> > I am very sorry about the conflicts.
> > 
> > I can think of a few ways to address this:
> > 1. A fixup patch on top of linux-next updating the function signature
> > to cros_ec_cmd() ; I will send this out if you'd like.
> > 2. Pull in Commit b1d288d9c3c5 ("platform/chrome: cros_ec_proto:
> > Rename cros_ec_command function") to usb-next.
> > We will also have to pull in dependent commit 015cd0043503
> > ("regulator: cros-ec: Use common cros_ec_command()")
> > 3. Revert the entire cros-typec-switch (patches 3-9) series from
> > usb-next and wait till after the merge window to apply it to
> > chrome-platform directly.
> 
> I think I'll just do #3 to resolve the issue.  I'll do it in a few
> hours.

Now all reverted from my tree.  Please send these changs through the
platform tree after the next -rc1 is released so that you don't end up
with build problems again.

thanks,

greg k-h

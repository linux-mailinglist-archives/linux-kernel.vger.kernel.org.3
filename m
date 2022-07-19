Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816257937A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiGSGuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSGuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:50:19 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167125281;
        Mon, 18 Jul 2022 23:50:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 620DE5C00E2;
        Tue, 19 Jul 2022 02:50:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Jul 2022 02:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658213417; x=1658299817; bh=X2tTQCC0iW
        qSbqbwa0QEysUBUs9rRD+BzpgOCtc5qW4=; b=PLCtiG0KrasR6cYhrj6Uq6RmUi
        o+LC82MDqgYNeVcZR6kpXJuKGsJ5WPjZiSPiZDqYMj8StuIjUMr/Ygnon/UgkGd4
        E4fxL6UrgWzd8cCjJUDnNWfHmg+bg4+Zmqn8M/DqrssF2kiSynMKTMaWyFPGHO9i
        EjsRBElneb+z5lSXHL/kpuwpIoksTwBOdWUmXV4AOU1DrSc00qbql6mNn1kIFzQ6
        pcINglLqrZL4sHukGk1nfgmXgt9EDRbdyT0gfkTO8BX6I4wx1s0n2SUdu/P8ExJy
        lRUcVktT209m5BvzBqGPzbrgQjLJ8genIAwuYbcCCRmMW9DNRq3Rv16/Ay9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658213417; x=1658299817; bh=X2tTQCC0iWqSbqbwa0QEysUBUs9r
        RD+BzpgOCtc5qW4=; b=eSAFAG1GLUkeJbi8OSJ30x0DSvlb7H5OSEIMVkots+U0
        K4R3/qGHA3Kb3qzEZ0cBDB6mQb3DCe/SM9EUYqCyzL4rxGCRn4qItExXzePCGNyQ
        bfej1M50Vn8D+ZtoM9pNnyQc4LZLR2sIn/RQAeHmCf6S9uqG6pwlxnahJ/GQOfXv
        fDtcKZcELDt2jz88ismjaHgsz6ylSmUPLMflFJesJB6WUCEy1kHHuz28Ei1MlNdW
        roOpcuU481+htPSLsv4s424M2BObkX1FRrtxDXuwl3SaagK8yhHVxAOahD9PeOyn
        JSDJ4qAfPzGMKYMTNO5j4NpdAt/1uO1v7kn8kSQXlg==
X-ME-Sender: <xms:KVTWYrOuBuru8DGNwdMnU428eS5L52hBeMXUGj-MiId7bgqaIWFY_Q>
    <xme:KVTWYl9QxzSL6F2pi7caxwqB1J_soHwLXWWygzGp-plFWy2u3eW2piiYcq5llBjHu
    ilkG35fRM-frQ>
X-ME-Received: <xmr:KVTWYqTqBvzf_QluVdfTWR7PPwFw6kgVPNM4cVJ9zndcBriKtewuiGY8-3NR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:KVTWYvur1FHCNIiBqSKZOg84sK5kY2KGW4XPApcyzNzWZnS0y9kKtw>
    <xmx:KVTWYjeAuFvpt9PPudg15Se2pE_LSO8JY-Qsm7vEp_Us6roVTaHVwA>
    <xmx:KVTWYr2dWjaIn2_0jnNzgEpFydIv-qZ1KboD-E9aceMzAHBUVVrvKg>
    <xmx:KVTWYu2wvtHIPlY0k2j-EkcW8noLDIFi-i0VUc_qHIxuvizpabYhuQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 02:50:16 -0400 (EDT)
Date:   Tue, 19 Jul 2022 08:50:14 +0200
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
Message-ID: <YtZUJr4oIIALgdO+@kroah.com>
References: <20220718163158.42176b4e@canb.auug.org.au>
 <YtXF8TUZHNRUUyJh@kroah.com>
 <CACeCKafbgLmhLoYQiTTDkeeJ26HqFYBHXtcpwQkzOyO9LESEFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafbgLmhLoYQiTTDkeeJ26HqFYBHXtcpwQkzOyO9LESEFw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:41:23PM -0700, Prashant Malani wrote:
> Hi Stephen & Greg,
> 
> On Mon, Jul 18, 2022 at 1:43 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Mon, Jul 18, 2022 at 04:31:58PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the usb tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > >
> > > drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_cmd_mux_set':
> > > drivers/platform/chrome/cros_typec_switch.c:52:16: error: implicit declaration of function 'cros_ec_command'; did you mean 'cros_ec_cmd'? [-Werror=implicit-function-declaration]
> > >    52 |         return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
> > >       |                ^~~~~~~~~~~~~~~
> > >       |                cros_ec_cmd
> > > drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_register_switches':
> > > drivers/platform/chrome/cros_typec_switch.c:244:23: error: implicit declaration of function 'acpi_evaluate_integer'; did you mean 'acpi_evaluate_object'? [-Werror=implicit-function-declaration]
> > >   244 |                 ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> > >       |                       ^~~~~~~~~~~~~~~~~~~~~
> > >       |                       acpi_evaluate_object
> > > drivers/platform/chrome/cros_typec_switch.c:244:49: error: invalid use of undefined type 'struct acpi_device'
> > >   244 |                 ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> > >       |                                                 ^~
> > >
> > > Caused by commit
> > >
> > >   e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")
> > >
> > > and commits
> > >
> > >   34f375f0fdf6 ("platform/chrome: cros_typec_switch: Set EC retimer")
> > >   bb53ad958012 ("platform/chrome: cros_typec_switch: Add event check")
> > >
> > > interacting with commit
> > >
> > >   b1d288d9c3c5 ("platform/chrome: cros_ec_proto: Rename cros_ec_command function")
> > >
> > > from the chrome-platform tree.
> 
> I am very sorry about the conflicts.
> 
> I can think of a few ways to address this:
> 1. A fixup patch on top of linux-next updating the function signature
> to cros_ec_cmd() ; I will send this out if you'd like.
> 2. Pull in Commit b1d288d9c3c5 ("platform/chrome: cros_ec_proto:
> Rename cros_ec_command function") to usb-next.
> We will also have to pull in dependent commit 015cd0043503
> ("regulator: cros-ec: Use common cros_ec_command()")
> 3. Revert the entire cros-typec-switch (patches 3-9) series from
> usb-next and wait till after the merge window to apply it to
> chrome-platform directly.

I think I'll just do #3 to resolve the issue.  I'll do it in a few
hours.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3040050B73B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447456AbiDVM3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389742AbiDVM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:29:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21956435
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1140ACE2943
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6671C385A4;
        Fri, 22 Apr 2022 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650630377;
        bh=YWvN2GspVnHvlnte3uDLsyT/zdRooy5HOmSXH4ILyuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8a9Yh+Ht3Kz/97UlvVaAMk64r8KVfczuaCGO5oW4WhL0vrR+wdX3Iy9FNFL6vXgh
         5oHodwiiUfOQe0i8o2kTf4uxUnXASb0L3G11/qhY5mEzrLulbIZ4WTcKPnShqaFHSF
         Oz/J2vqFheMqLYwwu+IhZ/6pZ783fWKjvp6JaOr8=
Date:   Fri, 22 Apr 2022 14:26:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v3 1/3] firmware: Add boot information to sysfs
Message-ID: <YmKe5sUIU4z6t0Hn@kroah.com>
References: <20220204072234.304543-1-joel@jms.id.au>
 <20220204072234.304543-2-joel@jms.id.au>
 <YmJPRPhfA4Cki85S@kroah.com>
 <CAK8P3a0G_xNQ6b2e71VXPVi+-j5L--SU37gFErwGYuh1QPrr1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0G_xNQ6b2e71VXPVi+-j5L--SU37gFErwGYuh1QPrr1A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:05:46AM +0200, Arnd Bergmann wrote:
> On Fri, Apr 22, 2022 at 8:46 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Feb 04, 2022 at 05:52:32PM +1030, Joel Stanley wrote:
> > > +What:                /sys/firmware/bootinfo/*
> > > +Date:                Jan 2022
> >
> > It isn't January anymore :)
> 
> The patch was sent on Feb 4, I would expect that to be close enough. Does this
> need to be the month of the kernel release it is merged into instead?

That's usually best, but at least the month the patch was sent in is
good.

Also I notice there's no "who is responsible for this" entry here.

> 
> > > +Description:
> > > +             A system can expose information about how it was started in
> > > +             this directory.
> >
> > I do not understand what you mean by "how it was started".
> >
> > > +             This information is agnostic as to the firmware implementation.
> >
> > How?  This should be very firmware specific.
> 
> The original patch was specific to a particular SoC vendor. Since the
> information provided here is fairly generic in the end, I asked for
> the interface
> to be generalized to the point that it can be reused across multiple
> vendors and architectures.

Ok, and is that what this interface provides?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82B47BCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhLUJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:34:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50340 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhLUJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:34:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D0DDCE129D;
        Tue, 21 Dec 2021 09:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB2DC36AE2;
        Tue, 21 Dec 2021 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640079253;
        bh=S0liGZ/rrTWRVdA9HyNrsNhXjNGJ+JYhJzh98QoHfGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmR7lXKIcRmYcBOZFtreMCl4qB5kNvl7wYHMNeztXCOF++uhNzbqPdbgb4v+m3W68
         mgcM4P4RcNKHyjk5Czvk1M2+vzN4BhMuygwHRP7ZJqlCHTmDmgb72JQfbkPSytaSKr
         bmj96z7eglkDIMb4luXxJEDGfRBSysor5eRBJgZo=
Date:   Tue, 21 Dec 2021 10:34:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
Message-ID: <YcGfky32lSXeABEF@kroah.com>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
 <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:37:07PM +0000, Daniel Scally wrote:
> Thanks Andy
> 
> On 20/12/2021 22:13, Andy Shevchenko wrote:
> > + Sakari, Dan
> > 
> > On Monday, December 20, 2021, Clément Léger <clement.leger@bootlin.com
> > <mailto:clement.leger@bootlin.com>> wrote:
> > 
> >     nargs_prop refers to a property located in the reference that is found
> >     within the nargs property.
> 
> I think this is right (it's not used in the ACPI version, and the OF
> version is quite convoluted so a bit hard to follow)...but also I note
> that none of the users of fwnode_property_get_reference_args() pass
> anything to nargs_prop anyway...do we even need this?

Looks like it is unused, please just remove it.

thanks,

greg k-h

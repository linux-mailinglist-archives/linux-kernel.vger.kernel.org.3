Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCF249135E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiARBZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:25:22 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:41150 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiARBZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:25:20 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 4BE4B1E005F5;
        Tue, 18 Jan 2022 03:25:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ee; s=20150108;
        t=1642469118; bh=Cbmo9zzdZXPewDMITMeQMfnHGjPMBioKlh1IQUhsBxQ=;
        h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
         Content-Type:X-ESPOL:from:date;
        b=MlXWID5ySVJJLPQhj/Lei5OCIAAYySnUfHFyzB/PLJhndtigEpcg+IYiSOUGLA4vN
         E07e+IerxIeiTvOQTOS/fkvC6RPniMHY02Lo5n0e2AVK8jQ7g0tMe5xTEKbLY5EGIn
         GKzWswZdwgW+NzR9vBzh0MfqZcJTaICiH8Z8dS2s=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 3E4991E005F4;
        Tue, 18 Jan 2022 03:25:18 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id sc4amGnhCHPH; Tue, 18 Jan 2022 03:25:18 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id E78C91E005E9;
        Tue, 18 Jan 2022 03:25:17 +0200 (EET)
Date:   Tue, 18 Jan 2022 04:25:12 +0300
From:   Boris Lysov <arzamas-16@mail.ee>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Missing ARM TWD Watchdog driver?
Message-ID: <20220118042512.360ee83a@pc>
In-Reply-To: <20220117170225.GB94025@C02TD0UTHF1T.local>
References: <20220117190112.2b2c2f53@pc>
        <60dceae6-5c7c-9f2d-9fcb-5e849f1d8ce5@roeck-us.net>
        <20220117170225.GB94025@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: 6NpmlY9HHDysjlqlQGetewt38GpVJY3o+OCk0Rhfgnn7NzCFfUoRMmO6mHAFPnHC3iM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Guenter,

On Mon, 17 Jan 2022 17:02:25 +0000,
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Jan 17, 2022 at 08:34:57AM -0800, Guenter Roeck wrote:
> > On 1/17/22 8:01 AM, Boris Lysov wrote:
> > > Hello everyone,
> > > 
> > > I stumbled upon the ARM TWD Watchdog driver which seems to be missing (or
> > > I'm just blind).
> > > 
> > > As per commit a33f5c380c4bd3fa5278d690421b72052456d9fe ("Merge tag
> > > 'xfs-5.17-merge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux"),
> > > multiple device trees declare usage of arm-twd:
> > > 
> > > (...)
> > > 
> > > and it is documented in
> > > Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
> > > 
> > > However I could not find the driver itself. I tried running
> > > case-insensitive grep and ripgrep to no avail. Does this driver actually
> > > exist? Is it gone?
> > > 
> > 
> > I may be missing it, but I do not see any evidence that it ever existed.
> 
> Likewise, AFAICT we added the binding but never the driver.
> 
> Looking at the git history, that schema was introduced in commit:
> 
>   50e02e9a030a9ae3 ("dt-bindings: timer: arm,twd: Convert to json-schema")
> 
> ... and replaced Documentation/devicetree/bindings/timer/arm,twd.txt
> 
> Per:
> 
>   $ git log --follow Documentation/devicetree/bindings/timer/arm,twd.txt
> 
> That was introduced alongside a driver in commit:
> 
>   d8e0364364d333fe ("ARM: smp_twd: add device tree support")
> 
> ... which only introduced a driver for the timer, and not the watchdog,
> as the commit message notes.
> 
> Thanks.
> Mark.

Now I understand there's no ARM TWD Watchdog driver.
TYVM for your replies!

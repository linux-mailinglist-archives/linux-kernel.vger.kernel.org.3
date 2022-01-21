Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5306496562
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiAUTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:02:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiAUTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:02:44 -0500
Date:   Fri, 21 Jan 2022 20:02:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642791762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fG4ZoXatxEkNbG5UBcm+lHkGC19XMjND5Hhdrf/oMvc=;
        b=CicPx0kKrpOco+R2uwemaIWb13krg1Vm3REpg0bTJf/dh3v9ZTIdgh+nTmH+REckZhi6IO
        es6mKr6aXX+QQBZQSjdlAC8dqueXESsA6ZlNV7kwMerMM6pVX+1DXxgPUFskUOCsEdpxVd
        QF38oEwRYEH5wZaAAm2Np6xAilpElnGTvgEVcD1+KOQ1EeduL1+/HK0w1oWbHqAtYr3eVG
        p0Mr2GMmnEwLWJJ2dIZ4l9YeJa1oGlMxXLhSeQ8QTmrwzp1ep6aurJhpdcQYsr7qbOD+/o
        G/3OhwTX18CA4IPPDS4CECa/c0YMT/X17x4dbca4RilFlyFGxr3dAhvCgo1LOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642791762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fG4ZoXatxEkNbG5UBcm+lHkGC19XMjND5Hhdrf/oMvc=;
        b=fRtimwwvuM5hArrw57j7b+p7TzTP1em7EqCTkZE2JjqBMESxnFIbSWxK4sCox5bZVoLLph
        kLIXkc7EogAY78AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.16.2-rt19
Message-ID: <YesDUV+ErrdoEvvw@linutronix.de>
References: <Yer73zjSLXFooB1+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yer73zjSLXFooB1+@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-21 19:30:57 [+0100], To Thomas Gleixner wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.16.2-rt19 patch set. 
> 
> Changes since v5.16.2-rt18:
> 
>   - Update the printk series. Patches by John Ogness.
> 
>   - Redo the i2c patches introduced in the previous release to address
>     other driver which look also broken.
> 
> Known issues
>      - netconsole triggers WARN.
> 
>      - Valentin Schneider reported a few splats on ARM64, see
>           https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com
> 
> The delta patch against v5.16.2-rt18 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16.2-rt18-rt19.patch.xz

The diff got too big and and the announcement didn't make it to the
list. Here is the mail without the incremental diff which can been
viewed at
   https://git.kernel.org/rt/linux-rt-devel/d/v5.16.2-rt19/v5.16.2-rt18

> You can get this release via the git tree at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16.2-rt19
> 
> The RT patch against v5.16.2 can be found here:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16.2-rt19.patch.xz
> 
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16.2-rt19.tar.xz

Sebastian

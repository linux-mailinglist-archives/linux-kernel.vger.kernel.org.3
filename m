Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A9C4892AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiAJHrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbiAJHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:40:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5BC02259A;
        Sun,  9 Jan 2022 23:34:07 -0800 (PST)
Date:   Mon, 10 Jan 2022 08:34:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641800044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1Fyw/nK/eEELQ/VDjJLho5JF7z/A8I/nGFppjKVNmM=;
        b=WQ0mqVWTlRHsgCd+gFHT38uHoVAxxj+yDUeJx2FCEvZj1Y8xn9WJKOhVY6ce/vyJb273TG
        RNiz2N9lWAbfee98M/JkXgnO74hRNTOKNjCJLSgkx/ixhyVuHGXtpTC1oN6mbgJ3nr7P8k
        zewoosB9DbTnyiNTnQbRp3n/288uyhbKunhUd6jwNVU6kwe7k4DcnYNdiZ9z2sa1Rb8/4H
        xpOtpkti+btiZXgtw1S6mMYSg37xROT1UyTHxPbMUyTnyduRPkBFmlCMme1zy+gy8co2m+
        Jc63CW6S5ZWI5gaOYUKlZUR1JHh8uQ59ebwHSuTGQvcdNc4bi3Z1szVmfemVZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641800044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1Fyw/nK/eEELQ/VDjJLho5JF7z/A8I/nGFppjKVNmM=;
        b=6Cosbfs7uwMSnZILukUWRlByOnALOg4G2tiFlXgCbKO21SEaKdf1bYjLW8zFDnMbTRlKmh
        igTghP+n1awVmjBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.19.223-rt100
Message-ID: <Ydvha9U7NCRRB8YL@linutronix.de>
References: <164133136582.713651.8616556329027058758@puck.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164133136582.713651.8616556329027058758@puck.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-04 21:22:45 [-0000], Clark Williams wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 4.19.223-rt100 stable release.

Do you have
     https://lore.kernel.org/all/YcN9+vGl7GXAZwJH@linutronix.de/

on your radar?

Sebastian

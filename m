Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6564639A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbhK3PSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:18:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbhK3POH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:14:07 -0500
Date:   Tue, 30 Nov 2021 16:10:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638285046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+K8fRBNVP6IimUZyWFxiKEdO3dBDmQS+h4Oz+CI7XpI=;
        b=P1Katl6RIwKCPLhgLQfngYQw7punL/C4DaEYB7F02HVT2Qgs6mjloox2xDiE+l+cNJfEbO
        6ufDRBm2OvCWQXnS9wl8a8jNY4qNveqCLiPFvHQXhaB+oiOxaJ34WzpbX3oQLCPQ1zoQUY
        +RnVETX0d2EzLEjTbgFt/TwZrMYk3G6WMQWsPt8JbNqzmoex9AyV+XcZkllAXyLC3DEpc1
        2+1SFMWvimn8OpatjmeC21CPCYhofHSKHIk6k24SXnxlqa/q11+5EGZdDh3qIefYEnPhZx
        kmIqbmS8RU8paVBCWeDmjZfgwLAveKXphWN55nL2KDP2aZdwOdu7h+E3+oHrjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638285046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+K8fRBNVP6IimUZyWFxiKEdO3dBDmQS+h4Oz+CI7XpI=;
        b=Y1QL+0Tf/ngCsIPK6wJG6ERwgN7QxGTO4J6KHzzAYk9RCLDkgRqE8m7Bg9mhltyd7eL9ZI
        OfgNq7VOxF8nzHBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211130151045.idygiysuatdhwjd4@linutronix.de>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
 <20211007171929.hegwwqelf46skjyw@linutronix.de>
 <20211009164908.GA21269@zipoli.concurrent-rt.com>
 <20211116152534.122f8357@gandalf.local.home>
 <20211116210249.t3f6gw56iaow57mq@linutronix.de>
 <20211116163924.5d5a2ffd@gandalf.local.home>
 <20211122195048.GB6166@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211122195048.GB6166@zipoli.concurrent-rt.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-22 14:50:48 [-0500], Joe Korty wrote:
> 
> Hi Steve, Sebastian,

H Joe,

> I will keep poking at it from time to time, see if I can
> get the issue to come back.

The issue shouldn't come back. I'm curious however if the bunch of i915
patchesm that I have in the latest RT, cause any problems with or with
PREEMPT_RT enabled. That is latency wise or usage wise (like lagging/
juddering playback wobbling GUI or anything like that).

> Joe

Sebastian

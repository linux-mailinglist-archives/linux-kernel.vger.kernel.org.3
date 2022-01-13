Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8180F48D30B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiAMHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiAMHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:41:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1BC06173F;
        Wed, 12 Jan 2022 23:41:57 -0800 (PST)
Date:   Thu, 13 Jan 2022 08:41:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642059715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mBgCRHm2JbN8EBFL4ncOMIw/22izNjHqYOj2r/BLtY=;
        b=lyJsXZ4fQvea5mXeQZPGDXWvxGohyE6/RMvPijxYbARGsiMgggYgA2YzfTBQMgQwJWUfr7
        O15XXPSwouvYBcDB4BPqy6W/WCwBX+KSVlFkznweONdsgH1jeULrdZhKOGAS41XsZu0Vl0
        PHERKBvaRfWP6SLTXfnzPCjQDHcGC97N5G5AYNL4lI8C64agVamAZ5R1cEqWPMnQ4BJ8hl
        L0HL/GLW0l9q9D6UpSVonKeHyU0PRd0Ug88bse057ebabX4ExYW76O80GtyjRpQI03D0jI
        0I9DLwmGpRY2ukpis9MGhs3V/OkK5yFl7lJf1v9Nh9Fcgoxo79LuGKV4wmg13Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642059715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mBgCRHm2JbN8EBFL4ncOMIw/22izNjHqYOj2r/BLtY=;
        b=7VPQtl0XpTeYZt879nqAm+uoO4HS4j7IwXeuuPTt0/rlLk8l30PVWXP/cN5KZSXOJUq6x4
        U1wPVOVBD6MHEeDg==
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
Subject: Re: [ANNOUNCE] 4.19.225-rt101
Message-ID: <Yd/XwQQy/4thD0vA@linutronix.de>
References: <164204551290.1795235.14392385656999546066@puck.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164204551290.1795235.14392385656999546066@puck.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-13 03:45:12 [-0000], Clark Williams wrote:
> Hello RT-list!
Hi Clark,

> I'm pleased to announce the 4.19.225-rt101 stable release.

this
   https://lore.kernel.org/all/YcN9+vGl7GXAZwJH@linutronix.de/

is kind of important.

Sebastian

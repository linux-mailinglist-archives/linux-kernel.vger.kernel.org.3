Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB246C44A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhLGUUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhLGUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:20:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739ACC061574;
        Tue,  7 Dec 2021 12:17:16 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:17:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638908234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oESRTJAmMs9dAuWEEdfClw9487fUg9HjiJqAVoDqOcs=;
        b=JJrRgLydgeWsXw7qDeKhKAVFqFj+/XprP4TnlZvSQegsrva5MGEdcyN+nKWjOl9J+8eNPo
        0O5GqccVI4KjRyCuST0rD+MiCUTGBD6vlWgWbdSXgNiXj9bI2LIBHb9lLXytmA3z8Af7KP
        77pO1dXtWjF8+Hhtd30O/B+n/sACCi8kNG0P+ivXX9e61z3pkcB5xlwPmQhhTYX71Ynrwp
        zRvF8Uq61MOdti2hoJF7dRaXZ+k0QHEDfDnuHSW9ddhSl7ppVyLLEQTuo1VrSdB8Rcxhdw
        a0jgVbAGypB4AhLK3jKmJ+yO0s00ILif3D5iRLuP7XWKBfEFHzsSjMPhD80kSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638908234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oESRTJAmMs9dAuWEEdfClw9487fUg9HjiJqAVoDqOcs=;
        b=sLui7Pa19kqJfHS3vDLNwaomXrnW8Vgs0klhG1cXio6vrgCCvKswZQ+fSW9o+fUhGDT63Z
        0vIlsl6C9DP1e+Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
References: <YalDQe/lyXqAxB0K@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YalDQe/lyXqAxB0K@uudg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-02 19:05:53 [-0300], Luis Claudio R. Goncalves wrote:
> I'm pleased to announce the 5.10.83-rt58 stable release.
=E2=80=A6
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.83-=
rt58.patch.xz

Any particular reason why every patch has "v4.9-rt" in the Subject line?

> Enjoy!
> Luis

Sebastian

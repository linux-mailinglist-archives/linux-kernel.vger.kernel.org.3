Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7C471734
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 23:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhLKWjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 17:39:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhLKWjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 17:39:05 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639262344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJPPsgENWjM6iwVutHLQnc1R7EzOEMMqbAeMB58/IDg=;
        b=FZjl2hSTLMDuUcMqrIqX151ZtM94BfSq+ZDD1tJAl2xp5nC+NCKdaAilQQai9VrhgVYzHo
        obNHJQFDJsLT6sLYpcA9zBc+0dGS85pmkZkeYwDgrtUwECboYw7vlZbIUrOkZKx/uOGQJc
        /vECLPY+EpgGCjc5tvFHZ4QC0Z3ttGNaF9Ul9YWciXHXfkcNfEY0NfiEFQ+hGgn+jVzO9W
        dJkOXki/rA+gdVA5Kf3d18Y07JzCYU05eKgiHdqczj6rMQkDuRsr7vKzhby5fmSuK83YQd
        +c0uTTtUZ4ElDuI6f6dlOTida7pD6s1x+Yf/0w0u+0py8Tib4TPW3p0Tk2GZtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639262344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJPPsgENWjM6iwVutHLQnc1R7EzOEMMqbAeMB58/IDg=;
        b=6ymp/SgjqBRWlOLs0q+NTFsCUcRGTy8cYW3yjcb9pSlATkckMaisw6MIUsXATHb9Ldobf2
        rX2wgUh5tIkbEKDQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] irq: Remove unsued flags argument from
 __handle_irq_event_percpu().
In-Reply-To: <CAHmME9rYB7uii-HgorYmuEytoJ3bEyuD2FKkqP_oYqrAUf8cvg@mail.gmail.com>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-3-bigeasy@linutronix.de>
 <CAHmME9rYB7uii-HgorYmuEytoJ3bEyuD2FKkqP_oYqrAUf8cvg@mail.gmail.com>
Date:   Sat, 11 Dec 2021 23:39:03 +0100
Message-ID: <87o85mvkag.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Tue, Dec 07 2021 at 18:41, Jason A. Donenfeld wrote:

> Applied to the crng/random.git tree, thanks.

I have no objections vs. that patch, but it is good practice to solicit
at least an ACK from the relevant maintainers before applying patches
which touch other subsystems.

Thanks,

        tglx

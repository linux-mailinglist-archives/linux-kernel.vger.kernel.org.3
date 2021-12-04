Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F374685DE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbhLDPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 10:19:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33948 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhLDPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5423860E9D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 15:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85563C341C2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 15:15:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wb3ExR6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638630932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nzxAtLM8TN2eNRhKXbnNdtLPpfPJzruxJ4ipdwIBkS0=;
        b=Wb3ExR6P+68BQ5G3PmOHHPUkAJRFYh6LzskmunY/Ww5tDE5QcitkDFK23LWnVbRrkHrTMx
        5V1A4hYKYTtewGc1/8p1M/g6/P3EAL4IunPP0oVuzdyWq+fsCA0KwwO0dEhrcCs7OJln89
        tdGuUSk5dMhD2dvfeeZN71BRUU//35E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ceccb8af (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 4 Dec 2021 15:15:32 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id g17so18209775ybe.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 07:15:32 -0800 (PST)
X-Gm-Message-State: AOAM533hH/ob+7Ex3VZobIKJ1bt+GNik3j3IHewJWFTyQyreA3ZSF15R
        d8eaIc82lxyEy4EnthxLuBEdtSheEmcJRc3Nx38=
X-Google-Smtp-Source: ABdhPJxcKyNrMcMm+v7SJM68o2cirQPOSC9lqit5v953BtUIgklksdL0caoVAvd2YJQqQ6pjlYG8dpj152NAGe7RCOk=
X-Received: by 2002:a5b:c81:: with SMTP id i1mr1277436ybq.115.1638630931416;
 Sat, 04 Dec 2021 07:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20211130184315.258150-1-Jason@zx2c4.com> <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
 <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com> <YauCkjsgDL4sdCId@mit.edu>
In-Reply-To: <YauCkjsgDL4sdCId@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 4 Dec 2021 16:15:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9q_hYyiUKb+H82-njugXaruQc6=sVa3HCQHnOHEOsGVwQ@mail.gmail.com>
Message-ID: <CAHmME9q_hYyiUKb+H82-njugXaruQc6=sVa3HCQHnOHEOsGVwQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Sat, Dec 4, 2021 at 4:00 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> Thanks for stepping up.  There's no question that this Fall has been
> insanely busy for me, and for the past 3 weeks or so, I've been on
> vacation and Thanksgiving travel, and I'm still catching up on a
> mountain of e-mail.
>
> Something that I think would make sense is that we set up a joint git
> tree on git.kernel.org, for which we would both have access to push
> to, and use a group maintainership model much like what other teams
> have done.  Do you agree?

Sure, that works for me. I had started using zx2c4/random.git. But
I'll talk to Konstantin about moving that over to a shared repository
in a group namespace.

Jason

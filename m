Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA414850A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiAEKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:05:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53386
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239189AbiAEKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:05:40 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B3D783F206
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641377138;
        bh=5D1xjiOTZGR/NYZwV/HYXBeCQP6CLWn6afeigaR+RhI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TJxQx2ETAiOQcRjlc8+ec0FiXmDl731D6uKvtuzHTVOXRIJSaAwhyrRCipwkviNPU
         uqLoyG/jVnLDz0qwDTON6Sy9NdCdF26d8l5rc/ThkK30JG4BLao7ZoKaE4u3QoHXea
         XDtddASyjVlVss4r6Kd63cTVAHcKY0vKu4Bd3H+VRrYO1kM0W08Zyhij4YboF51e5h
         wezn3HZL5+dyhY6y8Sk8w82RoaDvt6VjHTmi5YDpeKreke6Rnw9E2e1D71t9fF302X
         kUpduWp5nKA8jJQMq3le8iJqmuq2vUMXaPzV1gTiuK8vhSUWp9xToDoAH7CHe6aRE2
         6X+/wGssLxxgA==
Received: by mail-ot1-f69.google.com with SMTP id l13-20020a9d7a8d000000b005906a348cf0so203942otn.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5D1xjiOTZGR/NYZwV/HYXBeCQP6CLWn6afeigaR+RhI=;
        b=PwvBDPX3P5gT0aUQA3lWk8BU5wDy87Yp6af3HVj9Uy2ziywi4hFbNF36as4vjvm1xZ
         yftwEgxv5myFougznlTimKm59KYvzg8wYZ1n8kp3pynPmYPXSFCuP9x9YgdTynQZhxNs
         9mFDJ/vQhbYhxvpzqZwu4tCSB4VimSGKpB2JyAN6B8JTeIcUk6R8mFYKQxKzF6qL+QYk
         pQvlylEHJCayZYA44aJt9AOb9nJzZu7sLrvxoE3O4OczuLYC9EbodLHXvOvmSes5z7Vh
         Dw7Q18Qkh6yrxrsdHeeQlBdJAM1D0XQdBksa1y2+lgUcNfW9RKQ5eWJUSelYVkDYHZGz
         tNaQ==
X-Gm-Message-State: AOAM531WzMQII8TEUv0hTeGTnz8kAopWkRKOVkYbqmf7wqCK2JNMM88J
        WJ4Q9t786Uiu1b6rLSMidx5FvlkzNiBw0Je3vDy/5s17652+b/l1l0Jh5H2Mo42LH53nj7L1BTt
        CnBa8suulT2u5StCMEserpcJerHGC6FdyU7OGp0vtCovWF0FHXurzE8l5ow==
X-Received: by 2002:a05:6808:1445:: with SMTP id x5mr2013414oiv.146.1641377137601;
        Wed, 05 Jan 2022 02:05:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSxetywTS05F3LrKs6cZGyzYOlhWLLIzBvlpKZkAi3sZzki1WinEFEvYmM/4hhYZX5mg8FCJv4tka7ZKCUbmU=
X-Received: by 2002:a05:6808:1445:: with SMTP id x5mr2013396oiv.146.1641377137288;
 Wed, 05 Jan 2022 02:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com> <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org> <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
 <20220105072010.GA31134@srcf.ucam.org>
In-Reply-To: <20220105072010.GA31134@srcf.ucam.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 5 Jan 2022 18:05:26 +0800
Message-ID: <CAAd53p6VcAo0MVMWerTag42cWFE2ifzdQ=AFmGd9a=2gFjgv5A@mail.gmail.com>
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 3:20 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Jan 05, 2022 at 02:57:57PM +0800, Kai-Heng Feng wrote:
>
> > The affected system from the customer has SecureBoot enabled (and
> > hence lockdown), and the kernel upgrade surprisingly broke ioperm()
> > usage.
>
> Which kernel was being used that was signed but didn't implement
> lockdown? That sounds, uh, bad.

It was upgraded from older distro release. Older kernels don't have lockdown.

>
> > The userspace program is proprietary so I can't share it here.
>
> Ok. Are you able to describe anything about what it does so we can
> figure out a better solution?
>
> > Basically this patch makes ioperm() a noop on SecureBoot enabled x86 systems.
> > If reverting is not an option, what else can we do to circumvent the regression?
>
> There's two main choices:
>
> 1) Disable secure boot on the system in question - if there's a need to
> run userland that can do arbitrary port IO then secure boot isn't
> providing any meaningful security benefit in any case.

How so?
Other security features are still incredible valuable, we don't want
to toss them out just because someone has to use ioperm().

>
> 2) Implement a kernel driver that abstracts the hardware access away
> from userland, and ensures that all the accesses are performed in a safe
> way.
>
> Doing port IO from userland is almost always a terrible idea - it
> usually involves indexed accesses (you write an address to one port and
> then write or read data from another), and if two processes are trying
> to do this simultaneously (either because SMP or because one process
> gets preempted after writing the address but before accessing the data
> register), and in that case you can end up with accesses to the wrong
> register as a result. You really want this sort of thing to be mediated
> by the kernel, both from a safety perspective and to ensure appropriate
> synchronisation.

Agree, let me start a discussion with them.

Kai-Heng

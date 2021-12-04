Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4C4683DE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384625AbhLDJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384721AbhLDJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:57:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3DC0698CE;
        Sat,  4 Dec 2021 01:53:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so4054804wms.3;
        Sat, 04 Dec 2021 01:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/Z7q22hz6/jZEG3t/fjQe/LIXP2juQxxdbIILcT/y4=;
        b=HgfVC2dmrGyWIIEZEEubKF3pZeAK6/vxgibrcuoVZJZzobbLOvqs7Jp3MJvnSN3nP0
         DfnJQfKceYfd1lCBzVMwuTGo4kAx4Dn34sYkppryT2t0xMFLFhKHg6sTpx1WZOV0yJjh
         KNChkBP5Y7IOoZWcCa6TqBvVE0ucqVI8C2X3UlZBBXubBnEbG0LsDoAES9iAjI7h1DKt
         pkFPYICq3N+mWm94+zvcsbg1FvcAoXL7uyaepJ5sq92maD1UJi6IzyqtG/Q8d0kgrfXE
         8wEoS5KBiqlU/HN7W0iYDqpi9xbmKctsKBXYxvfwl45mCsgS7HTN4STcHQzpPxJZRnM/
         Koxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/Z7q22hz6/jZEG3t/fjQe/LIXP2juQxxdbIILcT/y4=;
        b=e/z1Yrz7ZaLFpcwaQuUzIFAbIWvKaOYu9dCU1IWdqmjhj3ALwCyKYNXZsWixGP4T+8
         H1ItiGgqBRfXQn7lRebERBMRzkMcyv1SB0VjEPSkiWcVS8c0bo+U8HQG3hz5bV/+Qoy7
         w2s/eOcRn694dPGRg/hwZMO9K/+BbxapvAiMwej9cnaVjj4OlA3rL+QwggyS/EzrD0+I
         RSPkUIJ1BRlB0JfPqxA/TlOui2/togOF07iFqRAXNYaZRJzXtZYUYBpUG4hIHPIKtPaE
         YtnqVGofYCxEb1zTXm89jTVzFmCJlFOZR8K8k4u3Z7FO4ki4t9z+E5hrFi2VXN8tFwlj
         WEuw==
X-Gm-Message-State: AOAM530iI+dGqI0UrJImRBER2MjcQ2XKYwVfs1epzGu21+98iXNVBX1P
        AFkvxLZTWWYezmAepBun3DmeKZIztYwJY1hCVuY=
X-Google-Smtp-Source: ABdhPJwEFX+M4vpBrMjQKMjVUF8zHIgyL4SnMphnUrqZ1Y87ChfGwFllVxhBfes4y5FdhjlczSblHLbN8AZPNjoNCbA=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr22103483wmj.9.1638611634690;
 Sat, 04 Dec 2021 01:53:54 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <4641592.OV4Wx5bFTl@positron.chronox.de>
 <CAHmME9oaS4TOpk7rQ73BRKeVLjMUNyt6EFyeOX=hZSkFBPDu0g@mail.gmail.com>
 <56d2da397bb53f71c0354b102c3b40940e9b4eda.camel@redhat.com>
 <CACXcFmntNAWYCwQ6CmH5c3pn3fXbxKh=j75GZUeLkuqi3QdS+A@mail.gmail.com> <YaXZCdtyylHMa29o@kroah.com>
In-Reply-To: <YaXZCdtyylHMa29o@kroah.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Sat, 4 Dec 2021 17:53:41 +0800
Message-ID: <CACXcFmmzDrNQijjXmJaBwjXLiST_2LqVONpMO1JG5xvy-ZXhoQ@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>,
        Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        John Kelsey <crypto.jmk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Also, why does any of this have to be in the kernel at all?

The kernel has had random(4) since Ted invented it sometime in
the 90s. There's no question it's a good idea; that's why all the BSDs
& some others have copied it. The only questions here are whether
it could be made FIPS compliant & whether it should be.

> If FIPS requires a deterministic random number generator
> that will not allow entropy to be acquired from hardware
> or external inputs,

It doesn't require that at all; in fact their DRNG design
requires an external source of random bits. However, it
requires that the source be certified & that would be a
problem for us. Intel & others might be able to get their
random number instructions certified and vendors of
crypto or SOC chips might get theirs certified, but the
kernel community could not do that.

I think the kernel's entropy collection routines are good
enough that they could, in principle, be certified, but
that would involve some work & considerable money.

> why does the
> kernel care at all?  Just write a fips_random.so library and get it
> certified and have any userspace code that cares about such a crazy
> thing to use that instead.

That does not solve the problem. The library would
also need a certified source of random inputs, so
to get it certified you'd have to get something else
certified first -- random(4), an instruction or a hardware
rng.

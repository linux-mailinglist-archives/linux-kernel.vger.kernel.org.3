Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC6461C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbhK2Q5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:57:40 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:29556 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345788AbhK2Qzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638204621;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=JyBjq88B15JKCOYh7QHsQko101At+fMhRrQiO+4wgy0=;
    b=qJZ6r+xe4Sy0ZbKZakDcT/ZcDuLh6dI+xkgkZtaTC6AL8rbMvMYblB3q6c+zwwfLyy
    3NVA6Ud87lYwD3Pt56n8s2w2WyMtisujmcqfX/TOe+McXEMccjP7/uKsm6WGmj6MnVJk
    Gconuffpc14E29VoSJoQRBhWC2aQIj/UoRuAm7IwG7Nx5L+GMpeUdJVEXiF6+IEfvvgL
    LfVUYELUcuLUyy2p+kOuZQbzqTUgXppRZYdhPG1wazsFMMr4C/ywthkuTzNc/U1dMMqE
    +4mcM9/YjIBuR4qmiJhBuS/+EMyXR9CyRfZ8EmNoWiUfFn0pJfcuD8p3Ilt3H94vQnN1
    budw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbIvSX5lo="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xATGoJRSz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 Nov 2021 17:50:19 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Nicolai Stange <nstange@suse.de>,
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
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Date:   Mon, 29 Nov 2021 17:50:18 +0100
Message-ID: <1852548.vyqkCxSGx7@tauon.chronox.de>
In-Reply-To: <YaT+9MueQIa5p8xr@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de> <9311513.S0ZZtNTvxh@tauon.chronox.de> <YaT+9MueQIa5p8xr@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. November 2021, 17:25:24 CET schrieb Greg Kroah-Hartman:

Hi Greg,

> > > 
> > > Links to the patches and discussion please?
> > 
> > Please consider https://lkml.org/lkml/2020/9/21/157
> 
> That's a load of patches, some of them seem sane, what ever happened to
> them? 

Nothing was discussed, nothing was picked up.

> Seems like the conversation got derailed by people with email
> server issues that prevented them from participating in public :(
> 
> But that patch set is a nice way to do this, incremental changes working
> with the existing codebase, not trying to ignore the current code and
> create a separate implementation.
> 
> Also, minor note, please use lore.kernel.org links, we don't have any
> control over lkml.org, nor can we take patches out of that site with any
> of our normal tools.

Apologies, will do for the next time.


Ciao
Stephan



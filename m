Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CA4712C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhLKILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:11:15 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:9982 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhLKILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639210201;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rmuTbR1U+aS9VFNcLM66wKMxKdcM8MhagXJXOCel4FU=;
    b=oO/9ue6kjiMT/QaPU1PsB9c2QIJg/CrfFjWoBXj1Nb99vWz2PmQ3286WgZ+UGdaxeB
    GadEX9k/IFexEQaWnLR5L8bCLTRYa3pjS9VH0Ud3Yb2IjWtGJT+fEdLxVXPqA8O3zOvn
    WrH0yNH/HWsprF73b6YijzpMClPJfI5WKlr+XNqsb1Ug1SKz08O3SFrPf+O0u//SjNUl
    d9k2MAj3Aepd96kK2Q5noFL1IVb3fT4lPQaXlCsPYcf0KAJUX9fGsWZkZLvnbPVy+1A0
    7roex6ao/LOMEAhg00wnieUPUc+4HHFl8KAWlj6ZN/Prrle/u4o01Ub8DlEEbWzwPICJ
    EE/w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSfFROW"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.35.3 DYNA|AUTH)
    with ESMTPSA id z09342xBB89u9dt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 11 Dec 2021 09:09:56 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Simo Sorce <simo@redhat.com>, Willy Tarreau <w@1wt.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jeffrey Walton <noloader@gmail.com>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Date:   Sat, 11 Dec 2021 09:09:55 +0100
Message-ID: <25222015.1r3eYUQgxm@positron.chronox.de>
In-Reply-To: <20211211070610.GA2153@1wt.eu>
References: <YaZHKHjomEivul6U@kroah.com> <b806a2a1a42b66f0fa5569b79862fe57277feda4.camel@redhat.com> <20211211070610.GA2153@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 11. Dezember 2021, 08:06:10 CET schrieb Willy Tarreau:

Hi Willy,

> On Fri, Dec 10, 2021 at 12:02:35PM -0500, Simo Sorce wrote:
> > On Fri, 2021-12-10 at 10:48 +0100, Greg Kroah-Hartman wrote:
> > > Given that there are no patches here to review by anyone, why is this
> > > email thread still persisting?
> > 
> > There is a will and a need to "improve" things, but given past absence
> > of feedback, people are trying to understand if there is any point in
> > trying to submit patches. Patches are work, and people like to know
> > they are not wasting their time completely before committing many more
> > hours.
> 
> It is obviously natural to think this way, but you can also understand
> that reviewing patches is extremely time consuming. And it's extremely
> difficult to review a patch series which says "replace all that
> infrastructure with a new one", especially when the motivations are
> "comply with this or that standard" without the benefits being obvious
> at all for those having to review those patches.

I am so surprised by such statements. Patch 00/15 lists in a bullet list the 
significant benefits of the LRNG. But seemingly nobody reads the introduction 
with its concise bullet list or the documentation. The FIPS bits are a tiny 
aspect of the whole effort (which even can be completely compiled out based on 
config options), the more significant aspects that have nothing to do with 
FIPS and benefit all are testability, performance, use of contemporary 
cryptography, and flexibility.

> But this does mean that a list of incremental changes/additions has to
> be established on the submitter's side, not a list of replacements.

Before I started the endeavor of the stand-alone patch of the LRNG, I 
developed cleanup patches to random.c in 2014 and 2015. I got massively 
discouraged to continue working on random.c as I did not get feedback from the 
maintainer. Some patches were taken, some were not without a comment... 

Ciao
Stephan 



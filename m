Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70773462F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhK3JB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:01:28 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:34488 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhK3JB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638262604;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DDCWyuV1q4Bg8hLGjlZOFkvlJxWKzcNwpLgCQQgqV00=;
    b=Hy/FuZQ4+1Hb8JRIrOQFEaj6DrstHlgd/qZI/VaFB5IJAFZWUobBcENwj3OQmuHvY0
    R0Z0GovxyGklFvevpI9qpSdWBjTyZx73MXv9ziMFngUBmYasaQNaIokW9zifMZ3wppg0
    zeLv3TC/1W6Sr9lLUDVQyGCPCXrN2GTJti3FHLq2rBKtaXr91qiwFb+kyeSwhIy+pfzD
    qLAHkLCtaBqWICNYr3l1FmkDDYYfsNb0IlN4bjp7Kr/l9vYdKfCXmxz4ZEaYGhzMy6QD
    gN8tKSEZNgIO1U3cuSeS7P1DhpjH7kbDJZx6czwSmmmJymwRwu14ryxKPvGg+8km7aqq
    1NAQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeuWroQ="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xAU8ufUjK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 09:56:41 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Sandy Harris <sandyinchina@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
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
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Date:   Tue, 30 Nov 2021 09:56:41 +0100
Message-ID: <2288548.vrFIavQkS3@tauon.chronox.de>
In-Reply-To: <YaXZCdtyylHMa29o@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de> <CACXcFmntNAWYCwQ6CmH5c3pn3fXbxKh=j75GZUeLkuqi3QdS+A@mail.gmail.com> <YaXZCdtyylHMa29o@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. November 2021, 08:55:53 CET schrieb Greg Kroah-Hartman:

Hi Greg,

> On Tue, Nov 30, 2021 at 03:32:38PM +0800, Sandy Harris wrote:
> > I think we should eliminate add_disk_randomness() since it does
> > not work well on current hardware. Also, FIPS requires that
> > entropy sources be independent & add_interrupt_randomness()
> > depends on the same disk events so these sources may not be.
> 
> This whole "may not be" guessing game when it comes to FIPS
> certification is a huge problem.  I have heard of different vendors
> getting different feedback and different implementations "passing" in
> different ways that totally contradict each other.  It seems that there
> is a whole certification industry built up that you can use to try to
> pass these tests, but those tests are different depending on the vendor
> you use for this, making a total mess.
> 
> So perhaps getting solid answers, and having the FIPS people actually
> implement (or at least review) the changes and submit them (this is all
> open for everyone to see and work on), would be the best thing as that
> would at least let us know that this is what they require.

Just as a note: I am working as FIPS tester. I am part of the NIST entropy 
working group which oversees the entropy related requirements. The LRNG's FIPS 
compliant implementation is directly based on those requirements. The LRNG was 
even reviewed by NIST personnel who mentioned that they do not see any 
contradiction to the specification. Finally, we are pursuing to get a separate 
ENT validation from NIST for the LRNG which would indicate that the LRNG meets 
all their requirements.

Besides, the LRNG can be configured to have no FIPS bits included at all as 
documented in the patches and in the separately provided documentation. Yet, 
it offers a streamlined conditioning operation and a combination of different 
entropy source data which is obvious to not destroy entropy.

Ciao
Stephan



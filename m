Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3361B48B080
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbiAKPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:10:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56196 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbiAKPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:10:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997EF61422;
        Tue, 11 Jan 2022 15:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4FC36AEB;
        Tue, 11 Jan 2022 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641913844;
        bh=McsMtOZ08KNWSnvYFOe9+6qopfWa4aTK73Luxx5P3hM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=DNpfDhPldxCXoEMFoSG9T69ITKuzR7l5o1TUboM2eBnDVC96zyQuhCvY0FQk0uMFH
         EsbPXYK0j1b+Mt6gFfEPSKY3lAvfotrXpk1sTIRSSyey5rm1M1EEEjzpK2eoVSws0l
         9Gv3yIIcoFSorx6q2a9SVQsnx1ii0vso+OawPTcn0Er3nqNRBtIooGWaR+8uJKNMhO
         5aOqYCeXnq0QoF3/t+ip3aRutJ1Eo4MNdWvdM6LmH6FTFaTbdCF1gurJhSAcmxfuie
         6DiVRKddngeHnkcKM6eNIaAjs5tGoZpFzLH3MYhHzmIRBnHCb9IcICCCJiCJGm0mDZ
         mRpbeQf+zihlQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9ACA627C005A;
        Tue, 11 Jan 2022 10:10:41 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Tue, 11 Jan 2022 10:10:41 -0500
X-ME-Sender: <xms:753dYTVHh6VdTqykd5DQwTFAgBibeMtuBBaBR9zg0-yIChjkuEZoBg>
    <xme:753dYbkLZefzSqMVxjUkC0sfpinhDDcgClUxTUELPgQ6NeyIpJc21GK6yBVemQlUE
    VsHApcD52PbKUqGxlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:753dYfaLeoIhK2mhrLaGTpCiiGufV2nw04A7qOyKvZlqhS0ah-HYRA>
    <xmx:753dYeUHmEf-VDFD7Qi5UxWgz8w0qLH91okAyR91Ap2mUr2BXR9ZHw>
    <xmx:753dYdneMiwtY0tj8wbyw8iiJYBq7x00KZgIlkh9VpUJ5DKYxE3dvA>
    <xmx:8Z3dYReZHnH6x8hSQoRM46Bi7ny7wUMVACUbPEs-9XCK4EGYmp7-R_9lDcPRaoxT>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 44B3921E006E; Tue, 11 Jan 2022 10:10:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <fcd3a0f9-0228-4b4a-b425-a7438acef3b9@www.fastmail.com>
In-Reply-To: <CAHmME9qw8hbbE2y56t7zygedofDDDLoPUxYWGZB_Kae0ipFARA@mail.gmail.com>
References: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu>
 <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
 <CAHmME9qw8hbbE2y56t7zygedofDDDLoPUxYWGZB_Kae0ipFARA@mail.gmail.com>
Date:   Tue, 11 Jan 2022 07:10:18 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Marcelo Henrique Cerri" <marcelo.cerri@canonical.com>,
        "Simo Sorce" <simo@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jeffrey Walton" <noloader@gmail.com>,
        "Stephan Mueller" <smueller@chronox.de>,
        "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
        "Willy Tarreau" <w@1wt.eu>, "Nicolai Stange" <nstange@suse.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Matthew Garrett" <mjg59@srcf.ucam.org>,
        "Vito Caputo" <vcaputo@pengaru.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Jan Kara" <jack@suse.cz>, "Ray Strode" <rstrode@redhat.com>,
        "William Jon McCann" <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        "Peter Matthias" <matthias.peter@bsi.bund.de>,
        "Neil Horman" <nhorman@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Julia Lawall" <julia.lawall@inria.fr>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Andy Lavr" <andy.lavr@gmail.com>,
        "Petr Tesarik" <ptesarik@suse.cz>,
        "John Haxby" <john.haxby@oracle.com>,
        "Alexander Lobakin" <alobakin@mailbox.org>,
        "Jirka Hladky" <jhladky@redhat.com>,
        "Eric Biggers" <ebiggers@kernel.org>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Jan 11, 2022, at 5:06 AM, Jason A. Donenfeld wrote:
> Hi Andy,
>
> On Tue, Jan 11, 2022 at 2:44 AM Andy Lutomirski <luto@kernel.org> wrot=
e:
>> So let=E2=80=99s solve it for real.  Have a driver (in a module) that
>
> Um, let's not. This really isn't something the kernel needs to solve
> here at all. There's a viable userspace solution. I see that the
> discussion of something finally slightly technical (as opposed to just
> compliance BS) has nerd sniped you a bit, but keep in mind what the
> actual overall picture is. This isn't something that needs to be done.
> My little CUSE thing (which I'm happy to develop out a bit more, even)
> has the intent of fulfilling a compliance checkbox and nothing more.
>


Can you develop your CUSE thing enough that it=E2=80=99s credibly safe a=
gainst side channels?  If so, fine.

I admit this is all rather absurd. FIPS aware userspace can do whatever =
it wants, and
It should be aware that /dev/urandom IS NOT FIPS.  What=E2=80=99s the pr=
oblem?  rand(3) isn=E2=80=99t FIPS either, but no one puts person-years =
of effort into trying to paint it FIPS-colored

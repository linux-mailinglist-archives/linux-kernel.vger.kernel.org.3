Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9848A544
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbiAKBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:44:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40184 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiAKBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:44:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C4F7B81864;
        Tue, 11 Jan 2022 01:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD7FC36AF2;
        Tue, 11 Jan 2022 01:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641865468;
        bh=U1cLTMcj9acjC/ZshBrjqYKqAR1pltmGCBlmvDFjgqY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=cwotnZKz9AaxK8JJI0wgjpXGcgnc92Hk5F17MZ7HZSrmX9tVF1sInLTi79CAdT+3z
         ithWHT49GprV+7Nev7MGVtP79seovvGATXcdQihjjlecaCOFtYdiVlNB9ttxcZ8fAr
         vHntJ638UEzrkvGhjpt/mxxiFs+pdr7yn61LEqvIurGtiYiO6U83UItwmDzyvPUG7p
         xdzpdbOKk8Yy5IrvBI7ETmwb43HPjSrO8zGzsyebobATQvg2CIbqICX4kvqTVBGwZ5
         JczakWYaxAhvnAINmM77mnyvi6E/wKPFgvFnzzJrl/vpjpXJsyjIEKqaC17l+HxJxO
         MpzMd4XyPTi/g==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id AF1D027C0054;
        Mon, 10 Jan 2022 20:44:25 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Mon, 10 Jan 2022 20:44:25 -0500
X-ME-Sender: <xms:9-DcYXUj_HNvWvuZ2H3km8mjhfCDaMNzfXDoBpetKUybneDfbfJ9DA>
    <xme:9-DcYflSCFimvOpG5DTqmQFuHYztzCtbui7VGz6RJHwj2p2pYzjWecGnZfK7lhAY2
    -RAd_o3-4qW-nZnDbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuefgueefveekhedvtdffgfekleehgfekheevteegieekgeehiedv
    fffgjeetudfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:9-DcYTZiA1l-QO3SAWO149AQs4GMVAuYlDiYYH1HU80R5QM75N6Z-A>
    <xmx:9-DcYSXBWJPMcyQ87vIOK4kPm_Fan_IbQshArt5h_4wb1HGVmwpZtA>
    <xmx:9-DcYRk_sdoAoHLJ0a38pG4IYo-T-vOteGqnMlVnI4VdZ_1r21UYYw>
    <xmx:-eDcYVcXYLQJ-JWY66dZPJ4fPq58eRG4aC-GwAAIYc4t5USHGJumXKUTZ7T3vf9n>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 781C321E006E; Mon, 10 Jan 2022 20:44:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4527-g032417b6d6-fm-20220109.002-g032417b6
Mime-Version: 1.0
Message-Id: <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
In-Reply-To: <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
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
Date:   Mon, 10 Jan 2022 17:44:03 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Marcelo Henrique Cerri" <marcelo.cerri@canonical.com>,
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



On Mon, Jan 10, 2022, at 2:19 PM, Jason A. Donenfeld wrote:
> On Mon, Jan 10, 2022 at 9:18 PM Theodore Ts'o <tytso@mit.edu> wrote:
>> In general, you need FIPS
>> certification for some specific use cases / application.  For example,
>> if you're going for PCI compliance, then you might only need FIPS
>> compliance for your OpenSSL library.  What the FIPS certification lab
>> might consider acceptable for its entropy for its DRBG is an
>> interesting question.  For some, simply having the OpenSSL library use
>> RDSEED or RDRAND might be sufficient.  Or it could talk to an actual
>> physical RNG device.
>>
>> So disabling getrandom() is probably not necessary, just so long as
>> you can demonstrate that the FIPS cryptographic module --- i.e., the
>> OpenSSL library --- is getting its entropy from an acceptable source.
>
> I don't know exactly what these people think they want, but what you
> say seems probably correct.
>
>> I suspect what's actually going on is that some enterprise customers
>> have FIPS complaince on a check-off list, and they aren't actually
>> getting a formal FIPS certification.  Or they only need something to
>> wave under the noses of their PCI certification company, and so the
>> question is what makes them happy.
>
> Right.
>
>> And this is why some FIPS certification have gotten by just *fine*
>> with a pure userspace OpenSSL library as their FIPS cryptographic
>> module.  Where you draw the line between a "blessed" entropy source
>> and one that's just hand-waving is really at the discretion of the
>> certification lab.
>
> Hah, probably correct.
>
> So, seen this way, and combined with the solution provided at [1] (or
> similar) for people who think they need something there, it seems like
> the FIPS people can likely get what they need without really needing
> to involve the kernel anyway.

Hmm, cute, but I think we can do a bit better. After all, this hack invo=
lves trusting a whole lot of code that is *not* intended for secrets to =
avoid having side channels.

So let=E2=80=99s solve it for real.  Have a driver (in a module) that ex=
poses a /dev/urandom compatible interface to the CryptoAPI DRBG.  We can=
 do a really nice job of it, and maybe it=E2=80=99ll be 100 lines of cod=
e.  People can do whatever they like with it in their container manager =
or boot scripts. And if it has a problem (where it=E2=80=99s *less* secu=
re than the real urandom), we can say =E2=80=9CI told you so=E2=80=9D.

We can go one step farther: add an LSM hook to getrandom().  Then someon=
e can hack up a fips_t policy for SELinux that turns off getrandom.

>
> Jason
>
> [1] https://lore.kernel.org/lkml/YdynXjhhuQfbYuSb@zx2c4.com/

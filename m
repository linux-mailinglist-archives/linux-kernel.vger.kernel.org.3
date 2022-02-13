Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD24B3936
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 04:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiBMDQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 22:16:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiBMDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 22:16:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F02D5F262
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 19:15:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8D560F4D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 03:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D16BC36AE2;
        Sun, 13 Feb 2022 03:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644722155;
        bh=cfBWan6cCytJstd6/pWGmDyKPrlRMs3PhvFLZb9flIA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=n6JbxKlqcL0RAOuXM/wB7PjxNSkOwDc3Mk5RwS+gAaCsG9+WtOvtx0ANA+x9xFJ5w
         mbXMBbPJydMkjNn3FLkYFKafzV8vihxga6fQD0iDOLO2yVmsjCgk/MvdqjoPKAPQz6
         moUjoQXuSLmC+ANubX4LzdHVEVmdRvZAWYJ3pRZMkZhSsk/ADJjfOtUffO6ea+L6vB
         9BT9kvv7671cLvTM6lWU/wj4+wxhJktllZJ+gMIikltRcu5F7JxkwCEv7UrGC8fgO1
         BY5P9IQyAXsSva1KrgyBvfSt5E+NDpbmKoZ+G262fdNB2d8RFvUGvsCwE2hVXPp4Jf
         hRCwPV49B1KYA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1BF9027C0054;
        Sat, 12 Feb 2022 22:15:52 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Sat, 12 Feb 2022 22:15:53 -0500
X-ME-Sender: <xms:53cIYsWHCSBLT20UKSNUTMb5qweuMdG6OtrolriGuqewjZWZS1dtlw>
    <xme:53cIYgnpm3vUbdrGFAUQQSkkvpvKuUaaSwRCyJz73WAfHhyZxyuOMXUqPKKjs7ynQ
    JGCD5Ni84IuoaGqbOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieevieeu
    feevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:53cIYganbE64N5FtxbXIhcvP5cEsBlcLyBW1qmXC6zPjhg2K9UldOQ>
    <xmx:53cIYrXtvXSgyojTVSs8d7oybism5nfG7LO6nh_CZPbzlAALvAhXiQ>
    <xmx:53cIYmmYjq0iVHPXlfReLn_yJanYCFq6QJyScKOL1uKgMZWSpTVD4g>
    <xmx:6HcIYldQHsQwB-Dv9w6_2nhXKOggZdLrPO6ylOa8HrDKqODCn_wNmh87cJ8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8F97C21E006E; Sat, 12 Feb 2022 22:15:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4748-g31a5b5f50e-fm-cal2020-20220204.001-g31a5b5f5
Mime-Version: 1.0
Message-Id: <fbdd43e1-a305-48d1-8ccb-2deffcb715f7@www.fastmail.com>
In-Reply-To: <20220211210757.612595-1-Jason@zx2c4.com>
References: <20220211210757.612595-1-Jason@zx2c4.com>
Date:   Sat, 12 Feb 2022 19:15:31 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>
Cc:     "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Feb 11, 2022, at 1:07 PM, Jason A. Donenfeld wrote:
> This is very much an RFC patch, or maybe even an RFG -- request for
> grumbles. This topic has come up a million times, and usually doesn't =
go
> anywhere. This time I thought I'd bring it up with a slightly narrower
> focus. Before you read further, realize that I do not intend to merge
> this without there being an appropriate amount of consensus for it and
> discussion about it.
>
> Ever since Linus' 50ee7529ec45 ("random: try to actively add entropy
> rather than passively wait for it"), the RNG does a haveged-style jitt=
er
> dance around the scheduler, in order to produce entropy (and credit it)
> for the case when we're stuck in wait_for_random_bytes(). How ever you
> feel about the Linus Jitter Dance is beside the point: it's been there
> for three years and usually gets the RNG initialized in a second or so.

I dislike this patch for a reason that has nothing to do with security. =
Somewhere there=E2=80=99s a Linux machine that boots straight to Nethack=
 in a glorious 50ms.  If Nethack gets 256 bits of amazing entropy from /=
dev/urandom, then the machine=E2=80=99s owner has to play for real. If i=
t repeats the same game on occasion, the owner can be disappointed or am=
used. If it gets a weak seed that can be brute forced, then the owner ca=
n have fun brute forcing it.

If, on the other hand, it waits 750ms for enough jitter entropy to be pe=
rfect, it=E2=80=99s a complete fail.  No one wants to wait 750ms to play=
 Nethack.

Replace Nethack with something with a backup camera or a lightbulb, both=
 of which have regulations related to startup time, and there may be a r=
eal problem. Keep in mind that some language runtimes randomize their ha=
sh table seeds at startup, possibly using /dev/urandom. This patch may b=
reak actual, correct, working code.

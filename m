Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C15AB75C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiIBRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiIBRTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:19:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3EF105B5F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 990BEB82CC8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A75C433D7;
        Fri,  2 Sep 2022 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662139140;
        bh=Taglg9igKY1YjGpYeZOws0enqFqxTZUqboD0GC5T7us=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=sjtlAfuKa+CYfLJsKmnLNEL0t4RRclQO3+I6WemSL+3MYgEFFk1Cc43Mla8Wl/xYW
         mg3zIy4sBfKku8jFIZJwJHsJMwpXWRRBUsOUx4CtRLZ1O9grhxlo9b/IJXtOxLkvJO
         SFKDJ6+Ka013SHiSF8LFWzjHtlQ2eL6F5wGa8LUX12jX3W6H6OgZOy+zzbv8loyJNg
         55uTYDA4tcWyVPvamvq14J5Y280pF621yusMCglO6tZc51/YQe/kKSFIdb/BrD+ihl
         xaxEet6DhTFrAwRfaHdHLbhyygWc8EsoDKxKCTpDHrR6kJwLdYaCHCNfUHVnn9eASv
         mdp0y90MHj2dA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 848BD27C0054;
        Fri,  2 Sep 2022 13:18:58 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Fri, 02 Sep 2022 13:18:58 -0400
X-ME-Sender: <xms:ATsSY4e6oGQkdydZFgZxGEHgv2lQrFmpMIcDhnzPDDvqrRy9Ii8Jfg>
    <xme:ATsSY6PRbo47siw0o145mWD5TWWba3fK4PyHaaksn70HqtyUXuoqyb7HfwJUT8pmk
    FazGnKtad-ZBF4Yx1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdvtdekfeeileejiedvfffhieegfefhfeefvdethfevffef
    ieelfedtlefggefhnecuffhomhgrihhnpehunhguvggrughlhidrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitd
    ekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:ATsSY5gMLMlRrxFDDbeM-78MlztDtNFl98rfKU_GrlejpXlF_wqV4Q>
    <xmx:ATsSY99YFezecg_kukLYsSPe66YwfaEbDWir5ADphsMKX5EfwSuesg>
    <xmx:ATsSY0v1xj645zMrsa-Ce8tNSxWRrxC0ulMaEcwHZP6gP3XWJ4v44Q>
    <xmx:AjsSY2JY7CTzWzTNkALtJrxlMA8Z66yzFI_QlG_RU9T8JtT8ZgSACQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B7CB731A0062; Fri,  2 Sep 2022 13:18:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <ec3cb7fb-8161-487e-ba6e-5d260b88af80@www.fastmail.com>
In-Reply-To: <a96082e1-96ad-e92b-a5d0-d239123d943e@intel.com>
References: <202208221331.71C50A6F@keescook>
 <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
 <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
 <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
 <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com>
 <c36eb441-e93e-4beb-bdf2-1e6285f7a187@www.fastmail.com>
 <CAEAAPHYTUYdtBLn4RsmNXMeaT8OvQ_k+Vy4uYdy_aSnaW79fcQ@mail.gmail.com>
 <a96082e1-96ad-e92b-a5d0-d239123d943e@intel.com>
Date:   Fri, 02 Sep 2022 10:18:36 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Jann Horn" <jannh@google.com>
Subject: Re: PKU usage improvements for threads
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Aug 25, 2022, at 7:36 AM, Dave Hansen wrote:
> On 8/25/22 05:30, Stephen R=C3=B6ttger wrote:
>>>> We were also thinking about if this should be a more generic featur=
e instead of
>>>> being tied to pkeys. I.e. the doc above has an alternative proposal=
 to introduce
>>>> something like a memory seal/unseal syscall.
>>>> I was personally leaning towards using pkeys for this for a few rea=
sons:
>>>> * intuitively it would make sense to me to extend PKEY_DISABLE_ACCE=
SS
>>>>   to also mean disable all changes to the memory, not just the data.
>>> It would make some sense, but we can't do it with the existing
>>> PKEY_DISABLE_ACCESS ABI.  It would surely break existing users if th=
ey
>>> couldn't munmap() memory that was PKEY_DISABLE_ACCESS.
>> Our thought was that this could be opt-in with a prctl().

I know Linux never copies other OSes, but OpenBSD is considering this:

https://undeadly.org/cgi?action=3Darticle;sid=3D20220902100648

If it works well, we could implement it.

>
> So, today, you have this:
>
> 	foo =3D malloc(PAGE_SIZE);
> 	pkey_mprotect(foo, PAGE_SIZE, READ|WRITE, pkey=3D1);
> 	munmap(foo); // <-- works fine
> 	mmap(hint=3Dfoo, ...); // now attacker controls &foo
>
> Which is problematic.  What you want instead is something like this:
>
> 	prctl(PR_ARCH_NO_MUNMAP_ON_PKEY); // or whatever
> 	foo =3D malloc(PAGE_SIZE);
> 	pkey_mprotect(foo, PAGE_SIZE, READ|WRITE, pkey=3D1);
> 	wrpkru(PKEY_DISABLE_ACCESS<<pkey*2);
> 	munmap(foo); // returns -EPERM (or whatever)
>
> Which requires the kernel to check when it's modifying a VMA (like the
> munmap() above) to see if PKRU _currently_ permits access to the VMA's
> contents.  If not, the kernel should refuse to modify the VMA.
>
> Like I said, I don't think this is _insane_, but I can see it breaking
> perfectly innocent things.  For instance, an app that today does a
> free() if pkey-assigned memory might work perfectly fine for a long ti=
me
> since that memory is rarely unmapped.  But, the minute that malloc()
> decides it needs to zap the memory, *malloc()* will fail.
>
> I also wonder how far these semantics would go.  Would madvise() work =
on
> these access-denied VMAs?
>
> My gut says that we don't want to mix up pkey semantics with this new
> mechanism.

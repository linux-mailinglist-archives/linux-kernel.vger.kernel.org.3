Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1759EC63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiHWTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiHWTcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:32:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01DC7F13B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5845B82052
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B7AC4347C;
        Tue, 23 Aug 2022 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661279075;
        bh=KJNS3EW9vcaaWW1rz09BY0G2qmkzynK0jgbX6GshbOw=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=rFWlSLhniF2euVfqDNvMPWn6Zml0+la3tUOLD8crYlYCKhIwuTD/rh71ls/Azx0Oo
         Nl6rLDGDurd1qomX8LUkoJWZ9J6jpWvuVUyf9VUMofE4NAQtS33Q64GDemcWgH5VmD
         ZargW3XNBH13XlvtRObuWz7E7Xg1GFvZQavxElyT91t53UkbkBdmgTqUO9Bhg4s/Bq
         ozjxHsLgCrv+bPmfz8ZdWw6zkGHZsxuSR1/giQWin/rmD/yN386cVhm+a9xnQy8BtO
         N/Zws9EHzaifTPWSmY+jXWc5xzIZh0GHugvo4I9KtZ2koujj0eWDaMm0+6ovUBrR97
         FI3QEHtKowuyw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0410027C0054;
        Tue, 23 Aug 2022 14:24:33 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 23 Aug 2022 14:24:34 -0400
X-ME-Sender: <xms:YRsFY0r7_laYb_d1i5QZyhneeUxDjaFu8FyRgZ-N3mwFmUmEgYU1mg>
    <xme:YRsFY6qWgzwkNnx8HlrfAUuxUVLums-yfJzdnVImDW6ctTACY_AILM469_ttPTtRn
    TQkS4SOhGA1-q4vrwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:YRsFY5M6fEUtxb5_vKK1SG47UJTSlJrhxrBGwTBZ5O7a9ciJXkI83Q>
    <xmx:YRsFY75u7PBbJXKWycVZgSDjhhhs_0P814gP_9RXaPUE8mUB2nMV9A>
    <xmx:YRsFYz6flRcP2GrfB_4wtHqcvnuP6dxKlZ7ubcthrsq5nV4J0ls0nw>
    <xmx:YRsFY1mCLpu8iUHn2TKJYWFx0epHXSSH01hHpLEdx4lhkS0_10tg4A>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F1CD31A0062; Tue, 23 Aug 2022 14:24:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
In-Reply-To: <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
References: <202208221331.71C50A6F@keescook>
 <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
 <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
Date:   Tue, 23 Aug 2022 11:24:13 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
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



On Tue, Aug 23, 2022, at 11:12 AM, Dave Hansen wrote:
> On 8/23/22 04:08, Stephen R=C3=B6ttger wrote:
>> On Mon, Aug 22, 2022 at 11:11 PM Dave Hansen <dave.hansen@intel.com> =
wrote:
>>> On 8/22/22 13:40, Kees Cook wrote:
>>>> 1) It appears to be a bug that a thread without the correct PK can =
make
>>>> VMAs covered by a separate PK, out from under other threads. (e.g. =
mmap
>>>> a new mapping to wipe out the defined PK for it.) It seems that PK =
checks
>>>> should be made when modifying VMAs.
>>>
>>> Could you give an example of this?  Is this something along the line=
s of
>>> a mmap(MAP_FIXED) wiping out an earlier mapping?  Or, is it more sub=
tle
>>> than that?
>>=20
>> Yes, that's one example. And the same applies to other operations on =
the
>> VMA. E.g. another case we'd like to prevent would be munmap(addr) whe=
re
>> addr is covered by a pkey to which the calling thread doesn't have ac=
cess
>> permissions to.
>
> Yeah, that's something for which our defenses are quite weak.  But, it
> also calls for a very generic mm/ solution and not something specific =
at
> all to pkeys.
>
> I assume that you wouldn't want to turn off *all* mmap(), MAP_FIXED or
> munmap() in the process.  You just want to make one or more VMAs more =
or
> less immutable.  That _sounds_ like a topic that would have broached at
> some point in the past, although it doesn't ring any bells.
>
> The concept would make a good lightning talk at Plumbers of LSF/MM.

This kind of thing seems questionable to me. If the attacker controls sy=
scall arguments, they can do almost anything. ISTM a CFI scheme should a=
im to prevent that bogus call in the first place, e.g. by preventing a p=
roblematic call.

Which makes me think that the actual solution is to have syscall interce=
ption support changing PKRU, perhaps via sigaltstack.

>
>>>> 2) It would be very helpful to have a mechanism for the signal stac=
k to
>>>> be PK aware, in the sense that the kernel would switch to a predefi=
ned
>>>> PK. i.e. having a new interface to sigaltstack() which includes a P=
K.
>>>
>>> Are you thinking that when switching to the sigaltstack that it would
>>> also pick up a specific PKRU value?  Or, that it would ensure that P=
KRU
>>> allows access to the sigaltstack's pkey?
>>=20
>> Either of those would work for us.
>>=20
>>> Logically something like this:
>>>
>>>         stack_t sas =3D {
>>>                 ss_sp =3D stack_ptr;
>>>                 ss_flags =3D ... flags;
>>>                 ss_size =3D ...;
>>>                 ss_pkey =3D 12;
>>>         };
>>>
>>> Then the kernel would set up RSP to point to ss_sp, and do (logicall=
y):
>>>
>>>    pkkru &=3D ~(3<<(12*2)); // clear Write and Access-disable for pk=
ey-12
>>>
>>> before building the signal frame running the signal handler?
>>=20
>> Yeah, that would work for our use case.
>> We also have a doc discussing this in more detail :) :
>
> That doesn't seem like it would be too much of a stretch.  There's a
> delicate point when building the stack frame that the kernel would need
> to move over to the new PKRU value to build the frame before it writes
> the *OLD* value to the frame.  But, it's far from impossible.
>
> I also bet we could do this with minimal new ABI.  There's already a
> ->ss_flags field.  We could assign a flag to mean that stack_t doesn't
> end at '->ss_size' and that there's a pkey value *after* ss_size.  I do
> think having a single pkey that is made accessible before signal entry
> is a more flexible ABI than taking an explicit PKRU value.
>
> I think that would allow just reusing sys_sigaltstack().

sys_sigaltstack() is already pretty much useless with SHSTK, and it=E2=80=
=99s kinda busted with AVX512. How about we just add a whole new non-klu=
dgy API?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF75ADE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiIFEfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiIFEe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:34:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94D13E3E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E243CB8161C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06745C433B5;
        Tue,  6 Sep 2022 04:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662438893;
        bh=M87zvDUxLrG8grmam+DgD3GHwqA0JmATZJWNyH1twYk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=PzNZBbzNmhyd8B8YD3/S/IV98+Q190OIEDi7eZ+ma0YHFlG5Jp9yJ3j9jo95Uv0/F
         OmvFbDEY3QJGSMjyw60Sw8m7jzvHkofqXjozzBR7toKyyPuNJ4/02SzKh1BjeeUF3c
         qZHyFzfqqycOl99D82sXJ6gsHKrMdR+MyiRf23mgTq0JpIt4wsHBq3k3dhNgegLIvo
         mgcN4QC9S0r9tN14mLvOIZv1IhynczO45FfEW0ftxBwIDw9jm5fu/jWc5wWbMrKAoz
         gN8r3cehOqU17YxHj1ACgomPAzSEmJ+dpFuuDnM/hfL7xS9VvUmr6yyFfG88j+lXOI
         njKhgI1CRccgQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D4A3627C0054;
        Tue,  6 Sep 2022 00:34:51 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 06 Sep 2022 00:34:51 -0400
X-ME-Sender: <xms:680WY7BfmLwziWei7hkHzyHZZj1kIC5HTiei75ZU-kTApcxSLdSxBA>
    <xme:680WYxj6DlHzbPzC3TEgMeHaQVPMJRSW1w9iDlOUGuj5toMhitQIk5wy1SScPQKIi
    liUKzZBjaibm6WopDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeljedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:680WY2lkkk1G5yyFMq68x04_xUmGzaWgskljyUlxzlji9vcjeOZQGQ>
    <xmx:680WY9yCOnGV9t6SgYW6Mck2qIcln2zz7_uE8tabpWJU8Y7IM9oDiA>
    <xmx:680WYwQkj24uuQdw55uXFB-s5aLANAQmXsGMlSMsSrjzzwfhncmOtg>
    <xmx:680WY2P3lJEh8yovaLCm6lY-pXR0qZLGgWniz9PTzIKTsrvNqiAKew>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5DCD631A0062; Tue,  6 Sep 2022 00:34:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <e1c67217-1143-4643-a7a3-ca3f34f28d30@www.fastmail.com>
In-Reply-To: <20220903001412.17015-1-yangff1@gmail.com>
References: <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
 <20220903001412.17015-1-yangff1@gmail.com>
Date:   Mon, 05 Sep 2022 21:34:30 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Fangfei Yang" <yangff1@gmail.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
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



On Fri, Sep 2, 2022, at 5:14 PM, Fangfei Yang wrote:
> I guess the question here is whether the code to call sigaltstack and=20
> signal handler is considered part of the security code (sigreturn=20
> obviously has to be, since the kernel has to restore the PKRU based on=20
> the saved fpu).
> I think to a large extent this is necessary, at least for the signal=20
> handler to be able to access the relevant registers at the time of the=20
> interrupt, which may contain data that the handler should not have=20
> access to. Even specifying a PKRU at the time of signal registration=20
> would make the system functionally sound and safe since the relevant=20
> calls must be protected.
>
> It's just that the design here should be such as to minimize the ways=20
> in which the interface can be abused (e.g., accidental override access=
)=20
> as well as to simplify the difficulty of writing secure code. It might=20
> be reasonable, then, to save the PKRU when the `sigaltstack` is called.
>
> The main purpose is to simplify the design of the handler entry point=20
> without adding new system calls, while not accidentally gaining=20
> privileges that do not belong to the current PKRU because of the syste=
m=20
> call, whether immediately, or later in signal delivery.

I think you might be so much more familiar with the system you=E2=80=99r=
e working on than anyone else that you=E2=80=99re not explaining some ba=
sics and we=E2=80=99re all lost.

How is PKRU a =E2=80=9Cprivilege=E2=80=9D and what do you mean my =E2=80=
=9Cimmediately=E2=80=9D?  I can=E2=80=99t follow this.

>
> This is because this part of the design can be largely made easier if=20
> additional source checking and PKRU switching by the handler at the=20
> entry point can be avoided.

Why would the entry point check a source?  Or change PKRU?  What would i=
ts PKRU logic be and why?

As I see it, the handler can (awkwardly, perhaps) manage PKRU just fine =
for all purposes except kernel access to the signal stack.

>
> As `WRPKRU` can be abused, if the handler uses this instruction,=20
> additional SP as well as PKRU checks must be performed to prevent=20
> malicious programs from forging signals, and the check must get=20
> multiplex among all threads. However, for the kernel, it takes very=20
> little code to avoid these checks by giving the handler the PKRU it=20
> wants.

Can you elaborate?  Of course WRPKRU can be abused to fully bypass PKRU =
protection.

>
> If only one PKEY is specified, then it is likely that `WRPKRU` is stil=
l=20
> needed, since the TCB itself may occupy multiple PKEYs, or, the handle=
r=20
> need to access the memory of other PKEYs (e.g., complex multi-domain=20
> signal designs).
>
> And, logically, it makes sense for a signal context (sigaltstack) to=20
> have the same PKRU when it is registered, and when it is used in the=20
> future. Thus, a special flag in `ss_flags & SS_SAVEPKRU` to ask the=20
> kernel to save the current PKRU would be sufficient.

This isn=E2=80=99t logical at all to me. It makes some sense as an API s=
implification to avoid a new syscall, and it makes sense in a bizarre (t=
o me) world in which user code can control access to PKRU but not to sig=
altstack(), but why do we live in that world?

>
> From the security side, if the current PKRU does not have access to th=
e=20
> signal stack, then a future signal occurring when the kernel uses this=20
> PKRU to write will also result in an segfault, thus avoiding unwanted=20
> access through sigaltstack.

Do you mean in current kernels?

> This is also more accurate than checking the PKEY of the page when=20
> registering the signal stack (if we restricted the PKRU when=20

What do you mean =E2=80=9Caccurate=E2=80=9D?


> registering the sigaltstack). Consider a possible error: a page is=20
> accidentally unmaped after being registered as a signal stack, and the=
n=20
> another page that should not have been accessed by this PKRU is mapped=20
> to the same location, thus causing an override during signal delivery.
>
>> I also bet we could do this with minimal new ABI.  There's already a
>> ->ss_flags field.  We could assign a flag to mean that stack_t doesn't
>> end at '->ss_size' and that there's a pkey value *after* ss_size.  I =
do
>> think having a single pkey that is made accessible before signal entry
>> is a more flexible ABI than taking an explicit PKRU value.
>
> Agreed, the most flexible way should be allow setting the PKRU to any=20
> subset of the current PKRU. So we can check `(~new_pkru) & current_pkr=
u=20
> =3D=3D 0` when calling sigaltstack.=20
>
> However, no matter how it is done, one of the more disgusting thing is=20
> that code like this appears in the program that handles the signal.
> ```
> old_pkru =3D read_pkru();
> write_pkru(stack_pkru);
> do_xsave();=20
> *(fpu_saved + pkru_offset()) =3D old_pkru; // this may be an argument =
of=20
> fpu function call
> ```
> And when restoring, you also need
> ```
> old_pkru =3D *(fpu_saved + pkru_offset());
> *(fpu_saved + pkru_offset()) =3D stack_pkru;
> do_xstor();
> write_pkru(old_pkru);

Sorry, what code does XSAVE here?

> ```
> These plus the testing of the current runtime environment (MPK) are=20
> truly disgusting. It's just structually ugly.

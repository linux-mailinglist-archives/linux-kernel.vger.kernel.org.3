Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E163560F40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiF3CjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiF3Ci4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5841304
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23CCF62017
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052BAC3411E;
        Thu, 30 Jun 2022 02:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656556722;
        bh=rfxOa7Si8i6HAVrL1PPC9Wi+JEHcRpWPQNKdTnH/Qvc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=UQv7CTfdGqGmqPcTNBXqhka5g+oy8i5sFZf2IfBAKKbH169eZFQfkpu9AuPHhD81c
         YbqlkFJWJBD6I0KpYQhA6MLeIAU+YYwqENHkDW1ZyNXh1TXTJsUQw8jyY3bDlN6ly2
         cGAE/wll8C3PjGogxC8teijr/YWWBxW8L+IYzSkPoQh4FWBJr80VHsyKE0x0DdYh3x
         /JmhllTeHFyCs/DeCe/sBqu+kKarG7lhcR50PAAiU9G/HQftG1anXs4r9cIox+3TQo
         aMcxfXUSI+JXP5TruhtHhG4+lXa8P7HsxeWfMn/FFesutL8zQBtN1LSVURqfj1HZhd
         QNhM4jmVCcSCQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D6B2027C0054;
        Wed, 29 Jun 2022 22:38:40 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 22:38:40 -0400
X-ME-Sender: <xms:sAy9YiQJsodHexjZbmcWeuvyr2kUWW9X9n6gWb-pGAhzu4RTkdpglg>
    <xme:sAy9YnxYKqgFcHrzjEuHBamN6Rjr6FTJmY_79z9CtZiAidyOTT07VNwPebIzYIBva
    0F7EkKqLq9fjYBRKX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:sAy9Yv1sN7dCqlMMY0GXtpehzHX_XXkoYTL6XlZVaRv69nepeS74eQ>
    <xmx:sAy9YuAhpPLx9OwtTv-wzYIzi8pN4J3T_ucfVxsRQ_nqVclkGFDElQ>
    <xmx:sAy9YrhwFX3AGmD6npvOF9xmt7UawuNcOgRp9ubHb19c1-suwntrDg>
    <xmx:sAy9Yur7mqh0eD4sL-OJhU_CT2S1wvGSr72JGtyJzT2TkDMRhfh_Nw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9983531A0062; Wed, 29 Jun 2022 22:38:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <7c8381b3-c71b-45e8-a162-c9701dabcc9b@www.fastmail.com>
In-Reply-To: <20220629004257.x3pyoydmtk2lhrnx@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <53d41f54-28ad-023c-537f-281cc2c40ae9@kernel.org>
 <20220629004257.x3pyoydmtk2lhrnx@black.fi.intel.com>
Date:   Wed, 29 Jun 2022 19:38:20 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Andi Kleen" <ak@linux.intel.com>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove tags before
 address check
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Jun 28, 2022, at 5:42 PM, Kirill A. Shutemov wrote:
> On Tue, Jun 28, 2022 at 04:40:48PM -0700, Andy Lutomirski wrote:
>> On 6/10/22 07:35, Kirill A. Shutemov wrote:
>> > untagged_addr() is a helper used by the core-mm to strip tag bits a=
nd
>> > get the address to the canonical shape. In only handles userspace
>> > addresses. The untagging mask is stored in mmu_context and will be =
set
>> > on enabling LAM for the process.
>> >=20
>> > The tags must not be included into check whether it's okay to acces=
s the
>> > userspace address.
>> >=20
>> > Strip tags in access_ok().
>>=20
>> What is the intended behavior for an access that spans a tag boundary?
>
> You mean if 'addr' passed to access_ok() is below 47- or 56-bit but 'a=
ddr'
> + 'size' overflows into tags? If is not valid access and the current
> implementation works correctly.
>
>> Also, at the risk of a potentially silly question, why do we need to =
strip
>> the tag before access_ok()?  With LAM, every valid tagged user addres=
s is
>> also a valid untagged address, right?  (There is no particular need to
>> enforce the actual value of TASK_SIZE_MAX on *access*, just on mmap.)
>>=20
>> IOW, wouldn't it be sufficient, and probably better than what we have=
 now,
>> to just check that the entire range has the high bit clear?
>
> No. We do things to addresses on kernel side beyond dereferencing them.
> Like comparing addresses have to make sense. find_vma() has to find
> relevant mapping and so on.=20

I think you=E2=80=99re misunderstanding me. Of course things like find_v=
ma() need to untag the address. (But things like munmap, IMO, ought not =
accept tagged addresses.)

But I=E2=80=99m not talking about that at all. I=E2=80=99m asking why we=
 need to untag an address for access_ok.  In the bad old days, access_ok=
 checked that a range was below a *variable* cutoff. But set_fs() is gon=
e, and I don=E2=80=99t think this is needed any more.

With some off-the-cuff bit hackery, I think it ought to be sufficient to=
 calculate addr+len and fail if the overflow or sign bits get set. If LA=
M is off, we could calculate addr | len and fail if either of the top tw=
o bits is set, but LAM may not let us get away with that.  The general p=
oint being that, on x86 (as long as we ignore AMD=E2=80=99s LAM-like fea=
ture) an address is a user address if the top bit is clear. Whether that=
 address is canonical or not or will translate or not is a separate issu=
e. (And making this change would require allowing uaccess to #GP, which =
requires some care.)

What do you think?

>
> --=20
>  Kirill A. Shutemov

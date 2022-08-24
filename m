Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0159FFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiHXQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiHXQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3913DCF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5826CB825C1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944AEC433C1;
        Wed, 24 Aug 2022 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661359543;
        bh=YhXKxbHJvYKPSYoq9igyuosSk/awWJCF3sNV8e9VUGY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ZvIKmahlwag3k0YqVFxAqiWLwaHWSWovir0BrjhZeoAHTneRFyABweo/1bGIHNMGn
         0+1mwKQFebrbJRqf2T0UaSFQLD2PldpVMw51QugVBfEHaI2evU6W+VO6XBU261lCQj
         w8kogsUeC95IYGKpwH0yURUy30PXC83WI/3nb6gRowlZmVEAtIOi4kCn24hzT8ORzA
         GYnC4HjUUMBb4chC7K7dOVWFU5JNSmDVVI6EqSTXNY7n0NVrNcT7ZJHlW+D3D8GOSC
         sTk5VacW0UPsIbUcZ3JktSfvkK2GF1m/6r2xu7nOzH34nK34+CGim+zG2kqUzNccrD
         FL/2Iq7IfutzQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 68CE327C0054;
        Wed, 24 Aug 2022 12:45:42 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 24 Aug 2022 12:45:42 -0400
X-ME-Sender: <xms:tVUGY9uDPA8dMcfo1P8UkLEzhnE9p3tvb_ccHQLGI2zh6tQnd33HaQ>
    <xme:tVUGY2cCFZsMD4tjHBQM60zimDIbCba03bqw9RtfEFTU1QuXLuBJRVIsggcHYYuwG
    AGuEwjKmrTGeHzifq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepgedvtddvheekgfehiefgkedvgfeutdetgefhfeekueevveei
    jeehffduvdehieffnecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:tVUGYwzobmiWHywi0ZUOUIalK0G26e9F5d-O_hzHEIXcnG7Zb9YKHg>
    <xmx:tVUGY0MBp7NQnjyE2_yuHAbq0JB9tJXlXP4088bweLWK52Jr8frUFQ>
    <xmx:tVUGY99_RQnViSUay72SX-ZzU6wHNxCgwUg47oPilvo57huHaqso1A>
    <xmx:tlUGY5aZZlSLftq78W3aMiEvNAzn98tVT8U1LzzOwoyR2D7k8lGh2g>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA33C31A0062; Wed, 24 Aug 2022 12:45:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <c36eb441-e93e-4beb-bdf2-1e6285f7a187@www.fastmail.com>
In-Reply-To: <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com>
References: <202208221331.71C50A6F@keescook>
 <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
 <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
 <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
 <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com>
Date:   Wed, 24 Aug 2022 09:45:21 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Cc:     "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Jann Horn" <jannh@google.com>
Subject: Re: PKU usage improvements for threads
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 24, 2022, at 1:51 AM, Stephen R=C3=B6ttger wrote:
> On Tue, Aug 23, 2022 at 8:24 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
>>
>>
>>
>> On Tue, Aug 23, 2022, at 11:12 AM, Dave Hansen wrote:
>> > On 8/23/22 04:08, Stephen R=C3=B6ttger wrote:
>> >> On Mon, Aug 22, 2022 at 11:11 PM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>> >>> On 8/22/22 13:40, Kees Cook wrote:
>> >>>> 1) It appears to be a bug that a thread without the correct PK c=
an make
>> >>>> VMAs covered by a separate PK, out from under other threads. (e.=
g. mmap
>> >>>> a new mapping to wipe out the defined PK for it.) It seems that =
PK checks
>> >>>> should be made when modifying VMAs.
>> >>>
>> >>> Could you give an example of this?  Is this something along the l=
ines of
>> >>> a mmap(MAP_FIXED) wiping out an earlier mapping?  Or, is it more =
subtle
>> >>> than that?
>> >>
>> >> Yes, that's one example. And the same applies to other operations =
on the
>> >> VMA. E.g. another case we'd like to prevent would be munmap(addr) =
where
>> >> addr is covered by a pkey to which the calling thread doesn't have=
 access
>> >> permissions to.
>> >
>> > Yeah, that's something for which our defenses are quite weak.  But,=
 it
>> > also calls for a very generic mm/ solution and not something specif=
ic at
>> > all to pkeys.
>
> We were also thinking about if this should be a more generic feature i=
nstead of
> being tied to pkeys. I.e. the doc above has an alternative proposal to=
 introduce
> something like a memory seal/unseal syscall.
> I was personally leaning towards using pkeys for this for a few reason=
s:
> * intuitively it would make sense to me to extend PKEY_DISABLE_ACCESS
>   to also mean disable all changes to the memory, not just the data.
> * We couldn't come up with another use case for the more generic API t=
hat
>   doesn't include pkeys.
> * Fewer syscalls for our use case, since we already set the pkey on th=
e mappings
>   we want to become immutable.
> That being said, either approach works for us.
>
>> > The concept would make a good lightning talk at Plumbers of LSF/MM.
>>
>> This kind of thing seems questionable to me. If the attacker controls=
 syscall arguments, they can do almost anything. ISTM a CFI scheme shoul=
d aim to prevent that bogus call in the first place, e.g. by preventing =
a problematic call.


What I'm trying to say is: CFI, by itself, can protect syscalls by makin=
g sure that callers are safe.  So, for example, if all munmap() callers =
do:

if (addr is dangerous)
  abort();
else
  munmap();

Then, with CFI, an attacker can't get to the actual munmap without first=
 doing the dangerous check.  And you can implement this entirely in user=
 code.

With syscall user dispatch (this thing: https://lwn.net/Articles/828510/=
 -- sorry, I meant that when I typed interception), you even have a way =
to intercept *all* munmap() calls, for example.

Regardless, I think it would be reasonable to have a nice way to create =
a sigaltstack and make it harder for the stack and the associated code t=
o get corrupted.  I"m not sure that pkeys are the right solution, but a =
nice coherent package that makes it difficult to accidentally change wha=
t happens when a specific signal is delivered could be quite powerful.


>
> I'm not sure that CFI can solve this problem since the attacker
> doesn't change the
> control flow in this attack. We will definitely have to ensure that
> certain syscall
> arguments can't be controlled by the attacker, e.g. if the protection
> bits of an mmap
> syscall are ever spilled to the stack, that would be one way to bypass
> the mitigation
> and we have to ensure in userspace that this doesn't happen.
> However, this seems infeasible for common syscalls like munmap. If any=
 thread
> wants to unmap a page, it's likely that the data for that came from a
> place that the
> attacker might have corrupted.



>
>> Which makes me think that the actual solution is to have syscall inte=
rception support changing PKRU, perhaps via sigaltstack.
>
> Can you expand on this? I didn't really understand what you meant.
>
>>
>> >
>> >>>> 2) It would be very helpful to have a mechanism for the signal s=
tack to
>> >>>> be PK aware, in the sense that the kernel would switch to a pred=
efined
>> >>>> PK. i.e. having a new interface to sigaltstack() which includes =
a PK.
>> >>>
>> >>> Are you thinking that when switching to the sigaltstack that it w=
ould
>> >>> also pick up a specific PKRU value?  Or, that it would ensure tha=
t PKRU
>> >>> allows access to the sigaltstack's pkey?
>> >>
>> >> Either of those would work for us.
>> >>
>> >>> Logically something like this:
>> >>>
>> >>>         stack_t sas =3D {
>> >>>                 ss_sp =3D stack_ptr;
>> >>>                 ss_flags =3D ... flags;
>> >>>                 ss_size =3D ...;
>> >>>                 ss_pkey =3D 12;
>> >>>         };
>> >>>
>> >>> Then the kernel would set up RSP to point to ss_sp, and do (logic=
ally):
>> >>>
>> >>>    pkkru &=3D ~(3<<(12*2)); // clear Write and Access-disable for=
 pkey-12
>> >>>
>> >>> before building the signal frame running the signal handler?
>> >>
>> >> Yeah, that would work for our use case.
>> >> We also have a doc discussing this in more detail :) :
>> >
>> > That doesn't seem like it would be too much of a stretch.  There's a
>> > delicate point when building the stack frame that the kernel would =
need
>> > to move over to the new PKRU value to build the frame before it wri=
tes
>> > the *OLD* value to the frame.  But, it's far from impossible.
>> >
>> > I also bet we could do this with minimal new ABI.  There's already a
>> > ->ss_flags field.  We could assign a flag to mean that stack_t does=
n't
>> > end at '->ss_size' and that there's a pkey value *after* ss_size.  =
I do
>> > think having a single pkey that is made accessible before signal en=
try
>> > is a more flexible ABI than taking an explicit PKRU value.
>> >
>> > I think that would allow just reusing sys_sigaltstack().
>>
>> sys_sigaltstack() is already pretty much useless with SHSTK, and it=E2=
=80=99s kinda busted with AVX512. How about we just add a whole new non-=
kludgy API?
>
> Attachments:
> * smime.p7s

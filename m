Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFD560ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiF3BwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiF3BwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35D366B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EBA561F5B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF1FC3411E;
        Thu, 30 Jun 2022 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656553936;
        bh=DKyHfowia1Y3f5XEY9TyUXvdb4vNfV4Xp3/ML2v6NAk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Stfx1PrX5zdaHkiVLi+dtVwzO9y/HEZdm5omFArQWSWfsw2JnGOfaVxtTt5aFike3
         69Doz2I3rbLy5Np3Qbfi43mvz3S26kbe+F/JNXqF3YlJlrqA7rykZVKT5cAJShE3UK
         2QdqjLHJASbVzs7X2bSUtZMpbqcpav3ZsDmzKd6pPdqt1aB947Vfdmj/NVQc2bjYwO
         QSKSPOuHUs9K1bNCO3xFrrCF6RvX/jb6IUdCvz9O20nsdk+hMtBAaPomrYgKfuwvQc
         r7/P3AHlQk2dCtSRL3WnhuHGSB7lYW9hUHAqBEIjFhAtuMeLKDVB54m/SQ2nw1gcYs
         5/ND3rjqdQtrg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4458927C005B;
        Wed, 29 Jun 2022 21:52:15 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 21:52:15 -0400
X-ME-Sender: <xms:zgG9YpCwMHiHAxYPiPe_MJffXEDBZ7R_khBY-zGgSW5XzKK3zbQFJQ>
    <xme:zgG9YnipEthSsbfE1RwEQ62fqH7mIjma6DQnRnmoNS5dRsA2BwAr5UQ0S3g0NA7Dp
    urS3fzXwwCJhjOg628>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:zgG9YklQNAYTEDefYcnFa9j7Py1e3Y_BDLc6-rkdaJmbKd9KV4Ef5Q>
    <xmx:zgG9YjwxlzpgnyiX_uGAUhvU_r0wermbONu3MVo1mS216FwDt_vzqQ>
    <xmx:zgG9YuSiL3CBsddaqIekBcwN-z3lnNTlLobHGcflkOGCsSjXUgbfFQ>
    <xmx:zwG9YqaHGMqIEcti6Mvd1LPbEQJ0POiUxi0G3lNbLfCqKVufPK7H2g>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A473831A0062; Wed, 29 Jun 2022 21:52:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <c12b8785-1fc2-434a-83ae-f28532e6823a@www.fastmail.com>
In-Reply-To: <20220629003452.37yojljbcl7jjgu5@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
 <9efc4129-e82b-740f-3d6d-67f1468879bb@kernel.org>
 <20220629003452.37yojljbcl7jjgu5@black.fi.intel.com>
Date:   Wed, 29 Jun 2022 18:51:44 -0700
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
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
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



On Tue, Jun 28, 2022, at 5:34 PM, Kirill A. Shutemov wrote:
> On Tue, Jun 28, 2022 at 04:33:21PM -0700, Andy Lutomirski wrote:
>> On 6/10/22 07:35, Kirill A. Shutemov wrote:
>> > Linear Address Masking mode for userspace pointers encoded in CR3 b=
its.
>> > The mode is selected per-thread. Add new thread features indicate t=
hat the
>> > thread has Linear Address Masking enabled.
>> >=20
>> > switch_mm_irqs_off() now respects these flags and constructs CR3
>> > accordingly.
>> >=20
>> > The active LAM mode gets recorded in the tlb_state.
>> >=20
>> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> > ---
>> >   arch/x86/include/asm/mmu.h         |  1 +
>> >   arch/x86/include/asm/mmu_context.h | 24 ++++++++++++
>> >   arch/x86/include/asm/tlbflush.h    |  3 ++
>> >   arch/x86/mm/tlb.c                  | 62 ++++++++++++++++++++++---=
-----
>> >   4 files changed, 75 insertions(+), 15 deletions(-)
>> >=20
>> > diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
>> > index 5d7494631ea9..d150e92163b6 100644
>> > --- a/arch/x86/include/asm/mmu.h
>> > +++ b/arch/x86/include/asm/mmu.h
>> > @@ -40,6 +40,7 @@ typedef struct {
>> >   #ifdef CONFIG_X86_64
>> >   	unsigned short flags;
>> > +	u64 lam_cr3_mask;
>> >   #endif
>> >   	struct mutex lock;
>> > diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/=
asm/mmu_context.h
>> > index b8d40ddeab00..e6eac047c728 100644
>> > --- a/arch/x86/include/asm/mmu_context.h
>> > +++ b/arch/x86/include/asm/mmu_context.h
>> > @@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *=
prev, struct mm_struct *next)
>> >   }
>> >   #endif
>> > +#ifdef CONFIG_X86_64
>> > +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
>> > +{
>> > +	return mm->context.lam_cr3_mask;
>> > +}
>> > +
>> > +static inline void dup_lam(struct mm_struct *oldmm, struct mm_stru=
ct *mm)
>> > +{
>> > +	mm->context.lam_cr3_mask =3D oldmm->context.lam_cr3_mask;
>> > +}
>> > +
>> > +#else
>> > +
>> > +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static inline void dup_lam(struct mm_struct *oldmm, struct mm_stru=
ct *mm)
>> > +{
>> > +}
>> > +#endif
>>=20
>> Do we really need the ifdeffery here?  I see no real harm in having t=
he
>> field exist on 32-bit -- we don't care much about performance for 32-=
bit
>> kernels.
>
> The waste doesn't feel right to me. I would rather keep it.
>
> But sure I can do this if needed.

I could go either way here.

>
>> > -	if (real_prev =3D=3D next) {
>> > +	if (real_prev =3D=3D next && prev_lam =3D=3D new_lam) {
>> >   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=3D
>> >   			   next->context.ctx_id);
>>=20
>> This looks wrong to me.  If we change threads within the same mm but =
lam
>> changes (which is certainly possible by a race if nothing else) then =
this
>> will go down the "we really are changing mms" path, not the "we're not
>> changing but we might need to flush something" path.
>
> If LAM gets enabled we must write CR3 with the new LAM mode. Without t=
he
> change real_prev =3D=3D next case will not do this for !was_lazy case.

You could fix that.  Or you could determine that this isn=E2=80=99t actu=
ally needed, just like updating the LDT in that path isn=E2=80=99t neede=
d, if you change the way LAM is updated.

>
> Note that currently enabling LAM is done by setting LAM mode in the mmu
> context and doing switch_mm(current->mm, current->mm, current), so it =
is
> very important case.
>

Well, I did separately ask why this is the case.

> --=20
>  Kirill A. Shutemov

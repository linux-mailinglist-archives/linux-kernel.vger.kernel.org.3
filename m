Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1803564358
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGBX4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiGBX4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F8AE71
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 16:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 765CAB80915
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7360BC385A5;
        Sat,  2 Jul 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656806163;
        bh=EEBHZFmCM87ZQjKZ2GqVTCe4m6ueSfuZnutZDydVnhg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=XvbaPO89FeqREm618JRoXMFk9HptS/EcEepS391vHW7exJfiVVCnpneISt5Auk7e3
         i4PWs+MgdSw3qzURlYiIqIGQ7cTj5JXUr5jaDh3lW2+WpBg2BK+HJAnoNf+lnlRwgn
         YRrd/fhusndEorBxcNiIxTT/yNzRX5WOKNe2itKHligJmx3TXH08ENT/erL1werFsq
         uqtsXPWYhzMGQ5XQKevIBCgbgl/dwFEwxykt6EQCHz0vKhgq56NgAoKARk3/sN0XoD
         ennIzS5itxhHEzmedWKpqP2Yps+lKph2JJbK3PQckoSXSx6MvFUQ30b1o4GeDSDFka
         kcXqqYvOZjhkA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4B37F27C0054;
        Sat,  2 Jul 2022 19:56:01 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 02 Jul 2022 19:56:01 -0400
X-ME-Sender: <xms:ENvAYpMrXldHGvM0dO8i52QJN8YYcaZY06l-WELajnKnbCn919kOAg>
    <xme:ENvAYr-7uLv3eGnSMDazQX4gNNmqaiPGVrERu0imsp0fDOIAjgiJJU-NknMuFbS0K
    Q8hCz7k2P1VPqgKNTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:ENvAYoTiyZOiOFruaCHA5BeexZVA4W5n6OmcbYBa9jIQkRjcmUV9Og>
    <xmx:ENvAYlt2C92wv74KLCZrHyv86MZi0f5izT8uciLqTDjSkMnYcszEkw>
    <xmx:ENvAYhfrXqwrq7C_wO_qaJTZEJHyU8u-uozk48wO00TsyHqwaTJCLQ>
    <xmx:EdvAYh1zC3XwnVAtYasP4mdWe9_oqqfH3txS7geBM-whGIJWmjHQjA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 908FE31A0062; Sat,  2 Jul 2022 19:56:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <91ff4c04-ec26-418e-a685-f910505eec5a@www.fastmail.com>
In-Reply-To: <20220701153840.7g55cazg73ukvr7l@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
 <20220629005342.3thjt26e6p6znyrh@black.fi.intel.com>
 <1d765bc0-279c-4fd3-91f4-e99e6aef203c@www.fastmail.com>
 <20220701153840.7g55cazg73ukvr7l@black.fi.intel.com>
Date:   Sat, 02 Jul 2022 16:55:40 -0700
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
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
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



On Fri, Jul 1, 2022, at 8:38 AM, Kirill A. Shutemov wrote:
> On Wed, Jun 29, 2022 at 07:29:13PM -0700, Andy Lutomirski wrote:
>>=20
>>=20
>> On Tue, Jun 28, 2022, at 5:53 PM, Kirill A. Shutemov wrote:
>> > On Tue, Jun 28, 2022 at 04:42:40PM -0700, Andy Lutomirski wrote:
>> >> On 6/10/22 07:35, Kirill A. Shutemov wrote:
>> >>=20
>> >> > +	/* Update CR3 to get LAM active */
>> >> > +	switch_mm(current->mm, current->mm, current);
>> >>=20
>> >> Can you at least justify this oddity?  When changing an LDT, we us=
e a
>> >> dedicated mechanism.  Is there a significant benefit to abusing sw=
itch_mm
>> >> for this?
>> >
>> > I'm not sure I follow. LAM mode is set in CR3. switch_mm() has to h=
andle
>> > it anyway to context switch. Why do you consider it abuse?
>> >
>> >>=20
>> >> Also, why can't we enable LAM on a multithreaded process?  We can =
change an
>> >> LDT, and the code isn't even particularly complicated.
>> >
>> > I reworked this in v4[1] and it allows multithreaded processes. Hav=
e you
>> > got that version?
>> >
>> > Intel had issue with mail server, but I assumed it didn't affect my
>> > patchset since I see it in the archive.
>> >
>>=20
>> I didn=E2=80=99t notice it. Not quite sure what the issue was. Could =
just be
>> incompetence on my part.
>>=20
>> I think that=E2=80=99s the right idea, except that I think you should=
n=E2=80=99t use
>> switch_mm for this. Just update the LAM bits directly.   Once you read
>> mm_cpumask, you should be guaranteed (see next paragraph) that, for e=
ach
>> CPU that isn=E2=80=99t in the set, if it switches to the new mm, it w=
ill notice
>> the new LAM.
>>=20
>> I say =E2=80=9Cshould be=E2=80=9D because I think smp_wmb() is insuff=
icient. You=E2=80=99re
>> ordering a write with a subsequent read, which needs smp_mb().
>
> I think it is better to put smp_mb() to make it explicit.
>
> Does the fixup below look okay?
>
> diff --git a/arch/x86/include/asm/tlbflush.h=20
> b/arch/x86/include/asm/tlbflush.h
> index 2d70d75e207f..8da54e7b6f98 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -367,4 +367,30 @@ static inline void=20
> __native_tlb_flush_global(unsigned long cr4)
>  	native_write_cr4(cr4 ^ X86_CR4_PGE);
>  	native_write_cr4(cr4);
>  }
> +
> +#ifdef CONFIG_X86_64
> +static inline u64 tlbstate_lam_cr3_mask(void)
> +{
> +	u64 lam =3D this_cpu_read(cpu_tlbstate.lam);
> +
> +	return lam << X86_CR3_LAM_U57_BIT;
> +}
> +
> +static inline void set_tlbstate_lam_cr3_mask(u64 mask)
> +{
> +	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
> +}
> +
> +#else
> +
> +static inline u64 tlbstate_lam_cr3_mask(void)
> +{
> +	return 0;
> +}
> +
> +static inline void set_tlbstate_lam_cr3_mask(u64 mask)
> +{
> +}
> +#endif
> +
>  #endif /* _ASM_X86_TLBFLUSH_H */
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64=
.c
> index 427ebef3f64b..cd2b03fe94c4 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -745,15 +745,16 @@ static long prctl_map_vdso(const struct=20
> vdso_image *image, unsigned long addr)
>  static void enable_lam_func(void *mm)
>  {
>  	struct mm_struct *loaded_mm =3D this_cpu_read(cpu_tlbstate.loaded_mm=
);
> +	unsigned long lam_mask;
>=20
>  	if (loaded_mm !=3D mm)
>  		return;
>=20
> -	/* Counterpart of smp_wmb() in prctl_enable_tagged_addr() */
> -	smp_rmb();
> +	lam_mask =3D READ_ONCE(loaded_mm->context.lam_cr3_mask);
>=20
>  	/* Update CR3 to get LAM active on the CPU */
> -	switch_mm(loaded_mm, loaded_mm, current);
> +	write_cr3(__read_cr3() | lam_mask);

Perhaps this should also mask off the old LAM mask?

> +	set_tlbstate_lam_cr3_mask(lam_mask);
>  }
>=20
>  static bool lam_u48_allowed(void)
> @@ -805,7 +806,7 @@ static int prctl_enable_tagged_addr(struct=20
> mm_struct *mm, unsigned long nr_bits)
>  	}
>=20
>  	/* Make lam_cr3_mask and untag_mask visible on other CPUs */
> -	smp_wmb();
> +	smp_mb();
>=20
>  	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
>  out:
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index c5c4f76329c2..d9a2acdae90f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -486,31 +486,6 @@ void cr4_update_pce(void *ignored)
>  static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
>  #endif
>=20
> -#ifdef CONFIG_X86_64
> -static inline u64 tlbstate_lam_cr3_mask(void)
> -{
> -	u64 lam =3D this_cpu_read(cpu_tlbstate.lam);
> -
> -	return lam << X86_CR3_LAM_U57_BIT;
> -}
> -
> -static inline void set_tlbstate_lam_cr3_mask(u64 mask)
> -{
> -	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
> -}
> -
> -#else
> -
> -static inline u64 tlbstate_lam_cr3_mask(void)
> -{
> -	return 0;
> -}
> -
> -static inline void set_tlbstate_lam_cr3_mask(u64 mask)
> -{
> -}
> -#endif
> -
>  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *nex=
t,
>  			struct task_struct *tsk)
>  {
> @@ -581,7 +556,7 @@ void switch_mm_irqs_off(struct mm_struct *prev,=20
> struct mm_struct *next,
>  	 * provides that full memory barrier and core serializing
>  	 * instruction.
>  	 */
> -	if (real_prev =3D=3D next && prev_lam =3D=3D new_lam) {
> +	if (real_prev =3D=3D next) {
>  		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=3D
>  			   next->context.ctx_id);
>=20
> --=20
>  Kirill A. Shutemov

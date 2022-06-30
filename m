Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9821B560F35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiF3C3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiF3C3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:29:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAA4286EE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC221B827D8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10558C3411E;
        Thu, 30 Jun 2022 02:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656556177;
        bh=7tLDaGhHMNkOqcurFcWid92UvaCBwbWDvCnr7w5tqYQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=rF6Ur1V5P/smmTAbxRB+m+fuPXnRtOnRbl/r8LSaIX6O0xYN/Wvn20kbY1E47hdci
         71qhHfN6WqNakH3+td9FRHczYZTGA9LsCyJAIvaOmkimkCwzfvjFBe1BU67+JaGk+J
         IACPpMC9mQfrg3UCm2tKXwR0KvW6sgkSimZgKEHu6yQ+I0QZMssuEH9D+KjKA0Kmue
         9Ww6FjYaWWgkyjPG5CjymtZx3ctMpcVsdPx1gORoeIaarkdQTI12tdzQJcXXD4Sllb
         +JNPuTnZsUhjbJyLkzZyAzhkk8/4nVoitosIT0S0GbqJpkaWUtygRrUpjHVPA5g5sb
         VZ2l7vJ3VXgRQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E63D127C0054;
        Wed, 29 Jun 2022 22:29:35 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 22:29:35 -0400
X-ME-Sender: <xms:jwq9YiSXyD3UdhlO-YaretllbogkJjxZ07N5tN5XBm9u7F6HH1g43Q>
    <xme:jwq9YnzOWFsfUerQUFGu-ZKAKm_owdMxaEaI2_EkGAjN6jwFej_x4Oq0-hpWXyH7u
    iOwNaAr-h2zqBMrPjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeiteejleegjeekleegveeujeejvdehjeekveegudduudffueek
    jefffeeujeekhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:jwq9Yv2qA4jhv_o5C-z5PA1k5metluFuWG2seOt4XsEJXm3CWZfrhA>
    <xmx:jwq9YuCHToF7Uu4b1H8gQ0m9tsNaTIUS49YJpquoPisAXmRqReHeww>
    <xmx:jwq9YrjeRltJbUjIjOwrbsK2VglTKWnLNttgWxtnV2gMQXD8Cal_hA>
    <xmx:jwq9YupRHMTtXQQ688Q-1GBU8FSs9d9-GNz6RP2te2G3O67Io0qndQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 389CD31A0062; Wed, 29 Jun 2022 22:29:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <1d765bc0-279c-4fd3-91f4-e99e6aef203c@www.fastmail.com>
In-Reply-To: <20220629005342.3thjt26e6p6znyrh@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
 <20220629005342.3thjt26e6p6znyrh@black.fi.intel.com>
Date:   Wed, 29 Jun 2022 19:29:13 -0700
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



On Tue, Jun 28, 2022, at 5:53 PM, Kirill A. Shutemov wrote:
> On Tue, Jun 28, 2022 at 04:42:40PM -0700, Andy Lutomirski wrote:
>> On 6/10/22 07:35, Kirill A. Shutemov wrote:
>>=20
>> > +	/* Update CR3 to get LAM active */
>> > +	switch_mm(current->mm, current->mm, current);
>>=20
>> Can you at least justify this oddity?  When changing an LDT, we use a
>> dedicated mechanism.  Is there a significant benefit to abusing switc=
h_mm
>> for this?
>
> I'm not sure I follow. LAM mode is set in CR3. switch_mm() has to hand=
le
> it anyway to context switch. Why do you consider it abuse?
>
>>=20
>> Also, why can't we enable LAM on a multithreaded process?  We can cha=
nge an
>> LDT, and the code isn't even particularly complicated.
>
> I reworked this in v4[1] and it allows multithreaded processes. Have y=
ou
> got that version?
>
> Intel had issue with mail server, but I assumed it didn't affect my
> patchset since I see it in the archive.
>

I didn=E2=80=99t notice it. Not quite sure what the issue was. Could jus=
t be incompetence on my part.

I think that=E2=80=99s the right idea, except that I think you shouldn=E2=
=80=99t use switch_mm for this. Just update the LAM bits directly.   Onc=
e you read mm_cpumask, you should be guaranteed (see next paragraph) tha=
t, for each CPU that isn=E2=80=99t in the set, if it switches to the new=
 mm, it will notice the new LAM.

I say =E2=80=9Cshould be=E2=80=9D because I think smp_wmb() is insuffici=
ent. You=E2=80=99re ordering a write with a subsequent read, which needs=
 smp_mb().

> [1]=20
> https://lore.kernel.org/all/20220622162230.83474-1-kirill.shutemov@lin=
ux.intel.com/
>
> --=20
>  Kirill A. Shutemov

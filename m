Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04573547C23
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiFLVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFLVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB64C7A4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EADC060F0B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6848C3411C;
        Sun, 12 Jun 2022 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655067846;
        bh=aYXiIBYKvoFj5z94fquzqeoEWIZqOnibRde30CWTxP4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=GPjhlV70l5vBYnlKCrhK3eRHlAmchzSOeHrT48cyliYhfqhl85PEQl2ozJ2uwdjXU
         bnDhG2Tjog3ANCw2W8SP6kgHiivwIht4TU+bDLpqN2m9iNAQ31/oGv24IVkuQJLGoj
         mKPHMKogD4++HD8WXC591dJmngLX7liLRhIIYW4X/bPNG62q6RkmFyHNel8UdCwmvX
         qfLUoyIO/zFfPjeyXaIqFqUBhrjZgJB2qs9XP57gJdYLbM94KkR0SbQEHF9Way3Wbo
         EvVTHrft1VLP/lH81RQUzdOQST1e5Zy+Z5ksk9yTX1NiMUItvHeLy8LITU90utzsNC
         A5lM1qi4jn5Ew==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 94ABB27C0054;
        Sun, 12 Jun 2022 17:04:04 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sun, 12 Jun 2022 17:04:04 -0400
X-ME-Sender: <xms:w1SmYrSwyTmjaeMAjOMYcUsD1qEzhKGWQ9koZ_78iFnSPfFJbkjqig>
    <xme:w1SmYswQiBUrKCswQt94T4KVnMNsXzAEEjWpFW8Zrg54EhuQMnli1xC0ize9v5ksB
    bfTk_Tm055uJ0tPIEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduhedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:w1SmYg3HdsWBX8ft_9NdouN1_p560XSACJyHo2W5YV8LstuY2VrEYQ>
    <xmx:w1SmYrDaR9U5dhYBbt7iyAIJJPetGNaUgM2LX1fsFywS-VOX4VvpcA>
    <xmx:w1SmYkgBltREtKXJTR4Hxqh1qYd2O4QVqGhKYsIXehrm4zj3hBPPBg>
    <xmx:xFSmYjrdz-6iR0JH3-Ltp4ihANqXg9tJJUVqzWubJ0XnFRLUbMUNwQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E136331A0062; Sun, 12 Jun 2022 17:04:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-692-gb287c361f5-fm-20220603.003-gb287c361
Mime-Version: 1.0
Message-Id: <5d3b281f-3d8b-4bbd-9681-b226810c3e8b@www.fastmail.com>
In-Reply-To: <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
 <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
 <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
 <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
Date:   Sun, 12 Jun 2022 14:03:43 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022, at 3:18 PM, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 11:08 -0700, Edgecombe, Richard P wrote:
>> On Fri, 2022-06-10 at 21:06 +0300, Kirill A. Shutemov wrote:
>> > On Fri, Jun 10, 2022 at 04:16:01PM +0000, Edgecombe, Rick P wrote:
>> > > On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
>> > > > +static int prctl_enable_tagged_addr(unsigned long nr_bits)
>> > > > +{
>> > > > +       struct mm_struct *mm = current->mm;
>> > > > +
>> > > > +       /* Already enabled? */
>> > > > +       if (mm->context.lam_cr3_mask)
>> > > > +               return -EBUSY;
>> > > > +
>> > > > +       /* LAM has to be enabled before spawning threads */
>> > > > +       if (get_nr_threads(current) > 1)
>> > > > +               return -EBUSY;
>> > > 
>> > > Does this work for vfork()? I guess the idea is that locking is
>> > > not
>> > > needed below because there is only one thread with the MM, but
>> > > with
>> > > vfork() another task could operate on the MM, call fork(), etc.
>> > > I'm
>> > > not
>> > > sure...
>> > 
>> > I'm not sure I follow. vfork() blocks parent process until child
>> > exit
>> > or
>> > execve(). I don't see how it is a problem.
>> 
>> Oh yea, you're right.
>
> Actually, I guess vfork() only suspends the calling thread. So what if
> you had:
> 1. Parent spawns a bunch of threads
> 2. vforks()
> 3. Child enables LAM (it only has one thread, so succeeds)
> 4. Child exits()
> 5. Parent has some threads with LAM, and some not
>
> It's some weird userspace that doesn't deserve to have things work for
> it, but I wonder if it could open up little races around untagging. As
> an example, KVM might have a super narrow race where it checks for tags
> in memslots using addr != untagged_addr(addr) before checking
> access_ok(addr, ...). See __kvm_set_memory_region(). If mm-
>>context.untag_mask got set in the middle, tagged memslots could be
> added.

get_nr_threads() is the wrong thing.  Either look at mm->mm_users or find a way to get rid of this restriction entirely.

IMO it would not be insane to have a way to iterate over all tasks using an mm.  But doing this for io_uring, etc might be interesting.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C075AD6AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiIEPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiIEPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:35:28 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB22F005
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:35:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 941AF3200939;
        Mon,  5 Sep 2022 11:35:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Sep 2022 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662392121; x=1662478521; bh=TM
        ae4UrAehFIdNxLvvM/JWw7tJKL6ziDhN9OKwFTLro=; b=jb3b5uDOnBZid2q+gv
        UGQi4iFnUXvQ83BSf2ZaVDPdwHOB0GMOqugRzLSMKPoG+96oWjYeD8OJm37GH6z8
        jk8Cj/PL1vuR4MOdZWDdO8eRhi4IRrUKLCQ2AmspiBdw1yUOb/fQCCh+aUbMr+lR
        a+mO+AtXnSu/h++cMIohjMVY2RLx1ZVqT5tcF8+MfzmrnVoHw+bkvGHbc2/VB59X
        E3Y8LckWgfYysN70/pzgyDaiT0rlvmDYyNrLUjkbMY+wig/Jxb5Sa9IXDK2zqFyu
        q6X0PWVLG8yydmT/wdHGU7vl9vgas8iVa/pZVODqsGW/3k8hYSrUwyOo9vNjwouu
        Vn6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662392121; x=1662478521; bh=TMae4UrAehFIdNxLvvM/JWw7tJKL
        6ziDhN9OKwFTLro=; b=yStOOqdXgkt/Whf2Q6KslPMVEHSN/1Cy5u7Ze3zbmBBt
        DrxHZJkTLXwTlublFZMAkI4YT/kvWUd7azFtBT8i/qA0RZERd8/eQKOQJuGCXI/h
        EqYalWg2mSKc1HODh/ErbavaduRgieOvOgeMNr9kuQbCv18o/wttqy3/staW+nMq
        E7rbRUeIdCuUyu+iL8S49gsSx4QcOffzEndEPzoxc57eQX9vQbtP5esJ4t6rAflW
        PcViMaJXghBcHlu75gWYC2kciVLmII60VXWjbogggBzUYhsl3SW8RdQgtcQuBt9u
        zL2Um0URwtWKm59mG5PwVEnPG/7t2nFztcnFnNyKzQ==
X-ME-Sender: <xms:OBcWY4gcJlsIwGYmJ7OLyJ0hiwupsewzL5YwmqzPnpRtE5b0GZNxfQ>
    <xme:OBcWYxByMpJ__AAibslBurT5etUQSSG8M-GlmVMRWp4U0e_NUZWVlQH0OPUonI1mb
    keaYmg1DEe41VcBpqQ>
X-ME-Received: <xmr:OBcWYwFJFZCv2CRFGC6WhfpJmLjoBimiGO6tUh0NEoRvkHjGcZlYRSOP_DBcAKLAvTpUdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:OBcWY5RnduiMdaKUzhjOxY-W4O2pcOC5TAkRawUK9azToxhIf_p7jg>
    <xmx:OBcWY1zWLGz5cq70FVVxd4EM7Zn3BRkKtJT9j-_fp6XOpqfNGCQtpw>
    <xmx:OBcWY36JZD3Vqqm8zHOBEI19TzsbsdyY7NB9U8gjzC2RrsKCF-pN2g>
    <xmx:ORcWYyguSJD9C9pqZpu4Pq80nhZDznCcmRzKgD-I5R1B7QfCSXAGwA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 11:35:20 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DC94B1040BF; Mon,  5 Sep 2022 18:35:17 +0300 (+03)
Date:   Mon, 5 Sep 2022 18:35:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bharata B Rao <bharata@amd.com>, ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220905153517.k6ctaqqtkcyu2zmn@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
 <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
 <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
 <YxYIAVx2qJLMDJlC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYIAVx2qJLMDJlC@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:30:25PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 05, 2022 at 04:44:57PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Sep 05, 2022 at 10:35:44AM +0530, Bharata B Rao wrote:
> > > Hi Kirill,
> > > 
> > > On 9/4/2022 6:30 AM, Kirill A. Shutemov wrote:
> > > > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> > > >> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > >> 64-bit linear addresses, allowing software to use of the untranslated
> > > >> address bits for metadata.
> > > >>
> > > >> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> > > >> this time.
> > > >>
> > > >> Please review and consider applying.
> > > >>
> > > >> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
> > > > 
> > > > +Bharata, Ananth.
> > > > 
> > > > Do you folks have any feedback on the patchset?
> > > > 
> > > > Looks like AMD version of the tagged pointers feature does not get
> > > > traction as of now, but I want to be sure that the interface introduced
> > > > here can be suitable for your future plans.
> > > > 
> > > > Do you see anything in the interface that can prevent it to be extended to
> > > > the AMD feature?
> > > 
> > > The arch_prctl() extensions is generic enough that it should be good.
> > > 
> > > The untagged_addr() macro looks like this from one of the callers:
> > > 
> > >         start = untagged_addr(mm, start);
> > > ffffffff814d39bb:       48 8b 8d 40 ff ff ff    mov    -0xc0(%rbp),%rcx
> > > ffffffff814d39c2:       48 89 f2                mov    %rsi,%rdx
> > > ffffffff814d39c5:       48 c1 fa 3f             sar    $0x3f,%rdx
> > > ffffffff814d39c9:       48 0b 91 50 03 00 00    or     0x350(%rcx),%rdx
> > > ffffffff814d39d0:       48 21 f2                and    %rsi,%rdx
> > > ffffffff814d39d3:       49 89 d6                mov    %rdx,%r14
> > > 
> > > Can this overhead of a few additional instructions be removed for
> > > platforms that don't have LAM feature? I haven't measured how much
> > > overhead this effectively contributes to in real, but wonder if it is
> > > worth optimizing for non-LAM platforms.
> > 
> > I'm not sure how the optimization should look like. I guess we can stick
> > static_cpu_has() there, but I'm not convinced that adding jumps there will
> > be beneficial.
> 
> I suppose the critical bit is the memory load. That can stall and then
> you're sad. A jump_label is easy enough to add.

What about something like this?

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 803241dfc473..868d2730884b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -30,8 +30,10 @@ static inline bool pagefault_disabled(void);
  */
 #define untagged_addr(mm, addr)	({					\
 	u64 __addr = (__force u64)(addr);				\
-	s64 sign = (s64)__addr >> 63;					\
-	__addr &= (mm)->context.untag_mask | sign;			\
+	if (static_cpu_has(X86_FEATURE_LAM)) {				\
+		s64 sign = (s64)__addr >> 63;				\
+		__addr &= (mm)->context.untag_mask | sign;		\
+	}								\
 	(__force __typeof__(addr))__addr;				\
 })
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

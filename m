Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3384EFA7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349452AbiDATnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiDATnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573461D1936
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E582E61720
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 19:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29F3C340EC;
        Fri,  1 Apr 2022 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648842092;
        bh=/Y8/OhXYBEbqn8OGJCyAUnOAQ6cUj7tjx72r1WjnUtU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=C3lWKOp89sC4JSn0gJXCcVN3ynzqLuzDSn3cQ0vm3jR2hQSMz9gWfjFcTCtC/BLSl
         ez5hkKK2MAT6zyFiUOuGKzHzyPiXmHlS7dtSV9VZ45bUbTjyxgIDSYzcG1QdJQ1tdQ
         ckTph4jrL0mTbPNp+z8K+5NYehN3MuzMYv2veDnDKwXtZJwPAS3RX2cBCYpJ33192X
         G34DV6ddfimMLM3eCbEJq/YXTlcQEyyBcV9c+RCkXrpkPdy93q8wDii9l/6MEMkL0i
         UCBselLIVbIccn28g8hOoKjUGgXKQ07i6ua8Ea6PpaEOQSe40gBqaWP3ahd/uCW0gC
         UYO1myyuM+V+A==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6696F27C0054;
        Fri,  1 Apr 2022 15:41:30 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Fri, 01 Apr 2022 15:41:30 -0400
X-ME-Sender: <xms:aVVHYqbnLFI5bld4s1TdTmBeYmYatVCnao3OAiuVND6tAPP89unBDw>
    <xme:aVVHYtbhOx5hs-8wrrFZqyB3t2hwBk7deN8tJ_WqZW3T21eLrurglMb2V5iqvWC4w
    G4l9PAfKyKTwYs8Pts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfelhfdugeetvdfhfeeuveevtdegueekhfffheetffdtleevtdeh
    tdeivdeuvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:aVVHYk_EDWmq_lV6GjI7a8RBxoSoSy7vknqdSVacpe0M-B2Zbo7hoQ>
    <xmx:aVVHYsr78th0E8vI-6FVzidgyqbU5Xi1mpkV1LOX0PMqxZhZfZnVlw>
    <xmx:aVVHYlp1KDQbRtwJdOwM_Fz1yVXix6WupoXl0VNzCN1iJw4JthOOFQ>
    <xmx:alVHYmSzKFBEWS7nyf0oTNlfMm0hoDTZZiIspLEy1u4cQCxKUdThaQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3AFB921E006E; Fri,  1 Apr 2022 15:41:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <57a435ac-1ae3-49a0-bacf-307dc1a9349d@www.fastmail.com>
In-Reply-To: <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
 <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
Date:   Fri, 01 Apr 2022 12:41:07 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Bharata B Rao" <bharata@amd.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, shuah@kernel.org,
        "Oleg Nesterov" <oleg@redhat.com>, ananth.narayan@amd.com
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Mar 23, 2022, at 12:48 AM, Bharata B Rao wrote:
> On 3/22/2022 3:59 AM, Andy Lutomirski wrote:
>> On Thu, Mar 10, 2022, at 3:15 AM, Bharata B Rao wrote:
>>> Hi,
>>>
>>> This patchset makes use of Upper Address Ignore (UAI) feature available
>>> on upcoming AMD processors to provide user address tagging support for x86/AMD.
>>>
>>> UAI allows software to store a tag in the upper 7 bits of a logical
>>> address [63:57]. When enabled, the processor will suppress the
>>> traditional canonical address checks on the addresses. More information
>>> about UAI can be found in section 5.10 of 'AMD64 Architecture
>>> Programmer's Manual, Vol 2: System Programming' which is available from
>>>
>>> https://bugzilla.kernel.org/attachment.cgi?id=300549
>> 
>> I hate to be a pain, but I'm really not convinced that this feature is suitable for Linux.  There are a few reasons:
>> 
>> Right now, the concept that the high bit of an address determines whether it's a user or a kernel address is fairly fundamental to the x86_64 (and x86_32!) code.  It may not be strictly necessary to preserve this, but violating it would require substantial thought.  With UAI enabled, kernel and user addresses are, functionally, interleaved.  This makes things like access_ok checks, and more generally anything that operates on a range of addresses, behave potentially quite differently.  A lot of auditing of existing code would be needed to make it safe.
>
> Ok got that. However can you point to me a few instances in the current
> kernel code where such assumption of high bit being user/kernel address
> differentiator exists so that I get some idea of what it takes to
> audit all such cases?

Anything that thinks that an address >= some value means kernel.

>
> Also wouldn't the problem of high bit be solved by using only the
> 6 out of 7 available bits in UAI and leaving the 63rd bit alone?
> The hardware will still ignore the top bit, but this should take
> care of the requirement of high bit being 0/1 for user/kernel in the
> x86_64 kernel. Wouldn't that work?

Maybe, but that seems quite ugly.  This will make the userspace and kernel semantics diverge.

>
>> 
>> UAI looks like it wasn't intended to be context switched and, indeed, your series doesn't context switch it.  As far as I'm concerned, this is an error, and if we support UAI at all, we should context switch it.  Yes, this will be slow, perhaps painfully slow.  AMD knows how to fix it by, for example, reading the Intel SDM.  By *not* context switching UAI, we force it on for all user code, including unsuspecting user code, as well as for kernel code.  Do we actually want it on for kernel code?  With LAM, in contrast, the semantics for kernel pointers vs user pointers actually make sense and can be set per mm, which will make things like io_uring (in theory) do the right thing.
>
> I plan to enable/disable UAI based on the next task's settings by
> doing MSR write to EFER during context switch. I will have to measure
> how much additional cost an MSR write in context switch path brings in.
> However given that without a hardware feature like ARM64 MTE, this would
> primarily be used in non-production environments. Hence I wonder if MSR
> write cost could be tolerated?

I'm not sure what you mean by a feature like ARM64 MTE.

>
> Regarding enabling UAI for kernel, I will have to check how clean and
> efficient it would be to disable/enable UAI on user/kernel entry/exit
> points.
>
>> 
>> UAI and LAM are incompatible from a userspace perspective.  Since LAM is pretty clearly superior [0], it seems like a better long term outcome would be for programs that want tag bits to target LAM and for AMD to support LAM if there is demand.  For that matter, do we actually expect any userspace to want to support UAI?  (Are there existing too-clever sandboxes that would be broken by enabling UAI?)
>> 
>> Given that UAI is not efficiently context switched, the implementation of uaccess is rather bizarre.  With the implementation in this series in particular, if the access_ok checks ever get out of sync with actual user access, a user access could be emitted with the high bits not masked despite the range check succeeding due to masking, which would, unless great care is taken, result in a "user" access hitting the kernel range.  That's no good.
>
> Okay, I guess if context switching and sticking to 6 bits as mentioned
> earlier is feasible, this concern too goes away unless I am missing something.

I think it does go away.

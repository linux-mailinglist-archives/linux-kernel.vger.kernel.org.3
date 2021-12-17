Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912624781D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhLQA4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231376AbhLQA4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639702609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6KKTzHigCV5bTIA4kNvrEj8YHg+yLJsqr64wtL6ZoE=;
        b=Fl+r66mZ88tGMIE2mNlVvZudQ47WQ0nvcX0EkEzAa7v4u90AqBvDFJAYa05QmyFN/JE0wS
        FI83JffMgUkhODxOEVRaeb1ndHZeE02lcyAwDDQv/1B8zecOxUPgzXh95ekG39XrMlGrsT
        Gh5Cul8OpO0l21p+ddJHXaARMq1Wc6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-5ej4aGHFMQ-BU4AzCdnolg-1; Thu, 16 Dec 2021 19:56:45 -0500
X-MC-Unique: 5ej4aGHFMQ-BU4AzCdnolg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85AE41006AA3;
        Fri, 17 Dec 2021 00:56:42 +0000 (UTC)
Received: from localhost (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E716ABAF;
        Fri, 17 Dec 2021 00:56:37 +0000 (UTC)
Date:   Fri, 17 Dec 2021 08:56:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, tglx@linutronix.de,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com
Subject: Re: [PATCH] x86/purgatory: provide config to disable purgatory
Message-ID: <20211217005635.GA29161@MiWiFi-R3L-srv>
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
 <YZ0HkaOiKfmgN8zl@zn.tnic>
 <YaTd4ZID7O+bVRXT@redhat.com>
 <79517d3c-3674-cc21-fbdc-b26946809756@bytedance.com>
 <87o862c396.fsf@email.froward.int.ebiederm.org>
 <433e69ec-3079-b905-b07f-b9c7a910be4f@bytedance.com>
 <33d9b711-288c-e5f4-0cc8-365c01861da5@bytedance.com>
 <c74fa6ef-1b55-1f60-39c5-4b26efbabddc@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c74fa6ef-1b55-1f60-39c5-4b26efbabddc@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 at 06:05pm, Usama Arif wrote:
> Hi,
> 
> Just wanted to check again if there were any comments on my responses below
> or the v3 of the patch at https://lore.kernel.org/lkml/20211206164724.2125489-1-usama.arif@bytedance.com/.

I will have a look. Could you please CC kexec mailing list too next time
when kexec/kdump related patch posted so that more people can help review
if concerned or interested?

I usually don't switch to lkml mail folder unless have to, since it
contains too many mails and take longer time.

> 
> Thanks!
> Usama
> 
> On 06/12/2021 16:51, Usama Arif wrote:
> > Hi,
> > 
> > I have sent a v3 of the patch with a much clearer commit message, please
> > let me know if there are any comments for the v3 patch or my responses
> > below.
> > 
> > Thanks,
> > Usama
> > 
> > On 01/12/2021 10:29, Usama Arif wrote:
> > > Hi,
> > > 
> > > (Resending the reply as my email client had updated and inserted
> > > html code and caused a bounceback from the mailing list, sorry about
> > > that.)
> > > 
> > > Thanks for your reply, I have responded with further
> > > comments/questions inline below, and also have provided some context
> > > for the patch at the start:
> > > 
> > > The patch is not introducing a new CONFIG option, as can be seen in
> > > the v2 patch diff. It is converting an existing CONFIG option that
> > > only enabled purgatory for specific architectures in which it has
> > > been implemented (x86, powerpc and s390) to an option that can that
> > > allow purgatory to be disabled (with default enabled) and only
> > > provides code to disable purgatory for x86 only. From what i see,
> > > purgatory is currently not yet implemented in other architectures
> > > like arm64 kexec_file case and riscv, so this would on a high level,
> > > provide only the option to make kexec on x86 similar to other the
> > > other architectures.
> > > 
> > > As a background to the discussion, the usecase we are aiming is to
> > > update the host kernel with kexec in servers which is managing
> > > multiple VMs, to cut down the downtime of servers as much as
> > > possible so that its not noticeable to VMs. The patch is aimed at
> > > x86 purgatory code specifically. We are targetting other
> > > optimizations as well in other areas in boot path to cut down the
> > > 600ms time much further, so that cut down of 200ms downtime is
> > > significant in the usecase described. I did have a few
> > > comments/questions about your reply, please see my responses below:
> > > 
> > > 
> > > On 29/11/2021 16:53, Eric W. Biederman wrote:
> > > > Usama Arif <usama.arif@bytedance.com> writes:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > Thanks for your replies. I have submitted a v2 of the patch with a
> > > > > much more detailed commit message including reason for the
> > > > > patch and timing values.
> > > > > 
> > > > > The time taken from reboot to running init process was measured
> > > > > with both purgatory enabled and disabled over 20 runs and the
> > > > > averages are:
> > > > > Purgatory disabled:
> > > > > - TSC = 3908766161 cycles
> > > > > - ktime = 606.8 ms
> > > > > Purgatory enabled:
> > > > > - TSC = 5005811885 cycles (28.1% worse)
> > > > > - ktime = 843.1 ms (38.9% worse)
> > > > > 
> > > > > 
> > > > > Our reason for this patch is that it helps reduce the
> > > > > downtime of servers when
> > > > > the host kernel managing multiple VMs needs to be updated via kexec,
> > > > > but it makes reboot with kexec much faster so should be a
> > > > > general improvement in
> > > > > boot time if purgatory is not needed and could have other
> > > > > usecases as well.
> > > > > I believe only x86, powerpc and s390 have purgatory
> > > > > supported, other platforms
> > > > > like arm64 dont have it implemented yet, so with the reboot
> > > > > time improvement seen,
> > > > > it would be a good idea to have the option to disable
> > > > > purgatory completely but set default to y.
> > > > > We also have the CONFIG_KEXEC_BZIMAGE_VERIFY_SIG which can
> > > > > be enabled to verify the next
> > > > > kernel image to be booted and purgatory can be completely skipped if
> > > > > not required.
> > > > 
> > > > CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is something totally and completely
> > > > different.  It's job is to verify that the kernel to be booted comes
> > > > from a trusted source.   The sha256 verification in purgatory's job
> > > > is to verify that memory the kernel cares about was not corrupted
> > > > during the kexec process.
> > > > 
> > > 
> > > Thanks, acknowledged.
> > > 
> > > > I believe when you say purgatory you are really talking about that
> > > > sha256 checksum.  It really is not possible to disable all of
> > > > the code that runs between kernels, as the old and the new kernel may
> > > > run at the same addresses.  Anything that runs between the two kernels
> > > > is what is referred to as purgatory.  Even if it is just a small
> > > > assembly stub.
> > > > 
> > >  >
> > > 
> > > With this patch, i am trying to give an option (with default
> > > purgatory enabled)to disable purgatory completely on x86 only, i.e.
> > > no code running between 2 kernels on x86. From my understanding
> > > there is no purgatory in arm64 kexec_file case, in riscv and in some
> > > other archs as well, so I am not sure why its not possible to
> > > disable purgatory (all code running between 2 kernels) in x86?
> > > Unless i misunderstood something about the working of other
> > > platforms? In x86 case, from what i see relocate_kernel is still
> > > part of the older kernel and not purgatory, and with my patch,
> > > purgatory.ro is not built and kexec does execute successfully with
> > > purgatory disabled.
> > > 
> > > About your point for the old and the new kernel may run at the same
> > > addresses,i dont think that can happen as in bzImage64_load function
> > > its loaded using the kbuf struct. This doesnt happen in other
> > > architectures (for e.g. arm64) that dont implement purgatory and any
> > > of the tests I conducted with the patch applied due to the use of
> > > kbuf struct.
> > > 
> > >  From what i see in the code, purgatory in x86 specifically, has 2
> > > main functions, sha256 verification and loading the %rsi register
> > > for bootparam_load_addr. In this patch purgatory was disabled, which
> > > resulted in sha256 verification disabled and bootparam_load_addr
> > > moved to relocate_kernel. Our analysis revealed that most of the
> > > time is spent in the sha256 verification, so I would be ok to
> > > reformat the patch
> > > to make the sha verification optional and keep purgatory enabled if
> > > thats preferred? Although in my opinion the current patch of only
> > > providing an option to disable purgatory seems much better.
> > > 
> > > 
> > > > That sha256 verification is always needed for kexec on panic, there are
> > > > by the nature of a kernel panic too many unknowns to have any confidence
> > > > the new kernel will not be corrupted in the process of kexec before it
> > > > gets started.
> > > > 
> > > > For an ordinary kexec it might be possible to say that you have a
> > > > reliable kernel shutdown process and you know for a fact that something
> > > > won't come along and corrupt the kernel.  I find that a questionable
> > > > assertion.  I haven't seen anyone yet whose focus when getting an
> > > > ordinary kexec to work as anything other than making certain all of the
> > > > drivers are shutdown properly.
> > > > 
> > > > I have seen countless times when a network packet comes in a the wrong
> > > > time and the target kernel's memory is corrupted before it gets far
> > > > enough to initialize the network driver. >
> > > 
> > > I agree that when doing testing and research, there are things that can
> > > go wrong during kexec process, but i assume that the expectation is that
> > > in production environment, when for e.g. updating a kernel with
> > > kexec in servers,the expectation is that kexec will execute
> > > successfully as long as there is nothing wrong in the old kernel and
> > > the new kernel.
> > > 
> > > Maybe I didn't understand this correctly, but if a network packet
> > > comes in and corrupts the kernel memory, wont it also cause a
> > > problem even when purgatory is enabled? I agree that issue like
> > > these would be caught earlier with purgatory, but then if something
> > > like this breaks the kexec process in a production environment where
> > > the old and new kernel are well tested, trusted and expected to
> > > work, wouldn't there be a much more fundamental issue with the
> > > reliability of the current kexec process.
> > > 
> > > > For a 0.2s speed up you are talking about disabling all of the safety
> > > > checks in a very dangerous situation.  How much can you can in
> > > > performance by optimizing the sha256 implementation instead of using
> > > > what is essentially a reference implementation in basic C that I copied
> > > > from somewhere long ago.
> > > > 
> > > > Optimize the sha256 implementation and the memory copy loop and then
> > > > show how the tiny bit of time that is left is on a mission critical path
> > > > and must be removed.  Then we can reasonably talk about a config option
> > > > for disabling the sha256 implementation in the kexec in not-panic case.
> > > > 
> > > Thanks for this, I assume that over here you are suggesting for e.g.
> > > in x86 to replace the existing sha verification implementation in
> > > purgatory with the one in arch/x86/crypto/sha256_ssse3_glue.c? Also
> > > could you point to the memory copy loop to optimize? I can have a
> > > look at these 2 options.
> > > 
> > > Even with these optimizations, i think the v2 patch should still be
> > > considered. The patch in the end is providing only an option to
> > > disable purgatory on x86 only, with the default value of keeping it
> > > enabled and not changing kexec behaviour. The CONFIG already
> > > existed, it is just renamed and now provides user the option to
> > > select to disable purgatory for x86, rather than it being
> > > architecture dependent.
> > > 
> > > Thanks again for the review and comments,
> > > Usama
> > > 
> > > 
> > > > That sha256 implementation in part so that we can all sleep at night
> > > > because we don't have to deal with very very strange heizenbugs.
> > > > 
> > > > Eric
> > > > 
> 


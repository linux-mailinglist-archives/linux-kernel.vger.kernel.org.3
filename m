Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2176F49676C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiAUVkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAUVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:40:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63EC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:40:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so44882344edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XzEYKOvGUCpJX1XC7Y0iE2kDUqIGFs9tTF2AQ87lvo=;
        b=1FHUwnsgGA6Odi7wwfQc5WTlGMrmy+53Pg9yOCxP/YPWosvijOtSsQksoXSMP80AN6
         zx7Sw2lu5mFVfkt9M4kv+9JfLb6cW1w8/qmu7AhBlpwYbQJR9WHKAodsaqYSUeCe2Hwn
         g7M3fvX0NEzhtiSsbTOeeU+Xr0frSH1XRWjYsrx/W18xY0sfmY3JC6o91EGUkqUwGRPh
         mqmEeJT4iUviFmC0wGbwh5lGxeZhFvb8InCG8tmpcxOqSrvQrcMuQORxFV+XztoLiyBe
         odv5PPEvge6mxsVn8eDdZRbCARMKAzxxKCu2DoWhaR56lHqLUwgqfQnPxbsnfUDxq7Z9
         mSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XzEYKOvGUCpJX1XC7Y0iE2kDUqIGFs9tTF2AQ87lvo=;
        b=eUIB9rD3OLxTJIjn2FB9CjAe2W+5RxD+4cokUMa0LJOBHIxcWg+hUbOOVZqBj9XRRm
         vCIMe4S6ud6qXC9PeYr+DWXd3jctA3g9UKUkg0lCsOd1qp94Z9u+MLOW2uaNF7cNrgQl
         kr8xeLTPmFDIJtGVA9w05yLtwzpnej1CAWpmFZC1Wl33x9aPVC/VAVereO0wZS2zUlui
         8ORKjHsCp8+NnyxMwQlCl5vfnxkCdMO3uxKSZlkmBVQhij6JFeHJz0nUmwC7KQA5STDb
         GthMjBjl0K8XWhvIVNpToMJL/UZCTc6LgLPhSX0an13D1iYRKw47utGj8F9vL2PG08GE
         J/gA==
X-Gm-Message-State: AOAM532CHq23C8WzOAuW0FBTeL/CqtJt+0OEF8oaiCyMSqAQDW7s978+
        byFwcl/MnN2nmgTdr6xXuQDy6nGnqn7pggeROwZS
X-Google-Smtp-Source: ABdhPJyQLJtPj7Mu2Mv0ZwC2SSr2Iox19K/oxdj+523DvOIjsMyu/b4DP8NVvcO9V+LRwi9GrtbhSc7hL9jqXgNDk14=
X-Received: by 2002:aa7:d407:: with SMTP id z7mr5819912edq.331.1642801202509;
 Fri, 21 Jan 2022 13:40:02 -0800 (PST)
MIME-Version: 1.0
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
 <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com> <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
In-Reply-To: <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jan 2022 16:39:51 -0500
Message-ID: <CAHC9VhThAbwuy+wXZfeMorc0QZ19FOfh0rk7uqaOj7uHvruM0Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        trenchboot-devel@googlegroups.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:56 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 2, 2021 at 11:11 AM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
> > Hi Paul!
>
> /me waves
>
> > On 11/30/21 8:06 PM, Paul Moore wrote:
> > > On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
> > > <ross.philipson@oracle.com> wrote:
> > >>
> > >> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
> > >> enhance the boot security and integrity in a unified manner. The first area of
> > >> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> > >> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> > >> Trust for Measurement).
> > >
> > > My apologies for such a late reply, but I'm just getting around to
> > > looking at this and I have a few questions on the basic design/flow
> > > (below) ...
> >
> > No worries, thank you so much for taking the time to review.
> >
> > >> The basic flow is:
> > >>
> > >>  - Entry from the dynamic launch jumps to the SL stub
> > >
> > > So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
> > > image has already been loaded into memory and the SL stub is
> > > executing, yes?
> >
> > That is correct.
> >
> > > As TrenchBoot seems to be focused on boot measurement and not
> > > enforcing policy, I'm guessing this is considered out-of-scope (not to
> > > mention that the combined stub+kernel image makes this less
> > > interesting), but has any thought been given to leveraging the TXT
> > > launch control policy, or is it simply an empty run-everything policy?
> >
> > The TrenchBoot model is a bit different and takes a more flexible
> > approach to allow users to build tailored solutions. For instance Secure
> > Launch is able to be used in a configuration that is similar to tboot.
> > Consider the functions of tboot, it has a portion that is the
> > post-launch kernel that handles the handover from the ACM and a portion
> > that provides the Verified Launch policy engine, which is only capable
> > of enforcing policy on what is contained in the Multiboot chain. The
> > TrenchBoot approach is to introduce the Secure Launch capability into a
> > kernel, in this case Linux, to handle the handover from the ACM, and
> > then transition to a running user space that can contain a distribution
> > specific policy enforcement. As an example, the TrenchBoot project
> > contributed to the uroot project a Secure Launch policy engine which
> > enables the creation of an initramfs image which can then be embedded
> > into a minimal configuration Secure Launch Linux kernel ...
>
> Thank you for the answers, that was helpful.
>
> I think I initially misunderstood TrenchBoot, thinking that a Secure
> Launch'd kernel/userspace would be the "normal" OS that would
> transition to multi-user mode and be available for users and
> applications.  However, on reading your response it appears that the
> Secure Launch'd kernel/initramfs exists only to verify a secondary
> kernel/initramfs/userspace and then kexec() into that once verified.
>
> > Finally if your schedule allows it and it is not too much to ask, it
> > would be greatly appreciated if some code review could be provided.
> > Otherwise thank you for taking the time that you have to review the
> > approach.
>
> I have to admit that I'm not sure I'm the most appropriate person to
> review all of the Intel TXT related assembly, but I could give it a
> shot as time allows.  I would think Intel would be willing to help out
> here if one were to ask nicely :)
>
> Beyond that, and with my new understanding of how TrenchBoot is
> supposed to work, I guess my only other concern is how one might
> verify the integrity of the Secure Launch environment on the local
> system during boot.  My apologies if I missed some details about that
> in your docs, responses, etc. but is this something that TrenchBoot is
> planning on addressing (or has already addressed)?

I wanted to follow-up on this thread just in case this last question
was lost ...

-- 
paul moore
paul-moore.com

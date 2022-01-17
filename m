Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0134A490944
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiAQNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiAQNNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:13:44 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E85C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:13:44 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y17so19092745qtx.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v95MTDE6AwXJuJQAhPQ7NXPCKSsA4ja2dsCjYA+yvqo=;
        b=FrJ405V3mUw7sUTQyI1GqbU4h2e0ueIGC2ozRZCH0jX8W1XwdTnq2NgiYUCLNHOZuP
         ammSvth9vj1A+fdJJKM1mTBf2T9EUp/jSOr/5F0Y+n8gj2Rs08IR/dGRoDB3OSV2GOCS
         oaLR3tiGdPFH3UQIQsIHLVMsddpd+JGurMKDIGvJHaKxLAVn+rnVifiqHt6NWlaY/K3s
         bE5zkABdZaabcFkrqIxilNe8IBoXwP+tF6b3ugEjdZ/bsa6Wwe9dV1IY9hDUeMhrIRXj
         jWsVAg5fk3aHO/TWUKBskt5YFy9EzFXUS5NVXKl9tZiE8eim1jrmkfvMNTIf1xelGUQX
         z2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v95MTDE6AwXJuJQAhPQ7NXPCKSsA4ja2dsCjYA+yvqo=;
        b=Ds1wIBGG2a3HtIEz8H5e9hJx1Du5amZWLMsFRlZ5XFKnKcDL4q2Mk5V2SRTZUPcTMv
         SQeAJp+espqTGrvVKS7JskqeEXpuz4A6bn6Et7vWUOIUYPcRJnwChKvt1+jep32MZWb4
         q/yGAP4Fc9XwVITXHhSKetJ2pusZtJik7hOpFOrFvFnxV7bdnRUuhcsQNAcXOe93TLTD
         z2dOIeREmH+Gx9hw1RmazF3800sx4X+XrFF50LsCcbXlTwy/eTFurTVUZaITqXxM30Oc
         bO5LAXimujbGenMJAIJuQdCORNY+N7qTdivjTcVTYiwNSVYyiyW48Ef8Bs442g6utrPh
         SyGA==
X-Gm-Message-State: AOAM531cCTjmj9oo6eWaGHM/cSGB3gHwKGQKmk/JcvKo7HHQqIGXA1ZV
        /vo1u9x9PoUQ7gVPAZ/y+LUrDX8kX2ezE4iGJwtWqwnJhgze8A==
X-Google-Smtp-Source: ABdhPJy8tsAc3Zrv1hefqgTT6H6NoS9VEjRY7O+xv9ZGLsNDyvmrNNEo96qFakH7bQCayVaOkPvQmB+Pj2Asfpl66JE=
X-Received: by 2002:a05:622a:3cd:: with SMTP id k13mr3965011qtx.458.1642425223156;
 Mon, 17 Jan 2022 05:13:43 -0800 (PST)
MIME-Version: 1.0
References: <Yd9qmMx7NO450mzZ@iki.fi> <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com> <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com> <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com> <YeIU6e6wetrifn+b@iki.fi>
 <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com> <YeIgzLzPu0U8s0sh@iki.fi> <YeK2hFcy72tYL61S@iki.fi>
In-Reply-To: <YeK2hFcy72tYL61S@iki.fi>
From:   Nathaniel McCallum <nathaniel@profian.com>
Date:   Mon, 17 Jan 2022 08:13:32 -0500
Message-ID: <CAHAy0tT7+AwgQUtzndj1E99hVcHNmyk2xJ6wUSxa4oPYytAMzA@mail.gmail.com>
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 6:57 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre wrote:
> > > Hi Jarkko,
> > >
> > > On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> > > > On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
> > > >> Hi Jarkko,
> > > >>
> > > >> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> > > >>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
> > > >>>> Hi Jarkko,
> > > >>>
> > > >>> How enclave can check a page range that EPCM has the expected permissions?
> > > >>
> > > >> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
> > > >> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
> > > >> time the enclave provides the expected permissions and that will fail
> > > >> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).
> > > >
> > > > This is a very valid point but that does make the introspection possible
> > > > only at the time of EACCEPT.
> > > >
> > > > It does not give tools for enclave to make sure that EMODPR-ETRACK dance
> > > > was ever exercised.
> > >
> > > Could you please elaborate? EACCEPT is available to the enclave as a tool
> > > and it would fail if ETRACK was not completed (error SGX_NOT_TRACKED).
> > >
> > > Here is the relevant snippet from the SDM from the section where it
> > > describes EACCEPT:
> > >
> > > IF (Tracking not correct)
> > >     THEN
> > >         RFLAGS.ZF := 1;
> > >         RAX := SGX_NOT_TRACKED;
> > >         GOTO DONE;
> > > FI;
> > >
> > > Reinette
> >
> > Yes, if enclave calls EACCEPT it does the necessary introspection and makes
> > sure that ETRACK is completed. I have trouble understanding how enclave
> > makes sure that EACCEPT was called.
>
> I'm not concerned of anything going wrong once EMODPR has been started.
>
> The problem nails down to that the whole EMODPR process is spawned by
> the entity that is not trusted so maybe that should further broke down
> to three roles:
>
> 1. Build process B
> 2. Runner process R.
> 3. Enclave E.
>
> And to the costraint that we trust B *more* than R. Once B has done all the
> needed EMODPR calls it would send the file descriptor to R. Even if R would
> have full access to /dev/sgx_enclave, it would not matter, since B has done
> EMODPR-EACCEPT dance with E.
>
> So what you can achieve with EMODPR is not protection against mistrusted
> *OS*. There's absolutely no chance you could use it for that purpose
> because mistrusted OS controls the whole process.
>
> EMODPR is to help to protect enclave against mistrusted *process*, i.e.
> in the above scenario R.

There are two general cases that I can see. Both are valid.

1. The OS moves from a trusted to an untrusted state. This could be
the multi-process system you've described. But it could also be that
the kernel becomes compromised after the enclave is fully initialized.

2. The OS is untrustworthy from the start.

The second case is the stronger one and if you can solve it, the first
one is solved implicitly. And our end goal is that if the OS does
anything malicious we will crash in a controlled way.

A defensive enclave will always want to have the least number of
privileges for the maximum protection. Therefore, the enclave will
want the OS to call EMODPR. If that were it, the host could just lie.
But the enclave also verifies that the EMODPR operation was, in fact,
executed by doing EACCEPT. When the enclave calls EACCEPT, if the
kernel hasn't restricted permissions then we get a controlled crash.
Therefore, we have solved the second case.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B8525E68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356394AbiEMJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiEMJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:05:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B6A30AC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:05:03 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f16645872fso83589967b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTZeQcmD3o4x5mR0Wyhiwk1leVubQ6DCWCi/CUnT8/o=;
        b=JclI6fSkn+QxqcDqS74bRoEiEWygWWh2m7a2JQIUc+KNlgUJMnHrsMaN8dDJHsWhDs
         Vvg7V4SSKU7iWJSf1b1Wf69hMjzQ6pKMp2Q/IgNtFsXYGxd3g+Dqei4jcVV7cx3yieoY
         tAOIe1i6qKeP724rjdtCoYg6m3iXQnDUB70mDDRWhsH0uy3mqvTm2CRndk3W1LOkyunX
         Cz8dfCt3RTApDFWiuwB8ARXo9Np3hz+OBEDreUcG83YfDtQ+LCQspK4fdFK+8C6C09fw
         E48nS5zzNJw4TouRxhcdLVLhaSyBGQG098fkis6hOWl+xWQvVTthFuUp9cwGmxGkGTXq
         l8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTZeQcmD3o4x5mR0Wyhiwk1leVubQ6DCWCi/CUnT8/o=;
        b=YubgAkWQK5XkoBATxKnVsrtIzp+m8v4I72yJQs94kJgRHRdrteNV5upNCAcYcz5zU1
         INpsq0FdXXNkHuSxYUjcn91pqbUySElyntf06uTGJ+RHTNJS1rCNEOfXt1tljcOugyjB
         jprKR/Rc40mEUlKq+AB4DXLnId7pj/1jQ9zJtB7l661uyA2xPH+jiAt7Ke2U9KC0brL5
         kFGUn+G5GkQhSq6tPiEESSOVAaMegOWJOip25+C5wlhaCAZWv3biS/pf4Dq1fr5ANz3O
         DYyC/VEcmQTQMjFvf6WDOw0y0H5B9pnrfJ2l8ln1jDG+5zAo+b8X8N0ouhoYn8gQIeNi
         527Q==
X-Gm-Message-State: AOAM531y3mg9rFiFrCqWF0ZeSFJzMC13ff7AslvsRszNyRip8GPEPjZR
        T4Sfi1DxQYVSPgeSkp3RyAm5Ozc/rHFhaFBN7owW4KFeP0Y=
X-Google-Smtp-Source: ABdhPJz0uPL6o9Jeys/ofYLD0g2mhFhnvv7bOqSPD5KcnuAwQytfH/LQTi+Eum3tvwPC2hmo38ngdU4HP7GYGoz23A0=
X-Received: by 2002:a0d:da87:0:b0:2fb:994f:7bc4 with SMTP id
 c129-20020a0dda87000000b002fb994f7bc4mr4716907ywe.369.1652432702667; Fri, 13
 May 2022 02:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220316041612.71357-1-jiangshanlai@gmail.com>
 <20220317221943.6vhoqx3fdv7py6hi@treble> <CAJhGHyC1qPee2QOpgR8B+2Sd+XzfoJD3NL9biFZ5gKE-B9r_rQ@mail.gmail.com>
 <20220318170312.rc2zgtubddg4dpya@treble> <CAJhGHyAjXgqxxH+myLt0nMcSLQWWLrcOb8WevyQNf-Oajip7-A@mail.gmail.com>
 <CAJhGHyBbN82UTEqFy1_=bPo+8a13S24jUzwKu5o5jJu3jbkETA@mail.gmail.com>
In-Reply-To: <CAJhGHyBbN82UTEqFy1_=bPo+8a13S24jUzwKu5o5jJu3jbkETA@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 13 May 2022 17:04:51 +0800
Message-ID: <CAJhGHyDm5RH3+c_7Abp6kFThS4YuhL+x4i7s9X9v_ie7gz2Lkg@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed for #VC
To:     Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Brijesh
+ Tom

On Wed, Apr 27, 2022 at 4:26 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Tue, Apr 12, 2022 at 8:24 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 1:03 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > Ok, maybe Joerg can test it.  It looks obviously right to me though.
> >
> > It looks also obviously right to me.
> >
> > Hello, Joerg
> >
> > Any feedback?
> >
> > > Since it fixes a real frame pointer unwinding bug, it probably needs:
> > >
> > >   Fixes: a13644f3a53d ("x86/entry/64: Add entry code for #VC handler")
> > >
> > > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >
> > Hello, Borislav
> >
> > Can you have a look at the patch, please?
> >
> > Thanks
> > Lai
>
>
> Hello
>
> Ping.
>
> Thanks
> Lai


Hello, Joerg, Brijesh, Tom

Ping.

Thanks
Lai

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE44C8C57
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiCANOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiCANOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:14:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48A2899C;
        Tue,  1 Mar 2022 05:13:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gb39so31425268ejc.1;
        Tue, 01 Mar 2022 05:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxtFZKhISu0etU9DibCTjNmJ3WaumuAfeWm74bRzdGw=;
        b=CSUiXwFwgCw6lTlsv4UgUtvCqISWprWRrsZm85ikxqOB4O3vBFUlpF6AjjAnf8QduG
         J0sXQAnoKyXxmmxroVcKSlxzcO1kNO1hxnzEu/1IiUOH/0TiXO35H+WVqFJQr6ZbVqTr
         TgRe5e0OadQmPqXhP+/yXIsGtuuXwPqm623qV2laLIQ90gMQsM1loHgmFnkendgueoE6
         s8X8fxDH9oU34+qurmQTEJkQscBetbOfcAfg7lIcPy1LhORrNdj/xW4aaEOt304u/gkQ
         pVpEj1KmwLUNsiR1wCmMZrf9weesYpc+tScwhcJuEddl/NGXkIif+awtZ+BiD1jIC4F5
         66DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxtFZKhISu0etU9DibCTjNmJ3WaumuAfeWm74bRzdGw=;
        b=rH+5l8GJHMgFfAaLs7oT5wjePT8WhPHfkgZB8dbAAH+86TWsgdLcHXC96MFfdMTpGx
         8JVmpaBRprXcOwidP3rU436s4vqtptl8gFNEM0SPvOmimKV8iVzpeYOgRZCCpvrqyqOY
         F7U+ml16McUqjb9Wyl1Zu1C6NjWRe6/riMiyZhpa7eJ/UIAJQeKQTLlm0KT5/n33/evZ
         IlDhCbIFYbAVIGONYdzhOqS2fGhYo41OdETRsPhYo8wTVe5S91w1t305zNWF3Bzo8q87
         VD4RLJmTHE2mwBEZhn7amd8D7XHG6LKh0g811eoyRbde/cyjp32CCOewYiw1YGIyEupa
         ns7Q==
X-Gm-Message-State: AOAM531QWZZeyfiTW/tbb4LVZrgCDEeWlpLr1Eh1pzj4uFv9robs2U2T
        Wjca35T7ye1Ku7fDrEieEW0E6UKiH9zLeLdpsIs=
X-Google-Smtp-Source: ABdhPJzUwasJ8V5JVzKH1YVjlbEKO0FzQ1mI2x8dZ5HgI03rjM1HDDY8wVi/WZinLUd5rkqHDEbxmMGVpGOqqFm7jVo=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr19484038ejc.497.1646140410406; Tue, 01
 Mar 2022 05:13:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
In-Reply-To: <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Mar 2022 15:12:09 +0200
Message-ID: <CAHp75Vf96sLAj5PJq1J5_5w24v5phQDMD=v2iSgDv0=vVrm0xw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     jason <jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Tue, Mar 1, 2022 at 12:14 AM Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
> From: Jason A. Donenfeld <Jason@zx2c4.com> Sent: Monday, February 28, 2022 1:55 PM
> > On Mon, Feb 28, 2022 at 10:28 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > My point is that this is clear abuse of the spec and:
> > > 1) we have to enable the broken, because it is already in the wild with
> > >    the comment that this is an issue
> > >
> > > AND
> > >
> > > 2) issue an ECR / work with MS to make sure they understand the problem.
> > >
> > > This can be done in parallel. What I meant as a prerequisite is to start doing
> > > 2) while we have 1) on table.
> >
> > Oh, okay, that makes sense. If you want to get (2) going, by all means
> > go for it. I have no idea how to do this myself; Ard said something
> > about joining the UEFI forum as an individual something or another but
> > I don't think I'm the man for the job there. Is this something that
> > Intel can do with their existing membership (is that the right term?)
> > at the UEFI forum? Or maybe a Microsoft engineer on the list?
>
> My team at Microsoft, which works on Linux, filed a bug on this
> issue against the Hyper-V team about a year ago, probably when the issue
> was raised during the previous attempt to implement the functionality
> in Linux.  I've talked with the Hyper-V dev manager, and they acknowledge
> that the ACPI entry Hyper-V provides to guest VMs violates the spec.  But
> changing to an identifier that meets the spec is problematic because
> of backwards compatibility with Windows guests on Hyper-V that
> consume the current identifier.  There's no practical way to have Hyper-V
> provide a conformant identifier AND fix all the Windows guests out in
> the wild to consume the new identifier.   As a result, at this point Hyper-V
> is not planning to change anything.
>
> It's a lousy state-of-affairs, but as mentioned previously in this thread,
> it seems to be one that we will have to live with.

Yes, my point of 2) is targeting the following:
a) MS should be notified
b) MS must try very hard to avoid similar problems in the future, they
very well may discuss the matters in ASWG with other companies
c) the spec will be fixed for the future versions, while the current
one will live for the backward compatibility only

Frankly I'm a bit frustrated that it's not the first time MS violates
the ACPI spec, while being a member of ASWG.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CD56331F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiGAMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGAMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:06:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D483F3E;
        Fri,  1 Jul 2022 05:06:10 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-317a66d62dfso21429877b3.7;
        Fri, 01 Jul 2022 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+GOpgJPIy3kJaRQ4VvuwFYQZLJJM8+4dMGApVoBS8s=;
        b=bDGvT2h8J3Uh2rVeoEAeBqh68zjNS2k3X+4P4D8Ihk8M5q/3MfsbxH5FOrcyhtXTMY
         L/D3/XWGurmWOdj9hplmGVV7dwA2OB4Qm852NCPguyfZJeaIegJSLzrrNJ2RXvdTQBUS
         Pr3DeawtZfu8DRikhV6Lh/WRz/vGiv3d3lD0VhRMUdo7KArVa+uOXxHK1MCP0bW1V6xs
         qktT7fbCB/SGte+J9oDqQMKCj0EdqQ4pDt5Aq0ye9M/9MYG0gIY3zJYi+YnuTqeq5ujm
         ez/W+mwqeYeQS9Ty/ox2V/tyCXsQBHuFfhkAsWPdbqFMLHRlhxymDtm2KFBXPFOIA318
         J/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+GOpgJPIy3kJaRQ4VvuwFYQZLJJM8+4dMGApVoBS8s=;
        b=ZqKSQykXpje8Lkyk945W6baf+w8qGLGic6NEJYGd5BkG1h96YsyfmtrtzFZC/Ti5Ze
         rcpwsboDLz50LL5clZxY/TbR1X4Mfry6vMzDvMdH1t/O5ssTnnI/GWhUZBclvfc3PqRw
         3RBWee/7SUb0CwJxbENivhaM5k6q2jb8T6u8PKiovgiitv8zB9/yKIfPxC4hAlvcMPv9
         6Wn7WLNiwAnVc1Vi9cXmGcoT9U00MpZBTkUeSeuCAjWIhfmIzfn9urp5V4yCUdnR3NU+
         Sd+/UXOmHily/Bb6pgZPTTKqnRUlAEFzUK5kmpRUAZdPLgyovAEX30YW+7QFbdX2av9P
         2+Rg==
X-Gm-Message-State: AJIora9j/DAag9amGiP0e+KEITYHUUNgDKJ4f5ZWfLnDVtSs9CRQ6YVn
        D3c71TGk1MTQq0K8aYBG3IaAcv3wOBGmExK5J97/ygEqcVmx7Dup
X-Google-Smtp-Source: AGRyM1sgHzbszwdeRHztq+x3rl8CL2sq3B116/1aH1OX/n2KUmD4G/9XG9ddA3egMmZ9l3pI+ZaGBoMWkZwDpJAm6sA=
X-Received: by 2002:a81:cd3:0:b0:317:861c:ac07 with SMTP id
 202-20020a810cd3000000b00317861cac07mr16598778ywm.486.1656677169090; Fri, 01
 Jul 2022 05:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com> <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com>
In-Reply-To: <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 14:05:32 +0200
Message-ID: <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Fri, Jul 1, 2022 at 1:54 PM John Garry <john.garry@huawei.com> wrote:
> On 01/07/2022 12:07, Andy Shevchenko wrote:
> > On Fri, Jul 1, 2022 at 1:06 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
> >>> On 30/06/2022 19:13, Rafael J. Wysocki wrote:

...

> >>> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
> >>> sent a fix today (coincidence?):
> >>>
> >>> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
> >>>
> >>> And they conflict. This code has been this way for years, so I just
> >>> suggest Yang Yingliang resends the fix on top off Rafael's change.
> >>
> >> Wondering if Yang can actually switch that to use
> >> platform_device_register_full().
>
> Maybe that would work and simplify things. Let me check it.
>
> BTW, when we originally upstreamed this driver there was some ACPI
> platform device registration code which you/we thought could be factored
> out later. I can't remember it. I was looking through lore but couldn't
> find it. I don't remember it being so important, though.

My suggestion is definitely not for the fix itself, but as a follow up.

> > And for the record, I think the Fixes even for very rare bug hits
> > should go first.
>
> ok, I have to admit that I was going to feel awkward asking Rafael to
> deal with this fix by having a v4 on top of it.

I don't think it's a problem as long as we have an immutable branch /
tag with that patch. Another approach could be that Rafael can take it
as a precursor for his series and route via ACPI tree, but let's hear
what he thinks about this himself.

-- 
With Best Regards,
Andy Shevchenko

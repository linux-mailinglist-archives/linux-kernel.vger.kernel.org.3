Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17460557121
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353008AbiFWChK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiFWChD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:37:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD403CA7A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:37:01 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3177f4ce3e2so157423597b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49Nk7hmUdiJCNEYE0l0yCJRDHLf0jxWA0g/35538DuA=;
        b=aGy21QAm2ckk1RncPP4GRr5ft+rJupnCr6OT/Le1/gXU/A9f6Fk/UaMnFtGMpAjRPC
         7wwBIH+TFzD39mTpiazmfjeXUmlQ3UU9gZcNik0JvaaSeoYeGqJqUscvkHXqOFVcMa/R
         SuB7JET94Z5HUQ9MShoToSmLuuoKSHVqvbBlOOIFg/fHYUewTUv80g5mgSDKZx10uHd+
         qBb/Z0LvSv2ZbksXBn+fLEy1JQwEVzZq2CeQuOzjntgynlq7qSPTqha3lZMvGlHRl97b
         pjpaedi+ISyzZimuCTzg0/3RdM+bfRpsyRaIlvpZWkywzNQwa7pmPkUQbpSKsuz3eRsH
         N0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49Nk7hmUdiJCNEYE0l0yCJRDHLf0jxWA0g/35538DuA=;
        b=OYHjjTQyTQzaKULdbI0lRkb8YZWBo16sM/PpOugb2Mbt5pxbyGPrcT518VAhqzRow6
         ghp19I78p8LH7Y3orCA/tGvhgwHPyJop997Lh0z6oFEpKmOqTw9ZLSJVMv7Sjzxf+DXW
         KblbtPffzN+KFlcK+I81MbYWBL/Anzg2Pgzid7Mf3Q8qZOO30UtL18ydnVyN9rm8FE98
         qcEUVLkZ9HZpQgB3Mf1MIyT7gjWHF2rG2iIlz/QPWHSgypJtzxLLMbeRN1LK1PHeFV8g
         nhSukoIZ3nC5ZFhM/EsEpP9jJjGuXHxvscgNAWjSvT+eAJCOiEl/o7/SmTMzkZbF0aIE
         +HIA==
X-Gm-Message-State: AJIora8O7ljptOV4J1VKUGmC3moHDedQOH8W6FP0+9ymTL+5Y8L5E2g4
        X4CBGtPd3xAeMZ/MIQe4sFfJUDBYbS6Y+qvzrcmY/A==
X-Google-Smtp-Source: AGRyM1uForsh5uwbmA0/mI09ZlD3rwatBHRJYURxs0u4OU+1zZPa3scdhxXMEMbqrJC6Nd6N/RQLqd9C8noLcEuIb08=
X-Received: by 2002:a81:4896:0:b0:317:f767:95f8 with SMTP id
 v144-20020a814896000000b00317f76795f8mr8455343ywa.218.1655951820855; Wed, 22
 Jun 2022 19:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220616032522eucas1p19a6c8718f01fa61c2fee795fb8945a92@eucas1p1.samsung.com>
 <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
 <d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com> <CAGETcx8e0QDbaqHGm1O8y6zwrBCwRitsRFXeUPt0w6uFx9k6+g@mail.gmail.com>
In-Reply-To: <CAGETcx8e0QDbaqHGm1O8y6zwrBCwRitsRFXeUPt0w6uFx9k6+g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jun 2022 19:36:24 -0700
Message-ID: <CAGETcx-MHwex8tHLB1d71MAP01-3OPDZSNCUBb3iT+BtrugJmQ@mail.gmail.com>
Subject: Re: Default async probing for DT based systems
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:04 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Jun 17, 2022 at 2:04 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi Saravana,
> >
> > On 16.06.2022 05:24, Saravana Kannan wrote:
> > > Hi,
> > >
> > > TL;DR: I want to improve boot times by enabling async probing by
> > > default for DT based systems. Can you give it a shot please?
> >
> > Yes, I've gave it a try on my test systems. It looks that there are a
> > few issues. The first one, the most obvious to notice, is related to
> > __request_module() calls from various drivers and frameworks. Here are
> > some examples:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 3 PID: 73 at kernel/kmod.c:136 __request_module+0x230/0x600
> > Modules linked in:
> > CPU: 3 PID: 73 Comm: kworker/u12:5 Not tainted 5.19.0-rc2-next-20220615+
> > #5203
> > Hardware name: ARM Juno development board (r1) (DT)
> > Workqueue: events_unbound async_run_entry_fn
> > pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > UDC core: g_ether: couldn't find an available UDC
> > pc : __request_module+0x230/0x600
> > lr : __request_module+0x228/0x600
>
> Ah, I think I know what these might be. Going by memory,
> __request_module() from asyc thread context has some issues for module
> loading. So I think a check was added like this. And I think the check
> is triggering when it shouldn't (this isn't module context here).

My memory was right and this is indeed the spurious warning that was
meant to cover a potential deadlock in a module load path. I was
trying to disable this warning till we hit the point in the boot flow
where request_module() can actually succeed. But I got stuck trying to
figure it out.

It looks like the usermode helper that's used for module loading
triggered by request_module() is enabled in populate_rootfs() that
runs well before most of the initcalls are done. I was under the
impression that init with pid 0 would be the first userspace thread
that can start. But I don't see anything obvious that prevents the
usermode helper from running and loading a module before init process
has been exec'ed after we set system_state to SYSTEM_RUNNING.

Can someone clarify when is the earliest request_module() can succeed?

Thanks,
Saravana

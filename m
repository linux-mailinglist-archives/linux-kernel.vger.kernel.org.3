Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B714B2D65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiBKTNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:13:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbiBKTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:13:02 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F3CEF;
        Fri, 11 Feb 2022 11:12:59 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x136so26007160ybe.11;
        Fri, 11 Feb 2022 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97vKTexOw96BvBZHA/izkqIjYsp/DT1XRSPk3iMr3tk=;
        b=W9D46H5xdJ3uiUJ6I9kShMBEQQA0li8fJSYc55jdnJwKnjWRbPW/MhyGcgb4UladZO
         lGHU5WjvNiwoj6Lllur8ToP57NA1aPamlt1qeddhOd1vuLKRq2rtLEKT6/IbbHFycvXy
         MDqPeo2gTSAHohVTzDuNBeLxidZlvjbrr0nPvB4C1J3fy0rUSkl74OxpTx4hAcjaY7j0
         zkUtHlo1zLFsf8sg5oA23gut/s885zKi2Eo5qUVlIQu8lOA6+1gTXp3BtnEZ0KxWp95O
         l8998TQnfTZQqIPAz0A0Q3Mop3XTpQuWHHW1v7wmnkHdJjtQxjhOpzjUOBpZ0FOU+Ut/
         zpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97vKTexOw96BvBZHA/izkqIjYsp/DT1XRSPk3iMr3tk=;
        b=eworMU7Y1ocxQmJVo7k2pVkyF5p2BaQGwsdD5n5jb0d6CfjjNoO442F0TK8XubToIV
         Wg1RNWDXVFdxdF4aAaz1rn+sgnjY0/OmCxS/IzhgZX8t7MTccsUDWc3hgCvO3w97rfWO
         o838lNRAPspjJoF5gsDdxlo51YzkiixCTtdGa1820UNx9cr5yJkvk7r/G+hPm5hx0IVj
         jVk1aKlw9pCNgV1E/N4odg7cJlwrxnTz5OukJzw9OBDsmUTl8z8NwD0gRRfcoz/2/GKr
         BTwgAaIjHSPXs2YFjr7mQLfnH2iVVmPjPUaqFYGtKXkOrapjqZLWGG/rV63St1ADGd3J
         I2IQ==
X-Gm-Message-State: AOAM5324IUO5vJNZ/3r2rIuyAVYIaRzmL6ve9N3M1uO6QnS2T5XQAN/E
        v6v7KdLS/1vPBh4ae0reIvTgOuBQbglJ0MFGYQC22lRLq08cNg==
X-Google-Smtp-Source: ABdhPJwGNdeRBdmH+kQfHDYx/HhxjdSveKVp7+tuSERa7Q/1h69GCQrcXRjSw2nB+MbV0/hM0aTnROg08nw7Guvc24w=
X-Received: by 2002:a25:148b:: with SMTP id 133mr2810906ybu.270.1644606778147;
 Fri, 11 Feb 2022 11:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20220210184340.7eba108a@canb.auug.org.au> <20220210193302.686fa61a@canb.auug.org.au>
 <20220210214125.2b248790@canb.auug.org.au> <20220210222953.6e078d20@canb.auug.org.au>
 <YgWdbYfWgHP2jBmI@bombadil.infradead.org> <20220211123336.54eff9de@canb.auug.org.au>
 <YgW+DopXpFNZTj4k@bombadil.infradead.org> <20220211184647.0a62dad4@canb.auug.org.au>
 <YgawN2b1MOF7DN7g@bombadil.infradead.org>
In-Reply-To: <YgawN2b1MOF7DN7g@bombadil.infradead.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 11 Feb 2022 11:12:47 -0800
Message-ID: <CAA5qM4C8MBmichi5UC2S-tR3xjVNY=StAkuaXnG8VhKsi-1s5Q@mail.gmail.com>
Subject: Re: linux-next: boottime warning from todays linux-next
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Feb 11, 2022 at 06:46:47PM +1100, Stephen Rothwell wrote:
> > Hi Luis,
> >
> > On Thu, 10 Feb 2022 17:38:22 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Fri, Feb 11, 2022 at 12:33:36PM +1100, Stephen Rothwell wrote:
> > > >
> > > > Thanks for noticing that.  I have removed the old version from my copy
> > > > of mmotm today.
> > >
> > > And ... does that fix your boot?
> >
> > Yes, the messages are all gone.
>
> Fantastic, thanks for the confirmation!
>
> OK so now a side independent curiousity remains though. Double sysctl
> registration should not happen. But if someone introduces a bug by doing
> that, it seems to not crash on x86. But it does cause a crash or a
> kernel warning on ppc.
>

IMO this is ARCH irrelevant, it will definitely give the same result
on double registration.

Tested on a x86 using the same double registration code.

[    1.098835] Call Trace:
[    1.098835]  <TASK>
[    1.098835]  dump_stack_lvl+0x34/0x44
[    1.098835]  __register_sysctl_table+0x6f4/0x720
[    1.098835]  ? early_memunmap+0x5/0x5
[    1.098835]  init_fs_stat_sysctls+0x3e/0x41
[    1.098835]  do_one_initcall+0x82/0x280
[    1.098835]  ? trace_event_raw_event_initcall_finish+0x150/0x150
[    1.098835]  ? parameq+0x80/0x80
[    1.098835]  ? _raw_spin_unlock_irq+0x20/0x30
[    1.098835]  ? create_object+0x395/0x510
[    1.098835]  kernel_init_freeable+0x2a5/0x2fe
[    1.098835]  ? rest_init+0xe0/0xe0
[    1.098835]  kernel_init+0x14/0x130
[    1.098835]  ret_from_fork+0x1f/0x30
[    1.098835]  </TASK>

However this is not a fatal error and the kernel is still operable in
both PPC and X86 cases, the bug can be catched and we can use
WARN_ONCE().

> Why?
>
> And I think we should just WARN_ONCE() for this case, and make the
> issue clearer so that if it happens again, folks don't go scrambling
> as if chickens running around with their heads cut off.
>
>   Luis


- Tong

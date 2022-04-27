Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D68511752
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiD0Me6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiD0Me4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:34:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116A4BBBF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:31:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b12so1419001plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGcMZHnjSns8JTuzYE9jTqed4AGG4r5oPIvvfDMdW4c=;
        b=ctLrqDJVyjW8JBHbFLUPVekF8onbzNl/a4t84wK81WekIWLRCuh6Sw4R+qBreLXPnD
         UcNRk83XmMea5li6P0bAyVfq6VP5NOXBZjFqEUVVnCrDGPuHnWxV6PDUaOCy+5yPru+r
         Q6eD1QY+PNuHzH0iGGi5t1uzCeQajfU6siOQhYtgETdAiR6g9TyBqXXXncaeL4qZkc4J
         wUA09XqVZxR/pdatWBk9mGjeXXPf5/am9eadh+65hS6Fhln13LYtcy2WApnGZiDa5+P2
         Fz4jeLYDuXobHESeJXnl1+1l8NliE6Q99MosI26xJBw8Xo1THTFZpAzPN6g5fVJfrBrQ
         qvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGcMZHnjSns8JTuzYE9jTqed4AGG4r5oPIvvfDMdW4c=;
        b=P8ii2Ig+vYK5KNtnjjeHTolkl0bva67SsRdMLwusCsKw/yLEafMjb8eyUn9S6+hoPi
         QXcZjuZtF7X7pWiwYT4DTQv0Qk4swjTX/HIPjfMlClYvS+r3m6D9ydWBxEopn7wrxK5E
         Sd450K+GJFEY7eGp0tGo5lSMcdUYfkeTY2CIrjqkqp1/OdgXC35b6ofEPp3o1fZN58o3
         3pgYnVflqeL/KPuT+nRnwOqsyaSpI+O4yy36l5OBEIRbaWddZV6+LhCTpv3uIhB2+R/Q
         3V35l1SZAh9OUoAwZwf+WRIBZ8SIRL4k8WYdTT4SLtUdexutY/mw0nL5vmHGsmzy+jPW
         TlFw==
X-Gm-Message-State: AOAM533eayDQD2LXjJISAyhQlhTDD3ZPSWzVpDc7HsdBgC6Jo6SBuyM7
        vLRrxJlJs/yHNd7uESB/HLQp3AuzHVaEm279p1I=
X-Google-Smtp-Source: ABdhPJzgueqJcjLxOYi7REPhnZTGxdnFE9nNel8FAqBzRk28jxaFt0ZO09MW8p3LcOvq0TOjKd30ivxIi4Yp4RKaRAk=
X-Received: by 2002:a17:90b:4c84:b0:1d2:cadc:4e4d with SMTP id
 my4-20020a17090b4c8400b001d2cadc4e4dmr43321277pjb.8.1651062705339; Wed, 27
 Apr 2022 05:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <YlaWxh5qYCe40US7@alley> <20220413055305.1768223-1-maninder1.s@samsung.com>
 <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcms5p5>
 <747830777.1512786.1650256482294@mail-kr5-3> <YmAlAvy6aSeeJKoO@bombadil.infradead.org>
In-Reply-To: <YmAlAvy6aSeeJKoO@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Wed, 27 Apr 2022 18:01:34 +0530
Message-ID: <CALkUMdQanGgtahQDqQV-r6oWF=cvTsteztOoe5bqHsJApST0Rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kallsyms: add kallsyms_show_value definition in all cases
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "wedsonaf@google.com" <wedsonaf@google.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "void@manifault.com" <void@manifault.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maninder,

in sprint_module_info(), we need to take care of mod->init_layout
addresses as well.
Please test the patch against  init symbols.

Vimal

On Wed, Apr 20, 2022 at 8:51 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Apr 18, 2022 at 10:04:42AM +0530, Maninder Singh wrote:
> > > What about splitting kallsyms.c into two source files where one
> > > would be always compiled? It would be usable also for the
> > > spring function introduced by
> > > https://lore.kernel.org/r/20220323164742.2984281-1-maninder1.s@samsung.com
> > >
> > > It might be something like kallsyms_full.c and/or kallsyms_tiny.c.
> > >
> >
> > This patch is not taken by Luis yet in module-tetsing branch.
>
> Please resend that patch, as I'm happy to route it in through
> modules-next [0]. I use modules-testing *prior* to pushing to
> modules-next, if 0-day does not complain after about a few days
> then I push to modules-next and this gets merged to linux-next.
>
> You can send that patch and then this one and include in the subject
> something like:
>
> [PATCH modules-next 1/1]
>
> Vimal, I'd like your review of these patches too. And after those
> we can see where your change fits / if it is still needed.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
>
>   Luis

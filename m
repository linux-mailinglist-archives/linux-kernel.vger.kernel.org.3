Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193975722A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiGLS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:29:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB42A43A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:29:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e69so15414532ybh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+CRJwxgr3RwmxsPLFpAzp9LSqC6LpBVUE2YrUJJqMY=;
        b=TPBVw3zPRpaWQdE/I24xJe12PNP366ffMUe9ZbJElSALxDd5JacyM1b2cCueFFbj+g
         bbtng71YJ1cJZV1sZVsXrp9Zn8Ci5bV4SMwpHEreeMrFmzY7rAxmbhfA3jYxbQfgGulj
         OxWY/fcecG1mWpF7gSs04GPjg2xOb+qorrbjRwrlV8vF5S6lxm6AZTlAaOR2rI15FYGM
         rzPDUSt/vZ12PzHBEAx1OQhmWX+FOaFTBEY5+1t5bxsmQihDf8/eYzVpb5d5ItIvx0Pa
         LAu4IVDl1pExZdUOBLSVnUQy0RbffgzMWisIHALOy0+YMex7Y5yANJz1RAL36ISjAfVt
         YTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+CRJwxgr3RwmxsPLFpAzp9LSqC6LpBVUE2YrUJJqMY=;
        b=nNdvyrsD1qoqNg+6yRBhQhAoHeGUT8LfGfhYeswEXRMVbaO5PwT7L7vOWgHW2X47CL
         xvR65jsfPgQKlv6oDkVxwkpLartwo4zOjXH1OcYRdOfR90EuZ2GIjJk2bm3mu0kxfW83
         FAgfe8ygDt5iQZ7X4x8xsEDRZKZF+PeywQ3iHumg4R7zg8R6T2CetHGJLBSMn77Q6aCv
         50h48hq714F9h8CD+6yJQ9LKgHsE2Vl+jfhojfUHwloNrX2O9QVr6rsOoB5eeFq+bfrR
         DOCrAHQZZbEjuOUerCGosW4zwBX43Pq5tzcSTBH7/+5pwoGsc6F0PT8ELZMe311ojBO/
         Nqow==
X-Gm-Message-State: AJIora8VCDfxyd7RXTg8fYeV30vpu2hz2baKPGP5enfrL8/rIP1nsR4L
        6yI9dCLZrLiYVPcbT8CLWc29WcNQ0Mt6lR1JMso=
X-Google-Smtp-Source: AGRyM1ux9OgeLzuxTR55QshLROCaEjHiQDqJCNscE9F1xFr4KKwTnM06+wSR36yyOJgCmItJKILESkAGmJs9INp/FzE=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr24480407ybg.460.1657650558734; Tue, 12
 Jul 2022 11:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com> <CAHp75Vf8EhRYWdQN6Oc79GzWCvo-sRJDvy7_Aek_Z63GCu2dMQ@mail.gmail.com>
 <CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com>
In-Reply-To: <CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 20:28:42 +0200
Message-ID: <CAHp75VcQq3wmwmpaDtu6HC2yrK4rWp+4HOcqMaOHQ3EQQ0c=DA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] lib/find: add find_nth_bit()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Tue, Jul 12, 2022 at 6:26 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Jul 11, 2022 at 1:55 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 11, 2022 at 6:51 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > 2) fns() is not good abbreviation, because among ffs (First) and fls
> > (Last), fns would be read as Next, which is misleading, I'm not sure
> > fnths(), which is correct, is good for readers.
>
> I agree that fns() may be confusing, but fnths() is even worse to me.

I also think it's not the best choice.

> I expect that it will be mostly used indirectly via find_nth_bit(), and
> will not create a lot of confusion for users.

Perhaps in that case we can survive with something else? Naming is hard...

-- 
With Best Regards,
Andy Shevchenko

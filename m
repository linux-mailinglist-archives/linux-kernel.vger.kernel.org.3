Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D76B5A345A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiH0EVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0EVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:21:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C132ED8;
        Fri, 26 Aug 2022 21:21:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id jm11so3184288plb.13;
        Fri, 26 Aug 2022 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pa6GJfOmt9j0fp8mSKGvACEvOt/yd79WjKyBkEQPYYY=;
        b=WTYFMBtJEv4BisN8xUeskjLepiRigIdIOFS/G+PgVbw9cmsfh00+e1SFStrmZ07bEN
         bXKFs0AZpFmJaX7OK3jjiyTPVrXI1eb2bNBhRcGIjtB8CbmEX6XphGIErmV+ViYbJ6v3
         a7I/80pDBbTvdOa7P9P6F2YKnMQy7yuCVI8gXeB62rrw507tRuyR+FSJeJfT8uJxlcc1
         AkNh9lUcGnr4qhLkaLzVd45MaflRFbDk92PTYsn+kiW1PJ7XaCv9aax/wMRuam5QuB72
         qC5rQR3nevNYL3UcJGAc3CG+hT6gZ0/DcIP7RsRYKxNwWVVuTZ99eJxZBDsUgFR81xFX
         57cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pa6GJfOmt9j0fp8mSKGvACEvOt/yd79WjKyBkEQPYYY=;
        b=Vep+6BtapIOSEJRmGe//x9fi6yHO1d4TNd5wW5PL9Zod1C4gU2Rpx/Vmre05DKiAnA
         joX6M40M5tfZnGHuLNhWJJ7YEN5PosFAPCLPUC4XIRGIy79r8J0TOSvWI+e7AR96YSwD
         TTyyHoqeTGMSu1kE131tea3REwh1+Wj2ReTIi5IwxAt0dS6exu/MU0Ea/Ymvb+HvbQ18
         ofLGSHNMhL6CqZTpeJsVnbEHeRJUMy90zbgjeQL0LxvM8K59qfpsldfzgz70gtkRizqj
         YFB5msliOih52Egxy4jveGAtXOeNhta5Zo8FxfkGZTrbXi3PowVPZGnQ5Kr68SZX+rdC
         exuw==
X-Gm-Message-State: ACgBeo3WH19xkdSwAw2eDo3BS3IawHYJAwmSQnY1okmhnQW7A9cybR0A
        8PnjkQg2JicyQHKjLeZdSi394+HxjURwDPfQMCk=
X-Google-Smtp-Source: AA6agR4h8s5l5vu06OWA2b9yYwneHKE8Gp4cod+zmt8/Osz0vY3BWuSYIwftJ+KbDmF/odB8vSc0arn+y25/WS0yshQ=
X-Received: by 2002:a17:902:bb94:b0:172:8fd9:7438 with SMTP id
 m20-20020a170902bb9400b001728fd97438mr6366413pls.174.1661574102787; Fri, 26
 Aug 2022 21:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220826160150.834639-1-imagedong@tencent.com>
 <20220826135839.39c7711f@kernel.org> <874jxyu32m.fsf@meer.lwn.net>
 <87zgfqsld6.fsf@meer.lwn.net> <20220826152711.6756e510@kernel.org> <87v8qesk0i.fsf@meer.lwn.net>
In-Reply-To: <87v8qesk0i.fsf@meer.lwn.net>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Sat, 27 Aug 2022 12:21:31 +0800
Message-ID: <CADxym3av1mU3LzVzJ65B4RHispPU+W5CBz5K6jp6bHZn5fr15g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, sfr@canb.auug.org.au,
        bagasdotme@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
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

On Sat, Aug 27, 2022 at 6:43 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > On Fri, 26 Aug 2022 16:14:45 -0600 Jonathan Corbet wrote:
> >> Jonathan Corbet <corbet@lwn.net> writes:
> >> >> You'll need to CC netdev@ for the patch to get into the net-next tree.
> >> >> Since this is a pure Documentation/ patch get_maintainer.pl did not
> >> >> produce netdev@ in the recommended addresses.
> >> >>
> >> >> Please wait for a review/ack from Jon before reposting, we need his
> >> >> permission to apply this patch.
> >> >
> >> > I could also just carry it through docs; I'm about to send a set of
> >> > fixes Linusward in any case.  I wanted to run a couple of tests to be
> >> > sure, but I don't expect any problems with it...
> >>
> >> The patch is clearly correct, it can go in via whatever path seems most
> >> suitable.  Let me know if you'd like me to push it; otherwise:
> >>
> >> Acked-by: Jonathan Corbet <corbet@lwn.net>
> >
> > Oh, if it can make it to Linus via the doc tree before the 6.1 merge
> > window that's even better!
>

Thanks to both of you! Seems I don't need to repost this patch
with netdev@ CCed?

Menglong Dong

> OK, I'll apply it and ship it, probably next week.
>
> Thanks,
>
> jon

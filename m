Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E236B4C5844
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiBZVXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBZVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:23:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4D26CD48
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:23:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p14so17475852ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWZ01UyCGLSlDNqY8JjmkSJKDtH9axWGLl/d6bmmI2A=;
        b=WlGYT50nOVvuXCTkZs/10ZQqFCXwEQYkBIcwA0Y/acruuDAB44TEduCAL4R6Udyyad
         qkTAOxCgVb2nbIjw/fyRFYxHzS29h5Pg83h+8mij7A3qMN8RQklxh8yUrGulN7PivGY+
         hUYVMjAdySTlbRg30aBwanlkuNDn3pUTW+QdsZjf6jl/CVgtm1BTi+W6Czi6mIlkK0f3
         x5EaPszIZlqLaKLmXIKHnc8F+SE6+RMNj1dICYpTgVOn/4tuJxWLONqJNgEGSogx0oTT
         1vn1k/TyZzC9+01TQPYHTw/X+dRdjf+paaCrRQl9EIgIrX3Qv631Q5nG2RnR2AlOUpe7
         21Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWZ01UyCGLSlDNqY8JjmkSJKDtH9axWGLl/d6bmmI2A=;
        b=W0k6G0yZEd9rYjPp336bEiVY/Bf6fybxqSuOEWT9B8ejzpUBqPRIEKT//lM8bq1Lhl
         AiBmYry1AKsiqw20u8JNisR12jzRls3KG7pJOY9PI4Y6gTUREOzlz2MfafJQ3yemI04R
         g9y7VerN0XOOhW5vcp69eB8MyENr+a+oGE/UtNdS5m7BkEO/kuxfrdrEyVXljIW2GCCE
         XdwI6tNU52K3nCvmcDlySZJMjGXyb7je6biiXyTN82dIq8S80VkzIE/HI2eQHDh/Jyql
         hE+nc2BWueK6/SbpjCfhrB+xWyIIfh0jwTs0X0rgj0m3VgvWSAzFeHJF6mOTU/ipLStM
         gUXg==
X-Gm-Message-State: AOAM532+umWmFCV1pko1H36EkZFF3OQc9m0tl+zcvCF2UPO6dHFOXn3F
        SefRhtkd0fMLmnI2wE1d3PRT8zIf1N6Gj9284MEZmCYNKJY=
X-Google-Smtp-Source: ABdhPJzuScH+m3ha4aSMHjV6W8J6w5omN6qOU4v7f1V/dh9CaAT5DYg75KBcpPiUNiYff+VTdF81kU/L1x4ojJK2gOc=
X-Received: by 2002:a17:906:6a2a:b0:6cf:d228:790c with SMTP id
 qw42-20020a1709066a2a00b006cfd228790cmr11014296ejc.75.1645910582220; Sat, 26
 Feb 2022 13:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20220226033054.2860933-1-dlatypov@google.com> <CABVgOSksQBD4F8UaKE3N8D-_U65w_t+OwchQ1G52YnAb1a4YUg@mail.gmail.com>
In-Reply-To: <CABVgOSksQBD4F8UaKE3N8D-_U65w_t+OwchQ1G52YnAb1a4YUg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 26 Feb 2022 13:22:50 -0800
Message-ID: <CAGS_qxpCH_R9h41r=ycV4aRkXH50mUR5HdODYUF-tTqLbPwuAw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: more descriptive metavars/--help output
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 8:29 PM David Gow <davidgow@google.com> wrote:
> > @@ -292,11 +290,11 @@ def add_common_opts(parser) -> None:
> >                              help='Path to Kconfig fragment that enables KUnit tests.'
> >                              ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
> >                              'will get  automatically appended.',
> > -                            metavar='kunitconfig')
> > +                            metavar='KUNITCONFIG')
>
> Is it worth making this something like FILE or PATH instead.
> PATH_TO_KUNITCONFIG would be verbose, but this is a path being given,
> so just KUNITCONFIG is still a bit useless.

Here's what the complete help output looks like right now:
  --kunitconfig KUNITCONFIG
                        Path to Kconfig fragment that enables KUnit tests. If
                        given a directory, (e.g. lib/kunit), "/.kunitconfig"
                        will get automatically appended.

So I didn't think it mattered too much if we left it as-is.
But I like PATH (since users can use a dir, FILE felt potentially
misleading, even if  technically correct).

Will send a v2 with the typo in the commit fixed and this changed to PATH.

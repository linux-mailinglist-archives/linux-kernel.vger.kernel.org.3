Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DAA5969BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiHQGqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiHQGqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:46:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2355A83D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:46:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so17857823lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nAqyWnNuUpYvt906E68zKBY59gzdyctyb9Q1L2Fs+ck=;
        b=qUYkmfw9D1MbfHRbF8XIoYOMYeVeDuvZ8CgQM2Jk5g2hD1UdiXHGoknIRP2VGxKPnz
         RtgVtU/2RJhZDlIJBNbmORJL4chclOIj6OJ7WL2Z8Psf/Q9apuTcZPqCIogSc7GM9KYm
         v7LNGSg4K7zh8iz5Ipx2SCG8d7rvqDVZ2uYuEvR4LtfdL0y3UWfJCdj6WEgpz/4+MFAs
         ORcsyNu6PPVUrATkapJ/JSWjHKQGLA6IKiSMMBhbs1xsGdYP32xwxkxG8sCDY1OZabNL
         HO+2sHmQobKWiUPFhW5E8qfmVV92UgqlzV/b3MwIKYrnBDpSJNI0TPT62/qhlxfO47IX
         0NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nAqyWnNuUpYvt906E68zKBY59gzdyctyb9Q1L2Fs+ck=;
        b=gfaba9t0uDpcHDqcp6ZgPq2pfp8liBIw+prs75VU13MzKHsiBj+XdybfoK7gfuns1M
         gDvu21EECriaKvWP475K7cCOCQdULHeuj9uSKFILCtgfGPkaszjAK10UNhCEUw3QOWbO
         wwFAme4jggQmtzzGUQTr1uzXBGQa6bCO5XsyUU0wSNr8Jk0PyoQt+ictDi1nPisXdZ4c
         rRQ7O65aJSASA+rtT0PEekhBbhSY5xrZFRJsI/0a0bgcxgM70SzAt2MMsSdX/iz6DkW+
         bSBB4i6zYBchHJ61UapOws3RmtmSozybghxOtACLhSB2eX5gbX1WGWVeS+y2OWi7POfV
         l+qw==
X-Gm-Message-State: ACgBeo2FfcCfjpXpg1A5J7jq7lnZhf/yBubvqiVm5fP2irxz0U0wcEjy
        Fm4WQyWsjcssYBFFvHRMbqR7d987U34wvFEIR/HAmw==
X-Google-Smtp-Source: AA6agR6BMY0UyExFx6N03MH0PaHsNCnoE3x2/qTyYfykvF0R2VGr+kIUvK6Ne9/vYBGCQmQVDIxJkYR6VXZEPeFGGy8=
X-Received: by 2002:ac2:5383:0:b0:48d:aa47:5c29 with SMTP id
 g3-20020ac25383000000b0048daa475c29mr7600984lfh.188.1660718775116; Tue, 16
 Aug 2022 23:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220813042055.136832-1-tales.aparecida@gmail.com> <20220813042055.136832-3-tales.aparecida@gmail.com>
In-Reply-To: <20220813042055.136832-3-tales.aparecida@gmail.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Wed, 17 Aug 2022 12:16:03 +0530
Message-ID: <CAO2JNKVu6rhWdLsbqaUBruEFWpSkaOc=h1QMFHUdr7zSGm=Bmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Documentation: Kunit: Fix inconsistent titles
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, corbet@lwn.net,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 13, 2022 at 9:51 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Use the same wording when citing and describing Kunit parts.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---


This looks fine.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Best Regards,
Sadiya

>  Documentation/dev-tools/kunit/architecture.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
> index cf9e6e3eeae4..8efe792bdcb9 100644
> --- a/Documentation/dev-tools/kunit/architecture.rst
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -6,8 +6,8 @@ KUnit Architecture
>
>  The KUnit architecture can be divided into two parts:
>
> -- Kernel testing library
> -- kunit_tool (Command line test harness)
> +- `In-Kernel Testing Framework`_
> +- `kunit_tool (Command Line Test Harness)`_
>
>  In-Kernel Testing Framework
>  ===========================
> --
> 2.37.1
>

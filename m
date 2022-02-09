Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1860F4AFB2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiBISnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbiBISla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:41:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834F3C05CB88;
        Wed,  9 Feb 2022 10:41:33 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id n5so2463521ilk.12;
        Wed, 09 Feb 2022 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdVKbWl+swvS6/xo2ZLmEHRuVncfYpgRkMyp8UCeKHk=;
        b=f4nWzz4RsobozTfJhmxl3WPmpmP/DDnSSeklXu1s3tP9mG0Z9w7srOhO5bS5v/JlHJ
         7aH+RIIe3I4eyhTj2P1BbgqxIsjc2GSkgiw2k2ifQ4MQDlAmPWGTIX1ZvD9XkDDaDStU
         SbEdvEAkiFXYEFZHlQsBYbaboGA3BTFwzZjG5HHEejcIXJwHSvt31IzdCi/o1fv4KDEi
         Jp3y+RXSCMyhbjoN0HWW1fYUcUqZfVEn7lotrwUJeDgq+RQwZO7MwC0f3OwUmf/ypYk9
         jhVmYfW+H8bLSOYQ5otTt93Im1zRkQsVqALx95C6kfWpyU7auEeunKSR04gKcAKGL7pn
         USRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdVKbWl+swvS6/xo2ZLmEHRuVncfYpgRkMyp8UCeKHk=;
        b=q92Rqh8rZKBsq6tNgrCo9MpZsVbXfoIB0rizd6d2d47OeIyYaEOkYakBp7i6vKMBp0
         rLJWZvOYvogErKqlWNhwy4jH1NfjMBTLoQf8qHZ7MTwI33A4uBO08cIYIvQBaKwuOBfp
         VYoLK48Bl26q0ByLlelWyv+WjGpRycochVUi/5qy49hcKGmtleYbOUxTnUOR1WdZWqUD
         xRJN4NYonSXlhHZeWufr/cAUcjcEfLXFNd94fZDv19s9GEwoSmDDRhr84d7Fx50n00xy
         cqgosaangj9zyRjSZIqopbpHQx73mBHHA29HiellwytHKMpc9c7+LF3UNuQknEuPznBZ
         wIUg==
X-Gm-Message-State: AOAM531bjfzMfJHIIiSI2cne7mN8dKGI+Fs2F+gxQW0o+0sxeoT9i043
        2Rkf2an0ahijHGzNBrUrLn358z+oRsE7iQWR3T8=
X-Google-Smtp-Source: ABdhPJzRDCy5Ev+nQWg511F1jl0oxvqccsAWt9ueb866KNUtfNrwdURFYH1NNfvH5NEvzbzgY2rpe0DxLMkWHy9aBr0=
X-Received: by 2002:a05:6e02:1a64:: with SMTP id w4mr1782146ilv.151.1644432092937;
 Wed, 09 Feb 2022 10:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20220201185054.1041917-1-german.gomez@arm.com>
In-Reply-To: <20220201185054.1041917-1-german.gomez@arm.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Feb 2022 19:41:22 +0100
Message-ID: <CANiq72nb_M3PJLG=mFfQVgAd4fbkL=OhGKS_uQHNf8Jbef3hag@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Remove demangle-rust files as superfluous
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
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

On Fri, Feb 4, 2022 at 6:46 AM German Gomez <german.gomez@arm.com> wrote:
>
> Demangling of Rust legacy symbols has been working through libbfd for
> some time now, making these files no longer needed, so remove them.

What about:

    Link: https://github.com/rust-lang/rust/issues/60705
    Suggested-by: Eduard-Mihai Burtescu <eddyb@lyken.rs>

Maybe also reference commit cae15db74999 ("perf symbols: Add Rust demangling").

Cheers,
Miguel

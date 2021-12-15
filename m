Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2004A47609F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbhLOSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:22:30 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:46756 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbhLOSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:22:28 -0500
Received: by mail-lf1-f52.google.com with SMTP id bt1so2153647lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yl8xRrnO5YdvXRh5WZ2gJbb966QjOOewKNP5m/QcJI=;
        b=raIybRvGp63A70xv1AZFapgIzI4kTHCYfn0N/lzEdZgRM1CCtFZbWAUxvtb5FHSgnF
         y1X69YbUkp79nVeaVB9yKABGnI6GjuN29UuR6cQft625vwI7tSIrVS+BJ0eh8dMuUxZO
         8UqHPm19tr2BHeIV0jFcrlfZ0xwU30SPNwGWW27ChEbwHgbEfbrWXgtpO/EVkbcm7UYR
         +hbQIwoEwu9Cs8Xx8dfzQWZQQwB0fm7UkmSi06isCgru2r4wb9GgGHw2OYmIN7AhItfk
         QRdrnshShkV7S7sYbUSjRA/n4zOClYhVJZ6TJ4qwBhl9MxBJttQv2kCigEcdzzWqcwA+
         PFcA==
X-Gm-Message-State: AOAM531Ug8VOzDzL1rXrUdgQpJZpEgpZvJKaaUpj1fQ4rR7KS7W+mJwx
        /+n65i+ljyEBeYPoy9x0+y1tQ9BEkntNPkkQREE=
X-Google-Smtp-Source: ABdhPJyyHrqiZOq0CgmNuWf3MIYlzycSL/S4jw3z64p7JpV37Ev+7XaWoyp9VzZQnHDg59uyNPvWWWfIdeZOCWs4Je4=
X-Received: by 2002:a05:6512:31cd:: with SMTP id j13mr11045223lfe.586.1639592547336;
 Wed, 15 Dec 2021 10:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <20211129231830.1117781-5-namhyung@kernel.org>
 <011B6FDF-15F0-411F-98F2-155E95BE7047@linux.vnet.ibm.com> <CAM9d7cgaYC9BxeA3dRtb8CP+9BnFQ7pXgG9X+ku_CZ43i=ZqGg@mail.gmail.com>
 <CAM9d7cgnQOZVaCs7Yj=siBLkhK7Z5TmmXLBA+VkGs1S3PUOSTw@mail.gmail.com>
In-Reply-To: <CAM9d7cgnQOZVaCs7Yj=siBLkhK7Z5TmmXLBA+VkGs1S3PUOSTw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Dec 2021 10:22:16 -0800
Message-ID: <CAM9d7ch5qyDbBmv87Y5DXLN0Jz6tMMAxNF17_puMnPVO69=m3Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency subcommand
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
> Well, now we build perf with BPF by default.
> So I think it's ok to follow your suggestion.
> it'd show the usage and options when the -b option is used
> and BPF support is not enabled.

Oh, it seems we're not there yet. :)
But anyway I think we can get there soon so I'll make the change.

Thanks,
Namhyung

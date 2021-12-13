Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6E47351F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbhLMTka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:40:30 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42659 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLMTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:40:29 -0500
Received: by mail-lf1-f53.google.com with SMTP id t26so32868286lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pA0BhK7wOH6CJ9spPsUs0dq0xLQhqSwH3MNawG5Z8d8=;
        b=I0vPbpg9i6M+uvwyfZAlbhKTIZLZWafTXOBOWRAMCRA8MhOb7r4isthuAWmKAW9XKk
         CcFTpgCkvu/9yEBMcXvoiGBCsLj96xkM9QQjZG4ncnbqAxnqXiibYYmh056GlcyytC5x
         Hmf7ddKYHvgjbS7vZMNUupf51mmq9RhzbA93zODMz9++N1eUyNusxiYXWVF4VCIdgbW1
         Z53OpwhvJRqTCLnCr/vcLLVx9WU7dOh1vuVH7OlIjhx9QMUGG2ITcIuM6nZFV0dweHJg
         mp7rsgIyZU6ZgrkLUmmQ0byLuPPl6KTXppI0si00/luERY5xs8ffJ2HriGPRESelYazL
         z7zQ==
X-Gm-Message-State: AOAM531W3fMsbNwP2OeCVK9rQX1GFPlOl5RZCN7VFohZLvkSb8cEVEgH
        83bUJHVhgE8kMKDAGCWNuW8gaboWCRWI/koWAzM=
X-Google-Smtp-Source: ABdhPJx2edp3sy9vnPhJ7Yj52DH5GED4ACa8wLIl+1ZsAyvky1EHjS3+FTiwU22Rfv8c+KQN0pnO9Ry3i3YL68sah5A=
X-Received: by 2002:a05:6512:220f:: with SMTP id h15mr370405lfu.454.1639424427864;
 Mon, 13 Dec 2021 11:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <YbePytGwg9Kb7hT1@kernel.org>
In-Reply-To: <YbePytGwg9Kb7hT1@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Dec 2021 11:40:16 -0800
Message-ID: <CAM9d7ciqzb4CArnzMf20x7XccwvmPSzCdk3w7Hhu=qg9TuD4vw@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
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

On Mon, Dec 13, 2021 at 10:24 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > Hello,
> >
> > I've implemented 'latency' subcommand in the perf ftrace command to
> > show a histogram of function latency.
>
> This still applies cleanly, I'll test it later.

Thank you Arnaldo!  While I have some small modifications
but the functionality should be the same.  Please let me know
if you have any suggestions.

Thanks,
Namhyung

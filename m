Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4122A47C6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbhLUSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:33:41 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhLUSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:33:40 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA844-1nADHt0GWg-00Bc2W; Tue, 21 Dec 2021 19:33:39 +0100
Received: by mail-lj1-f169.google.com with SMTP id b19so22741727ljr.12;
        Tue, 21 Dec 2021 10:33:38 -0800 (PST)
X-Gm-Message-State: AOAM532SPmI13WrRQtDIXB/w4seTF8AOxEwKfqq6HzsxzA57lkvnGT5i
        dbr6QYroCg7d+VNa/Hc4qJiCAcFTR6OPeQnKnEo=
X-Google-Smtp-Source: ABdhPJxLPfvoBB+dfcIJaQqwJtQ3BevGRPxqadC+I3rCQp9PvcGuMoU65G3rfQPJYAfstpb2qB1NqFuHBwuqdhFOzcw=
X-Received: by 2002:adf:f051:: with SMTP id t17mr3447981wro.192.1640107753248;
 Tue, 21 Dec 2021 09:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20211221170057.2637763-1-guoren@kernel.org> <20211221170057.2637763-2-guoren@kernel.org>
In-Reply-To: <20211221170057.2637763-2-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:28:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_Ha89oH5NYx6zPzTBj9y8spCAeihcbjqQVriDv9jCaQ@mail.gmail.com>
Message-ID: <CAK8P3a3_Ha89oH5NYx6zPzTBj9y8spCAeihcbjqQVriDv9jCaQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] sched: Remove unused TASK_SIZE_OF
To:     Guo Ren <guoren@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.or>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3mNbFTCsQCLdexz0lNRo7TDSExMnsNoRzl52Qq/10skgGsq2NMd
 hiMJFIjrjHOsJbCIQ2PZlecBeRVIyEtSWhqQCHAOcc9DlhwKnHjpRmSwxlc8g2zCe96Mus1
 8FmqMzpqsC4uw1H9Tz5v8Fo93CvLxelyRSG5sauhkcHZFjLjtbkhLeLgMaYR76RvPbFUHtz
 +t+D5cUkHr3tJDE4XA80Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CHGcO7wWq08=:cVqUL4HobZ3TNA+3TxwBet
 S4yYsR4PXHvryR/gSO1/judUKjOugN9nF1ZxLBsxSvTsarjPeb/FVfNHW8naWN5EH80jzREgm
 cQbg0mTLWlh/oFD/xa3LAO23GAvrl0DxWdwsawe7HPn79Tu3ZGXluXqH9GMxINOp9mkzwX9Pi
 8wIbwWB0wiR6syfmfzCKcGzbna2Cl7/PI4/9cwhf8QmYJFLX+IHnydTm+JfuBIzzmEC10NQBx
 eUSauINKD41TWgJshVo5eUTPAgqltRKPGg98+yP3LVlES5y1nGtMjb51WQriCazTKs0TNvbro
 V/g7J8i89XmqnYFWJvd8P51dJALReze2bcEyhzF9jQXlm+S4LZjmL7G++n8qS+Yy25fIr6ReD
 UPWAh3prCFRXVeq4GYR9AwRoYqOgF403QTyf9MaFh94OZQQzgwchwchti4BFPxtzQ9BCzhTCA
 6mVvUe8slt025xm5uhQ3Sd0KuTXCs+li63lrRLF5lmhwo/Vz40r7YLomTM/tSXcpbYnSmGHr8
 SiDXZn0JiQ9EFfyrmgvOJBM5TaoLAl5njbFm5zuS5V6MRFj+QXEyBKylYh5xSQVHkBxFYGNXi
 Q6xk4mfvM1q5BnQ0ms5+jodpKGM4dLv2RJJoDQ+OUUjoEOQ/QGoX/YzVjpLTF1uHRSeYkk2td
 W1C9fAObitMw5MYrjuRgDIdTuRO354XZZRyS9EWZO1wOAk94Wtu15/8dkk6viuL9agatbPQkU
 4KCbMsC0hu0CfLpwUgzRH+3ErL7dS3x+QWDVjWdR/u/GS7UWUH/R5CtobnLZ+6H3FVdvBua6P
 Rnd+OkzSXyl2x3upSaExdXTsqqEUhG3dnFi+PkqqAfq3uhcK+U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 6:00 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This macro isn't used in Linux, now. Delete in include/linux/sched.h
> and arch's include/asm. This would confuse people who are
> implementing the COMPAT feature for architecture.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

It would help to list how long it has been unused for. Looking through
the git history, I see commit a06db751c321 ("pagemap: check
permissions and capabilities at open time") removing the last user.

I would normally offer to take the entire series through the asm-generic
tree, as I do for this kind of cross-architecture work. I'll probably
not have time before the merge window to pick it up though, so it
may be better to go through the architecture trees, or possibly
linux-mm for anything that fails to get picked up.

For the series:

Review-by: Arnd Bergmann <arnd@arndb.de>

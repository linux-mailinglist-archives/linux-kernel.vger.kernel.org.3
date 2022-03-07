Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2334CF17E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiCGFzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiCGFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:55:37 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBB85B8BC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:54:43 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d07ae0b1c0so151374637b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 21:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QRos77OuYahI5W9WnsHXgbvlDejxkrLInVdGyJ2rr7E=;
        b=AWosRUzNwLSzhGtqZqZuQXj+VF1mkxwHARPfyirpW9O8wax8OzX3d2jKzUjBFnmRwW
         anTC0PT7t4VdwOw7XTPXsJsxxEYbEpk3lm+l+ARif9Cqkq+n7bwN/DmEZrHYfLAsnkGs
         NtHYcxSLr+3hIANbrqSb5fs5nTLTgqNBtXflGhdw8tRvRCqbq/QeTo88PXR8AdwiwH99
         ZfMfO/wq42o3JFGGW+ITQDTnkjNjkjmnjxXaWstalQOWXMrcuMCUbdXPVMsy69YcUcfn
         p0xK29odBS4uczBG21T7ky4emPLjylO5i9/dbTaGzYMjOOAF3ughjkE5JSjr20ixe18t
         W+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QRos77OuYahI5W9WnsHXgbvlDejxkrLInVdGyJ2rr7E=;
        b=TN+UqvflnqccobbCblAGoc+TWd+aV9n7bwFd3QUIBKAv5Y87IGKHk/hCxDWKGoaTPK
         Mj39YjT4ikuCWWp4EbrzKosY2OY029ZAqxnyzGRL7sJtWzpLJKLTAt/eWt0R1IQQH1WU
         CvTA435Jh1q7a/pOBUAJnzlJRQIUTdpMNvMuYgZeVwNATqcF2UpUVFSRs4BLSvABfGGJ
         C2ocWkuRUFf8jrfYVt5Rp46piRktzFnQYH1qiw/WAAPgAbqcsJZvA3aUXWky+6E4DDnl
         RH2iRKDR/rvivi7qOSm8TDQ20j9x2xFmyi7UPswZBE1jl+RbAlMiEkB1CbxIVeOwcXA4
         0hFw==
X-Gm-Message-State: AOAM5336wh1Q2BLAES4Pcilv73WhEm/jPoMjnYUQs6XoGbdOuKvLbJws
        dq2PjKR9fhncQtFPOZqR2cOjwCuXB7wihm4CNoSjsp7mNBiZQaJE
X-Google-Smtp-Source: ABdhPJxnXO99Bk7rlCpR71gVaxojOT74qux6nT3oX69nqDJll+EyEnhJvugccXHWpZo+oSqCY62Izbxf9jUaLp5Da8A=
X-Received: by 2002:a81:2f12:0:b0:2d7:d366:164a with SMTP id
 v18-20020a812f12000000b002d7d366164amr7509616ywv.265.1646632480686; Sun, 06
 Mar 2022 21:54:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs+Qc3rAONJBmyQXFnYmrzFBJ8GMpwWXBMpj3Nx6wQ0Hg@mail.gmail.com>
 <CAABZP2xHynkBmsk8mcvPujSL65fsj=hpM9acuMvmDOUYbWk0KQ@mail.gmail.com>
 <20220304194408.GP4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2x-1k_+nHzSvuD3EKD1cMSPiOFFnehJPQ7_QnaeDLpkGw@mail.gmail.com>
 <4d828b01-b636-e0b8-0241-656331f27de4@bytedance.com>
In-Reply-To: <4d828b01-b636-e0b8-0241-656331f27de4@bytedance.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Mar 2022 11:24:29 +0530
Message-ID: <CA+G9fYtsZYnaFW4FEYGjZBf1XLJ5b4JNUJX=_GH2WG7dKOicAw@mail.gmail.com>
Subject: Re: [External] Re: [next] WARNING: suspicious RCU usage :
 include/linux/cgroup.h:494 suspicious rcu_dereference_check() usage
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu <rcu@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 at 06:27, Chengming Zhou <zhouchengming@bytedance.com> w=
rote:
>
> On 2022/3/5 4:28 =E4=B8=8A=E5=8D=88, Zhouyi Zhou wrote:
> > Hi Paul
> >
> > Yes, your suggestion works!
> > Thank you for your guidance, this is the first time I ever did a
> > bisection, I gained greatly during this process!
>
> Hi Zhouyi, thanks for the bisection test.
> Could this patch solve RCU warning? I just tested on my machine and there
> is no RCU warning any more.

This patch solves the reported problem. The test link provided below [1].

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 1e356c222756..0d1ada8968d7 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
>  extern spinlock_t css_set_lock;
>  #define task_css_set_check(task, __c)                                  \
>         rcu_dereference_check((task)->cgroups,                          \
> +               rcu_read_lock_sched_held() ||                           \
>                 lockdep_is_held(&cgroup_mutex) ||                       \
>                 lockdep_is_held(&css_set_lock) ||                       \
>                 ((task)->flags & PF_EXITING) || (__c))
>


--
Linaro LKFT
https://lkft.linaro.org
[1] https://lkft.validation.linaro.org/scheduler/job/4664565#L339

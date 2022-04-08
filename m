Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306B4F9F79
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiDHWJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiDHWJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:09:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7C103BA3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:07:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c1c0500b0038ea8b53580so1389577wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+VvyxgM4OC0WGPCxjOrHikEcgfUYeLNJ6nZBCP3TDM=;
        b=SJ8M2veFjJT2Qdk5xL/pf73ibR4NHvl/y1gShehfLU0vGvBchmkSpneO1btkI4XW29
         AuMlzJcY9HuHPK06sJmI7rM2anSaU4UobFGOGm4BqLBRFClKYmGakJZWZyaj8Kh/Ynju
         A4cwKtQ+2xoaqDOiwjRW/GGYGwWMvMXbPPKS/fywSRBZTZz2nZF9zUJ+b7Zywppl5cjL
         QaoVEWTp1vxhbuuVLqit5OKi04mLFmqPWRWwDhlEHFCVVdA6K2iZuV8c385lK8OrSnYB
         E+1VhHu/mbhUt4Mh49Zjl80xRZ0/O2YQtpH0l1klGf6fiePYAE5fu9HHFd4TjJynnb/y
         eeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+VvyxgM4OC0WGPCxjOrHikEcgfUYeLNJ6nZBCP3TDM=;
        b=Ex/48PLt685SwNkYLrNnJQV0lhM3uxCDAWhknE7S/P2/WBLBu0JpXiL3ot849dFz+z
         YCFvq/4bwYv8/oXDJYprzyOJl7uP+JdPV5xPVP1v0jiCNxwv1SkuhYifX1Jhf6Mnq3YI
         Z4V3QKT7Kc5SMCd0LVduTIM1HMu1DRSIQ1VMJ2u55nzD3QbkQsZUOPXWhahi5FDvrayG
         poj1fB7R8sjvWPkbxYeOUmvv2DB/QmhkvkXNrWbgEaTUNHEjynDyqd734p9HrxGwTVmI
         pCIx5TjBy8tMyC8eotC15UdoF+oV9cSBFrsLYin8xUl4GDcZMT4oXLz0v4KOY4VuqHuc
         eBDw==
X-Gm-Message-State: AOAM530L6hjJipPSiFGksEtYXvXb3WNi+74zsv1i9TXyXfqRz+BjCaUe
        NbcYFRGXvx+0OpkXWotcaAl4X0ULklK61T5DfTipQQ==
X-Google-Smtp-Source: ABdhPJy+tpkyyQT7ltCQLVg6N+RT1dUBIkVnbWGcVx9CvkXrix+Y0StqVmDLI9LnfkWHKaRyyNXWMgXJKRQpIRmSQWY=
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id
 q22-20020a1ce916000000b0038eac96f477mr1659745wmc.160.1649455627870; Fri, 08
 Apr 2022 15:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1> <CAC_TJvf_ubOPUVpNYK9UUWXn5J5hpiTkOt2++kYTGbF9bM_pYw@mail.gmail.com>
 <20220408174245.65e1ec98@gandalf.local.home>
In-Reply-To: <20220408174245.65e1ec98@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 8 Apr 2022 15:06:56 -0700
Message-ID: <CAC_TJvcO6WQMkfrZ5uBGj1vHG0BkRdnZYS5A_oTpWiHo3uhY7A@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 8, 2022 at 2:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 8 Apr 2022 10:53:53 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > If PREEMT_RT systems don=E2=80=99t disable expedited grace periods, we =
can
> > remove default off for those. Steve?
>
> Yep, commit 36221e109eb20 ("rcu: Enable rcu_normal_after_boot
> unconditionally for RT") is still there.
>
> OK, that explains it. I missed that change, so I didn't see the relation =
to
> PREEMPT_RT. It wasn't described in the change log nor was there any
> comment in the kconfig to say why it was special. Perhaps that should be
> added for those that don't know all this tribal knowledge ;-)

Thanks for verifying Steve. I'll update the commit and Kconfig texts
accordingly.

-Kalesh

>
> -- Steve
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

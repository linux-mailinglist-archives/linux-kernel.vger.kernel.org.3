Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144654C9870
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbiCAWjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiCAWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:39:43 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46AA3DDD3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:39:01 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j12so30192784ybh.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 14:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yt7b8oHQQpYaUvb/xOL7JlfwQ71+X5i0XbUTbCl8pc=;
        b=MOiMICj8Wo+edtTXbRvEJBGehmbkn84kMCiG2WRa/hekMCxrbf1OqvNVg9dcoaTrII
         OseVEzr4ahjRA3JZL02HlfN10JrfJP9reNBqtYfYHkrFY1gh2iDAeihUMlNfKprRsPsf
         +iUK4ERA1lLMS7GBmWCh0zY7wAFnDrBG6lc0x1WmWhvDnRelkLQDOHsCY0pjrPePgHcp
         WdtuvcyRzTta6RlfnDXQs+IEFoereErXffJ9g3XORW8HajxXG82U0XSELTnNzF9InJAG
         VncslWcDbJ/rcFFffO8AzhQSGhVaLLahd1o+BrEGfonrXW1U4aZOso7oo9qGI+KsCwIZ
         2/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yt7b8oHQQpYaUvb/xOL7JlfwQ71+X5i0XbUTbCl8pc=;
        b=Uugx2WDqRvqxPRaYJDVw/LFLX76l8fjn/ZHgTLbpAx7tRZPNSzMam/lf3nh+hLon4x
         L+HxV/gF387F5xmWKRh+HLttCHEJ/JSfeJ236aaIpcdOHNJHVQ4yUr81OfskWfvirqdg
         ny+X0sMgV7LuZwQZEBSgR6S5DxA9RVvehlyoi8LvEJPzigXmANBLhYTP5A22K8clxl3J
         4W6JHwS2VWCdyxHNCNY+Gfc/25jkUmHN51fO4sDyECZOAH7JrJZ0JicOb+z9oDVyBMDp
         +BonRwyRi+464UwLthsXAfyE/urKCGks6gTFXIlTEqSiMxrbYeSv5OKM1NlnmmAE/qio
         E0IQ==
X-Gm-Message-State: AOAM533QLWWRYjEODyn0RnPT9sht+fsN9sosJcRoiIjcpz92dgAyHN+D
        SFkcrQqtfRdaQmKoYuIygJB2AOGs0CTe5whB6ZTFmg==
X-Google-Smtp-Source: ABdhPJwApfTtLcuZXzoEx2VW3+6EHQyuHdjbYtN8ybo8wgps1P6qvVNiTqzaLiiC34CsJcy7qQ4Kr63U4gxKZM4FfJ4=
X-Received: by 2002:a25:32d4:0:b0:628:9974:3baf with SMTP id
 y203-20020a2532d4000000b0062899743bafmr1349119yby.497.1646174340805; Tue, 01
 Mar 2022 14:39:00 -0800 (PST)
MIME-Version: 1.0
References: <1646105865-22040-1-git-send-email-baihaowen88@gmail.com>
In-Reply-To: <1646105865-22040-1-git-send-email-baihaowen88@gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Mar 2022 14:38:49 -0800
Message-ID: <CABk29NufkSnuN_q+JHFNB=v_cO+VO+QSRLT4UL6=Awrkz8y=8w@mail.gmail.com>
Subject: Re: [PATCH] sched/core: remove unneeded semicolon
To:     Haowen Bai <baihaowen88@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 7:37 PM Haowen Bai <baihaowen88@gmail.com> wrote:
>
> Eliminate the following coccicheck warning:
> kernel/sched/core_sched.c:210:2-3: Unneeded semicolon
>
> Signed-off-by: Haowen Bai <baihaowen88@gmail.com>

Thanks,

Reviewed-by: Josh Don <joshdon@google.com>

> ---
>  kernel/sched/core_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index c8746a9..085f188 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -207,7 +207,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>         default:
>                 err = -EINVAL;
>                 goto out;
> -       };
> +       }
>
>         if (type == PIDTYPE_PID) {
>                 __sched_core_set(task, cookie);
> --
> 2.7.4
>

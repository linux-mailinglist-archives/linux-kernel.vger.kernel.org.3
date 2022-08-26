Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1253D5A30E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiHZVQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHZVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:16:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B969F74
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:16:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t140so3470826oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zoQXi/bir9+Uqx0GG7/pJwKEH06DUGEvDo+WlIyrA7A=;
        b=ZSGeO83fxvEwTF/5+tTkk0NEhDJ7ajmr+K7tNbXx7c/3zahi/sU5tRafIPOFtXjkk5
         7e4IIp2ZyzEc34yBoTo4PdSztr6Avfxjvf/Bg8N/hnnWW5T4ONTfWO9i+mcfZCWB2dch
         dnoTWa2A+bZvEjzKKalGVE4Qtd7iqGpX46XEMi4X5BiBlyrTp463rTadJft4QMQdh4id
         y0JLUzFNnSUWpmFMiy2+6NZ6dKiFwmLwj6J4rqOPn98OpPuNb1GMzfwnchS/cpVRPgxa
         9DJV9nO9iMXnCwcrGjyrS3F2bPZ9rjmk0SArKG1t77L+ms592ABzHezaYbAcpdpzzP03
         Y/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zoQXi/bir9+Uqx0GG7/pJwKEH06DUGEvDo+WlIyrA7A=;
        b=Vl530Ib2BreDXdyicMXlyP9uT8Aka9NoMYfi1S19vAHBP9U+y99TiaabZivJTx8isd
         d94ah02pznoY553NM4Hj9/BshwwMfB4+P/cuegm7f16L4yubm7GDCKdSYVWsec73db1Z
         cUpCzh2FoYbiLihySb9O1194uh2BdhpFHJyEKZSfVjbD0KbxyRnzkfdPcuvIhuaPEYrg
         Yh3M8bKYk2TCu0YaHuBpi4GdBLh/7ERto2YzmHHuSMDc1FQMGFST81MvULgosz8C/f4b
         MsyM1SpSCbJ3RK68d5v4/DJZn1GnI/3uNATJsCOCfcVPr21R24OcJZVAMG+qeG7L7v+F
         Vr4A==
X-Gm-Message-State: ACgBeo2EoRrs64VxTNcNkJMYGTY2g8qeFh90hJqWk68gsd1IizO+9vyL
        OBFG49+Zghk5QQqBfgNxa/p4As1Hb7hllH2H0E87
X-Google-Smtp-Source: AA6agR4C+ItQqPA6D77rvJCw8+6VU8PhzgoW1DmMbjPVIip4QNMYjrrW3apdrlgMYPfg0FZtKpvnrJVhxMnX0JPlPjI=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr2519175oif.136.1661548583658; Fri, 26
 Aug 2022 14:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661449312.git.rgb@redhat.com> <f3653c1aebf95d206b0bcbdf59afe2498520cff2.1661449312.git.rgb@redhat.com>
In-Reply-To: <f3653c1aebf95d206b0bcbdf59afe2498520cff2.1661449312.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Aug 2022 17:16:12 -0400
Message-ID: <CAHC9VhRMpA6MW62ZrYUHAax99n59i8b4+C7w3_vyFGuORWCNtA@mail.gmail.com>
Subject: Re: [PATCH ghak138 v2 1/4] audit: audit_context pid unused, context
 enum comment fix
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The pid member of struct audit_context is never used.  Remove it.
>
> The audit_reset_context() comment about unconditionally resetting
> "ctx->state" should read "ctx->context".
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h   | 2 +-
>  kernel/auditsc.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

For future reference, this probably should have been split into two
patches too as there is no connection between the two changes.
However, it's trivial enough I'm just going to merge it now.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 58b66543b4d5..d6eb7b59c791 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -133,7 +133,7 @@ struct audit_context {
>         struct sockaddr_storage *sockaddr;
>         size_t sockaddr_len;
>                                 /* Save things to print about task_struct */
> -       pid_t               pid, ppid;
> +       pid_t               ppid;
>         kuid_t              uid, euid, suid, fsuid;
>         kgid_t              gid, egid, sgid, fsgid;
>         unsigned long       personality;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9226746dcf0a..21e50e6d0fc0 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -965,7 +965,7 @@ static void audit_reset_context(struct audit_context *ctx)
>         if (!ctx)
>                 return;
>
> -       /* if ctx is non-null, reset the "ctx->state" regardless */
> +       /* if ctx is non-null, reset the "ctx->context" regardless */
>         ctx->context = AUDIT_CTX_UNUSED;
>         if (ctx->dummy)
>                 return;
> @@ -1002,7 +1002,7 @@ static void audit_reset_context(struct audit_context *ctx)
>         kfree(ctx->sockaddr);
>         ctx->sockaddr = NULL;
>         ctx->sockaddr_len = 0;
> -       ctx->pid = ctx->ppid = 0;
> +       ctx->ppid = 0;
>         ctx->uid = ctx->euid = ctx->suid = ctx->fsuid = KUIDT_INIT(0);
>         ctx->gid = ctx->egid = ctx->sgid = ctx->fsgid = KGIDT_INIT(0);
>         ctx->personality = 0;
> --
> 2.27.0

-- 
paul-moore.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807745170D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385405AbiEBNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385388AbiEBNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:47:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17512083;
        Mon,  2 May 2022 06:43:46 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e2442907a1so14286099fac.8;
        Mon, 02 May 2022 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SZS23R8/3aS8hn+ag0EZfvYi/qn+HWC2fpxjigLbwL8=;
        b=UNP4TjQWPwuVfp6XRBKcHnbi9I4brVINNlFFUvNcomXdIyUvMEsQNN/iBMGOIy6qXa
         U3HAa0YA6qIqgWWa7RDcWOuxj4VFnBkmEPEEDXzGU5fgiifoe8kN99AuoMjGF64Y5i5P
         80X+b7Sf99p7MyvucsH42RJOdepw/RQmgftXwISAoVFzarZzYeropcyinM1RCiN0MZnw
         cWN8rbJqp19kEs9oY6XOVASDAzidg4e3jOKDIEpX3699n5X31emqcJlE9vLMVGieyZPH
         lbl6f4fl/XE7+ICY+6C7n0BzFjikw56P8rtVitnftt0aqaKDGbyvux2ZfxFXUF8nmgFe
         WZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SZS23R8/3aS8hn+ag0EZfvYi/qn+HWC2fpxjigLbwL8=;
        b=vIx75l6WsQlkQRGbl3C7s6cNZj+oex3Bbua21XVOywPiLJRzVwP3JZjkZvvpBVpvmC
         KljfcIuLdTj8xhVUFI7iMsH5Lkg4TKipOkFIIT4XR57AdpZQqelRzTJIT7RVEMUhA0Cg
         yLZztf09sGp8T/byXx1TXU4rzivJbPHLpQ32RtXcsJPKX71/m1nUlJ4KVGgvJm2bY9v0
         eWX12eR09545dNwfBqK45ojFPBKjeB25k6vMAiYgMy8XUvEys+proUPKYiTla+o3QoBE
         TQxdp6J8kyj5pbe4cJ4CxqXa52iCfkDi1UPUfk/M8rP1CrwAhbmoX7WNqCGJy5cP0cPO
         U0Iw==
X-Gm-Message-State: AOAM533d6ViGG29Uk8FgmwxF1NNzsKEs3T0t3GY6cDkkuExXND8nIwjY
        Hi88bQynfkyN5hldBcox/+ixwKbO/J+Z158FVmM=
X-Google-Smtp-Source: ABdhPJwHclCFT2TQxVLkZG72hIFxYuXSoE1SrnGa/xh8TsP31EvTN9bhqMxe1iprI9aSI30jJu4aiUovupdu6b4WshU=
X-Received: by 2002:a05:6870:d0ce:b0:ed:9988:ba91 with SMTP id
 k14-20020a056870d0ce00b000ed9988ba91mr3217956oaa.205.1651499026041; Mon, 02
 May 2022 06:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-4-cgzones@googlemail.com> <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
 <CAJ2a_DcY3=jz_zBQ7QZ_gycsvL1mn=TxKaWqWr3gGLhEAXTcQA@mail.gmail.com>
In-Reply-To: <CAJ2a_DcY3=jz_zBQ7QZ_gycsvL1mn=TxKaWqWr3gGLhEAXTcQA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 2 May 2022 15:43:35 +0200
Message-ID: <CAJ2a_De2o7+v2v4QDnXNB=q9N6J84iMz8QMe6vK7ojvxVhfqqQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 at 17:09, Christian G=C3=B6ttsche <cgzones@googlemail.co=
m> wrote:
>
> On Fri, 18 Feb 2022 at 18:31, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> >
> > On Thu, Feb 17, 2022 at 6:22 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> > > introduced a NULL check on the context after a successful call to
> > > security_sid_to_context().  This is on the one hand redundant after
> > > checking for success and on the other hand insufficient on an actual
> > > NULL pointer, since the context is passed to seq_escape() leading to =
a
> > > call of strlen() on it.
> > >
> > > Reported by Clang analyzer:
> > >
> > >     In file included from security/selinux/hooks.c:28:
> > >     In file included from ./include/linux/tracehook.h:50:
> > >     In file included from ./include/linux/memcontrol.h:13:
> > >     In file included from ./include/linux/cgroup.h:18:
> > >     ./include/linux/seq_file.h:136:25: warning: Null pointer passed a=
s 1st argument to string length function [unix.cstring.NullArg]
> > >             seq_escape_mem(m, src, strlen(src), flags, esc);
> > >                                    ^~~~~~~~~~~
> >
> > I'm guessing there was more to this trace for this instance of this war=
ning?
>
> Yes, complete output appended at the end.
>
> >
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  security/selinux/hooks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 1e69f88eb326..ac802b99d36c 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -1020,7 +1020,7 @@ static int show_sid(struct seq_file *m, u32 sid=
)
> > >         rc =3D security_sid_to_context(&selinux_state, sid,
> > >                                              &context, &len);
> > >         if (!rc) {
> >
> > ^ perhaps changing this condition to:
> >
> > if (!rc && context) {
> >
> > It might be nice to retain the null ptr check should the semantics of
> > security_sid_to_context ever change.
>
> If I read the implementation of security_sid_to_context() and its callees
> correctly it should never return 0 (success) and not have populated its 3
> argument, unless the passed pointer was zero, which by passing the addres=
s
> of a stack variable - &context - is not the case).
>

Kindly ping;
is my analysis correct that after

    rc =3D security_sid_to_context(&selinux_state, sid,
                                                  &context, &len);

there is no possibility that rc is 0 AND context is NULL?

> >
> > > -               bool has_comma =3D context && strchr(context, ',');
> > > +               bool has_comma =3D strchr(context, ',');
> > >
> > >                 seq_putc(m, '=3D');
> > >                 if (has_comma)
> > > --
> > > 2.35.1
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
> clang-tidy report:
>
> ./include/linux/seq_file.h:136:25: warning: Null pointer passed as 1st
> argument to string length function
> [clang-analyzer-unix.cstring.NullArg]
>         seq_escape_mem(m, src, strlen(src), flags, esc);
>                                ^
> ./security/selinux/hooks.c:1041:6: note: Assuming the condition is false
>         if (!(sbsec->flags & SE_SBINITIALIZED))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./security/selinux/hooks.c:1041:2: note: Taking false branch
>         if (!(sbsec->flags & SE_SBINITIALIZED))
>         ^
> ./security/selinux/hooks.c:1044:6: note: Assuming the condition is false
>         if (!selinux_initialized(&selinux_state))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./security/selinux/hooks.c:1044:2: note: Taking false branch
>         if (!selinux_initialized(&selinux_state))
>         ^
> ./security/selinux/hooks.c:1047:6: note: Assuming the condition is true
>         if (sbsec->flags & FSCONTEXT_MNT) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./security/selinux/hooks.c:1047:2: note: Taking true branch
>         if (sbsec->flags & FSCONTEXT_MNT) {
>         ^
> ./security/selinux/hooks.c:1050:8: note: Calling 'show_sid'
>                 rc =3D show_sid(m, sbsec->sid);
>                      ^~~~~~~~~~~~~~~~~~~~~~~
> ./security/selinux/hooks.c:1020:7: note: Value assigned to 'context'
>         rc =3D security_sid_to_context(&selinux_state, sid,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./security/selinux/hooks.c:1022:6: note: Assuming 'rc' is 0
>         if (!rc) {
>             ^~~
> ./security/selinux/hooks.c:1022:2: note: Taking true branch
>         if (!rc) {
>         ^
> ./security/selinux/hooks.c:1023:20: note: Assuming 'context' is null
>                 bool has_comma =3D context && strchr(context, ',');
>                                  ^~~~~~~
> ./security/selinux/hooks.c:1023:28: note: Left side of '&&' is false
>                 bool has_comma =3D context && strchr(context, ',');
>                                          ^
> ./security/selinux/hooks.c:1026:7: note: 'has_comma' is false
>                 if (has_comma)
>                     ^~~~~~~~~
> ./security/selinux/hooks.c:1026:3: note: Taking false branch
>                 if (has_comma)
>                 ^
> ./security/selinux/hooks.c:1028:17: note: Passing null pointer value
> via 2nd parameter 's'
>                 seq_escape(m, context, "\"\n\\");
>                               ^~~~~~~
> ./security/selinux/hooks.c:1028:3: note: Calling 'seq_escape'
>                 seq_escape(m, context, "\"\n\\");
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/seq_file.h:152:20: note: Passing null pointer value
> via 2nd parameter 'src'
>         seq_escape_str(m, s, ESCAPE_OCTAL, esc);
>                           ^
> ././include/linux/seq_file.h:152:2: note: Calling 'seq_escape_str'
>         seq_escape_str(m, s, ESCAPE_OCTAL, esc);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/seq_file.h:136:25: note: Null pointer passed as 1st
> argument to string length function
>         seq_escape_mem(m, src, strlen(src), flags, esc);
>                                ^      ~~~

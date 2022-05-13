Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631A8526813
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382937AbiEMRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382906AbiEMRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:16:51 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE4340D1;
        Fri, 13 May 2022 10:16:47 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id i6-20020a4ab246000000b00362214ddc1cso916618ooo.2;
        Fri, 13 May 2022 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=17XIQCN9HbjdH4lGYv9BZgUeaBs5X8MuvFgeV6MIHSM=;
        b=erVEE23WczJeSpgLclTLAQXK//buxM37l0dzLtn8veqXh7R22zWSbBG/kR1IxPo8P2
         wZjOXEt3l0G7xVbRuoBZFwb+5h2lqpC2Gh03+57jEzl+nFMc2lr6MpejHolJCJ52VNss
         L2zwV/OdFXIXN79UP3/H4eJ/+QUr/A1/DWOGleeFmq5NFXrV9tBYapoQIuwOBeN0gAfk
         cM1kpOgZp3XslPlPUjhP2mQi9I6RXChxMZQgOokZQnhwd9XxSCXPgkwykQyr2VIhbpJ6
         w7Pyy/Dz8xrD6g39W47MySgr0VKvbe4FRjd/oH1oh9AHIrMy6IdGq+HuotXVlj31+MOh
         bjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=17XIQCN9HbjdH4lGYv9BZgUeaBs5X8MuvFgeV6MIHSM=;
        b=2Tk2k1gqR8EQfj3zlhCXrTLXwg0wq1Tktdw/iKTwA7j5bffqwBorkeA3eGkSRfUHZM
         dEIbsXpwZf9i6AjVYSkZ2UtOHc0/2OEe/XDXpH2EJjAPaYYr3pshjF9SnF7UEDFq6J6u
         xBELxDkjKG84pNjSVlR+v+8V16zrImnB8lBWqB3n1Eu5+fIBpN60yOeikV5kDP0u9Jru
         HWVYagCMusEdIYkSnkJB+DN53AaJT9isAetfqmmaozRyJNgFGgeLcdZt5vDEMrnkRefD
         S1VFDwg6X+lxjb2Mco2cXgUrxHjLC5OxS99KXvmfZXN7iox9zhTlYb5zwCb/9eofjD6W
         Firw==
X-Gm-Message-State: AOAM533Pscw1dGI41BDUjkqIjStjpm0vn7AUgvdlG9eXjFaQqLvxSwNr
        GFBJXj8x0HIr3iidkMV85I1DyfIGOf8g+pOyIDA=
X-Google-Smtp-Source: ABdhPJwLnyoKJxKyDeZ2OcDJ/kFUZNq0etrdSRCBA3E3rqDcgAeopBJ04bDChWjaWe/0W3KQymvIWGzpGm2yV5Xkw/4=
X-Received: by 2002:a4a:eb10:0:b0:35e:b454:40ec with SMTP id
 f16-20020a4aeb10000000b0035eb45440ecmr2300614ooj.49.1652462206949; Fri, 13
 May 2022 10:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220217141858.71281-1-cgzones@googlemail.com>
 <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com> <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
 <CAHC9VhR-Xk65iSfZxVvaK+mJoFszxT2E8vF=cus1aAKcB0EgYg@mail.gmail.com>
In-Reply-To: <CAHC9VhR-Xk65iSfZxVvaK+mJoFszxT2E8vF=cus1aAKcB0EgYg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 13 May 2022 19:16:36 +0200
Message-ID: <CAJ2a_Ddy8Kkp6SHxktguSQ4WqHwpA=zrQUz8UYkajF5-YtPerw@mail.gmail.com>
Subject: Re: [PATCH] security: declare member holding string literal const
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Todd Kjos <tkjos@google.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, 3 May 2022 at 22:02, Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, May 2, 2022 at 9:38 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > On Thu, 17 Feb 2022 at 23:50, Casey Schaufler <casey@schaufler-ca.com> =
wrote:
> > > On 2/17/2022 6:18 AM, Christian G=C3=B6ttsche wrote:
> > > > The struct security_hook_list member lsm is assigned in
> > > > security_add_hooks() with string literals passed from the individua=
l
> > > > security modules.  Declare the function parameter and the struct me=
mber
> > > > const to signal their immutability.
> > > >
> > > > Reported by Clang [-Wwrite-strings]:
> > > >
> > > >      security/selinux/hooks.c:7388:63: error: passing 'const char [=
8]' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatib=
le-pointer-types-discards-qualifiers]
> > > >              security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_h=
ooks), selinux);
> > > >                                                                    =
       ^~~~~~~~~
> > > >      ./include/linux/lsm_hooks.h:1629:11: note: passing argument to=
 parameter 'lsm' here
> > > >                                      char *lsm);
> > > >                                            ^
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > >
> >
> > Kindly ping;
> > any progress on this one?
>
> I've already added my Reviewed-by tag, as has Casey, so I think it's
> pretty "safe" at this point.  The next step is for James to pull this
> into the LSM tree.  If it is still collecting dust at the end of this
> week, ping us again and I can just go ahead and pull it into the
> SELinux tree, it's small enough that it shouldn't cause any problems.

end-of-the-week-ping

>
> --
> paul-moore.com

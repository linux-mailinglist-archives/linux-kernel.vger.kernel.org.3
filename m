Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDA518DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiECUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECUGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:06:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8D403C9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:02:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so3257586pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lO/St+o2/PonjjcblNEybj23wOVCI5+m6U1+OI/TnZE=;
        b=PCvGCzsvIlu1EuXOzDqVzSwE4DAmJ15LlcKthP3s6kp4sJdaVpq9wwEcFLGha/McMd
         E2KG//amULHo4ISJDsiQ3tbmqYzmtcZUlJtCvhMEch/LKDRQZK8W0ShcLlfggWS3h0q7
         qkw6Ff1OihT0y0Hk+heZknTEeRzZmualGVja8NdrYSVda816O8WOKHPBRZ1XM0xH48Zp
         pheeFma0vOK2GncA1jZ/fqB0SubqSY44XUX/dLcAp8fUoktfTTqKnq2YJbL+oeV4X4ht
         4lCKXiUK/OJoyFM/YS8HdWvMOfMgFbGuz2D/V8hmJUhMncrWk2CW4UwrQeubLmzIzkw4
         k6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lO/St+o2/PonjjcblNEybj23wOVCI5+m6U1+OI/TnZE=;
        b=vsrbZ7y96x89vWYKW5TiSvea7T9MCi/XOEz3JQgPcs1q1N001zjfwGOp5IuqC5NLbt
         q7hZz0F4z7W40dmKXtFo7mJJqOV7YRPFhC0dTFqywzbnEK1CM9GsF3UUDbPf3PXinS39
         oywUw2iwvzpdOQQ+LP7ixCoOzUoE7BCYfPuz6/YxjKPyNck97tvBCm7w5Q1W95PyCNan
         omkkOHDWPTwZc6pCAdCJy4veh9raEYXVf/sSyzIgeb7hj6LAxq47Qe4qGacgogtiE9aN
         34Z3u9eMHKceEstrisNE80cfZozpYkyFQJ5SS3dGNo2DAIvnNfOgHX0OZgUaBFsgsqrw
         cc/Q==
X-Gm-Message-State: AOAM532ZDnI6PsddHdeFnK9ATlGTWVlQYaJlX7f/eofnTIrnqgXYnIkj
        cb/507o1qLt216t2kWPYCVHvcRrJ9/JjJ9SMBPP7
X-Google-Smtp-Source: ABdhPJyGr+c8LNlbNNBXcpq/E9lvU6ileaoiIgySTkkuyQiPg6JdjkUnr0umPie0YLBfSrHZOOgapp9FoirQubuXdyk=
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id
 n20-20020a17090a929400b001b948e9a030mr6495804pjo.200.1651608165644; Tue, 03
 May 2022 13:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220217141858.71281-1-cgzones@googlemail.com>
 <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com> <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
In-Reply-To: <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 16:02:34 -0400
Message-ID: <CAHC9VhR-Xk65iSfZxVvaK+mJoFszxT2E8vF=cus1aAKcB0EgYg@mail.gmail.com>
Subject: Re: [PATCH] security: declare member holding string literal const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:38 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 17 Feb 2022 at 23:50, Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
> > On 2/17/2022 6:18 AM, Christian G=C3=B6ttsche wrote:
> > > The struct security_hook_list member lsm is assigned in
> > > security_add_hooks() with string literals passed from the individual
> > > security modules.  Declare the function parameter and the struct memb=
er
> > > const to signal their immutability.
> > >
> > > Reported by Clang [-Wwrite-strings]:
> > >
> > >      security/selinux/hooks.c:7388:63: error: passing 'const char [8]=
' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible=
-pointer-types-discards-qualifiers]
> > >              security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hoo=
ks), selinux);
> > >                                                                      =
     ^~~~~~~~~
> > >      ./include/linux/lsm_hooks.h:1629:11: note: passing argument to p=
arameter 'lsm' here
> > >                                      char *lsm);
> > >                                            ^
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >
>
> Kindly ping;
> any progress on this one?

I've already added my Reviewed-by tag, as has Casey, so I think it's
pretty "safe" at this point.  The next step is for James to pull this
into the LSM tree.  If it is still collecting dust at the end of this
week, ping us again and I can just go ahead and pull it into the
SELinux tree, it's small enough that it shouldn't cause any problems.

--=20
paul-moore.com

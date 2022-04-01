Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C14EF6D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351493AbiDAPow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351526AbiDAPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:02:44 -0400
X-Greylist: delayed 213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 07:49:48 PDT
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A907D1890CB;
        Fri,  1 Apr 2022 07:49:48 -0700 (PDT)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-08.nifty.com with ESMTP id 231EhIC2011450;
        Fri, 1 Apr 2022 23:43:18 +0900
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 231Eh0GW032000;
        Fri, 1 Apr 2022 23:43:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 231Eh0GW032000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648824181;
        bh=pPkpLJjqF9Yl8JZ9lb7atfYgopqKf4JA2yqLOKb+X7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=StqsOj0XruXNEcabrRU/zt44ETt3d9h8XBTiihw4ozExeOhP1ckh/m/BQLuhEtWsH
         zYl6H2LT+r+u2H96XrSI6SPpvdWtLIW65J/0dfA85uQX22OI730J1yRJhcpH01bWET
         RaHKY65tFcfK4aOpvBnuwgJvjiNyRcJcv4iC/cDR6kP7xd7+cyLWRmAyDuYKryzwwF
         0NXTNrFGctmUwHieSissXNyg+NcLUZQDZu6iK8Rp9ORXZ7jOEQjuag8ULiOjKq7WO6
         86wQstAF2rAseksvRPagTSPJEN9VSOcIZbeGCo+DXpoFzRF8PMVASIUwsmaEcy/T4/
         VRpwg92b+FlEw==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso5523149pju.2;
        Fri, 01 Apr 2022 07:43:01 -0700 (PDT)
X-Gm-Message-State: AOAM533G1AnuXRUX43hGEWRQ09oXxLXAFPRHhVDbPiwzssngdjwmKDMy
        3D43vhOx+M8GW8A9f9fS5hv8vos2xb0hw0C7YP8=
X-Google-Smtp-Source: ABdhPJwm3WDvn+qqoBl9vEAKSvltgWEllK6Juf8EcRNrgCxMJlVkmDr8cKr3y/KPXf1kcKW48bhtB9B5cRIrRVdWt+M=
X-Received: by 2002:a17:902:b68c:b0:153:bd06:85ad with SMTP id
 c12-20020a170902b68c00b00153bd0685admr10793374pls.99.1648824180114; Fri, 01
 Apr 2022 07:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220306223016.2239094-1-ctshao@google.com> <CAKwvOdnmtRYnSx3VvG=PEnzpzWa8f=0bn1xDymjER5EShS2tmw@mail.gmail.com>
 <YiaMJCHOOuujHwiK@google.com> <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
 <YjFQvhv7I6w8xjbK@google.com> <CAK7LNATmPXs6f-Oe4XmfcZSRPsCsuexSebA=4-jyNsMYHu9cag@mail.gmail.com>
 <CAKwvOd=D22k53yXFC=E=VkJotn6q-AYCu5QsaFPmH_v+fWGVwA@mail.gmail.com>
 <YjovutS5McV8A8z4@google.com> <CAJpZYjXxFBz-d5qCbHLcdbPsqMJ569_91NDcsuRZ02g9QpiQBw@mail.gmail.com>
In-Reply-To: <CAJpZYjXxFBz-d5qCbHLcdbPsqMJ569_91NDcsuRZ02g9QpiQBw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Apr 2022 23:42:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdXJNX1HAhsmOS5NCrgb71Sj_GNKeaZjhk0bmm1bHODg@mail.gmail.com>
Message-ID: <CAK7LNASdXJNX1HAhsmOS5NCrgb71Sj_GNKeaZjhk0bmm1bHODg@mail.gmail.com>
Subject: Re: [PATCH v4] config: Allow kernel installation packaging to
 override pkg-config
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org, DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 6:58 AM Chun-Tse Shao <ctshao@google.com> wrote:
>
> On Tue, Mar 22, 2022 at 1:21 PM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 10:19:14AM -0700, Nick Desaulniers wrote:
> > > On Tue, Mar 22, 2022 at 12:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 16, 2022 at 11:51 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > >
> > > > > Tue, Mar 08, 2022 at 01:01:45PM +0900, Masahiro Yamada wrote:
> > > > > > On Tue, Mar 8, 2022 at 7:50 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 07, 2022 at 10:17:17AM -0800, Nick Desaulniers wrote:
> > > > > > > > On Sun, Mar 6, 2022 at 2:39 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > > > > > > > > what pkg-config and parameters are used.
> > > > > > > >
> > > > > > > > Sorry, kind a late thought here for v4, but we don't seem to prefix
> > > > > > > > many other host side tools with HOST_, i.e. LEX, YACC, AWK, PERL,
> > > > > > > > PYTHON3, etc.  Maybe just having the variable identifier be simply
> > > > > > > > PKGCONFIG rather than HOSTPKG_CONFIG then put it at the end of the
> > > > > > > > list in the top level Makefile after ZSTD (i.e. the list of host
> > > > > > > > tools)?  There's HOST_ prefixes when there's more than one tool
> > > > > > > > involved (i.e. host compiler vs target compiler), but I suspect
> > > > > > > > there's no such distinction for the existing uses of pkg-config?
> > > > > > > >
> > > > > > > Thanks for your suggestion, Nick! Yes I think it makes sense with PKGCONFIG
> > > > > > > instead of HOSTPKG_CONFIG since there is only one tool involved. I will
> > > > > > > work on it and submit a new patch.
> > > > > > >
> > > > > >
> > > > > > Please hold on.
> > > > > >
> > > > > > I was also wondering what to do with the "HOST" prefix.
> > > > > >
> > > > > > Libraries are usually arch-dependent.
> > > > > > (in other words, pkg-config should return different library paths
> > > > > > for $(CC) and $(HOSTCC) )
> > > > > >
> > > > > > You already understood this, so you added "HOST" prefix.
> > > > > >
> > > > > >
> > > > > > Please let me take time for further discussion.
> > > > > > I will come back to this when I get some time.
> > > > > >
> > > > > >
> > > > >
> > > > > Hi Mashiro,
> > > > >
> > > > > I was wondering if you were able to look more into this.
> > > > >
> > > > > Thank you!
> > > > >
> > > > > -CT
> > > > >
> > > > > > In the meantime,
> > > > > >   a8a5cd8b472ca20e5b8fa649c43b3756867322f8
> > > > > > as reference info if you have not seen it.
> > > > > >
> > > > > >
> > > > > > How many distros support something like
> > > > > > "aarch64-linux-gnu-pkg-config"  ?
> > > > > >
> > > > > > Ubuntu 18.04 and 20.04 seem to support it.
> > > > > > I do not know for others.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > >
> > > >
> > > >
> > > > Sorry for the delay.
> > > > I am OK with the idea of allowing users to override the pkg-config command,
> > > > but I tend to take time before making a decision.
> > > >
> > > >
> > > >
> > > >
> > > > Does anybody have any insight / thoughts about the following points?
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > [Q1]   with/without "HOST" prefix
> > > >
> > > >
> > > > Apparently, "pkg-config" should return different libs/cflags
> > > > for $(CC) and $(HOSTCC).
> > > >
> > > > I think the non-prefixed macro name "PKG_CONFIG" should be
> > > > reserved for $(CC)  (building for the target system).
> > >
> > > Ok. I retract my comment on v4 about removing the HOST prefix then.
> > >
> > > >
> > > > "HOSTPKG_CONFIG" looks unbalanced
> > > > due to the underscore.
> > > >
> > > > Perhaps, "HOST_PKG_CONFIG" might be better?
> > >
> > > I'm fine with HOSTPKG_CONFIG (what's in v4); follows the style of
> > > HOSTCC and HOSTCXX.
> > >
> >
> > Agree, it should follow the style of HOSTCC/HOSTCXX.
> >
> > > >
> > > >
> > > >
> > > >
> > > > [Q2]    "pkg-config" vs "pkgconf"
> > > >
> > > > The traditional pkg-config implementation [1] is not actively
> > > > maintained these days.
> > > > The last commit was more than one year ago.
> > > >
> > > > The alternative one 'pkgconf' [2] is more active.
> > > >
> > > > In fact, Fedora already switched to 'pkgconf' [3].
> > > > Now 'pkg-config' is just a wrapper of 'pkgconf'.
> > > > Many distributions already support pkgconf.
> > > >
> > > >
> > > > I considered the shorter macro name "HOSTPKGCONF" and
> > > >
> > > >    HOSTPKGCONF  = pkgconf
> > > >
> > > > but I am not sure if this is the right decision.
> > > > Maybe we should stick to "PKG_CONFIG" / "HOST_PKG_CONFIG"
> > > > for the macro names.
> > > >
> > > >
> > > >   [1]  https://gitlab.freedesktop.org/pkg-config/pkg-config.git
> > > >   [2]  https://github.com/pkgconf/pkgconf.git
> > > >   [3]  https://fedoraproject.org/wiki/Changes/pkgconf_as_system_pkg-config_implementation
> > >
> > > If the folks sending this are working on CrOS, better find what's in
> > > their build system. Chun-Tse?
> > >
> > > (I feel like I'm behind the times again, like when `apt-get install`
> > > became old news in favor of `apt install`...)
> > >
> >
> > In Cros we only support pkg-config, and that is the reason we would like
> > to make this change in upstream.
> >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > [Q3] What is the trend of handling cross-compile by pkg-config (or pkgconf).
> > > >
> > > >
> > > > By default, pkg-config returns the libs/cflags for native builds.
> > > >
> > > > For cross builds, the search paths for the *.pc files must be changed
> > > > via the "PKG_CONFIG_LIBDIR" environment variable.
> > > >
> > > > To ease this, some distributions provide  <triplet>-pkg-config
> > > > (for example,   aarch64-linux-gnu-pkg-config).
> > > > This became the nationale for tools/build/feature/Makefile defining:
> > > >
> > > >    PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> > > >
> > > > But, this wrapper shell script is not always available.
> > > > I do not know how to do it with the LLVM tool suite.
> > > > I am not quite sure if this is the global solution.
> > > >
> > > >
> > > > These days, pkgconf supports another way, .personality file [4]
> > > > to specify the .pc search paths for cross builds.
> > > >
> > > > Is it reasonable to use an option to distinguish native / cross builds
> > > > and use the same macro   "PKG_CONFIG = pkg-config" everywhere ?
> > > >
> > > >
> > > > [4] http://manpages.ubuntu.com/manpages/focal/en/man5/pkgconf-personality.5.html
> > >
> > > I'm not sure, but do we need to cross that bridge for this patch if
> > > it's just adding support for the HOST? No cross pkg-config necessary,
> > > yet. (Famous last words).
> >
> > Agree with Nick.
> >
> > Thanks,
> > CT
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
>
> Hi Masahiro,
>
> I was wondering if you have any suggestions and thoughts.
>
> Thank you!
>
> -CT


Nobody was opposed to the macro name HOST_KG_CONFIG,
so I am fine.



I still see inconsistency in your patch, though.


For example, you did

       echo >&2 "* 'make xconfig' requires '${HOSTPKG_CONFIG}'. Please
install it."

in scripts/kconfig/qconf-cfg.sh


but, you kept

       echo >&2 "* 'make gconfig' requires 'pkg-config'. Please install it."

in scripts/kconfig/gconf-cfg.sh




Also, I prefer "kbuild:" to "config:"
for the patch subject.


-- 
Best Regards
Masahiro Yamada

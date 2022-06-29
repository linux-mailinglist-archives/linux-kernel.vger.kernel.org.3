Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1B7560C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiF2WTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiF2WTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:19:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB5221256
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:19:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z13so30374475lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJYcl9YB+xnoN7EibhZqbPDRxOFyOyjZ3ozqLBQeuo0=;
        b=SZRdGJxwnziLCDPKM99AU6cM10rFDJIPvgB0Q0Idntq/KOKh2T+gAIAubuayY5vZFK
         B0wlREQ/clB3BO5mYcpujdKjBZDoMGCQQJWUVQA/gf1y/VmsXv8n4uvlPxbZwRiB/PuQ
         QcvWLqbyV6Eiwq1FBgD1Pk3byDFDPR9S12z5bg+U2UySEfztEIArp0kZ5VJfqvlhKtdN
         h2LYBEzxnkFqSisNfbJ8fvfkMluS0B5U5L4f3SkK5xC9E1vyBJ8e61+aLAhJjFRHhk5/
         hEUgmsUx5U7z9CXChe4FAkIraJ6Dkua73tPuyNLZkFwBb0TKCP0of2vf4lQHZr1+cQYo
         /Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJYcl9YB+xnoN7EibhZqbPDRxOFyOyjZ3ozqLBQeuo0=;
        b=WHO+BhVwLSl+EBIF8Sj+rN2ylB8XPmqhVWommYc5EbfzcjqNxRMY/k1NADiMKB1EzQ
         IBACsJlOOwZu36uC/ZIug6FIkd3TKfm2Y6BsvUWcRIlIvPfMjJoxoXB/fool1PE0gvIl
         zLJhVRwRPqynAT7Ezi6MRR2TEs3JHoxzpVGArd6NfA30x0xl91Sv0uRX03ILtpj537P9
         oB1Lo0IXXCC2RrbBAshOlMZIOty03ytI7sEaeaNVWXjBpLuWOOaaBrMSDAuQp26iG+CX
         1YFCW2LlKdcrj9KLU4Qa/jJItCZ36SZzOYg2IeJj8AwRv+CQ4dqpXmNvClivmscuOdWE
         IO2g==
X-Gm-Message-State: AJIora+rpxa3qWT8+Mckg4ZInqANzo8TMoIh2AGMIsrnm1YpaUD+E2M7
        t67KC4cngwGzrlH2YFMyRmZQ+N0AllFffprwv02RVw==
X-Google-Smtp-Source: AGRyM1uvVYDiTDKzXuICbQx322hpAKw4k6p7p+AI4WbW71mzkNffQi4Tj1JfrYYqABpKSHbFezojUP8Bre0g+8Yt6TA=
X-Received: by 2002:ac2:548d:0:b0:47f:b55a:6f60 with SMTP id
 t13-20020ac2548d000000b0047fb55a6f60mr3391711lfk.627.1656541148436; Wed, 29
 Jun 2022 15:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220618005457.2379324-1-vipinsh@google.com> <CAHVum0euKMV+rCLXMQ4NuDAqowyeCkO1LheSafR2tm=R4aUfJw@mail.gmail.com>
 <YrqaKpdVDl8DBl4g@kroah.com>
In-Reply-To: <YrqaKpdVDl8DBl4g@kroah.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 29 Jun 2022 15:18:30 -0700
Message-ID: <CAHVum0f=_7kh_OrOqiTH=UZuvr3ZbxNcZeUSbT66x5r0q2XEgQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: Include tools directory in tags generation
To:     Greg KH <gregkh@linuxfoundation.org>, rkovhaev@gmail.com,
        cristian.ciocaltea@collabora.com, zackary.liu.pro@gmail.com,
        ripxorip@gmail.com, masahiroy@kernel.org, xujialu@vimux.org,
        "drjones@redhat.com" <drjones@redhat.com>
Cc:     dmatlack@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 27, 2022 at 11:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 27, 2022 at 10:47:35AM -0700, Vipin Sharma wrote:
> > On Fri, Jun 17, 2022 at 5:55 PM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > Add tools directory in generating tags and quiet the "No such file or
> > > directory" warnings.
> > >
> > > It reverts the changes introduced in commit 162343a876f1
> > > ("scripts/tags.sh: exclude tools directory from tags generation") while
> > > maintainig the original intent of the patch to get rid of the warnings.
> > > This allows the root level cscope files to include tools source code
> > > besides kernel and a single place to browse the code for both.
> > >
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > > ---
> > >
> > > I have found myself many times to browse tools and other part of the
> > > kernel code together. Excluding tools from the root level cscope makes
> > > it difficult to efficiently move between files and find user api
> > > definitions.
> > >
> > > Root cause of these warning is due to generated .cmd files which use
> > > relative paths in some files, I am not sure how to make them absolute
> > > file paths which can satisfy realpath warnings. Also, not sure if those
> > > warnings are helpful and should be kept. Passing "-q" to realpath seems
> > > easier solution. Please, let me know if there is a better alternative.
> > >
> > > Thanks
> > >
> > >  scripts/tags.sh | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > >
> > > diff --git a/scripts/tags.sh b/scripts/tags.sh
> > > index 01fab3d4f90b5..e137cf15aae9d 100755
> > > --- a/scripts/tags.sh
> > > +++ b/scripts/tags.sh
> > > @@ -25,13 +25,6 @@ else
> > >         tree=${srctree}/
> > >  fi
> > >
> > > -# ignore userspace tools
> > > -if [ -n "$COMPILED_SOURCE" ]; then
> > > -       ignore="$ignore ( -path ./tools ) -prune -o"
> > > -else
> > > -       ignore="$ignore ( -path ${tree}tools ) -prune -o"
> > > -fi
> > > -
> > >  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
> > >  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
> > >         ALLSOURCE_ARCHS=${SRCARCH}
> > > @@ -100,7 +93,7 @@ all_compiled_sources()
> > >                 find $ignore -name "*.cmd" -exec \
> > >                         grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
> > >                 awk '!a[$0]++'
> > > -       } | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> > > +       } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> > >         sort -u
> > >  }
> > >
> > > --
> > > 2.37.0.rc0.104.g0611611a94-goog
> > >
> >
> > Hi Greg,
> >
> > Any update on the patch?
>
> Nope!
>
> I don't really think we should add back in the tools to this, as if you
> want to search them, then can't you just generate the needed tags for
> the tools directory?
>

Some folders in the tools directory do provide cscope rules. However,
those tags can only be used when I open the vim in those directories.
For example, if I am writing a KVM selftest and I want to explore code
related to certain ioctl in kernel as well as some code in KVM
selftest library, I cannot use two cscope files (one in the kernel
root dir and another in tools/testing/selftests/kvm) in a single VIM
instance. It starts having issues with the file paths. If the root
level cscope file includes tools directory then all of the tags will
be at one place and makes it very easy to browse tools code along with
the rest of the kernel.

> But as I don't even use this script ever, it feels odd for me to be the
> one "owning" it, so it would be great if others could chime in who
> actually use it.
>

I have added some folks in this email who have touched this script
file in the last couple of years or use cscope, hopefully they can
chime in.

Thanks
Vipin

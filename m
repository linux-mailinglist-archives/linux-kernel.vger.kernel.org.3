Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4D53D8A2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbiFDVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiFDVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:34:57 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038E7193CA;
        Sat,  4 Jun 2022 14:34:55 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 254LYYqu008895;
        Sun, 5 Jun 2022 06:34:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 254LYYqu008895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654378475;
        bh=IpVg/6Qws8WGuU81larsHNdjCKY06mUkL/iICPp7YQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AAosMuX15O0jCfMFAPDbwmsmq6M6A5TcYTPjiQVqVET4fppFS+FCvVIsuaYk7oGiR
         BY6EuwGEbxLTbF2UFZILII0+jguDw+9iU/TgsJbMaR/9eGkefuCoFOC60Hxv1ZwtFF
         NyOv107qT5FqFBwvi6EPU+BL1mjyW7iaSG8WPMxh4dYQ3/0XdjTRFavuNWNhxtaqQo
         j6sia3X4keFDKnDfITI5U9q2SbTZ4d1rwUL2yk2VFBz4lQE7Aosy9LSMa0DWaSbAyv
         hCUWCElvIG/Te15FOvImtVjq51JrY8FISsoEfjxJmxbOCUvmFmRIImlKxSw0LDohVs
         dWuChmeso5icQ==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so14775305pjl.4;
        Sat, 04 Jun 2022 14:34:34 -0700 (PDT)
X-Gm-Message-State: AOAM531zPxBV3lpP2hgBMs8nyDi8H7tYHOH2n3XR4vHtscZg5CnQkvQA
        DTQX/1ZekmujMjYhSQg5GltHyuJKpAwkwx/qg7g=
X-Google-Smtp-Source: ABdhPJx8iNilm38SygiNhAU8B7xrjDK8QNC/9WFnm618RkCoBkgLxcGXizJBXyUCTbzyPYtRAFsv8hjFkBrFW95BEY4=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr16529178plh.99.1654378474015; Sat, 04
 Jun 2022 14:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATHyNjCaK+agk=DOTR8sPaOP9kBvS_xYaBUHfF+5Fzftg@mail.gmail.com>
 <CAHk-=wg-mH-_GYpkhz_psjBWG6ZcjKnPo83fg7YMj_by+-LRTQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg-mH-_GYpkhz_psjBWG6ZcjKnPo83fg7YMj_by+-LRTQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Jun 2022 06:33:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmd0bigp7HQ4fTzHw5ugZMkSb3UXG7L4fxpGbqkRKESA@mail.gmail.com>
Message-ID: <CAK7LNATmd0bigp7HQ4fTzHw5ugZMkSb3UXG7L4fxpGbqkRKESA@mail.gmail.com>
Subject: Re: [GIT PULL] More Kbuild updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 5, 2022 at 5:25 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jun 3, 2022 at 9:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> >  - Fix modpost to detect EXPORT_SYMBOL marked as __init or__exit
> >    (This uncovered a couple of potential issues of exported symbols)
>
> I pulled, and then unpulled again, since this introduces new warnings.
>
> If you introduce new checks, you fix what it checks.
>
> And if the warnings didn't get sorted out, then it wasn't ready to be merged.
>
> There's a  good *reason* I require a clean build: non-clean builds
> just mean that people will ignore new warnings because they think they
> are the old ones that they have already seen.
>
> So no, it is *NOT* ok to introduce new warnings and think "people will
> fix these up because now there are warnings about it".
>
> Quite the reverse. People not only *won't* fix things up, and it will
> just hide new warnings from *other* things instead.
>
>                    Linus


OK, I will drop the offending commit
and send v2.


-- 
Best Regards
Masahiro Yamada

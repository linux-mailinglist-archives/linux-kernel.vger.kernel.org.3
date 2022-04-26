Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7A50F192
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiDZHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbiDZHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:01:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909A5DE67;
        Mon, 25 Apr 2022 23:58:11 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p65so31215197ybp.9;
        Mon, 25 Apr 2022 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7yRqtTQTTbmtbqFkDbH3OPtikPIs3kbhA8R9oT1fjtA=;
        b=bRBHixiG98kSSWlYRVnV48E5Za2aabxiGVPKzUUBMlsIX+gyTi3pwFGmzS7ddnDJWm
         sUJEjXJa9129BlLE2TIJdJqvmDb/mHh6njg0fOaxhqkZY5W7JdLWNyYfVAgjNvlisVUI
         mDiH6P/0JsNkOC4/KjxtgJCHSxhvsjFc0S8L9d/phQnhrDO0zAeZ1srks+2WPZyAQDnJ
         HsvLflr5Ph6LDs3BTugcP39vZ5R4QRv10eRMFQY5IblVSLNb5xq1lI83bot0t/hKF8VN
         Jkq3INh6dha6+8cQuQ11K4ESawBU63J8jqMQTVYnQ4rvyvRv+t+j9oS4d5Oaty33jDgW
         53iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7yRqtTQTTbmtbqFkDbH3OPtikPIs3kbhA8R9oT1fjtA=;
        b=ZnFNJsjqMXOuf+vCFwoANXyXGtd9nlBrHKK23r0zx32lUaJJ4IUHHEEkjziod9WKro
         W4JKpQ7IdLFRd618srbFCoXINpwbGd36PzU0ktY59alSCzffUfxzrv8PUG1iEdBhHJxy
         t8pajgwdQos3qvMt9wXZbEAyyHK3iV35TvFUPMgb5XpjyUZ5lgYZwyKsKCtgLTXgaLFy
         sOJtFZCgRg0CB4h5Ro7JATxUkLzmJRaV/mWwuh5SxOP3J15xytNPVpD0kvlmfK3wmzVN
         ztxh5df3RXaee6NP/W1upOTu9yT6X4G0Ojo57pzNrSxuTKb2HJ33arOyAzZ/lQWoI6Wj
         PjDg==
X-Gm-Message-State: AOAM531/Xb5EPk1ozMy3xP3PtkpSem8i6VZCMlStipnXdL5bYxuyuY8i
        gAof11mVc2p/zUv1AMYDAoPQuCw2fYyxeCOTg6A=
X-Google-Smtp-Source: ABdhPJw357ay+aWUKAuyu9Qe8tlk0iRQnqcntDWpTWz69x6FeUa6TPWxXIkKuahGyR8BfUfkYLhtqX7qRSs4Lzm1FYQ=
X-Received: by 2002:a25:9a43:0:b0:628:672c:e471 with SMTP id
 r3-20020a259a43000000b00628672ce471mr18683367ybo.73.1650956290907; Mon, 25
 Apr 2022 23:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com> <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
 <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com> <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
 <c498b2a7-8f0e-4f6d-10ba-49c4c7794ff9@gmail.com> <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
 <CAEensMzgJ6LmGiJajqwgE3cQCR-pcgr1o35Qf=n1K215BwHLhA@mail.gmail.com> <53ac1850-0286-0dc7-4a76-8a0ddee696c0@meizu.com>
In-Reply-To: <53ac1850-0286-0dc7-4a76-8a0ddee696c0@meizu.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Tue, 26 Apr 2022 14:57:58 +0800
Message-ID: <CAEensMw7PsQK4h8a9R_0iOo+KyMYqCf2_eR4-ojtb4qgD8SMgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
To:     baihaowen <baihaowen@meizu.com>
Cc:     Alex Shi <seakeel@gmail.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

baihaowen <baihaowen@meizu.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=80 16:20=E5=86=99=E9=81=93=EF=BC=9A
>
> =E5=9C=A8 4/25/22 11:19 AM, yanteng si =E5=86=99=E9=81=93:
> > baihaowen <baihaowen@meizu.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 09:17=E5=86=99=E9=81=93=EF=BC=9A
> >> =E5=9C=A8 4/24/22 11:16 AM, Alex Shi =E5=86=99=E9=81=93:
> >>> On 4/24/22 10:56, baihaowen wrote:
> >>>>>> +        =3D=3D=3D=3D=3D=3D          =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> hi, Alex
> >>>> I can apply local.
> >>>> =E2=9E=9C  linux-next git:(heads/next-20220421) =E2=9C=97 git am doc=
_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm=
-.patch
> >>>> =E5=BA=94=E7=94=A8=EF=BC=9Adocs/zh_CN: sync with original text Docum=
entation/vm/page_owner.rst
> >>>> =E2=9E=9C  linux-next git:(heads/next-20220421) =E2=9C=97 git am doc=
_pageonwer_patches/0002-doc-vm-page_owner.rst-Fix-table-display-confusion.p=
atch
> >>>> =E5=BA=94=E7=94=A8=EF=BC=9Adoc/vm/page_owner.rst: Fix table display =
confusion
> >>>>
> >>>> I think git send-email will change format by my select. I'll try to =
resend.
> >>> Send to yourself only then get it from your email client and try appl=
ying.
> >>>
> >>> Thanks
> >>> Alex
> >> Hi Alex
> >>
> >> Could you tell me how do you do when you get a patch from email ?
> > $: git clone git://git.kernel.org/pub/scm/utils/b4/b4.git
> > $: b4/b4.sh am <message-id>
> > ###=E5=9C=A8=E4=BD=A0=E7=9A=84=E9=82=AE=E7=AE=B1=E9=87=8C=E6=9F=A5=E7=
=9C=8B=E5=8E=9F=E5=A7=8B=E6=9C=89=E9=82=AE=E4=BB=B6=EF=BC=8C=E7=84=B6=E5=90=
=8E=E6=89=BE=E5=88=B0message-id=EF=BC=8C=E8=B4=B4=E8=BF=87=E6=9D=A5=E5=B0=
=B1=E8=A1=8C=EF=BC=8C=E5=89=8D=E6=8F=90=E6=98=AF=E4=BD=A0=E7=9A=84=E8=A1=A5=
=E4=B8=81=E7=B3=BB=E5=88=97=E5=9C=A8lore=E9=87=8C=E6=98=AF=E6=8C=89=E7=85=
=A7=E5=89=8D=E5=87=A0=E5=A4=A9=E6=88=91=E8=AF=B4=E7=9A=84=E9=82=A3=E4=B9=88=
=E5=BC=84=E3=80=82
> > $: vim xxxx.mbx   ### [modify your patch]
> > $: git am  xxxx.mbx
> >
> >
> > Thanks,
> > Yanteng
> >
> >> I get my patch from email and then copy-patse to a new file, then git =
am xx.patch.
> >> It will notice =E8=A1=A5=E4=B8=81=E6=A0=BC=E5=BC=8F=E6=A3=80=E6=B5=8B=
=E5=A4=B1=E8=B4=A5=E3=80=82
> >>
> >> --
> >> Haowen Bai
> >>
> hi, Yanteng
>
> No matter I select y or N, I could not git am the Chinese translation pat=
ch.
>
>     doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documen=
tation-vm-.patch
> Which 8bit encoding should I declare [UTF-8]? y
Git asked: What format encoding should I use, how about UTF-8?
You answer: Encode it in y .
> Are you sure you want to use <y> [y/N]? y
Git=EF=BC=9AYou're kidding.
You=EF=BC=9AI'm serious.
Git=EF=BC=9AOk, now, Content-Type: text/plain; charset=3D"y".

I'm sorry. I played a joke. >_<

Haowen, You only need to press enter, not y or N.

Thanks,
Yanteng
>
>     doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documen=
tation-vm-.patch
> Which 8bit encoding should I declare [UTF-8]? N
> Are you sure you want to use <N> [y/N]? y
>
> $git am xxx.patch
> error: cannot convert from y to UTF-8
> fatal: could not parse patch
> or
> $git am xxx.patch
> error: cannot convert from N to UTF-8
> fatal: could not parse patch
>
> so, the problem is happening when I did git send-email, and the original =
zh_CN patch is successful for git am.
> Have you ever meet this problem ?
>
> --
> Haowen Bai
>

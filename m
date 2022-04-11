Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6554FB322
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiDKFIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDKFIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:08:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1873E5D2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 22:06:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t11so1420421eju.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 22:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8YwA6QxP083/UCgyRAzMQGDlD5kZcDoyElaQeGpUgkE=;
        b=L2+00FLogMppoFXHFg3E8356ujGOz3c9PzPvknX62TvrV3yADOQ3iduXpQ65HZ6NTP
         bdHV/APDthmmVL35XIxLShGmCg/1CilV1e199jKpu88yq7qmMywK8FNagibdFYpAEY2d
         Pc4aRsiSnr8miNFi/l7jh854vwqv1T/9riQNuQpxHrLzEcJ+42LHz2qg5J7b1Q2ONKdF
         Vr3np310NqNIUZe12x3Rl0i2PXqqVFgFoRAirsRliKZCdr8jACAzmoKMMUTT9FOR2ZVS
         6e3uqwfGh7dO5GZbXThTBbzQSGKqwrBLZd2EQTw2IwYhkHRire1+mrGQ2wgvp85RMe2S
         hOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8YwA6QxP083/UCgyRAzMQGDlD5kZcDoyElaQeGpUgkE=;
        b=sA8NREWvW725B+st4qdWnAslOl/JNsg80L+YI3eehk392GRK0ZJkejRdQJW7Eol/bH
         JvFLG9+Gp4xjTmCw0ceYo+h3RpbK+BdACuwSdFIKC1gJNINHPCpAjWaGJjz2tV6SIfm1
         qHYNfWwQDX1BMNJH6VCuoLU+K/T4xWip8/fZ9c5PFG0pswy/kX4bL1g8fVuWsM3Gj6Pe
         0VjGFVKTEeXAxoH2xftoqktA60jqdcZSSYTKy74Yi8+CdE1hNETtmOyHHiMq5HgXz84+
         viO2pa/a8st/F9joPXYvZcOUls0MvvhXdWwD6F/cStMCO0SH2gjbYIRgVyoIZWkMLXjS
         L7QA==
X-Gm-Message-State: AOAM530YSUPIX6+CtcafReA+ASsSytZT1jJbFBpaJUHs1ZKGS+5a6M5E
        zn5Seup65auEAPh+EpDGqe3sxTPkSrN2E/5YjN0=
X-Google-Smtp-Source: ABdhPJxyuZ7pyS7zfRraE4aR/p3QWt5REA4NQkHtEaZOUVcQL/yHATvFUd5zb7sTRztjATSXfjWfLtazljD7Hak0srs=
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id
 t1-20020a1709061be100b006ceb0a8017dmr28152658ejg.413.1649653595243; Sun, 10
 Apr 2022 22:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220408052207.209856-1-dzm91@hust.edu.cn> <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
 <7e896205-027d-32e2-32b5-8951231132ac@kernel.org> <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
 <2f5b7291-da06-0895-8e75-c7a37251b47e@kernel.org>
In-Reply-To: <2f5b7291-da06-0895-8e75-c7a37251b47e@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 11 Apr 2022 13:06:09 +0800
Message-ID: <CAD-N9QX7wKN_x88w7p6t1KWeTGodeF-o0i-1d0Sq4Ja1OzPFoA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
To:     Chao Yu <chao@kernel.org>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net
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

On Mon, Apr 11, 2022 at 11:10 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/4/9 14:42, Dongliang Mu wrote:
> > On Sat, Apr 9, 2022 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2022/4/9 9:34, Dongliang Mu wrote:
> >>> On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
> >>>>
> >>>> On 2022/4/8 13:22, Dongliang Mu wrote:
> >>>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> >>>>>
> >>>>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
> >>>>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
> >>>>> blkaddr is in the range or not.
> >>>>
> >>>> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_=
blkaddr(),
> >>>> It means f2fs image may be broken, or there is a bug in f2fs.
> >>>>
> >>>> So, do you suffer any related issue in your environment?
> >>>
> >>> related issue? Can you explain a little?
> >>>
> >>> If you mean if this warning occurs, any other issues or crash
> >>
> >> I mean have you seen any warning info printed in the path of
> >> f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
> >> reproducer? or you just figure out this patch from perspective of code
> >> review?
> >
> > Yes, I have seen both warning information from Syzbot [1] and my local
> > syzkaller instance.
> >
> > In f2fs_is_valid_blkaddr, if the following condition is satisfied,
> > i.e., blkaddr is not in the right range [2], it will directly invoke
> > one WARN_ON.
> >
> > if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
> >                   blkaddr < MAIN_BLKADDR(sbi))) {
> >
> > This is the case on Syzbot.
> >
> > Otherwise, it will jump into __is_bitmap_valid. And if the following
> > condition is satisfied [3], it will trigger another WARN_ON.
> >
> > exist =3D f2fs_test_bit(offset, se->cur_valid_map);
> > if (!exist && type =3D=3D DATA_GENERIC_ENHANCE) {
> >
> > This appears in my local syzbot instance, but unfortunately it does
> > not get any reproducer.
>
> Oh, it occurs in syzbot test, I guess it is possible that f2fs prints suc=
h
> warning info after blkaddr of node/data block was fuzzed to invalid one.
>
> I prefer to keep WARN_ON() to catch more info of bugs found by non-fuzzed
> type test.
>
> Thoughts?

I am fine with both options. I can remove the WARN_ON in my local
syzkaller instance and continue fuzzing Linux kernel.

+Dmitry Vyukov how do you think? If WARN_ON is kept, this crash will
occur on Syzbot from time to time.

>
> Thanks,
>
> >
> > [1] https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fsyzkaller.appspot.com%2Fbug%3Fextid%3D763ae12a2ede1d99d4dc&amp;data=3D04%7=
C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c3534=
1c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp=
;sdata=3DUVSSS9IknYLJHzqqJAN5HmPgJ8GNczvi6%2FuQf2n3vlY%3D&amp;reserved=3D0
> > [2] https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Ffs%2Ff2fs%2Fcheckpoint.c%23=
L187&amp;data=3D04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f4=
5860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C3000&amp;sdata=3DSf%2Bx8WCAXf5c4%2Bins46saTsTN5uNTrnIceAP3oCWnQ=
w%3D&amp;reserved=3D0
> > [3] https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Ffs%2Ff2fs%2Fcheckpoint.c%23=
L135&amp;data=3D04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f4=
5860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C3000&amp;sdata=3DLy%2FBL5oFAWZmXwbN6TaYCExroDE8%2Fsli1alaJwR4wv=
U%3D&amp;reserved=3D0
> >
> >
> >>
> >> Thanks,
> >>
> >>> behaviors are generated? I tested on the syzbot. After removing the
> >>> WARN_ON, there is no abnormal issue or crash behaviors followed with
> >>> the corresponding reproducer.
> >>>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>> Fix this by removing WARN_ON.
> >>>>>
> >>>>> Note that, syzbot patch testing does not incur any further issues
> >>>>>
> >>>>> Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
> >>>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >>>>> ---
> >>>>>     fs/f2fs/checkpoint.c | 2 --
> >>>>>     1 file changed, 2 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>>>> index f5366feea82d..521498b2dd8c 100644
> >>>>> --- a/fs/f2fs/checkpoint.c
> >>>>> +++ b/fs/f2fs/checkpoint.c
> >>>>> @@ -158,7 +158,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_in=
fo *sbi, block_t blkaddr,
> >>>>>                 f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit b=
itmap:%d",
> >>>>>                          blkaddr, exist);
> >>>>>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>>> -             WARN_ON(1);
> >>>>>         }
> >>>>>         return exist;
> >>>>>     }
> >>>>> @@ -196,7 +195,6 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info =
*sbi,
> >>>>>                         f2fs_warn(sbi, "access invalid blkaddr:%u",
> >>>>>                                   blkaddr);
> >>>>>                         set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>>> -                     WARN_ON(1);
> >>>>>                         return false;
> >>>>>                 } else {
> >>>>>                         return __is_bitmap_valid(sbi, blkaddr, type=
);
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823D44FA577
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiDIGpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiDIGpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:45:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01072B6472
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:42:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bq8so21113981ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F/NiylbSnlTwbMHYz60q2+JT/Z/4lfxU2QxIerjfG0=;
        b=gZjUk86s0gIdGuXwfNi9lv2EhGp2HrzptHB9qYB2U9AMrnEYm7TKJZLMSDU/h1B96X
         B1r0LPVI6Vv7HBEKMR+dyMASFXFpBbLEiTcyHu7jp5ifO/TptiP2e3fKmxX0fnwjHBpQ
         M1wqki+NWzZ/ycsKhItd6yzINm4JV+Xvh6kAOyBgQh26RscOfDbcvRbyFi93dgGrWoSu
         kCkLXbRMwZzEp83wF2ZsKQkZsJgoip0OasmG3CLCFMtGYrIG2QS0OItPVYQxQPottP8Z
         x2xPTIiS5IdlA1SrAch36UgaWJSLZM0+KIAN/Xricc/vedCLNK1wFgx0JJtmxLmXKPD8
         Rt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F/NiylbSnlTwbMHYz60q2+JT/Z/4lfxU2QxIerjfG0=;
        b=OQyUnLRvTT3UPDMCv2qO/qvd/a+eiFyfKCKA6B4rNjxM+L0X487d935ZY5VOWYMYlY
         Ud9u1qzV6B000lhz+PeLAee1friK7//Xq5+oB8JXF1GJNnE7zq/34v2O/sm3kxGV2NXr
         rvV/yO7uNYcN0qCGsZQ5cvEtVcFyJokpkuBLYkiYoxKnUIlnNY0lzRvPIOqU+aqLzqEv
         NWrNWth1XMAF1W8Zbic3tc6reTmQNBdtscZseeeHnKiIcqXQxHS67XVwU1OcRnnp3dJ9
         wW+0HCk8YXpAvH2i/zChZscFWPjccuBD2YUxV9fPzM4iOtVjL4pJphgSX0hLTSm/TWHR
         OZWw==
X-Gm-Message-State: AOAM532d6BAiq8yXqAOyHKwcWj8e0Zs6tavIckKf0gEEJU7lQ4kU8yMY
        3vYRA8DlYtMPyjnepGNwuE/JS9D/isA6aepls6k3ZHL+N2+41w==
X-Google-Smtp-Source: ABdhPJx8qoqL+FbYtdeW6jN5xfqLHDYEKVYzM5xucpQpsFIqTOBoXZJ1lqWUYcA6QDQP7041JKouJjm9uFNUNz42wQM=
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id
 z21-20020a1709063a1500b006cfea4ea1ccmr22478337eje.753.1649486575449; Fri, 08
 Apr 2022 23:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220408052207.209856-1-dzm91@hust.edu.cn> <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com> <7e896205-027d-32e2-32b5-8951231132ac@kernel.org>
In-Reply-To: <7e896205-027d-32e2-32b5-8951231132ac@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sat, 9 Apr 2022 14:42:29 +0800
Message-ID: <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
Subject: Re: [PATCH] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
To:     Chao Yu <chao@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Jaegeuk Kim <jaegeuk@kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/4/9 9:34, Dongliang Mu wrote:
> > On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2022/4/8 13:22, Dongliang Mu wrote:
> >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> >>>
> >>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
> >>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
> >>> blkaddr is in the range or not.
> >>
> >> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
> >> It means f2fs image may be broken, or there is a bug in f2fs.
> >>
> >> So, do you suffer any related issue in your environment?
> >
> > related issue? Can you explain a little?
> >
> > If you mean if this warning occurs, any other issues or crash
>
> I mean have you seen any warning info printed in the path of
> f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
> reproducer? or you just figure out this patch from perspective of code
> review?

Yes, I have seen both warning information from Syzbot [1] and my local
syzkaller instance.

In f2fs_is_valid_blkaddr, if the following condition is satisfied,
i.e., blkaddr is not in the right range [2], it will directly invoke
one WARN_ON.

if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
                 blkaddr < MAIN_BLKADDR(sbi))) {

This is the case on Syzbot.

Otherwise, it will jump into __is_bitmap_valid. And if the following
condition is satisfied [3], it will trigger another WARN_ON.

exist = f2fs_test_bit(offset, se->cur_valid_map);
if (!exist && type == DATA_GENERIC_ENHANCE) {

This appears in my local syzbot instance, but unfortunately it does
not get any reproducer.

[1] https://syzkaller.appspot.com/bug?extid=763ae12a2ede1d99d4dc
[2] https://elixir.bootlin.com/linux/latest/source/fs/f2fs/checkpoint.c#L187
[3] https://elixir.bootlin.com/linux/latest/source/fs/f2fs/checkpoint.c#L135


>
> Thanks,
>
> > behaviors are generated? I tested on the syzbot. After removing the
> > WARN_ON, there is no abnormal issue or crash behaviors followed with
> > the corresponding reproducer.
> >
> >
> >>
> >> Thanks,
> >>
> >>>
> >>> Fix this by removing WARN_ON.
> >>>
> >>> Note that, syzbot patch testing does not incur any further issues
> >>>
> >>> Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
> >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >>> ---
> >>>    fs/f2fs/checkpoint.c | 2 --
> >>>    1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>> index f5366feea82d..521498b2dd8c 100644
> >>> --- a/fs/f2fs/checkpoint.c
> >>> +++ b/fs/f2fs/checkpoint.c
> >>> @@ -158,7 +158,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
> >>>                f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> >>>                         blkaddr, exist);
> >>>                set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>> -             WARN_ON(1);
> >>>        }
> >>>        return exist;
> >>>    }
> >>> @@ -196,7 +195,6 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >>>                        f2fs_warn(sbi, "access invalid blkaddr:%u",
> >>>                                  blkaddr);
> >>>                        set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>> -                     WARN_ON(1);
> >>>                        return false;
> >>>                } else {
> >>>                        return __is_bitmap_valid(sbi, blkaddr, type);

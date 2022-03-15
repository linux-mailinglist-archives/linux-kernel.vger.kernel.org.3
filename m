Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A084D9B78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiCOMpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348408AbiCOMpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:45:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E440931
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:44:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so23984567edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rfq986Ngid7vqyFyvLMRUqbrd21pr/MIsn9OsbU3BVY=;
        b=BQBqXj/R4v3UTpbm4iKkbLClg8I2FnpJHbtUjcL2lpt98dawcMO3hEx1UsQiTwZ01t
         CErIuNFN4HUchNhZ6jVC8mAUaiGqyxkiCSvScNgnWUIOI53ggrCUnBv5z+b1dAsRUMDw
         9oJDsQRtvJRgrvZlZqE7S7p6xC58mhllZ/yITHLGygpAT8rd8la7gAcoIvBWgGOStRv+
         QMmIdjfBdYUJmepNsnKU66MPk5R2RyQt9dWF5tzQXrLkWpleTlULvb3lvJruh1bUWMIj
         adDX5tNYky9uhRzkpVbGT947rIeEIZYaEE/d4j1KPWe4pixLmNNteBKaI7ksp+lAXnAh
         9Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rfq986Ngid7vqyFyvLMRUqbrd21pr/MIsn9OsbU3BVY=;
        b=idF8+nN/xHbNfZvIeP6SedvaX4DWXHXfgEYSHhmcf0Xe8KrovHv+RB1aDcm7uClrJl
         hTu2dbJPa6z0t9qiJApr6LIuc8/CzaLCr7ElDPtP8aLBJlbrshe2VezFq4FKP91yi/wr
         YdseLKHXb6wdONCOL4yV2lGFL4BeQIAYOedbOoEODMADVfmSXTskMyY/NnPhPfXy7UVx
         1y+1JV1ZKzyqb539I8mK6+AnRWkMRGsPSaLeCPnJ2jOkft2yHQuHmcrtGz9pgUtF3eJL
         KZA3CNJxRj1xoiboS/2YJiduZevRSa6u0qF0athAByLe4OBSH9Ogprv0i9R14aREs1Y+
         fkbg==
X-Gm-Message-State: AOAM533XFgSXRp6FxtJHgH4xvgM7uHGOnKXx+dFeaqN+UBppzCfWfz17
        mzQkE8+xYX6wC+U1gbgazQCkCN7i3xDsV2Nx4wM=
X-Google-Smtp-Source: ABdhPJyNoXfe2mx/IZX4LuxqBOHPWULEAUWiyJKBy7+WD0cGObLgTjyqXIcrehNhAw5Um1afnYkXW1WLHdXqKmw5bt0=
X-Received: by 2002:a05:6402:50c9:b0:418:7fbc:14ee with SMTP id
 h9-20020a05640250c900b004187fbc14eemr10098729edb.53.1647348271321; Tue, 15
 Mar 2022 05:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220315075152.63789-1-dzm91@hust.edu.cn> <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local> <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
 <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com> <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
In-Reply-To: <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 15 Mar 2022 20:44:04 +0800
Message-ID: <CAD-N9QXp4sCKUY2zwJduOG22B0NaMGRLevn3FVMO0qOQFxO3Bg@mail.gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Huang Jianan <jnhuang95@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 8:26 PM Gao Xiang <hsiangkao@linux.alibaba.com> wro=
te:
>
> Hi Dongliang,
>
> On Tue, Mar 15, 2022 at 07:59:26PM +0800, Dongliang Mu wrote:
> > On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wrot=
e:
> > >
> > > =E5=9C=A8 2022/3/15 18:55, Gao Xiang =E5=86=99=E9=81=93:
> > > > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> > > >> =E5=9C=A8 2022/3/15 15:51, Dongliang Mu =E5=86=99=E9=81=93:
> > > >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >>>
> > > >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. T=
his bug
> > > >>> is triggered by injecting fault in kobject_init_and_add of
> > > >>> erofs_unregister_sysfs.
> > > >>>
> > > >>> Fix this by remembering if kobject_init_and_add is successful.
> > > >>>
> > > >>> Note that I've tested the patch and the crash does not occur any =
more.
> > > >>>
> > > >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >>> ---
> > > >>>    fs/erofs/internal.h | 1 +
> > > >>>    fs/erofs/sysfs.c    | 9 ++++++---
> > > >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> > > >>>
> > > >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> > > >>> --- a/fs/erofs/internal.h
> > > >>> +++ b/fs/erofs/internal.h
> > > >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> > > >>>     u32 feature_incompat;
> > > >>>     /* sysfs support */
> > > >>> +   bool s_sysfs_inited;
> > > >> Hi Dongliang,
> > > >>
> > > >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra=
 member in
> > > >> sbi ?
> > > > Ok, I have no tendency of these (I'm fine with either ways).
> > > > I've seen some usage like:
> > > >
> > > > static inline int device_is_registered(struct device *dev)
> > > > {
> > > >          return dev->kobj.state_in_sysfs;
> > > > }
> > > >
> > > > But I'm still not sure if we need to rely on such internal
> > > > interface.. More thoughts?
> > >
> > > Yeah... It seems that it is better to use some of the interfaces
> > > provided by kobject,
> > > otherwise we should still maintain this state in sbi.
> > >
> >
> > I am fine with either way. Let me know if you reach to an agreement.
>
> If you have time, would you mind sending another patch by using
> state_in_sysfs? I'd like to know Chao's perference later, and
> apply one of them...

OK, let me test this patch in my local workspace. If it works, I will
send it later.

>
> Thanks,
> Gao Xiang
>

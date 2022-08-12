Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA101590AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiHLD2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiHLD2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:28:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723AA3D55;
        Thu, 11 Aug 2022 20:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 862F3B82316;
        Fri, 12 Aug 2022 03:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5FCC433B5;
        Fri, 12 Aug 2022 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660274906;
        bh=T7UnrmMmraBDFs8VzxkTjmBbnKGDsLEGu8IaBCyu3zA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vuy3UZAX9EFj/j97h2woBTDRHntBLFn/BrN2q2SFAp93l+E6LCzWJzMmQBL6FHzkq
         zZUFoGRv9//DVGU+Y50MPSI+AlC4ZvCXNX5j3fpLjwoAR7C9TkOsXNkvTAdvUXJTJl
         yU13E6+Vywt7o4MePa1TQyHoJCgo4bvsdrQeSE+dWbdMzqtkE+wmXD8JmlnCx4wG4j
         Nx2QF1+V/3li2IE9aaeL7ULQeou8vchiZbvk7ApoAsxfyb8BK6pE3xtX1LpmrHcfFp
         SDn81fp0M0kdXhefTihdarAqiZ7M9EecPiDRoxoK0e8mj5AQS8eAjg46q0n4KCYJkE
         LACZOgER9kGzA==
Received: by mail-vs1-f44.google.com with SMTP id b124so20111894vsc.9;
        Thu, 11 Aug 2022 20:28:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo2e7iiuGw0tp9j9sm5cG5idWHMK13bD+RxFMqs/zZ+HXEvdc+tc
        KKutr7x5i/lpwS+gMxBTm+8FTEqZriezS3YWiio=
X-Google-Smtp-Source: AA6agR5Eo7w7PcJkogroYiNkNxr2WdrF5a21kMXEJrsdEh0ccnnJ4RHRaa0Nf/PkpsOyMdAKe1wl3JGzEDLS8QHupsc=
X-Received: by 2002:a67:d59e:0:b0:38a:a3c2:9ee with SMTP id
 m30-20020a67d59e000000b0038aa3c209eemr1163385vsj.78.1660274905147; Thu, 11
 Aug 2022 20:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com> <20220812023950.GF373960@MiWiFi-R3L-srv>
In-Reply-To: <20220812023950.GF373960@MiWiFi-R3L-srv>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 12 Aug 2022 11:28:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7tCsyyNgDJWE5qDCXadF+V6k3GtZtf_yLVj6BZiPND2Q@mail.gmail.com>
Message-ID: <CAAhV-H7tCsyyNgDJWE5qDCXadF+V6k3GtZtf_yLVj6BZiPND2Q@mail.gmail.com>
Subject: Re: [RESEND] Please consider name next Linux release "I love Linux"
 (Re: Linux 5.19)
To:     Baoquan He <bhe@redhat.com>
Cc:     Zhang Boyang <zhangboyang.id@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>, song@kernel.org,
        wei.liu@kernel.org, jszhang@kernel.org,
        Guo Ren <guoren@kernel.org>, xiang@kernel.org, chao@kernel.org,
        ming.lei@redhat.com, Waiman Long <longman@redhat.com>,
        wqu@suse.com, yhs@fb.com, haoluo@google.com, decui@microsoft.com,
        Yanteng Si <siyanteng@loongson.cn>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

On Fri, Aug 12, 2022 at 10:40 AM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Boyang,
>
> On 08/11/22 at 10:02pm, Zhang Boyang wrote:
> > Hi,
> >
> > On 2022/8/1 05:43, Linus Torvalds wrote:
> > > (*) I'll likely call it 6.0 since I'm starting to worry about getting
> > > confused by big numbers again.
> >
> > Could you please consider name the next Linux release (5.20 or 6.0) "I =
love
> > linux" ? The number "5.20" is a wordplay in Chinese, which means "I lov=
e
> > you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.
> >
> > Even if next kernel version is 6.0, I think it's probably a good idea f=
or
> > both Chinese-speakers and non-Chinese speakers to express our love to L=
inux
> > Kernel.
>
> Interesting idea, LOL.
>
> Yes, 520 means 'I love you' in chinese since it has the similar pronuncia=
tion
> with '=E6=88=91=E7=88=B1=E4=BD=A0'. I even don't remember since when May =
20th becomes another
> holiday similar to Valentine's day in China. While I have complicated fee=
ling
> about 520. It means on each May 20th, I also need prepare gift for my wif=
e. I
> am not a romantic person, preparing gift to lover is always a torture to =
me.
> So almost each May 20th day, Valentine's day, double seventh festival whi=
ch is
> a traditional Valentine's day, I will become nervous, and it ends up
> with a satisfactory gift, or a bunch of flower and a digital red envelope=
 with
> 520=EF=BF=A5 and then complainment and blame in next two weeks.
>
> So, for naming next release as '5.20', I will vote for it w/o hesitance. =
No need
> to prepare gift, and can express our love to Linux kernel, it sounds
> awesome.
>
> Meanwhile, I would remind people to take it easy. Whether the suggestion
> is accepted or not, it doesn't impact the fact that linux may have
> become part of our life, not just our work, considering many kernel devel=
opers
> are workoing form home. But if you have boasted to your girlfriend
> or wife, and want to take this as a gift to her, you should try harder to
> convince Linus.
>
> Thanks
> Baoquan
Frankly, I agree with Boyang and Baoquan. :)

Huacai
>
> >
> > The name of Linux kernel release has a long history of play-on-words [2=
].
> > For example, 5.15 is named "Trick or Treat" and 5.17 is named "Superb O=
wl".
> >
> > [1] https://en.wikipedia.org/wiki/Chinese_Internet_slang
> >
> > [2] https://en.wikipedia.org/wiki/Linux_kernel_version_history
> >
> > Thanks and regards,
> > Zhang Boyang
> >
>

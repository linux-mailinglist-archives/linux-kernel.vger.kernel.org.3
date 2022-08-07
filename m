Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4E58BCA7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiHGTJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHGTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:09:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E61643A;
        Sun,  7 Aug 2022 12:09:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x64so5635875iof.1;
        Sun, 07 Aug 2022 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=mL5GgcWfstWeGYJhJ68nNeLCVdUqveKpU3sfQrU4jS8=;
        b=dvGrmV5h9eO2wJVSL0XJhv1Gt/WJj0w//G0Gg6m1x9dhjd2Q8sgsgXxLilTvQN8kxr
         h6CR9GvgcqTRcdkfBgffcRaIH/mUkuoagRRMaMIoJjUK28IcYqSO4/je/HSI+etgG/w6
         coSfq8qxu+SHXlikM01+KZPY5AeJFgKaYfbCOuwMAd32iCOCxnRzU+woX4yklkY56Zv+
         T1+zdls2pLhfKINUz+g2kRI8IAgQslnLcPdll1vXs+QDV3IYbkNuthh6VkfKbfJ61eNt
         gCblRM3ng5kDS398+lAO461ZV/3nOe6RIVogM37JCukLRUorWdrIKXKsM3jcZBMFgflG
         gMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=mL5GgcWfstWeGYJhJ68nNeLCVdUqveKpU3sfQrU4jS8=;
        b=H2bx08IoZIEKxF646J1dMDDog0jrmETWbu9DDzmoeTuFAGpeHdH/7EPr/DkfwsWlcO
         D/YhuYQzg1NII1C6hYn7dMg6maNz/IcXtqiJ3DR1cg2IswjIByHw7h9Xq1LOoh8web4S
         eQc9LwxDjlcXxtcSDlMn8Zjys/pP964IRrjIhs7VrDbRLQ8l1c4GF0k3yFdMFlt9id0/
         vRKFjZ0HfxhIF+B9G1tAkMwy0ie9wblVxlVWLtTqdhFo4qxY6phMPhswc6ueDFvDAhmw
         ugdTbztQ4xIx5ZZfkKyDoEHBJEIXIo4x9JCHU/Pm1aMKWf9pef7JJlecVX3yzAdpT66L
         3otg==
X-Gm-Message-State: ACgBeo3qOUjAWkvgiO9AsL8QbdnyexkuwOWwwUQNxbETqFBSDUC5spxG
        +xNWQbLQ+05uEqR6icpYpiRX/8OAXi1TtEit3Vc=
X-Google-Smtp-Source: AA6agR4/h1SXw70tF50lChS9ED9MW5RLqXWMAX8bbOCiqDbjN0hp6NCcgS07c7xUttCKzfkifIBj3euZP66AmPA80ww=
X-Received: by 2002:a05:6638:2642:b0:33f:5172:e77 with SMTP id
 n2-20020a056638264200b0033f51720e77mr6852089jat.85.1659899382051; Sun, 07 Aug
 2022 12:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220729170744.1301044-1-robdclark@gmail.com> <20220729170744.1301044-2-robdclark@gmail.com>
 <3d2083aa-fc6c-6875-3daf-e5abe45fb762@gmail.com> <CAF6AEGvKdM3vyCvBZK=ZcdGmak7tsrP1b8ANyyaMjVfNDViqyw@mail.gmail.com>
 <973de2f8-75e4-d4c7-a13a-c541a6cf7c77@amd.com> <CAF6AEGuhQT6A_jh8kLWh5xMoUGc1osdewyBk-8NoprtWOHseaQ@mail.gmail.com>
 <2fc74efe-220f-b57a-e804-7d2b3880d14f@gmail.com> <CAF6AEGv9H+fSFKPNqwPxYUjkgj05AimpXbp-p_JL8nKLnzON=w@mail.gmail.com>
 <e2423bd7-ef73-8d43-c661-a19c80ad1a26@gmail.com>
In-Reply-To: <e2423bd7-ef73-8d43-c661-a19c80ad1a26@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 7 Aug 2022 12:10:08 -0700
Message-ID: <CAF6AEGsoYaXe2+qug_TfT99KXuXh9Ez2L2HjQZroE6c6GSW4SQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/3] dma-buf: Add ioctl to query mmap info
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Sun, Aug 7, 2022 at 11:05 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.08.22 um 19:56 schrieb Rob Clark:
> > On Sun, Aug 7, 2022 at 10:38 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> [SNIP]
> >> And exactly that was declared completely illegal the last time it came
> >> up on the mailing list.
> >>
> >> Daniel implemented a whole bunch of patches into the DMA-buf layer to
> >> make it impossible for KVM to do this.
> > This issue isn't really with KVM, it is not making any CPU mappings
> > itself.  KVM is just making the pages available to the guest.
>
> Well I can only repeat myself: This is strictly illegal.
>
> Please try this approach with CONFIG_DMABUF_DEBUG set. I'm pretty sure
> you will immediately run into a crash.
>
> See this here as well
> https://elixir.bootlin.com/linux/v5.19/source/drivers/dma-buf/dma-buf.c#L=
653
>
> Daniel intentionally added code to mangle the page pointers to make it
> impossible for KVM to do this.

I don't believe KVM is using the sg table, so this isn't going to stop
anything ;-)

> If the virtio/virtgpu UAPI was build around the idea that this is
> possible then it is most likely fundamental broken.

How else can you envision mmap'ing to guest userspace working?  The
guest kernel is the one that controls the guest userspace pagetables,
not the host kernel.  I guess your complaint is about VMs in general,
but unfortunately I don't think you'll convince the rest of the
industry to abandon VMs ;-)

But more seriously, let's take a step back here.. what scenarios are
you seeing this being problematic for?  Then we can see how to come up
with solutions.  The current situation of host userspace VMM just
guessing isn't great.  And sticking our heads in the sand and
pretending VMs don't exist isn't great.  So what can we do?  I can
instead add a msm ioctl to return this info and solve the problem even
more narrowly for a single platform.  But then the problem still
remains on other platforms.

Slightly implicit in this is that mapping dma-bufs to the guest won't
work for anything that requires DMA_BUF_IOCTL_SYNC for coherency.. we
could add a possible return value for DMA_BUF_INFO_VM_PROT indicating
that the buffer does not support mapping to guest or CPU access
without DMA_BUF_IOCTL_SYNC.  Then at least the VMM can fail gracefully
instead of subtly.

BR,
-R

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C59576601
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiGOR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGOR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:29:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E11A3BD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:29:20 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p128so4383998iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKhjo8KG4zeKmBRRqGulQXfTOE6loy/w65MUvp5iYC4=;
        b=ApnumN/uO+q8VfK0eOjR1IyrQRBVSvV4Y9KtuhuDw1CHNQ1Bt6qAOT7Dh6G4KKDIYm
         j+HkYUlfKykcFB/h+chNUe06pdJ8QSFcoyQCDNBwJJt+PNAQxFZCHVWrLP+LRSTf8NDq
         JNudYxyLyyTYJOCS8ibyybJbzfOZ9krq8CN8A2wpqKql+hooOwyV6DtpkcMbgthW1/ZV
         C8XfCq4dCr+TEI3WJar57TNEVzoi2a/8dxyknMgTSYsjfQB/q4aVKsPbsXdfZ/+MXgPo
         Md/QFbr+NrUbHYPV12axpepy0F0jI5eT3YgFPjk79G4xLVN+iq6aL4LVFmAd7ZILHG1y
         HFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKhjo8KG4zeKmBRRqGulQXfTOE6loy/w65MUvp5iYC4=;
        b=VC1jiWwTtXys9jWyM+4wXOTtoyqPacbYfOrTCkqeNz7XP006qasxRzuztc6Gpcssnr
         poHMtG5MmCUUNzdkUMLxH4DI0kU9mvvu2ZCHeBLOIl7ctuKnO1+BZHH17D/to7J8sJmv
         0Bn4gi3TT6rmqPM7xyyUz3autydrRCv6oyAYoOqRdv6Zx8oyC7SF4BfL/0SRqG9l6oDo
         oCtbIH7T4M9pu2LFF7D5hUl8d+MtEwT7P+WLuPRpgLGmu80PrAmq9zKf+V4+8pu/lpPK
         lx79u+kizMPVmWeC7Td7U/2uApfUiA7l8CwMXBRaelvcOW8AzdmqkrDglrjGDEi5X1Iu
         HYww==
X-Gm-Message-State: AJIora9zOLs4Kw7Yue2C574PbdyVJ/XKb2wBvt3wa3ADS9pEZZEEqiSM
        XqjmnP2WWM9pr83mAPLTpr+NkU4uiMmGv18nVKpnJA==
X-Google-Smtp-Source: AGRyM1su4lMmzs+An9cEt4lDrZEMXE242gj1D3aPbBm6VaURSzClhzRMpyhB82dU/VnX2nUVQqii0+gdAXi6+f+2p38=
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id
 q3-20020a0566022f0300b006789c7c97a5mr7537079iow.32.1657906160115; Fri, 15 Jul
 2022 10:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220712130542.18836-1-linmiaohe@huawei.com> <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com> <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com> <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com> <YtGe2qIO038e627p@xz-m1.local>
In-Reply-To: <YtGe2qIO038e627p@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 15 Jul 2022 10:28:44 -0700
Message-ID: <CAJHvVcji14hUsqg=yrtevEqwMtZi7Xwyj4yUnLMaZi0DBqPTHA@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte
To:     Peter Xu <peterx@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:07 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
> > I agree we should either:
> > - Update the UFFD selftest to exercise this case
> > - Or, don't allow it, update vma_can_userfault() to also require VM_SHARED
> > for VM_UFFD_MINOR registration.
> >
> > The first one is unfortunately not completely straightforward as Peter
> > described. I would say it's probably not worth holding up this fix while we
> > wait for it to happen?
>
> Agreed, Andrew has already queued it.  It actually is a real fix since we
> never forbid the user running private mappings upon minor faults, so
> it's literally a bug in kernel irrelevant of the kselftest.
>
> >
> > I don't really have a strong preference between the two. The second option
> > is what I originally proposed in the first version of the minor fault
> > series, so going back to that isn't a problem at least from my perspective.
> > If in the future we find a real use case for this, we could always easily
> > re-enable it and add selftests for it at that point.
>
> I'd go for fixing the test case if possible.  Mike, would it be fine if we
> go back to /dev/hugepages path based approach in the test case?

One possible alternative, can we use memfd_create() with MFD_HUGE_*?
This afaict lets us have an fd so we can create two mappings,
without having to mount hugetlbfs, pass in a path to the test, ...

>
>
> Thanks,

>
> --
> Peter Xu
>

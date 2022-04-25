Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA950DB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiDYIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDYIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:47:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC3B860
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:44:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g28so6388551ybj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUyI57LrGA1YA09T5eg+o1crNTDbhxTBWfLQ6Nua+xI=;
        b=Hix8O6BrK3yWCpg8o7QTHgII/QCkA9OQK13YrqkUQW+9EqOCH5d2NNrM8SiPkIXDly
         LMVnkCXu3ea2/0/1qTvgRl0QMX4uLIVMDN58uD2CiYzqIpXm00N6GGCR2lTUnzronqs2
         W8bT0BBRPtUlgwBq/JZ6BvnMkflNn1488nZPeI1DqTuxsnjovFKtN//WmHhBcvKaXBBo
         UevWwE6LEclP1dGJ8/wJzxNTnmDC3q0aYpr8XtzVZf8mHA/QkRxSYTu2NKBnt19zU8z6
         ydoh3Fj0i4cZ9pvezYrNKjESVqbEQx8f4V7LkDeyFfcPQC8LYAYgPY99IPVGVzooa3Qn
         Ko1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUyI57LrGA1YA09T5eg+o1crNTDbhxTBWfLQ6Nua+xI=;
        b=AAkb45wXShzu50zFRFZpGcPFTOl3IuFHEEJRcQaFg2fTp/sCi3JWpq7lLORJ2mZogq
         /K/YHY6yeQnDWHLgo2edpd3xY10FStjjLbwct1pwd7HzDg6B+dfcOcK6PEr2OnVxXxpd
         1dBtzP/sAuaVv0tx37phJkYBhAVxiZB1Fkgjh1+EDimlR5dirIWiKPaWR/RYlqPW6C9L
         LQRgZ3xPJiMDg4KxlDPoek93nrXIBnB3pNSZWK6EjvXPOkDtS5CrsYpaxeAmN9nn+j7c
         d/E0PNIl0utL10taDhfdcn/281YaCOrofd9/MdPPFYU0IKo5Vaubq/AhxOhaFU/vd3g6
         EogA==
X-Gm-Message-State: AOAM5329hvmB0XBCtC3v19ipjEE+duOMAB8m8gXPr4TwkSzrjOSSiV3J
        0UtOdNCjiSgNxJi8pY6AIHs9WOhy7RDCljqYbDX3og==
X-Google-Smtp-Source: ABdhPJzuBFYllAhHDrnxbJCVb0PLWgz1spQb6b8Ab502TF0Js4CjUglBcd8kxDyroRaRj7ZSXirQqNAJMAaPVcbRPjw=
X-Received: by 2002:a25:6652:0:b0:645:d4c1:eb7 with SMTP id
 z18-20020a256652000000b00645d4c10eb7mr12717144ybm.412.1650876285603; Mon, 25
 Apr 2022 01:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYscb1y4a17Sf5G_Aibt+WuSf-ks_Qjw9tYFy=A4sjCEug@mail.gmail.com>
 <CAHk-=wgZ9H_Cama8RNyqNbPB5ydFy4P319JUcz9E27GyZ1xqdw@mail.gmail.com>
In-Reply-To: <CAHk-=wgZ9H_Cama8RNyqNbPB5ydFy4P319JUcz9E27GyZ1xqdw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Apr 2022 14:14:34 +0530
Message-ID: <CA+G9fYtDBfQsKL2kdeaB-R7h0wYY7VTVJ-BP_sOhnu_-5d+oSw@mail.gmail.com>
Subject: Re: page_alloc.c:(.init.text+0xa7c): undefined reference to `vmalloc_huge'
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 25 Apr 2022 at 13:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 25, 2022 at 1:10 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > # CONFIG_MMU is not set
>
> I just sent the stupid and straightforward patch in
>
>   https://lore.kernel.org/all/CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com/
>
> but then I thought maybe the alias patch is as simple as the attached.
>
> So does either (or both) of these patches work?

Yes.
I have tested these two patches and both the way the build passes.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

- Naresh
>
>                   Linus

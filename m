Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C22C584559
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiG1SDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiG1SDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:03:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEB74CDD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:03:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o8so864436ils.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XQkz3l4blJBLiLTAjl/FZyXziCJMNBNV1rmuyDfw/84=;
        b=BWliJSmnkQgO1y3ePZSHGzOW819Z/V1OguHLXGggxZWhKNm55DHUsml+ThMzNhzOdh
         vkr3lk2sS2oz5ngv2VEHI4+/FxQ0PVENUGmTlYd00kOI+6sTX59cPRGArtvNTjBOHE8M
         09INeJeAlX/eLh8oElv/6kJRafViJJorq0V8cIUiaG5nedEHIPfigzKGbCjPgnfjdSUf
         ovj+4IJPGd7CBXRq02R1XJmA07OldnqT7++nToBxEFN0utNb4teZ6yFTaSWIxzEUdeUC
         NzlQiNAvW88RN5r5eXQkwlecNPzATnJpbU4o+N35A7BQgwY7X3y+SoDniYlpG3WvG5/B
         ItgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XQkz3l4blJBLiLTAjl/FZyXziCJMNBNV1rmuyDfw/84=;
        b=DYvfqqaGhMeS6amcuBcW9nbAFhcG6/+73JHHiC4N1m85TFlw1ny4o2Qn+21qXju8Mj
         9gukvJPyeDO166WPmjo4QPTvnaajTO1hQxbOAJ08lb5z6eJg3cxUn7b8bHqxVqKj28do
         34ZaBt188ulRZec0HC8jSdWURM49i91yXBtL8x9QYM7EwfiviNCYu23GnOdCY8kIED7l
         gr3p+Ddx5lZIfo2Kk2l/MXnlaoZacat6CPDCJxANJf/RiM8qYW4deIqKHuMjP//4aSuM
         7+Sz4CShC20J88xU3umjhlaC2B9Kt08lSztcRlTRyEdsIU18LSrA8or0I0X8zeXm+dmV
         Q3JQ==
X-Gm-Message-State: AJIora+7x7TiQ4W7/Blab4CceZDsiUFzX7EKlmsLt+sd0hS6K9Ir370J
        OyDOvcBUSXea5TFh/P/OwKJ+qcO6Mx9gtJZzsYwsZrBrelzhcw==
X-Google-Smtp-Source: AGRyM1u5vV09nMNJatCWQHOe4HEUu9U9TIZS3YYzjBpgCOgDMpq9ET02MUTl02EsdHfb2aifCksbzWj1BkdeL8Z3cOA=
X-Received: by 2002:a05:6e02:1091:b0:2dd:f304:5a50 with SMTP id
 r17-20020a056e02109100b002ddf3045a50mr1630335ilj.146.1659031381251; Thu, 28
 Jul 2022 11:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220728121949.20985-1-linmiaohe@huawei.com> <20220728121949.20985-3-linmiaohe@huawei.com>
 <CAHS8izNM8aPdus_EVygtug+8b6CUNozz_se+mpqRe7SUZEcOwQ@mail.gmail.com>
In-Reply-To: <CAHS8izNM8aPdus_EVygtug+8b6CUNozz_se+mpqRe7SUZEcOwQ@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 28 Jul 2022 11:02:50 -0700
Message-ID: <CAHS8izML04ujw1+1622JPQjKH0RHt0zHSEQvbLXZaZ1edfF=bQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] hugetlb_cgroup: remove unneeded header file
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 28, 2022 at 10:45 AM Mina Almasry <almasrymina@google.com> wrote:
>
> On Thu, Jul 28, 2022 at 5:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> > The header file slab.h is unneeded now. Remove it.
> >
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
> Acked-by: Mina Almasry <almasrymina@google.com>
>

Actually, sorry, but this file calls kzalloc_node() which comes from
linux/slab.h, no? Can we keep the include then? slab.h is probably
included by other include files but for clarity it's better that
hugetlb_cgroup.c to include slab.h if it is calling functions declared
there.

> > ---
> >  mm/hugetlb_cgroup.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > index d16eb00c947d..99e9a367e1e5 100644
> > --- a/mm/hugetlb_cgroup.c
> > +++ b/mm/hugetlb_cgroup.c
> > @@ -19,7 +19,6 @@
> >
> >  #include <linux/cgroup.h>
> >  #include <linux/page_counter.h>
> > -#include <linux/slab.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/hugetlb_cgroup.h>
> >
> > --
> > 2.23.0
> >

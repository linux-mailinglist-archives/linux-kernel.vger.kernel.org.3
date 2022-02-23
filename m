Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226ED4C1E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbiBWWbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243841AbiBWWbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:31:31 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118A4D612
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:31:00 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id c36so2172896uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RPwSA1q9Nzhq0/2Be8zKvMRRcdwuPwwh16qax7HGnE=;
        b=K0CZpAIDRgzm1DInotHuxQNOJpRDnhpSUF+ctLbt+rxbs0LQZI1S/EJG354MaIhC1p
         b45wsq4jtpVp8/TYsrR7yb4UHfBZz2cfnUtGlk70ABA3mLXm2hl2NlxJgQMPfc0P8V/B
         fAw/G1/6B7k4ewpmyD5SJHfM3X1NDpa/y+ufO0W+38RcacUCr/Jaq2gwTigxybnkPr8G
         k+GmLhgJ03xfxxcsYrsKSdCyoGsHhW5WrYQEbXEAyQ8dKL6rgE9tfk0rxLHuKnqAg2K+
         mJ72+bba2C/Wp8bcOfZzDa9zKelfx9id1sP9BdY2CnJq66D7nJJyZ5eIZZV3Ta5wjXNH
         Y5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RPwSA1q9Nzhq0/2Be8zKvMRRcdwuPwwh16qax7HGnE=;
        b=YEl9ERorlXgBdDU0+P4HX+zhiqZW4kx9YjS0PWJo+zLnT/atv4ZmeakjzUYKqqBwee
         qcKl6jtncXxUshU3tS8VZqiep1tzJjA+GPDdmLAGgK24+b980HiXdV2t/AmiUR2vVjra
         v3huQ8S7LcIlAej+8uuHrsQrRxMGb87BfQ9QaadDmO3ORI1AoqX1rwZqbqQsWSFg/nBf
         NR04ebzwpnOksCCgk5uaSLTntQ6Gtvnzvcaz5ceDdFZBf89Cy2swezbQkypz6aqLWfkX
         Jqf4nKPpAmgjyhCcGE4W91RsB1ffdMb8qO+c5R43lddIkgiGaGRt0i+0dxebXl58ij8H
         oBDQ==
X-Gm-Message-State: AOAM530MmN/YeX3ZgWvoxgHdrSxM55QO0iQchHUM9/zeX1PiKD8k4joD
        PZKBZXEwgCMC6eKe/M0s0OzoanSwiwqqKqn253xoTg==
X-Google-Smtp-Source: ABdhPJxcYUHzeNXY0S/1ioCWxi5/56MKJyhukDlovTx8UShV5ojlA1UJTSNGHwOPvWyeZntnlGp/VLuoQHMIA6GpB20=
X-Received: by 2002:ab0:69d0:0:b0:345:72b0:ee12 with SMTP id
 u16-20020ab069d0000000b0034572b0ee12mr946042uaq.78.1645655459242; Wed, 23 Feb
 2022 14:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20220219012433.890941-1-pcc@google.com> <7a6afd53-a5c8-1be3-83cc-832596702401@huawei.com>
 <CANpmjNO=1utdh_52sVWb1rNCDme+hbMJzP9GMfF1xWigmy2WsA@mail.gmail.com>
In-Reply-To: <CANpmjNO=1utdh_52sVWb1rNCDme+hbMJzP9GMfF1xWigmy2WsA@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 23 Feb 2022 14:30:48 -0800
Message-ID: <CAMn1gO7S++yR4=DjrPZU_POAHP8Pfxaa3P2Cy__Ggu+kN9pqBA@mail.gmail.com>
Subject: Re: [PATCH] kasan: update function name in comments
To:     Marco Elver <elver@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 21, 2022 at 3:15 AM Marco Elver <elver@google.com> wrote:
>
> On Sat, 19 Feb 2022 at 03:00, Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> > On 2022/2/19 9:24, Peter Collingbourne wrote:
> > > The function kasan_global_oob was renamed to kasan_global_oob_right,
> > > but the comments referring to it were not updated. Do so.
> > >
> > > Link: https://linux-review.googlesource.com/id/I20faa90126937bbee77d9d44709556c3dd4b40be
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Fixes: e5f4728767d2 ("kasan: test: add globals left-out-of-bounds test")
> >
> > This Fixes tag is unneeded.
> >
> > Except the above nit, this patch looks good to me. Thanks.
> >
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> And yes, the Fixes tag should be removed to not have stable teams do
> unnecessary work.

I thought that Cc: stable@vger.kernel.org controlled whether the patch
is to be taken to the stable kernel and Fixes: was more of an
informational tag. At least that's what this seems to say:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#reviewer-s-statement-of-oversight

> +Cc'ing missing mailing lists (use get_maintainers.pl - in particular,
> LKML is missing, which should always be Cc'd for archival purposes so
> that things like b4 can work properly).

get_maintainers.pl tends to list a lot of reviewers so I try to filter
it to only the most important recipients or only use it for
"important" patches (like the uaccess logging patch). It's also a bit
broken in my workflow --
https://lore.kernel.org/all/20210913233435.24585-1-pcc@google.com/
fixes one of the problems but there are others.

Doesn't b4 scan all the mailing lists? So I'd have imagined it
wouldn't matter which one you send it to.

Peter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC54BE0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356272AbiBULXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:23:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356299AbiBULXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:23:06 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849892
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:15:25 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d6923bca1aso125049407b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW+puJnFP6GDgHHGWDtmoEv/OAIRXfNxeTuS1KHKS4k=;
        b=ouaPUyc5S5AFk1T7BxP0W0fhHLsDrC1X05D49SErp1xkWV9WjlDmH/BG8/BhlD++F9
         AT+4MGNLApzlCASeujOqYro1ZV8advB1PdCWuxdmmgixehhzJykeKLDDOqbMg/JkzY/6
         rnq12h426up1wRYeC10q6kegTee8TO07+5um77gBiNcyGEaIORHSDfbUM1BstxfamRP9
         grWcbQpNcTxhADWewkL5NuY6rahD3ZCPdUdpAAEpS9eI5oznaRHDJmcFixfdLNo/u+WN
         E8+LgKgf0MghrhwbqqY0TSVIs7YPxomaod3TrD9B1Eoi7ak7V39fxTeek92jejy85ncN
         TLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW+puJnFP6GDgHHGWDtmoEv/OAIRXfNxeTuS1KHKS4k=;
        b=JYaRq1oTmKZRdD4J/JFhSyh14DGBd+sdGBp4OO4l4ee8StU1TN1iWQ27zCM8+lavyw
         r9zkpq7c561ahIM2WeDSOWMim7YlZ1R4Cf3MhZLJAccuHg5WIQArkZ2N/j1jJQ68tLHy
         JOvdUuc+pn6AmNtTPVKKbVQRrFJAaJS+T+czAUVTiIaywPIpAshj72bhMFojgGugXGiU
         cq4Ey+vzseWfHn41lA30cTzEDWOjGshdELHj4TTy3feTEqMK3yjqmD7yqv+b2JJkXCx+
         BAuJUsE9Q+NGVVVsaTFc4PNnR6DIKi+T/kd8naDlzUNKWY99dWygL+FgzPBEpBCEgox4
         w27Q==
X-Gm-Message-State: AOAM5328RKTvQDbKvfxDE6DViBW8xJsC+W4KVoAe9xoiJOG5272/mMEa
        PUXxPx8SvkStu9gfvLud8w8Ftw6EUpCGbmidlcXC+nzihXvhcQ==
X-Google-Smtp-Source: ABdhPJyE6n7bniNE5YxwK4dvryGKYZY5CGm6vwxplnSM1NRRpYP8o6nDdeY+frPLwgGsECDDDHkRoX52uu4YXmh5jss=
X-Received: by 2002:a0d:fb07:0:b0:2ca:287c:6c97 with SMTP id
 l7-20020a0dfb07000000b002ca287c6c97mr18617337ywf.316.1645442123922; Mon, 21
 Feb 2022 03:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20220219012433.890941-1-pcc@google.com> <7a6afd53-a5c8-1be3-83cc-832596702401@huawei.com>
In-Reply-To: <7a6afd53-a5c8-1be3-83cc-832596702401@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Feb 2022 12:15:12 +0100
Message-ID: <CANpmjNO=1utdh_52sVWb1rNCDme+hbMJzP9GMfF1xWigmy2WsA@mail.gmail.com>
Subject: Re: [PATCH] kasan: update function name in comments
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

On Sat, 19 Feb 2022 at 03:00, Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/2/19 9:24, Peter Collingbourne wrote:
> > The function kasan_global_oob was renamed to kasan_global_oob_right,
> > but the comments referring to it were not updated. Do so.
> >
> > Link: https://linux-review.googlesource.com/id/I20faa90126937bbee77d9d44709556c3dd4b40be
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Fixes: e5f4728767d2 ("kasan: test: add globals left-out-of-bounds test")
>
> This Fixes tag is unneeded.
>
> Except the above nit, this patch looks good to me. Thanks.
>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>

And yes, the Fixes tag should be removed to not have stable teams do
unnecessary work.

+Cc'ing missing mailing lists (use get_maintainers.pl - in particular,
LKML is missing, which should always be Cc'd for archival purposes so
that things like b4 can work properly).

> > ---
> >  lib/test_kasan.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 26a5c9007653..a8dfda9b9630 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -780,7 +780,7 @@ static void ksize_uaf(struct kunit *test)
> >  static void kasan_stack_oob(struct kunit *test)
> >  {
> >       char stack_array[10];
> > -     /* See comment in kasan_global_oob. */
> > +     /* See comment in kasan_global_oob_right. */
> >       char *volatile array = stack_array;
> >       char *p = &array[ARRAY_SIZE(stack_array) + OOB_TAG_OFF];
> >
> > @@ -793,7 +793,7 @@ static void kasan_alloca_oob_left(struct kunit *test)
> >  {
> >       volatile int i = 10;
> >       char alloca_array[i];
> > -     /* See comment in kasan_global_oob. */
> > +     /* See comment in kasan_global_oob_right. */
> >       char *volatile array = alloca_array;
> >       char *p = array - 1;
> >
> > @@ -808,7 +808,7 @@ static void kasan_alloca_oob_right(struct kunit *test)
> >  {
> >       volatile int i = 10;
> >       char alloca_array[i];
> > -     /* See comment in kasan_global_oob. */
> > +     /* See comment in kasan_global_oob_right. */
> >       char *volatile array = alloca_array;
> >       char *p = array + i;
> >
> >
>

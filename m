Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82153D258
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349237AbiFCT0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbiFCT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:26:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B075623A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:26:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me5so17243901ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omWuaWUSnOwV+8HYbTsCRJE4z3TNTNukSNQi8ScudBU=;
        b=EasUcfCayO0OXpgHFHq40YO6LZGtkxtxVRjEW+IkVo6MX/7bOsDlgvabBNTvWWK0aH
         iAi0V1jnmmrIYl16NDBxWAGXuzdbtYXiipBm6vdj1PcNdb2i/G4fFtr+Wh+IXhP11fuL
         o84WkAzC5rv+Eu3fcWULlVtaUwkhs7dzZ6F8zv9a3GuBzjv8BYphChoeMxn5iNYgnlKJ
         pSSukb/wU5l3Ap5cVrQ36K7+9uYvi15tQ85trGftxFPdbrWeU5PwDO+RAGizvOCd6Y9I
         ySuyMS6ctRSeQ+Qe/QnGIrunN01HAgzw2l9OH8K7e4vk7Gg2ORjmQ0H5t+5ax/kQIcJ+
         XvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omWuaWUSnOwV+8HYbTsCRJE4z3TNTNukSNQi8ScudBU=;
        b=lwHxq/GuRzgxerY40Am9d1nsqxFB95DN2TBT0nXdX258ScgpyLtLd8+2zh0mLkEjAQ
         sACuRafG7DRsDsjJU9tfun67c2gz4Ht6evfBuI1IM80gPYumf/4MRWi8Vf18B9uJqqBk
         9KHD0L7+4XcB/6GdiM2/yn5pX5NQa7UBpSMooEhAXxv2JdF0m3B0Cws4XkZR8fKxuCa8
         kV+eU7HzOtjQRn9ochgQyAIgMq/1qHlIQ8+ZSX9b8jhZsm1WCCUQjExkXCXZO9rwVpu6
         IAg1o9tAy8JIHdaCybhmIRVyAX83WyPMzJipk4SPRfU3IFv8eVgvO7gFxJFkXotPV7gb
         bvYw==
X-Gm-Message-State: AOAM530YKgNT4Px/fddiTg5ssgBS1Gzub3H57+ltYEEQPYAzhs2+6i1w
        aiyw2d/yFrBwhEaONs0KKBV80BUYpFQt2kWVM1I=
X-Google-Smtp-Source: ABdhPJyeJmeC178sKnRtB8OennwBgln18dwq8hiaghocp5SScetEe5HOlMpw5VBkyeAL3F7APQGP3m21LI+XMf7Xa3U=
X-Received: by 2002:a17:907:8a27:b0:707:cc50:e790 with SMTP id
 sc39-20020a1709078a2700b00707cc50e790mr10102666ejc.77.1654284400772; Fri, 03
 Jun 2022 12:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220603171012.48880-1-andriy.shevchenko@linux.intel.com> <20220603101527.39a069809dd8c0b72920fca4@linux-foundation.org>
In-Reply-To: <20220603101527.39a069809dd8c0b72920fca4@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 21:26:04 +0200
Message-ID: <CAHp75VexnrOZua3j-v2y4mfcC0+LptRZ6jJX0vEX+OKqnLsZUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] rbtree: Replace kernel.h with the necessary inclusions
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 3, 2022 at 9:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri,  3 Jun 2022 20:10:12 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> >
> > Replace kernel.h inclusion with the list of what is really being used.
>
> There are surely thousands of files we could do this with.

Yes, but the idea is to touch only (global / generic) headers to clean
up them from kernel.h.

>  Is this the
> start of a lifelong project,

Continuation of something which annoys me for a long time. We have not
so many, btw, files that are generic and include kernel.h in the
include/*.

> or is there something special about
> rbtree.h?

Nothing except that header being included in many other modules.

I believe this work goes in conjunction with Ingo's huge clean up
series. Not sure where it's now.

-- 
With Best Regards,
Andy Shevchenko

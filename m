Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452D954A3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349139AbiFNBuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiFNBuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:50:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4F2C10A;
        Mon, 13 Jun 2022 18:50:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 25so9549814edw.8;
        Mon, 13 Jun 2022 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC4cC6xqLpNjJcTRVc9cbkZ2veanyHZIOpz/10KHRlE=;
        b=SylH0oLhpiSNSMQ24eXb2MxaYkBgTx3hdy3OloWuxF7tYYVBMSbP5jX6Ug6AFkCwkH
         TCJYe5Cj8MOkhwk7mQCXwMK+/57yzF6puQAJGzz1VaEn7JAZrtThZJ9Fa93puXpEmugT
         OEHbE1yvtIgLWKc1yeI+7T3TbRxRWpY6BCKGFbSeYHyd5qcIiPGsVR+oCUpRb9HfWCzl
         PpIGBpmjN6epxVKue9GJzjze86HTIAbW1iRJqA7tWN/874C56e4Lac80MEURqohZoo31
         tHCgmuRDQ1XRNOUu5wmACYTWUqjSOn5o9XsJHM4dPJ+wOkwydFJjSWdYeJ97QSUHQbZX
         Kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC4cC6xqLpNjJcTRVc9cbkZ2veanyHZIOpz/10KHRlE=;
        b=ICxccc9LRdcN2HRhv3473dvxtyXU1UIxMU4iXMPAtL+GDrM0cG42wTnXDR3TPjBoUL
         actjHGJP7Fw7Pnvs5ewF/jWjc5X9T3MshAtN55Ql+yHK4sMWmyYJ1MPLjPJr213CTQbM
         DCKNK+WYOyJnS3iLrOc97zYnVTzDHQGyJKLasXAev9gZwgJjNP5awT6Ck3BjCwxsvFBK
         Xeg/fl6cUHHLnBx8ZKAflfBHwG0q/zStpzVL5UAMlWsZ75ivMW6ouQLp+fuh8Rv/DpAP
         pA6/34CjAJ6N8guhmwzWk/HEZLRVLWnhG5xdkCCf0bTp0OY3js+IseS3yjcQy2UvZHzS
         rPqg==
X-Gm-Message-State: AJIora8VEngQ3nbVui6+5sBMbetuoevd5UATSiW9acw8ywYWYnE5u/Su
        QhkRj8Bs/TvawWYOUoo7Z1uBaSWKM7+Six92CpQ=
X-Google-Smtp-Source: ABdhPJwnROWsbMWlDeqxyGahZkqEhUbMS48bk+kBqxa4mCeEmj/YxhYUX7snuSgtPgK3zSD2HRg/Po/pa2lotiC/bIY=
X-Received: by 2002:a05:6402:3681:b0:433:2b63:4866 with SMTP id
 ej1-20020a056402368100b004332b634866mr3065276edb.295.1655171405197; Mon, 13
 Jun 2022 18:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
 <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 14 Jun 2022 09:49:30 +0800
Message-ID: <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
Subject: Re: [PATCH] dev-tools: fix one invalid url
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>, cocci@inria.fr,
        linux-doc@vger.kernel.org,
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

On Mon, Jun 13, 2022 at 6:12 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 13 Jun 2022, Bagas Sanjaya wrote:
>
> > On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > Fix the invalid url about Semantic Patch Language
> > >
> >
> > I think what this patch doing is to point SPL reference URL from old
> > Coccinelle documentation (doc root) to actual SPL doc entry on new
> > Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> > description and title.
>
> Agreed, thanks for the suggestion.

Okay. Let's modify the title to "modify SPL reference URL to actual
SPL doc entry".

BTW, I modify this URL because the previous URL cannot be accessed.

>
> julia

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165A255174E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiFTLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFTLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:24:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C2715830
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:24:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v8so11533512ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Yt7N7lIt6rrL+t7Ro4DPilPiH3bCntuNreRubvS7Kc=;
        b=P86niLyEltitD6qcrewvCIeD/Op6qsjJFYmoGU6u+gtc6fVIqmPbQhGFZEkDLgI6OI
         BXArQyWCEe/Cyz8l5OJ3nYOh+qih2Kxxycb2IrB1x91kOt1hBtAcm8Ms7plCV9r3Sw02
         BDdJBwuF5+ZhxP8OIygE9OSGlfvj1YA8GBERqjBNiHmTHtPc002LYYI/WdFffSmVbFp7
         ss5zm6nJOmHMP5dnB8lYHWM97VavfT7DzMnxXQ6bP5emyjiGDGqPvQkfKWXHTzLppgpl
         vmz0e+IzsOKiUPE8lJjv/rRI2sxRvUDpLWNXXZ00Tvx0CTMU593HWGFbs/WjimSaAeo7
         98BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Yt7N7lIt6rrL+t7Ro4DPilPiH3bCntuNreRubvS7Kc=;
        b=3ZxDXQ92oDJaMzNGhzwoQPbYH07zLk6GtwDWlzjZH3HS9Dyd/M34SvHg5XAID+ClNj
         PWXCH+ircUsuxlXtoXWIWAlW0Vj+etNqJVLaXzYH8C9vK4Y952jyKz6y2EJVqGAfcRPZ
         KVVEFIOyAOrrvcH08EJd6VFGFeVuMlIikNkyHq835QOF4NFCnu/LxPIG8EnOOrvYmYSb
         Z+A34toZnbQ7cei6n20YQHnCbc5OMweYV76C21ov7utcKTOM5Rf9ZrMCKg61lH0cXTWP
         EIqFyDDJsJ5FaWFxUpNxFJzOWnhdJZjvp7nRs97mVAxbrEezfifXhMOVNj8JCGTNX5Nr
         oBtw==
X-Gm-Message-State: AJIora9AwTQagzrnrfTOHjsFfjIdkftQDaV4Q21Vu9UWXnM50h0T8Vaw
        EZ5Mv/VVt0BGHc2lk+3G/jEIyQlXnx1kmhmHZIA=
X-Google-Smtp-Source: AGRyM1tkovQ3GhgpyWicWNL/SBpHcmpj4RpsJcHMRz54/hlnlFAbPCTQ0AcppAB5v0FJLJ4PjVP8MQEzCRBA39J1FiI=
X-Received: by 2002:a2e:7d17:0:b0:25a:6ccd:ab6 with SMTP id
 y23-20020a2e7d17000000b0025a6ccd0ab6mr3048176ljc.114.1655724244209; Mon, 20
 Jun 2022 04:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
 <Yq+PMWlARgDhv8uL@pc638.lan> <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
 <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
In-Reply-To: <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 20 Jun 2022 19:23:34 +0800
Message-ID: <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Jun 20, 2022 at 6:44 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > > >
> > > Is it easy to reproduce? If so could you please describe the steps? As i see
> > > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > > glance i do not see how it can accessed twice. Hm..
> > It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> > failed. IMO, vb->va which out of vmap_purge_lock protection could race
> > with a concurrent ra freeing within __purge_vmap_area_lazy.
> >
> Do you have exact steps how you run "monkey" test?
There are about 30+ kos inserted during startup which could be a
specific criteria for reproduction. Do you have doubts about the test
result or the solution?
>
> --
> Uladzislau Rezki

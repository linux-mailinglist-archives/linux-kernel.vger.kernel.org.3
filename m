Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349115A9A13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiIAOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiIAOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:22:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6E74DDB;
        Thu,  1 Sep 2022 07:22:11 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3378303138bso338299287b3.9;
        Thu, 01 Sep 2022 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=llgzYf8llaL/EQFs3tuAuAqt9Z5KoWpl+4uUr05iaK8=;
        b=fcbSSEhR2ZsvmYNnB/aQXc9F/i+SM/d8jxzsdHWSMPfcgdbV3linpJ3wj3+SnkwD/F
         o2AqZR86xlBVfHaLatuNGZp/wIvsXTblUOiZhNZ0VGvX05Zas9Iy9jJ6Yd7UqidYl8jp
         HqNqfkE3mL8FomBZh6rlRAQANs9ddDhQ6WeoLi402TMQnOzCD73ebnojKbyajx7ZhVvc
         aNOk7ww7q9txqFLIwp3OA4NGG6nnNwHH5ZoxKJ0EWKjQEsRMa6olk9yvYTbD7afvYMVY
         oUxxCFYT5z78M7jb1PlHwG/YwY+6FJ8jrhbEXt6/0ansIhBJ7G9n1mxaebM3nIwx1me4
         bO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=llgzYf8llaL/EQFs3tuAuAqt9Z5KoWpl+4uUr05iaK8=;
        b=2wbW5l1mZKQjHq97p7jrRkmRLrIdnpDYaBGBlORlXAYsxfMFuRYQRrAWEjSrLfD6PR
         UJUr6BdHPjf9+byWWULwdUXFOnttbbtgq6+BGsFv/4YLyDV+Yaic31hn2+UAUF1F7Mcu
         X2Y3GgD+JGzvJ3QxdmbX8oRakNPKoDU5nak2vA2v+lNLXv6dwYtoW2v3jRIxmc6rIkXM
         SuAaNkYrxL5NJw+FABYmjElZRMVb1pcH2CK3rzWyWQlXvyxQ0Ur4NpOFi3+/142D3Vyy
         QS1k8H5j2apULSYjs1YVADt+WV/j5u19WHIXe3iFCVwPqt7/u5+CdyjJrb6IxZ3PSKzj
         4NFw==
X-Gm-Message-State: ACgBeo2ZwfwJnQeEbXcbkyZft8mG4zPKQIUijiuR+KPiY6u7FMlM5w3h
        qzL+7sEQzOKpyHIYbTbZ4nwDgZf4kl4XN/FdhI6MRK/Ayrw=
X-Google-Smtp-Source: AA6agR6fFQP4CuyJerD+YutxFwlcsRBQyahL7qL90WE1xL3YQzvbookqIiRTL+KO+aqqpWa+nD9OWIyOWVuuhH0vIko=
X-Received: by 2002:a81:8984:0:b0:33e:1114:2598 with SMTP id
 z126-20020a818984000000b0033e11142598mr23329655ywf.75.1662042129959; Thu, 01
 Sep 2022 07:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220829065239.4531-1-lf32.dev@gmail.com> <87wnarnf4k.fsf@meer.lwn.net>
In-Reply-To: <87wnarnf4k.fsf@meer.lwn.net>
From:   lf32 dev <lf32.dev@gmail.com>
Date:   Thu, 1 Sep 2022 19:51:59 +0530
Message-ID: <CAOUyfw0aoZaaJ0yZzAVDQO=RHvNa=ZAXRDTO7yiNEomtyKb9-g@mail.gmail.com>
Subject: Re: [PATCH] Delete duplicate words from kernel docs
To:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Awesome, thanks for merging this!


On Mon, Aug 29, 2022 at 10:47 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Akhil Raj <lf32.dev@gmail.com> writes:
>
> > I have deleted duplicate words like
> >
> > to, guest, trace, when, we
> >
> > Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
> > ---
> >  Documentation/RCU/checklist.rst         | 2 +-
> >  Documentation/RCU/lockdep.rst           | 2 +-
> >  Documentation/bpf/instruction-set.rst   | 2 +-
> >  Documentation/trace/histogram.rst       | 2 +-
> >  Documentation/trace/timerlat-tracer.rst | 2 +-
> >  Documentation/virt/kvm/x86/mmu.rst      | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
>
> Applied, thanks,
>
> jon

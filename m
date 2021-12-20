Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6B47A9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhLTMsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhLTMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:48:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4987C061574;
        Mon, 20 Dec 2021 04:48:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z29so37723508edl.7;
        Mon, 20 Dec 2021 04:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRHlYhpHZvsECzL974twfMxddJZ0jbLrHI1pYPF66yc=;
        b=CBpKqpSUY1LCo0o8pCHQv3NnMN+ruL5PSDPyhUa/LBxdJ83nRh2YukO6h4nSPFnfkJ
         LwmsD2P1HLMDOuMqC/8CPEAKY774mKAiJzFvcFV5/SDP8jSzahwa5/ypNhdc3N3/PrV9
         7mOKrQIv9fQ6jp3tvvRsWG6BMR4zeOOOCSwCnzBGL9B+H+Unkb5qrYaCqkaYrYIlfvl8
         Z3v2xhym/+cNwI2ROkeiGXr4Db/Xdl4Tu/zChtZCKyFBpIALBO6mCI3hr6DZUpjK7dvy
         U0uNeOdq2U/1Q8w6Xb9F2Iq/QXde8yGJSO86vjDimF8acw8Y2Pw53Giz5aQV9wYKhhrm
         c9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRHlYhpHZvsECzL974twfMxddJZ0jbLrHI1pYPF66yc=;
        b=ktdaViliZoPclPfRTGATF523Ur2pg7ENlf985EbNWZgfkPzdjXpvyJTbf+DMsf4kC/
         85ZzgDM6Z5pSC7UaPHXxzsSOeotCZsthk6LD2y7srOTbCurVxepJ8t8TPSKLOPXJj7HY
         hO8qJTAUjz5tqxSTCR4t3AtC4q1OQAeKRlBzxQw9s3OUXPSySX+QgFb3FBC2VL1ThQ7F
         rASG5uKdNCC5EIjHr5yVCmWd7P6G8vGl+A/gaA+xbwN5IQ/5zMkhlikmb0flSzW2pu8m
         xujsLIfFgVQ/KDTR/rdwqGSWZzboGOd8S4oLKyoeShO6m4cFuWhnpxGMagqko4gH5vtk
         D5Gg==
X-Gm-Message-State: AOAM5318kUz8LiIA+0pRiXxjl9B6iv4LOF14hhRzEbHMEBBz9GDNN6GV
        26OJIRYWJ/nF2lHgG+WBqVmvtZq5DBRuZca7ifY=
X-Google-Smtp-Source: ABdhPJxToRKgdz4Y5zPqp+igA2yrTZhszbtK4ONBNiMk0A68rzHzL2HyWMmly7mVtY+NRlH/MlvxPI6jKz2hWFtgnDk=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr15681716edd.258.1640004481331;
 Mon, 20 Dec 2021 04:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20211220165103.0d75d56d@canb.auug.org.au>
In-Reply-To: <20211220165103.0d75d56d@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Dec 2021 14:46:01 +0200
Message-ID: <CAHp75Vd0xWe8HeNp=+njJQhFqSGF-74KdZ+oXMTzmGRFQ9arzg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the gpio-brgl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpio/gpio-rda.c: In function 'rda_gpio_probe':
> drivers/gpio/gpio-rda.c:200:22: error: unused variable 'np' [-Werror=unused-variable]
>   200 |  struct device_node *np = pdev->dev.of_node;
>       |                      ^~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   448cf90513d9 ("gpio: Get rid of duplicate of_node assignment in the drivers")
>
> I have used the gpio-brgl tree from next-20211217 (with the revert) for today.

My fault, sorry. Fix patch is on the way!




--
With Best Regards,
Andy Shevchenko

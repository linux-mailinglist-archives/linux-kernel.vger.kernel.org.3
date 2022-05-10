Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1D52225E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbiEJR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348009AbiEJR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:27:45 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E19D04C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:23:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a10so1782596ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2FaoOCAjCjGV80yLIIB5iRl7eAw6edvFtyAZUcH88E=;
        b=QRrlfvMdZ4xNl8ovQfQtYSOtUeAQoEU6XE3h9PA3vveTsfXpsOcZvUpqrrW7rKVSpx
         H+MkcQvaYvaJr+lA49ypRzWxOpta5toMCPT8tLh/VhfOhAKSYMhtl+JL3J4hPlWRq5AO
         FqLUmhHrkTyDcPsCATVfkquO9UvBuEouEd8GXdF3dgp3YnZI8iu9Qt7Rp75Xb4tvOiDQ
         zDfTxelTa6+s3sSqeGqH8rh8S5cI/FZuk6DGjx4NrvGBSsPkhpPUzO0EqTXMqYZVl6Mx
         yJiQl+muopGDwJrJdXmJH2mUAyAx/7Hpn7LgbbhFTqMCm7viUJvPbB67ZXH0b4onlRNO
         UFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2FaoOCAjCjGV80yLIIB5iRl7eAw6edvFtyAZUcH88E=;
        b=fcNEdaZsWy7n/oiRmXHcotZd/sm5YOIndz4/nNQCoAXU5d5x3DzwDCLRfJstRrfhfI
         oYkgRDXvNamSfUwSdjZ17CZaOKKougXUEK9keIbOs5qSN7i1S1xCE2j1j60iC1e9NSzi
         tUk+w6ZGLT0JhjkmcD82ds83hi1Y/N2ADaVey7UyvMmIrRBOaM5oZTuNU8BckTViSFlu
         thskQHScx/YdZSlb5+MF/Gme/HLyMrmfoh13EJzFqFRhyA4pJNcQ/cAYqoMxAtHfxkYo
         tTFoUOmPRXmdxPGoB6+u+QcvqzHTvS6GkcJ9E7JPIuDfz+xZUu0nBcw6BDGsA89ZHF/a
         HcYg==
X-Gm-Message-State: AOAM5337JdD0qWOJINPvnLB2skFLX0ik5BQOZfFu0NOFM7ZVo6jDfg9f
        GH+hVhmyZDLEXIj53Gdbe6JS7Tq61lVDZIVOPz4=
X-Google-Smtp-Source: ABdhPJyn7OPO8AM+k4ohdeS6EWil8MxkDwov7KEbEgSElky+BZ8Ftd1fAUU3Bijisu8E3WyGAjK9Bs5hwY5ff345htc=
X-Received: by 2002:a6b:8b17:0:b0:657:c836:de6 with SMTP id
 n23-20020a6b8b17000000b00657c8360de6mr9354382iod.99.1652203426566; Tue, 10
 May 2022 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <896b2d914d6b50d677fd7b38f76967cc705c01ba.1652203271.git.andreyknvl@google.com>
In-Reply-To: <896b2d914d6b50d677fd7b38f76967cc705c01ba.1652203271.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 10 May 2022 19:23:35 +0200
Message-ID: <CA+fCnZdZm3ATDj-nGs+6RNnKFtq9+0Zi3yLkaxv4Q9SsUoy7yA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kasan: update documentation
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, May 10, 2022 at 7:21 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Do assorted clean-ups and improvements to KASAN documentation, including:
>
> - Describe each mode in a dedicated paragraph.
> - Split out a Support section that describes in details which compilers,
>   architectures and memory types each mode requires/supports.
> - Capitalize the first letter in the names of each KASAN mode.
>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Forgot to mention the v1->v2 change: I reworded the last paragraph as
Marco suggested. The other patches were not changed.

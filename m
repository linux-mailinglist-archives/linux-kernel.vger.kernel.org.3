Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCF58D684
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiHIJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbiHIJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:25:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D121833;
        Tue,  9 Aug 2022 02:25:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so625114qtv.9;
        Tue, 09 Aug 2022 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=U+j+BlGsb4c+HYrBpAo1qOUNjjAcVAfu1SF1ejcI/+E=;
        b=f7Uw6C/MiuF8NuQrX6pT3ut7HODW+t4ho5JKDp8b6XakOLqrpWpHF0GuryPSKRSzZ5
         Cz1bT4v0cJxgu/1hj5c/PL6LoquF3R4BGYlBDrTECA96TeuMMaTwp54UB7iMZR+GgqAX
         hN9svmOqKZ+5WfJ0nBgitoqeQf/vjIk5XZ9/FFk4GPCqZKJm2kidByVX35mQoHy1mLWG
         VK9CINj/Dpm3dljM6abW8mtv0MPzINLoNpKOmlVSxXz0xXbpw6/LwAaCIibWuWkAF5TY
         Nq+DSgvksqASTEZ0NDEpb03dUveoAvJu8/lgG6nVVqrM3htHkwvp0aE8dWr3B1oIou6O
         nAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=U+j+BlGsb4c+HYrBpAo1qOUNjjAcVAfu1SF1ejcI/+E=;
        b=09hKWoGG1VJ4TFZ9ktbbRunpRjPdj3KKUmM15hcgHgtqUitODYpvAWQci2uovDC+6c
         g3KKINufb7eLxKD/IlnHfOCTJzFWwSPBw7lbI7jTL82nz58vajsa49FQuZtFem3eaA6p
         eL4aP8XDE+mUBJKM1GH9dji85QiRaIyDRJTIi2b8Wq3vyIrFaQvNciUhapZtemgi9yUs
         gQGcH6LlsSUar1XH3uVwx7nNEmc5a2ynRSWQFbmt86gR2Tmo6h8G5yNGVXd712cLOeDl
         48YsFX+cF0m6U7oSJP6USyHcGfCrlhLnV1CEeJvmAt+QfegvNnRz0yR/Lk0pp5MT+mhc
         G1YQ==
X-Gm-Message-State: ACgBeo0pB1Dm3T8t4Rz8t2FRnY8VW020G3u8WDn68kN7lTDUevm+MQ4n
        EMF7Q0O++FIOoP3Hnke7zAIiUT7U6FjOzFVVCX4=
X-Google-Smtp-Source: AA6agR7adguuUtM7oGKjIirEU0os+T8zfw4kB3W+BRlOCnR3y91VYGF066WHrvDDGCVGvJJXPUrd8qV2bIHjLwFzW/4=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr777600qta.429.1660037148447; Tue, 09 Aug
 2022 02:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev> <20220809025054.1626339-5-luke@ljones.dev>
In-Reply-To: <20220809025054.1626339-5-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:25:12 +0200
Message-ID: <CAHp75VeLWGURdL9SK4+fLPRsM_Dc3bNvGSoWXKOWMSz=3CQUQg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] asus-wmi: Document previously added attributes
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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

On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Documents some previously added attributes:
> - dgpu_disable
> - egpu_enable
> - panel_od

Try to find a commit that introduced thouse and add the respective Fixes tag.

...

> -                       * keyboard - 0 or 1, unknown what effect this really has
> \ No newline at end of file
> +                       * keyboard - 0 or 1, unknown what effect this really has

Should be part of another patch.

-- 
With Best Regards,
Andy Shevchenko

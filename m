Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F977553420
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiFUODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350675AbiFUODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:03:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DB413D12;
        Tue, 21 Jun 2022 07:03:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3178ea840easo93975877b3.13;
        Tue, 21 Jun 2022 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+ukcDB9pljhF1AQzBxm6MNzKas06rc0yYeh8QowLyW8=;
        b=m1UyEamKS6QAtTqv4EtKpzpAs8te/km4KjDsXmv4kHqq7DFK+OnXtVrCGtTI9q8o8Q
         TqK+4HPRj3U1Ws+cyo12SmQJubZacTD9KREgRQObDGEA0NyDb8T7zQ/6J5PsT/sQ1EOh
         fyT+dScJTALprBKXWYlPK/4P434CO0cLwbbC/QtRhZYbV5WgTFF+RmDWpjLcwsFvgXUx
         HWJBu1dcLjFl6FzSBLevA0DnMngK4c4mX9aMQciYRcnsHALsPpIOuSUH9uvN9YPEnz+9
         zakH5UapughIU1jRxn1lTuV8yJFpYFRkI3Y6PCGt/TxqlF8fUMO0IsSlGrhJlvo1ECiS
         7Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+ukcDB9pljhF1AQzBxm6MNzKas06rc0yYeh8QowLyW8=;
        b=vdvpxVqkQ3+fETn+QRlvAEhpTNef74B0oXq52WFJTUIqvk+ty29qiQ1jquGvJNPobk
         pEbWVbyo7RmttEvp3d/xPgFJdVQbCMlD5r0CUiiJHF7ZbsWhXdF5YLLs6Y44zOUypeQN
         sMSOt2B1f9DoUME+CQt48xymEw8A+LR9evWATtF3oKEfeJPeCAUP/QBMOBFsx8lhKviA
         2t/I51amHGZvK8YOVJjGsXJrQawqYGwDBbs24xDp0vJMTOVGwRO48OnbuvZvZRkioOou
         /gNy/HI70N+e8xRVXuRVfkD7oqDVL158gNYRJw5lvCnMibOx+UFJQGhBaBL6T6MXsPqQ
         R5ZA==
X-Gm-Message-State: AJIora//MxFvmutH838kTUdlKQQ8qy2UOcf2TlThJEm7BfKbhjdx8CO2
        ThS6aeUyO/FJjgGb1ikcDFKFLJjlcFWidIlqujo=
X-Google-Smtp-Source: AGRyM1s025+eB4Zs0hBbPkEF9uh5urOs9ZsNMOjbA19LRGjeY1pCnHQFzCCJKxt38rUfRrvYe0WJnC4FPDYeEaMm2z0=
X-Received: by 2002:a05:690c:58d:b0:317:dd62:f6d9 with SMTP id
 bo13-20020a05690c058d00b00317dd62f6d9mr9899585ywb.78.1655820206886; Tue, 21
 Jun 2022 07:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YrHJIjhDP0/Sur1M@shikoro>
In-Reply-To: <YrHJIjhDP0/Sur1M@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 21 Jun 2022 15:03:00 +0100
Message-ID: <CA+V-a8vYjQxgZxcDE6-0cyMA50-f6MvJAWXZVZiWO1QQn99a4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: renesas: Trivial fixes
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Wolfram,

On Tue, Jun 21, 2022 at 2:35 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> > This patch series adds trivial fixes to renesas mmc driver.
>
> Did I miss if there is anything left to discuss for v2?
>
Sorry I missed to follow up. I'll send a v2 soon.

Cheers,
Prabhakar

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57F53BE70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiFBTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiFBTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:10:42 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4FD48
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:10:40 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id k6so1322800qkf.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtWDo4MTVxUub0OsqsFcXGlMn8SJu8w5e+LETPN1X5w=;
        b=WEGpwTsANrZu0zwHT9Z/JjwZVI7FeF9I+mzBEM6dtsQkXlz5I3EOJF2rTNFvV+qWoE
         y5xN57IqcaBdzns75EC+w0RZp84MunipC8Vs4EDB+zxrxpyibPT/PRh8MTmZ5akaD0bf
         G9TQg4FQB1NM8FlO+NN2CYoQu0zKRFRdqz33JA5eZa+szwzOrQ+Ro4CRVt5QWPHGbk2y
         5Bmoq9lIJX84ARnLPJdtBrC6flwCgoLfqY1prE46OmJm7qhTsWCKFDvOS1nJldd6Fh3e
         +c0L9dYdE6hIKsuM/aoZ6VKZysLV2+g16haY95Ps5RUl23/DrddDLnjjBBWmkWKlEe6G
         5tVg==
X-Gm-Message-State: AOAM530pMy3pL7iVQhNt1ajtRb6ZJBMDJt8ZdsoIWpsMR8iqFXm22COc
        VwJ/AHoAK+UGryiDcZKKN7acVBYjgcYysg==
X-Google-Smtp-Source: ABdhPJyATvjF0lAoDsmzwI6ZS2N0KqnSa2ZnKqX/JCboyNsONXydVHm4EdCHkRIO4/vF4iEeSBNKww==
X-Received: by 2002:a05:620a:4415:b0:6a5:895d:f254 with SMTP id v21-20020a05620a441500b006a5895df254mr4003264qkp.517.1654197039775;
        Thu, 02 Jun 2022 12:10:39 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bw16-20020a05622a099000b002f9114d2ebcsm3628327qtb.17.2022.06.02.12.10.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:10:39 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-300628e76f3so61061897b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:10:39 -0700 (PDT)
X-Received: by 2002:a0d:f801:0:b0:30f:f716:2950 with SMTP id
 i1-20020a0df801000000b0030ff7162950mr3084004ywf.358.1654197038940; Thu, 02
 Jun 2022 12:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220602180919.4856-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220602180919.4856-1-wangxiang@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Jun 2022 21:10:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWroxsXvgon34voezjW5HE8mcqB_FEZY5DXi0z_CBpfWg@mail.gmail.com>
Message-ID: <CAMuHMdWroxsXvgon34voezjW5HE8mcqB_FEZY5DXi0z_CBpfWg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On Thu, Jun 2, 2022 at 8:09 PM Xiang wangx <wangxiang@cdjrlc.com> wrote:
> Delete the redundant word 'the'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/coldfire/intc-2.c
> +++ b/arch/m68k/coldfire/intc-2.c
> @@ -7,7 +7,7 @@
>   * family, the 5270, 5271, 5274, 5275, and the 528x family which have two such
>   * controllers, and the 547x and 548x families which have only one of them.
>   *
> - * The external 7 fixed interrupts are part the the Edge Port unit of these
> + * The external 7 fixed interrupts are part the Edge Port unit of these

I think "the the" should be replaced by "of the" instead.

>   * ColdFire parts. They can be configured as level or edge triggered.
>   *
>   * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

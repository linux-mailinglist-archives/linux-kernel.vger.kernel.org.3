Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28C53E8E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiFFOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiFFOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:36:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B3134E0F;
        Mon,  6 Jun 2022 07:36:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gl15so15498979ejb.4;
        Mon, 06 Jun 2022 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8DnZHGE2vgMI63o/XuWMCrMyIJgyxN5npgPANAZCSQ=;
        b=pcpLwsI323LNbbTPDRiEm8e0HpXKuMSNEB09iFlO6vvrWIh42IjIV0OttnBF9RFu0x
         n2nNl3w6XCnfMgiYdcf/lV7zOnsv6nWbPzGD8+t+ge8fZkeIi4gzvxEn9MU19SuZC9yK
         MPcvUBN1GQl+0CmSB9shHozkxPSiuWMREE3fRlShwLL6YdopfVWvN3dlDfEpGZXedFkI
         SkULvkW0CtWqsvGq8QUCK2QwdZTrotMItwCWQ+r9reuelwPX/0wOm3NXwXwZwEVUXjwO
         NwEhU6mPNp9tLLH9waIXHMfhz0cXyrXTgxGTd7uHC5BgyXID47IQK7Q3OCQGFHW5xhhc
         feMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8DnZHGE2vgMI63o/XuWMCrMyIJgyxN5npgPANAZCSQ=;
        b=u/WPILuPVInlJ2D7E0MBjQI2clYjJ/B5GJeUynY1od2v0/KmZfyjkso8BVdUr7VQFX
         XfYqhQiJyHbQzvGvHwbEN1qIaRdKa6bXgykG5hdPTOmnj5TbLcW8uawsN6OYcFTlszGW
         foI6CK2QHohPTejHl/8sj8hjV8YrZY8SMmRHjQ04x6rCZ90+JGbQ3yCnlltheq/4sNB7
         bV+dYRnDIgqUiOF1bheH6ZZv/AjHaiEJYE4FjewGrK4lVMfMrBql7e2KCxSJXLxej7Nc
         9JIy0kwrJtoSrpmZJf+3ampfD5R7Z2tpy+45e+BLIXhSTiGbNcyyFaiFErkW+BAUHtw0
         VDKg==
X-Gm-Message-State: AOAM532F2DhhVTR997WwvkT7ucRVGXbsGrI0kwOARUfGJPPyci53Rjb0
        4XuYPXxNk2WOIJfMmTsDNJJTBmIoyuGzrwLXbwR7s58n1sM=
X-Google-Smtp-Source: ABdhPJxgS23WYwbt+mF3jnkmWmfs7zhRJy0TM5IGchFJ/dZMGJIgHTAaP+RAqV9sJlVx+Rgwd0TsIvR7VYG4hthUQ8k=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr3456644ejb.639.1654526173854; Mon, 06
 Jun 2022 07:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220602083128.22540-1-jslaby@suse.cz> <20220602083128.22540-2-jslaby@suse.cz>
In-Reply-To: <20220602083128.22540-2-jslaby@suse.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 16:35:37 +0200
Message-ID: <CAHp75VfsR6sVwO9iF6RA0bhVjMF1jC1_JEkv106TubPgL_m8YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty/vt: Makefile, add --unicode for loadkeys invocation
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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

On Thu, Jun 2, 2022 at 12:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> For a long time, we generate unicode tables using loadkeys. So fix
> Makefile to use that flag too.

generated

Does it make sense to add the Fixes tag?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
> index fe30ce512819..b3dfe9d5717e 100644
> --- a/drivers/tty/vt/Makefile
> +++ b/drivers/tty/vt/Makefile
> @@ -30,6 +30,6 @@ $(obj)/defkeymap.o:  $(obj)/defkeymap.c
>  ifdef GENERATE_KEYMAP
>
>  $(obj)/defkeymap.c: $(obj)/%.c: $(src)/%.map
> -       loadkeys --mktable $< > $@
> +       loadkeys --mktable --unicode $< > $@
>
>  endif
> --
> 2.36.1
>


-- 
With Best Regards,
Andy Shevchenko

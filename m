Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAE5A190A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiHYStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiHYStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:49:02 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F878A031E;
        Thu, 25 Aug 2022 11:48:58 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-334dc616f86so564621937b3.8;
        Thu, 25 Aug 2022 11:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8DRGx+2fAsr6c6bdtDt+nKmp2Lo/v0GYFJUwFrOm7mE=;
        b=790gnLmn0v9Zoa37UY29vw4ms5WsCUu8quidKq5ScWiY6MOLJCxIZeHQu1ufjPIinq
         zXdLrOV3NV3si9f6MZ7YXddTNjRvGX8VY9MC3dlaIpORAhQwT3em2CZ6cBWy6rXWKc9J
         R6L8HSOjuccnK5QtUoV/FtnpvaYJetqaLECtEAV4tEGcfXS/smh49RYS8ajRwzbFG+HB
         PV3lWWA5EWyqNVa+l5Y/9C7TW5kbeyyLnLSsoeTCHYdp5G8FErZLIJKARmy9LhO8peE8
         68J/H+E/DuqlS0U3+DLHi9YSdtNiPzTA7ignw3EwmEOTHdIIM0kSie2gD7J7a4oABl5A
         gHqw==
X-Gm-Message-State: ACgBeo1oy99fdX0EZWp3cz60fEubYvJ5saqu/7ppXMrHXggWWFFmYlzH
        aXeoqnqDBosLPyU+1ikMzZLlZusu6lVUlc/YznY=
X-Google-Smtp-Source: AA6agR5rDQxTGZJMQ+F/ryErL/cqN6FBAXx/DcTj8QUBY260gtxmPmTA8ZEmo3WWvr3LwO6zzqeRk98qU1d+L26gK6Y=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr4528907ybf.81.1661453337491; Thu, 25 Aug
 2022 11:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220824075306.221472-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220824075306.221472-1-ye.xingchen@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 20:48:46 +0200
Message-ID: <CAJZ5v0h2PqVVw+vKcN=W=CjZ5Q50_5Og05Qvi=TjrddVSyYz8g@mail.gmail.com>
Subject: Re: [PATCH linux-next] ACPI: bus: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 9:53 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value from driver_register() directly instead of storing it
>  in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/acpi/bus.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c0d20d997891..661a63ea3248 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -973,16 +973,13 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_device);
>   */
>  int acpi_bus_register_driver(struct acpi_driver *driver)
>  {
> -       int ret;
> -
>         if (acpi_disabled)
>                 return -ENODEV;
>         driver->drv.name = driver->name;
>         driver->drv.bus = &acpi_bus_type;
>         driver->drv.owner = driver->owner;
>
> -       ret = driver_register(&driver->drv);
> -       return ret;
> +       return driver_register(&driver->drv);
>  }
>
>  EXPORT_SYMBOL(acpi_bus_register_driver);
> --

Applied as 6.1 material, thanks!

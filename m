Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB06D5A4F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiH2O2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiH2O2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:28:36 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732580506;
        Mon, 29 Aug 2022 07:28:35 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-33dba2693d0so199252067b3.12;
        Mon, 29 Aug 2022 07:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ovyPCToe6BVA5wXFC3JUJSrlO9UUVb1qRsKDJHgKKqE=;
        b=6kh/AVjxxdJTmUFsbxpfVSpW61bXhJpjNAbuDFFJTZMMD7cYzj9nbQWUTmkV66Y9J/
         19T80WoHSe8OFM7aINMyTl7IMvyo8td/OVPi3dj23OK0924DDujQm2vITNgFFLh9eNjx
         Tlh9zRv7Tl1CIGPuhIC474/+vI6QukgXTDUUok3Aidk3MLijer7GCnPTnXlRL+2DdQzj
         rMyx3olRUwG8bmdbesfpP8U/nHtRxF9iRhlBc8q1ubavQCW15BvZ16f111/nYVWyc0mu
         hjX+yek9XyHNGJqh+o55IlQhgT2m9gVRyeYR6jEhUNweB7nsH0yFkccq2kJisk4ATl5A
         nqew==
X-Gm-Message-State: ACgBeo35oPTVq7oj0EZ9BWfiVM45edM6DDyoe5s6nngRT112MjopQsuP
        eqXty8RueZ9uZc8NMyoEKmY7OEeXjH1cwurXNyo=
X-Google-Smtp-Source: AA6agR7zGiWHBCQf7pqrdzWTLjt4WSzzJAkMRrjSA4V53lEUhjr73CQ04lwxNHcthHySeAujiMshtqi15GVgfvtgoVc=
X-Received: by 2002:a25:8d84:0:b0:695:836a:fcaf with SMTP id
 o4-20020a258d84000000b00695836afcafmr8479720ybl.633.1661783314497; Mon, 29
 Aug 2022 07:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com> <20220829141100.63934-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220829141100.63934-4-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Aug 2022 16:28:23 +0200
Message-ID: <CAJZ5v0jtk0SBz6X3cwpKbckhGdmGE39Ynd94M5C8c4RvqVWQ=A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ACPI: platform: Keep list of ACPI IDs sorted
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Mon, Aug 29, 2022 at 4:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> For better maintenance keep list of the ACPI IDs sorted.
> While at it, replace terminator with more standard '{ }'.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Subject: ACPI: platform: Sort forbidden_id_list[] in ascending order

Changelog:

"For easier maintenance, sort the forbidden_id_list[] table rows in
ascending order with respect to the device ID field.

While at it, use an empty row as the list terminator, which is more
usual in the kernel."

Pretty please.

> ---
>  drivers/acpi/acpi_platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 0d812fe248d4..f13409583cd9 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -20,13 +20,13 @@
>  #include "internal.h"
>
>  static const struct acpi_device_id forbidden_id_list[] = {
> +       {"ACPI0009", 0},        /* IOxAPIC */
> +       {"ACPI000A", 0},        /* IOAPIC */
>         {"PNP0000",  0},        /* PIC */
>         {"PNP0100",  0},        /* Timer */
>         {"PNP0200",  0},        /* AT DMA Controller */
> -       {"ACPI0009", 0},        /* IOxAPIC */
> -       {"ACPI000A", 0},        /* IOAPIC */
>         {"SMB0001",  0},        /* ACPI SMBUS virtual device */
> -       {"", 0},
> +       { }
>  };
>
>  static struct platform_device *acpi_platform_device_find_by_companion(struct acpi_device *adev)
> --

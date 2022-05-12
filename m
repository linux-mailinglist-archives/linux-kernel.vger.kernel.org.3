Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914815250C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355669AbiELO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbiELO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:59:47 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6495DD1A;
        Thu, 12 May 2022 07:59:46 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id r11so10256083ybg.6;
        Thu, 12 May 2022 07:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjYn5CDwHEMqMskpcbiPZayzeTiT7uRz4ad7VPAKrRw=;
        b=7j2R32O3Dwq/dWERL615t6d09AukLIrkrdhJt+P3Z3sJT736FMZW6HsVqzIjNzWOAH
         FsZ0SjDS+ETvS0ET06Uk8bpDWh0CjHzzLq/fMGVVoEgIgtHFXvA1bv3J91T4OPJtEYek
         PcEnU5F34egDtiYW5k6poaXjEg0r7jKSBcLrj5f84wvudRTlz7TTJh6ttKb6VMIlWZDI
         gDsfqg+kSf6EfCl1fvPs0qY8VOCSWIsapjdQ4y0f37JMyKmG78olWP+pGvAMDyzsFRRs
         fXp7CXLO0QIoUYkWSgZI5SsTWYCZhdcww7byG49Cz0TZMy9JLUfpKUceh+LvzzCZoSjt
         QcrA==
X-Gm-Message-State: AOAM531G6O5POnXPhDgf8Nw0fEIDm5lS2tZwnLt7rGaO24dlqzvqdkH6
        g9CTUtiQY7UMYIPFK4l9e99I0urNCT5tyNIWikI=
X-Google-Smtp-Source: ABdhPJxLwnU63w6zP3WMO3aOxg4t3ua4oFQ4Kt1pfaTnUynnFHIXlWHPpXsuUZNrYLHVMK32NvXshFVQYG6Uzb/vnI0=
X-Received: by 2002:a25:c0d5:0:b0:64a:c6dd:1a00 with SMTP id
 c204-20020a25c0d5000000b0064ac6dd1a00mr166815ybf.365.1652367585477; Thu, 12
 May 2022 07:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220506204731.330378-1-ian@linux.cowan.aero>
In-Reply-To: <20220506204731.330378-1-ian@linux.cowan.aero>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 16:59:34 +0200
Message-ID: <CAJZ5v0jStNBSPJoRPdY4NggwO5qr7oh1Wg2hauz084H_kyXQnw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: acpi: clean up spaces to be consistent
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Fri, May 6, 2022 at 10:54 PM Ian Cowan <ian@linux.cowan.aero> wrote:
>
> This cleans up a few line spaces so that it is consistent with the rest
> of the file. There are a few places where a space was added before a
> return and two spots where a double line space was made into one line
> space.
>
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>  drivers/acpi/ac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index db487ff9dd1b..f8ec48cd7659 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -32,7 +32,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI AC Adapter Driver");
>  MODULE_LICENSE("GPL");
>
> -
>  static int acpi_ac_add(struct acpi_device *device);
>  static int acpi_ac_remove(struct acpi_device *device);
>  static void acpi_ac_notify(struct acpi_device *device, u32 event);
> @@ -125,6 +124,7 @@ static int get_ac_property(struct power_supply *psy,
>         default:
>                 return -EINVAL;
>         }
> +
>         return 0;
>  }
>
> @@ -286,6 +288,7 @@ static int acpi_ac_resume(struct device *dev)
>                 return 0;
>         if (old_state != ac->state)
>                 kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
> +
>         return 0;
>  }
>  #else
> @@ -296,7 +299,6 @@ static int acpi_ac_remove(struct acpi_device *device)
>  {
>         struct acpi_ac *ac = NULL;
>
> -
>         if (!device || !acpi_driver_data(device))
>                 return -EINVAL;
>
> --

Applied with adjusted subject as 5.19 material, thanks!

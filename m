Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115714C9487
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiCATlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiCATlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:41:19 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A765494;
        Tue,  1 Mar 2022 11:40:38 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2d07c4a0d06so156071267b3.13;
        Tue, 01 Mar 2022 11:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC4BvLXBCXqc68pcQ7m+8z/EJtaEH/MsSh5u4qPMaYc=;
        b=8EHGEbua/oGeSyQUtI/MrV2CcYEyH/d49+zMmDMvo8umN+6wx3t5kciPpKlA6rS225
         G3jIUyIJNnFeaLorxKJaJQSRR8mDXcDNnxcLcKeB9dOGzexMychR3xow0PoTzl+oDIdf
         YMNK7OeP3C5qC0sboLEk+LV1hQ0JeQz8+WjtC9jywXhRl/7U5SKKhkEu+guB6DOaZE+t
         IbvgNvDSzhZzS4YsUkrezFfAQFlxTIGHacdc4pd/OLOonFjW6cKGMaA3euswl10djTxn
         mU0Fi3TWf+wyhAzdqThTrcSzSwieOukwUERwQqwWYWLmloxMACCnYpYOVWosU0bsq29z
         Jo1Q==
X-Gm-Message-State: AOAM531ztxFb6jy4TYyI6dkfum8eUPuWyQaUPmoJaHt0FK0QCCvOgJLL
        kDahWjtc/3K7QhTWe8wjW5sDUqtrKm6bVhmwxwM=
X-Google-Smtp-Source: ABdhPJzqz8NvN2OYlSJ4r049oH9twxzobfp3rZ5a9AqKOhlvAWL0GuQURf4suVyw4zXef72pObOLA5ljD92LHelrPUU=
X-Received: by 2002:a81:1611:0:b0:2d6:3290:9bd3 with SMTP id
 17-20020a811611000000b002d632909bd3mr26858713yww.19.1646163637141; Tue, 01
 Mar 2022 11:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:40:26 +0100
Message-ID: <CAJZ5v0iCwJ10gM0+LsOMU9X3X4ToN_OHBW=9vVsfEP3+cRpudQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] acpi: exsystem: Add units to time variable names
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Thu, Feb 24, 2022 at 12:38 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> `how_long` uses different units in both functions, so make it more
> clear, what unit they expect.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/acpi/acpica/exsystem.c | 20 ++++++++++----------

As ACPICA material, this should be submitted to the upstream project
via https://github.com/acpica/acpica/.

This applies to the other patches in the series too.

>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
> index 1281c07112de..6bc5b46e6927 100644
> --- a/drivers/acpi/acpica/exsystem.c
> +++ b/drivers/acpi/acpica/exsystem.c
> @@ -107,7 +107,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
>   *
>   * FUNCTION:    acpi_ex_system_do_stall
>   *
> - * PARAMETERS:  how_long        - The amount of time to stall,
> + * PARAMETERS:  how_long_us     - The amount of time to stall,
>   *                                in microseconds
>   *
>   * RETURN:      Status
> @@ -120,13 +120,13 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
>   *
>   ******************************************************************************/
>
> -acpi_status acpi_ex_system_do_stall(u32 how_long)
> +acpi_status acpi_ex_system_do_stall(u32 how_long_us)
>  {
>         acpi_status status = AE_OK;
>
>         ACPI_FUNCTION_ENTRY();
>
> -       if (how_long > 255) {   /* 255 microseconds */
> +       if (how_long_us > 255) {        /* 255 microseconds */
>                 /*
>                  * Longer than 255 usec, this is an error
>                  *
> @@ -134,10 +134,10 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
>                  * order to support existing BIOSs)
>                  */
>                 ACPI_ERROR((AE_INFO,
> -                           "Time parameter is too large (%u)", how_long));
> +                           "Time parameter is too large (%u)", how_long_us));
>                 status = AE_AML_OPERAND_VALUE;
>         } else {
> -               acpi_os_stall(how_long);
> +               acpi_os_stall(how_long_us);
>         }
>
>         return (status);
> @@ -147,7 +147,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
>   *
>   * FUNCTION:    acpi_ex_system_do_sleep
>   *
> - * PARAMETERS:  how_long        - The amount of time to sleep,
> + * PARAMETERS:  how_long_ms     - The amount of time to sleep,
>   *                                in milliseconds
>   *
>   * RETURN:      None
> @@ -156,7 +156,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
>   *
>   ******************************************************************************/
>
> -acpi_status acpi_ex_system_do_sleep(u64 how_long)
> +acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
>  {
>         ACPI_FUNCTION_ENTRY();
>
> @@ -168,11 +168,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
>          * For compatibility with other ACPI implementations and to prevent
>          * accidental deep sleeps, limit the sleep time to something reasonable.
>          */
> -       if (how_long > ACPI_MAX_SLEEP) {
> -               how_long = ACPI_MAX_SLEEP;
> +       if (how_long_ms > ACPI_MAX_SLEEP) {
> +               how_long_ms = ACPI_MAX_SLEEP;
>         }
>
> -       acpi_os_sleep(how_long);
> +       acpi_os_sleep(how_long_ms);
>
>         /* And now we must get the interpreter again */
>
> --
> 2.35.1
>

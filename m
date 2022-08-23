Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495AE59EB64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiHWSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiHWStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:49:39 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D01EEE9;
        Tue, 23 Aug 2022 10:13:13 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-335624d1e26so397289407b3.4;
        Tue, 23 Aug 2022 10:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xjbcbO8Zt7nAdCqR/OOnim/u0BKXicwexFKdBPWF5UA=;
        b=K3WqMYvzn1TgadkS8a65O4uKsU2lxS8SuFBx1/uKMIc8Hjhhx+CRE0XSdHZftZuL3C
         G9KBEl3Uic3YqgGVN5Yr/H+hlUjC1S3w0rHjWSamVnaaK92RoI/UuJxgRfDLbnanFYJ9
         lx8K3gdbpj9ylPDp8ksMjCilu5ZvqWRAfhMW1vLWx4RPFdhcXCjqRFMceiaSQ9odHNIu
         BOvcXju69WY00uFHAvdJQFy/3x5wbxRZwnR91avjygtxquk1Fru+HnZSau59Y63E5bFv
         aHeiWipX8ErnSVUkqoWkdTrbMMSqcwCO4D5mKoB7tLsB6QqzPJ/RKnjgidcRsyJJPKWD
         +Whg==
X-Gm-Message-State: ACgBeo32GJTAvGrlsQ/ReLKM6Fqw3CgsJlK3tCudhMkeIddPg0QrAtmc
        9nd39b49i2flBl8g+NCYHZMycpe+EWsFleWDB0A=
X-Google-Smtp-Source: AA6agR5RwwEAYHTEyDT9M8GfloXYOsPsrh7q7Mo2LXQKsUHGZLrxmsJXZfYn8sTtMQ3Ac2o8Z2P/Avkd9oxF2VclUyw=
X-Received: by 2002:a81:104e:0:b0:336:37f1:9686 with SMTP id
 75-20020a81104e000000b0033637f19686mr27748007ywq.149.1661274782976; Tue, 23
 Aug 2022 10:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220822062420.4815-1-chuanjian@nfschina.com>
In-Reply-To: <20220822062420.4815-1-chuanjian@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:12:52 +0200
Message-ID: <CAJZ5v0iQsmPS2F-hTKhhHho2+=UgAfag6jNs=m-WQY0CL6t=Lw@mail.gmail.com>
Subject: Re: [PATCH] tools/power/acpi/os_specific/service_layers/osunixxf.c:remove
 unnecessary (void*) conversions
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 8:24 AM Dong Chuanjian <chuanjian@nfschina.com> wrote:
>
> remove unnecessary void* type casting
>
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

This is ACPICA code, so please submit changes against it to the
upstream ACPICA project on GitHub.  Thanks!

> diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
> index b3651a04d68c..a7e65fb95caf 100644
> --- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
> +++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
> @@ -679,7 +679,7 @@ acpi_os_create_semaphore(u32 max_units,
>
>  acpi_status acpi_os_delete_semaphore(acpi_handle handle)
>  {
> -       sem_t *sem = (sem_t *) handle;
> +       sem_t *sem = handle;
>
>         if (!sem) {
>                 return (AE_BAD_PARAMETER);
> @@ -715,7 +715,7 @@ acpi_status
>  acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
>  {
>         acpi_status status = AE_OK;
> -       sem_t *sem = (sem_t *) handle;
> +       sem_t *sem = handle;
>         int ret_val;
>  #ifndef ACPI_USE_ALTERNATE_TIMEOUT
>         struct timespec time;
> @@ -832,7 +832,7 @@ acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
>
>  acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
>  {
> -       sem_t *sem = (sem_t *) handle;
> +       sem_t *sem = handle;
>
>         if (!sem) {
>                 return (AE_BAD_PARAMETER);
> --
> 2.18.2
>

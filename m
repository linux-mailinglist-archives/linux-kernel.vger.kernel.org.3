Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E55685A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiGFKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiGFKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:32:08 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B8627170;
        Wed,  6 Jul 2022 03:32:06 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31c9b70c382so72848487b3.6;
        Wed, 06 Jul 2022 03:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m+ZKiB2sb7HrzVoAUSPctumZcgZ3EP8gbbHyC8OoYA=;
        b=HKsw0LL9leRQTSNa1JCFWFHWXUK04tIDKw2ZZgPLwk3IOW0/af347bXtX7ZGSh7CCj
         TgwCP2VFQjUpqb7+ysSweTHPugsJkB11SVd8Z/c+RgkXhNrpLfvB8cdsnGnM3tyBwwJ/
         RmFDcOZcWxBFtysERqPnrO5lcnm09qByhmTNgP8yWTaiUjcM5pC2KWkvdM+r9vbOp5W/
         R53JwsIIPK6S3FSw03yaeHwWjTqdbzbxCKQ+H5NbZy04oNhpKyskfogAb3icQc3gmUJM
         M/F8sOhzXHEViPb3jdcjBs4vHR2kAXpVRsNwzCt7wMRzhWXn65UjbVmDm9HASyZ7KAGS
         eU+w==
X-Gm-Message-State: AJIora+vbYwFl4ynWyA42Hwd3NBGzZpKLQQ8CrZFazEhBBVtZCR1VDox
        X8hWub42SspwswU31JWeP+LcAdsTNtFQi3GbM8cnVnRMKvY=
X-Google-Smtp-Source: AGRyM1s6pLDVipu6C8/ARY5l4EQq27mpST555pN9zVhce+RtJsOYmX0/F6b+WUQU89mH/rdpTj+1954PG41P0rgiuWI=
X-Received: by 2002:a0d:c486:0:b0:31c:3b63:91fe with SMTP id
 g128-20020a0dc486000000b0031c3b6391femr39955412ywd.7.1657103526222; Wed, 06
 Jul 2022 03:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220706014404.3191-1-zeming@nfschina.com>
In-Reply-To: <20220706014404.3191-1-zeming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 12:31:54 +0200
Message-ID: <CAJZ5v0jtB6KxzQLv7AC6fzAKFj6oRfkEBS3Nbi-g0RsK4VSwyw@mail.gmail.com>
Subject: Re: [PATCH] acpi/sleep: Add header file macro definition
To:     Li zeming <zeming@nfschina.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@nfschina.com
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

On Wed, Jul 6, 2022 at 3:44 AM Li zeming <zeming@nfschina.com> wrote:
>
> Add header file macro definition.

Please explain why you want to make this change.

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  drivers/acpi/sleep.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> index 7fe41ee489d6..adb3b5c13f90 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -1,4 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SLEEP_H
> +#define _SLEEP_H
>
>  extern void acpi_enable_wakeup_devices(u8 sleep_state);
>  extern void acpi_disable_wakeup_devices(u8 sleep_state);
> @@ -30,3 +32,5 @@ extern bool acpi_sleep_default_s3;
>  #else
>  #define acpi_sleep_default_s3  (1)
>  #endif
> +
> +#endif
> --
> 2.18.2
>

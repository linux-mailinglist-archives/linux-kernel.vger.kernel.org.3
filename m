Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D15606A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiF2QsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiF2Qrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:47:39 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D7C403CD;
        Wed, 29 Jun 2022 09:46:31 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3176b6ed923so153640057b3.11;
        Wed, 29 Jun 2022 09:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLmQ2/PpMURJRvT1ORVunkJnyaJ/GzRD3j6L0P/2GnY=;
        b=3lkqcb6lghMUlsGlQnWsiv26aaFwqtSYyW2q8vkFp70P4p3IFnHV76eZ8dkS5IyaKX
         5EWI5jkHnKGBad2JO3MPULGWjB9D0PkWofchMNZB1bKOUXSiMs1pogrl/t12IdbdWpCT
         Om2ATCtIHLID/K6Ju4AQpN4elHhJiV0dCTbSuGa25wlJR+XIYGW8u8vFzRAJ3ABiSEaY
         a+UuMxhjYPHFS1c8xq5LR0tgEOHznLGmV34aGBl/tgx9bWQxgZ8DKPrRg5xzN/qG8S6T
         mK1ecvu8TMKiSAawHU8wtwmN9jLRyiQMv9EMDsnoVDyB7Xd5wmJcyhFB+/FEKIb7E0zd
         uSBA==
X-Gm-Message-State: AJIora8ZZO2A7N0e8Rr8Nt/jU1ZXtDaazomtBbT/2XUoLlJPcv0WiI2+
        lvr76fZzCrq8KfXl0MK6kkOBwE3EtUU5lt31E0/LPSaA
X-Google-Smtp-Source: AGRyM1seQ7wW9lsNtM8Ksd1jOhz/rzH/yLDZVybzo/TA+W9KNKBKo04hfXn0LC3tv1juOctP1/C8oW2TBgnygHKe8pg=
X-Received: by 2002:a0d:d086:0:b0:31b:d0b2:e11f with SMTP id
 s128-20020a0dd086000000b0031bd0b2e11fmr4744401ywd.515.1656521186449; Wed, 29
 Jun 2022 09:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <TYWP286MB2601F3FF324862A2E81FA70CB1AB9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYWP286MB2601F3FF324862A2E81FA70CB1AB9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 18:46:15 +0200
Message-ID: <CAJZ5v0iYWQteOOi+Q2Z=vDyKMk3Rm27f+ufkT2FRrmS-o==PEg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Make acpi video driver available on !X86
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Riwen Lu <luriwen@kylinos.cn>
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

On Mon, Jun 13, 2022 at 11:34 AM Riwen Lu <luriwen@hotmail.com> wrote:
>
> From: Riwen Lu <luriwen@kylinos.cn>
>
> ACPI video device can also be found in arm64 laptops, so drop the
> Kconfig dependency on X86 for ACPI_VIDEO.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1e34f846508f..a25c36e0c863 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -210,7 +210,7 @@ config ACPI_TINY_POWER_BUTTON_SIGNAL
>
>  config ACPI_VIDEO
>         tristate "Video"
> -       depends on X86 && BACKLIGHT_CLASS_DEVICE
> +       depends on BACKLIGHT_CLASS_DEVICE
>         depends on INPUT
>         select THERMAL
>         help
> --

Applied as 5.20 material, thanks!

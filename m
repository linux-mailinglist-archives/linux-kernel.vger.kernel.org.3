Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F815754E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbiGNSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiGNSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:25:01 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F502F67F;
        Thu, 14 Jul 2022 11:25:00 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id l11so4593395ybu.13;
        Thu, 14 Jul 2022 11:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgpUMNKvx4KSxdOjg/H5oB64G7sRuqVxnCSFFK5S8sA=;
        b=FtVPv8yamS2M8R2Hd6fnpgy0UPOuVXIDaKzDwferjiysPyuEBRC6YruB09RseFLlX3
         Ji5id92KFuNglPre0JK+KUn8+LUNT03Koy7kSxeffMBSYCR9ToL5+HPiZ7V0QolPwEWB
         LOxkDi3h2OE1lIpmMVoBJVzDEfewB8R4YLUQQNUW1JL1xs3lt7F2grqIqwxn1RvQ+EJv
         oREmTnhTOxycPmG9zUN00rmbcBujH63KScnmzqSO8+mPF7JRs4smDF5O78CxfuiXLh8g
         Ukzynq8Xm6Ca/vf5h67XuzNIJcPcSP77qcBRWmxhTCErAczyDT6IYB4NLX/FL9VITHhF
         oujQ==
X-Gm-Message-State: AJIora/2Ee7JOMEdcJ9GvuHjzheDvC/LU6NU6B7DT/dxg8KsPe9l3IWp
        9+x2xqj+GxHzQV4duJ0Du68FBFSCE4eS8x0zfUc=
X-Google-Smtp-Source: AGRyM1sKF8hIlILzeJt9pj1sahLhPItLqLYJjCcPGgCAkSjpiF/Bs5Sy+YH0mASza7jY0e7LismkGuftew052O7DREk=
X-Received: by 2002:a5b:202:0:b0:66f:aab4:9c95 with SMTP id
 z2-20020a5b0202000000b0066faab49c95mr8918464ybl.81.1657823100117; Thu, 14 Jul
 2022 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220707151037.3901050-1-sbinding@opensource.cirrus.com> <20220707151037.3901050-2-sbinding@opensource.cirrus.com>
In-Reply-To: <20220707151037.3901050-2-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 20:24:49 +0200
Message-ID: <CAJZ5v0gNwsddY1Ecasxhc_9hze5b77KdyUcQbbieHd3orGUGJQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: utils: Add api to read _SUB from ACPI
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
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

On Thu, Jul 7, 2022 at 5:11 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Add a wrapper function to read the _SUB string from ACPI.
>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

In case you want to push this through ASoC

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Otherwise, I need a maintainer's ACK to apply the second patch.

> ---
>  drivers/acpi/utils.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  6 ++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 3a9773a09e19..5a7b8065e77f 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -291,6 +291,44 @@ int acpi_get_local_address(acpi_handle handle, u32 *addr)
>  }
>  EXPORT_SYMBOL(acpi_get_local_address);
>
> +#define ACPI_MAX_SUB_BUF_SIZE  9
> +
> +const char *acpi_get_subsystem_id(acpi_handle handle)
> +{
> +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;
> +       const char *sub;
> +       size_t len;
> +
> +       status = acpi_evaluate_object(handle, METHOD_NAME__SUB, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_handle_debug(handle, "Reading ACPI _SUB failed: %#x\n", status);
> +               return ERR_PTR(-ENODATA);
> +       }
> +
> +       obj = buffer.pointer;
> +       if (obj->type == ACPI_TYPE_STRING) {
> +               len = strlen(obj->string.pointer);
> +               if (len < ACPI_MAX_SUB_BUF_SIZE && len > 0) {
> +                       sub = kstrdup(obj->string.pointer, GFP_KERNEL);
> +                       if (!sub)
> +                               sub = ERR_PTR(-ENOMEM);
> +               } else {
> +                       acpi_handle_err(handle, "ACPI _SUB Length %zu is Invalid\n", len);
> +                       sub = ERR_PTR(-ENODATA);
> +               }
> +       } else {
> +               acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
> +               sub = ERR_PTR(-ENODATA);
> +       }
> +
> +       acpi_os_free(buffer.pointer);
> +
> +       return sub;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_subsystem_id);
> +
>  acpi_status
>  acpi_evaluate_reference(acpi_handle handle,
>                         acpi_string pathname,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2a0e95336094..447898685e09 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -762,6 +762,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
>  #endif
>
>  int acpi_get_local_address(acpi_handle handle, u32 *addr);
> +const char *acpi_get_subsystem_id(acpi_handle handle);
>
>  #else  /* !CONFIG_ACPI */
>
> @@ -1023,6 +1024,11 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
>         return -ENODEV;
>  }
>
> +static inline const char *acpi_get_subsystem_id(acpi_handle handle)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline int acpi_register_wakeup_handler(int wake_irq,
>         bool (*wakeup)(void *context), void *context)
>  {
> --
> 2.25.1
>

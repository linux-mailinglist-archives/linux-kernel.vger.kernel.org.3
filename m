Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964094A4EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358161AbiAaSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:51:14 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:34641 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiAaSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:51:13 -0500
Received: by mail-yb1-f178.google.com with SMTP id v186so43553909ybg.1;
        Mon, 31 Jan 2022 10:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9elPeCurEKfBJHZDKjGhZVFvClsJXI5gGke2sVJMJc=;
        b=uxNs+NZyl3Xf268BX4cn2LvezomWAVlBWSrrlHOxs+cSZ9wxZEj7VjASBItnknAhGA
         TXXsGjTUra+qVJhSkYgYgCHxpUWVa672KGGTfMLgKuRPlIsWzcMJZH0k5y410P1KyTSr
         0+K30Jt6zHOwsrsubvq0YMKW2xKl40Wg+4rJ3/pUL5ODjd6R75YB4z5n+jybPC9ieMMz
         I7Sa+4dso7yofQgVZZ6gGMwk3P4hMv1MdvOkxWZyT/3nwgHCaxZEOrXfvW6kySnEnFc3
         T9UmS9cNHvMtVBUjzZdJC6ObujfEKthvZYY3m4mxhrKRmLnytHxCkMll0MtfeRT8j+uY
         8teg==
X-Gm-Message-State: AOAM532MYDx3J7lyyITLttJ1FIZRBXbj67yTAXkzQiJnZWhYJHRtzX9U
        18b8oCWW4a9ntizLSAl+9NkGzP1qWrZs0ssfRowS5G6E/wI=
X-Google-Smtp-Source: ABdhPJxJ8wSGW1W6Abc0F3zUPNSQyR+J6M9pEZwLaKO0V7/UUGGjFWaidDtzjEOhSnmVTS0yKoO/9pPaZBkCFTVbIsM=
X-Received: by 2002:a25:c102:: with SMTP id r2mr34056787ybf.330.1643655072465;
 Mon, 31 Jan 2022 10:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20220131133337.1556355-1-trix@redhat.com>
In-Reply-To: <20220131133337.1556355-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jan 2022 19:51:00 +0100
Message-ID: <CAJZ5v0g5Xxd9kBPUdsC6D4fVHfZafKiGgkTONo2mpqvfgoFDgw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: cleanup double word in comment
To:     Tom Rix <trix@redhat.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 2:33 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Remove the second 'know'.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

This is ACPICA material, so it needs to be submitted to the upstream
project via https://github.com/acpica/acpica/

Also, it would be good to combine all of the analogous changes in one patch.

> ---
>  drivers/acpi/acpica/exfldio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
> index bdc7a30d1217c..b92605df3872c 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
>  #ifdef ACPI_UNDER_DEVELOPMENT
>         /*
>          * If the Field access is any_acc, we can now compute the optimal
> -        * access (because we know know the length of the parent region)
> +        * access (because we know the length of the parent region)
>          */
>         if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
>                 if (ACPI_FAILURE(status)) {
> --
> 2.26.3
>

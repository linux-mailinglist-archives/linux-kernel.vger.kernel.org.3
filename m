Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E95481E18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhL3QbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:31:01 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:38712 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhL3QbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:31:00 -0500
Received: by mail-qk1-f174.google.com with SMTP id i187so20969837qkf.5;
        Thu, 30 Dec 2021 08:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LlQF8MrlSTCG8lhWUSBO1XvMJHfGDeoUE+4aAQrtQA=;
        b=rORK2AxMzpp5Nd9QuFl/7myTTA2GzMl9XiKq6DB7DlBLRE5mSGJH3aassDl5YHKp57
         98Wwtl5sFm/+JSGJXjQp+EC7Y/yN0D+AE4vAGrPHIpmH/gQ16JyKwgs2Vb8itwSuxtZB
         WcECdi+hQwVOR97znMpzA2fO7uDyF0e1HHZlDBqxscaAHVyo75S/YVrsjtJVuZMojBtb
         0TtpxmEV+qHgA1oL/smaX7uPsQXi1aVh96BcNhxLZ6Ud8wzhYSumKWik0JOsNdGQnosB
         Q1H9bLRkyxcZqCIyi4dI+qyT5JWv0cY8ftADBUQ0H/57YJputv5Y2LQeKMlTJ+hhJ8qB
         FG9w==
X-Gm-Message-State: AOAM530bb1MM/uMl9xI4fF7vrwgUxf6wprgSBA101XGVJfy6mL6w1DYD
        o7TTs7j5WSm8plt3yEE3u7AYeoRW18aHVN6NoCAe5SKZPrc=
X-Google-Smtp-Source: ABdhPJwZPzCkL7MZH2MxAuFHP7hcaxGDZlNeR97Vr+vof5HsOVtkbRnoKbJ+gekALjs8/TanT8I5JJOjGq25l1T2mrs=
X-Received: by 2002:a05:620a:2001:: with SMTP id c1mr21983180qka.374.1640881859812;
 Thu, 30 Dec 2021 08:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20211224091458.693093-1-yinxiujiang@kylinos.cn>
In-Reply-To: <20211224091458.693093-1-yinxiujiang@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:30:48 +0100
Message-ID: <CAJZ5v0j1+p8E+BF_Ekmenpp+9WG7b3k5Y7YjyJzi7e+K1Nv2NQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Remove initialization of static variables to 0
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 10:15 AM Yin Xiujiang <yinxiujiang@kylinos.cn> wrote:
>
> Remove the initialization of three static variables to 0 which is
> pointless
>
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>  drivers/acpi/acpica/dbhistry.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
> index fd813c5d3952..60b77b11c0f2 100644
> --- a/drivers/acpi/acpica/dbhistry.c
> +++ b/drivers/acpi/acpica/dbhistry.c
> @@ -24,9 +24,9 @@ typedef struct history_info {
>  } HISTORY_INFO;
>
>  static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
> -static u16 acpi_gbl_lo_history = 0;
> -static u16 acpi_gbl_num_history = 0;
> -static u16 acpi_gbl_next_history_index = 0;
> +static u16 acpi_gbl_lo_history;
> +static u16 acpi_gbl_num_history;
> +static u16 acpi_gbl_next_history_index;
>
>  /*******************************************************************************
>   *
> --

This is ACPICA material, so please submit it to the upstream ACPICA
project via https://github.com/acpica/acpica/

Thanks!

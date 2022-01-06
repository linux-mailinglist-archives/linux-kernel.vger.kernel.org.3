Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96B1486619
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiAFOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiAFOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:33:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8CC061245;
        Thu,  6 Jan 2022 06:33:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a18so9119261edj.7;
        Thu, 06 Jan 2022 06:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ruhziq+qRDvSRRZ0MBr82/To9EUdVddAORFjQwBCBDQ=;
        b=fQpdVPhPVTB982Mze7Ottx1meO/gTc0SwSgMHXl+l/F4s/KGXtKmxnCXmzwCg6OI2s
         iqcyAScGrESMADf8XUCN0yAEDmOmv5I3rqobIsrW114N2dd6vSj1odgdcgrWhxgGg5ve
         Q2b086YO7IRV+kQ7YuiW6vw4dAyxTjyC67V3xogWyNGWqSWyyDyjE30lv65vnkjIwK0N
         aDOCHZWdw+aSwDcVKfTrC6XqC334TS2a0LX4U6WZdqgK+0fHJ6AYIfNeM6RiLgzWc9iz
         PHODMDo3ezg1QyMw314y01prjdFvPzArhhghaPGiHNj0cVxbBYnlkZycqyWNMpqV8i3i
         5B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ruhziq+qRDvSRRZ0MBr82/To9EUdVddAORFjQwBCBDQ=;
        b=tng6h/ykChs+2Z3fdSqDk5cKvs6X4nJ1PArcZTIsmUSvA08Zx6rx10UNLfdp3IYy7t
         nZ/mjD8PxX02++becdWDlXCT451tpO81pUW0Bxxd2CMm6YwXUjlsiI2brTVwMgkgGw5x
         bIaYg2eP16LZaDqPXGn6CtBo/yyWe5COQZ72u5AukmrBu50TYBy2wxRNdrvEfj7oAJY4
         c3os1bK44HMmu4zeNFeBBBTcqHieFPH1itiAARfjooZkAkXDGl+qQvEU18MTxYfyU+qR
         WckmFSHCPMooe1mOLDJE/c1Ur4VSR0cTshorE0f++a5/2hzdCHrKggBCkbY2SlkFLqOQ
         xSiw==
X-Gm-Message-State: AOAM533UxK6/MLT2TJT5LQ4BWem+xtGCZe+TRsrFcLNtFpXKsqmeCRbO
        3D/2EmZ5OprVwL9cR3bDs92+wIkxJ3tiWfhYZxc=
X-Google-Smtp-Source: ABdhPJzh5of1614ikI8nj+CxCWBLt9q8UCYRxINc5/5Zg+z10cTuhmAT3wiR+evrpRmjs3dV9qGGtxTR6LyThkdn/+c=
X-Received: by 2002:a17:906:c450:: with SMTP id ck16mr45187728ejb.579.1641479598906;
 Thu, 06 Jan 2022 06:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20220106041257.927664-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220106041257.927664-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:32:42 +0200
Message-ID: <CAHp75VdxV+4_yxJv1H1MZPpu02e2gHUkP55dduUqN7QJ2j6aGg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: humidity: hdc100x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 6:13 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "TXN1010" to for hdc100x device.

to for --> for the

> So add an ACPI match table for that accordingly.

...

>  - Change the ID to follow ACPI Spec

Is there any evidence Texas Instrument allocated this ID, or you just
created it yourself?
Please, add an excerpt from email from them to confirm this.

...

> +static const struct acpi_device_id __maybe_unused hdc100x_acpi_match[] = {
> +       { "TXN1010" },

> +       { },

No comma is needed.

> +};

> +

No blank line is needed.

> +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);

...

> +               .acpi_match_table = ACPI_PTR(hdc100x_acpi_match),

It's the wrong usage of ACPI_PTR().

>         },

All the comments are applicable to all your patches. Some of them I
already commented on and even kbuild bot has sent you a complaint.

-- 
With Best Regards,
Andy Shevchenko

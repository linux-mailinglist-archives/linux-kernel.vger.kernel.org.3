Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8749E771
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbiA0QZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbiA0QZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:25:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514AC061714;
        Thu, 27 Jan 2022 08:25:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id s13so7066582ejy.3;
        Thu, 27 Jan 2022 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsK26LwKVCtS4IHITRqNsNXPc6eDfVNCQyatciyTffY=;
        b=QYrB9a1UDkoczCvaHoE9khlMQRijF1g4e++GPYiAF1RJgwrYoHDnckl9udTDCMsZjP
         CSPl1MCQS/b+efmmQopo5VvXHKeF7Fk6kkkGUn4FCR4B4uJoWHpxay6C6fRnsyQNFBaJ
         eTX9nL3S2YNcG5Zev3GBCQi1GicwGdwyJ0bU+2wiaBh8UtyCTxuf72Lcma4V6DzhTgKu
         LpN3YGfKCYRa/6fc87o9gyWbRpZHymjJgNxRgiqIgsum7c1273fYj7+glXaIrJo3oen+
         9QSr++FkQ6CvRU+vqcXVBjOfqY+xTgCgJjwCvtjNZOap/3aRrPrUKsvWMGa0cLUVNzbk
         87lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsK26LwKVCtS4IHITRqNsNXPc6eDfVNCQyatciyTffY=;
        b=jyKd9+oVLOo3KFcoLmxsnJpP4hHMmOpQFuD2gWcXEfGLgd59SSiqJrHq7evGxWbI1Y
         ek3uY4qiOB6lgSiZlxR0VZe151UTLNzkfLAxFC7OlNJDAJ0bDcEQXVPDA6bIbWo1TMPV
         /oawLohyt0s1ENpFWBIR6SO50vNsmbc0EB19PfyiKbMEk1d5KR7zrvNYYn9OJsZDS7YY
         qUf4DpT3S0EHEnQaPJlfSIUPqThvLZZUGVr6JdWGznHdAOdMdnk+4m6BlRYhLNV5A95O
         FWVCRsdQP+a+igdvym6QKN2bl4RO1F4emFb+oE099GTdUA8sQnKDBZ0jR1R6pkkRZY9i
         tXbA==
X-Gm-Message-State: AOAM532go4QCnbivU8c8/M5KFX0lvkrS3657CPuaYUSXg309cbyLx4hq
        JhwyZbCTCJZu9PUoggQSLFQ0jioWMcKxnS53VAo=
X-Google-Smtp-Source: ABdhPJwpJTf+bvIuulAX+/Afv2dVUkiSl0zeLpHRq/pUsMA82rYvj0rJbgE3vqJHVJ5RU02z7iQdA2D/O7p+1kVpa7M=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr3693115ejc.132.1643300716068;
 Thu, 27 Jan 2022 08:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20220127143828.2033838-1-kai.heng.feng@canonical.com> <CAHp75Vetc62kz7VtEgWR2Jn_UsmYtzR1WM0n4pxycfKCN3h3+Q@mail.gmail.com>
In-Reply-To: <CAHp75Vetc62kz7VtEgWR2Jn_UsmYtzR1WM0n4pxycfKCN3h3+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Jan 2022 18:23:38 +0200
Message-ID: <CAHp75VdmxnsKX7Bc6e4NTdcVzO3CfJRRa_y3zB8KKqhBBq-5Eg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dps310: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jan 27, 2022 at 4:38 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:

...

> > +static const struct acpi_device_id dps310_acpi_match[] = {
> > +       { "IFX3100" },

> > +       { },

And no comma needed here.

> > +};
>
> > +
>
> This is redundant, I hope Jonathan may remove it when applying.
>
> > +MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);

-- 
With Best Regards,
Andy Shevchenko

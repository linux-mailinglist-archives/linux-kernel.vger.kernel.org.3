Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6447F05F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353296AbhLXRZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLXRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:25:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD0C061401;
        Fri, 24 Dec 2021 09:25:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o20so35465775eds.10;
        Fri, 24 Dec 2021 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuTjgwH+FkGjo+0kMKflsFHxsvKi/rJpxLiasu7mx6s=;
        b=XgjIkn8UkAuY6SKls/ZiprFT8L25uAkSS2Fl7njQ6bhReHWtRg4YJlbrGqtFzC6I1b
         7HBzqm+ebPYhziN0O4UCyMK7fTEN8OKXl2H3Y1HLHVGj1DJel9qEcOrC5JH65te1FAnh
         +jW1lzQAo8a4tf/VKygxgy2v4buur1E5bOj/YQ0NuXjw/IWE8kgLcvsF2U6X2h2tzSO8
         p5iGKS5PXHxk10WO0YERCXSowiFDL0d1aZVhlSNIJY9FnYQVb8vwjfLv6WFMEFCBzCm6
         m41+kRehH9mV3DtnfTYhD2EjnyVoJIrOyUqyHC0bB+yueY2Wytq1wY+8Rw9dg2VTKVHk
         YpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuTjgwH+FkGjo+0kMKflsFHxsvKi/rJpxLiasu7mx6s=;
        b=lCLKM5Ou+FSNBK79oV1iiNWuKaY9AbDvu05JtDtwygZxYBSu2arpIxisl7UbZtyDT2
         MYkvYQZs2aQGRTcDPMl+OKd+4quUql8nYzQEB/u3g/ODk5ltv0nLQ1m9f4qpYoPPP1Zl
         rR4QwLUI1RZUPciU0CzxOAYDg7KcoQc5Uq7WVZND8clV78YQfeSdlIeZIUMs7qBpvH/I
         N+UtJFlzgYYPhGM/pYzxpiM2IrMHLegNR9NfJdR8ouo0OZ7rvdjLVfNLOUaT7HaH5xXJ
         fhX/L8TeKpNyQ6XnZcqC3fRkPAEf9U3k5JALuQ2Jhesgz3x5NihOP27uV3nnOZn8Ff6R
         cXaA==
X-Gm-Message-State: AOAM533R/hO5ofBInUVwc1/FW60XwODE9blrA122PoBB9EJZhobicQ0W
        EXwQyo8e8WK0wXZFnlR6L2KhcWq2o6D6tZ5uac4=
X-Google-Smtp-Source: ABdhPJyc11+JkPEMQT+pTLoJD1KWuqfTAVmfOBMYnWwmWHpeCkyvXdY+D4MjyEu7TuPIWvnKfD9bf7bg0cpi1GLK8GI=
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr5924684ejc.147.1640366729650;
 Fri, 24 Dec 2021 09:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20211221071634.25980-1-yu.tu@amlogic.com> <20211221071634.25980-4-yu.tu@amlogic.com>
In-Reply-To: <20211221071634.25980-4-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 Dec 2021 18:25:18 +0100
Message-ID: <CAFBinCB9Fre9Lea2CAm_8o8g1e3o8oX4ZONbN_bhykNXoFHDdQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tty: serial: meson: add UART driver compatible with
 S4 SoC on-chip
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 21, 2021 at 8:17 AM Yu Tu <yu.tu@amlogic.com> wrote:
>
> The S4 SoC on-chip UART uses a 12M clock as the clock source for
> calculating the baud rate of the UART. But previously, chips used 24M or
> other clock sources. So add this change. The specific clock source is
> determined by chip design.
Does the new S4 SoC use an external 12MHz XTAL or does it use a 24MHz XTAL?
If there's still a 24MHz XTAL then I think this description is not
correct - at least based on how I understand the UART controller.

SoCs up to GXL and GXM had an internal divide-by-3 (clock divider) in
the UART controller IP and an external 24MHz XTAL.
This was not configurable, so the clock for all baud-rates had to be
derived from an 8MHz (24MHz divided by 3) clock.

With the A311D (G12B, which is still using an external 24MHz XTAL) SoC
the UART controller gained two new bits - with configurable dividers -
according to the public datasheets:
UART_EE_A_REG5[26]:
- 0x0: divide the input clock by 3 (meaning: this internally works
with an 8MHz clock)
- 0x1: use the input clock directly without further division (meaning:
this internally work with an 24MHz clock)
UART_EE_A_REG5[27]:
- 0x0: use the clock as configured in UART_EE_A_REG5[26]
- 0x1: divide the input clock by 2 (meaning: this internally works
with an 12MHz clock)

While writing this email I did some investigation and found that
UART_EE_A_REG5[26] is used in the vendor kernel even for GXL and GXM
SoCs.
So this probably has been introduced with the GXL generation (and thus
is missing on GXBB and earlier SoCs).
Also UART_EE_A_REG5[27] seems to have been introduced with the G12A
generation of SoCs (not surprising since G12A and G12B peripherals are
very similar).

Does the UART controller not work with divide-by-3 (as we have it
today) or are these configurable dividers to reduce jitter?


Best regards,
Martin

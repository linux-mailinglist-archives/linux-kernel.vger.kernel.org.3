Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32B4730EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhLMPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhLMPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:52:40 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:52:40 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c3so19004805iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjOK7zG4lmsI/zp9Y5fQMp7GBNGBJj/NStUfv3M1YVc=;
        b=dwo2lL/xcAhMSZxaD4BKaEmuczKzyAZqbBJYR+yDjtagIiQtaf/vB7gm48RoLcI/rI
         VW1aBzFKjdGInllx2a4i4+Q40oYWfUOP+nlyVlKK0r+iGPJiWlNLyZ45eKchDZ9b2p1U
         QhpZq7jCAqDY/M6pXX7CuP/c1coiEAJx2yDnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjOK7zG4lmsI/zp9Y5fQMp7GBNGBJj/NStUfv3M1YVc=;
        b=vC7MajWlgZl9+aK2fgCAJrhbF8hVne7aOt08BGnb3aq+QLFutw7V23DbGwIt2hmIxu
         F0VKpAeixkpDfvgCeWqCu3FKNhK85MX2zEPowRoyXW0sNgI3QPCsIPVPMmG9WjaBFjQn
         owCsC0wbOv/EX0Sr2dkJMKCb3APlkM2L5CEWMfiPwCnyn5mBhq5IKlrlXzTSxWt02+FB
         +xFPERmEG09JLTrZUbrly8Y5+FOPs0eFfgP36d3qE0ZqvNJurcQAfNob0Vz4YYmVEmFD
         N/U42p2z5fA/JB1ZBjYTjpUr0AfVlEJBs71cAsyPoCEYMF6+G8D2az30Azjdm7zW14NI
         Jyrg==
X-Gm-Message-State: AOAM530/U/WmglLwpG8ijp5BEDTzy5EjgyPv3BArP1TpfWfvfeWdWNCf
        2r3sqmesckSV6qG5yccS1XbbmiVpAKjOFg==
X-Google-Smtp-Source: ABdhPJzldEoqXPsbDlb4KY32JNKCJa7pINtbNA8kxu6TWVKKcHYaTFAgbwg8Cavm6VRTlDXi5myH5Q==
X-Received: by 2002:a5e:cb0d:: with SMTP id p13mr32581199iom.71.1639410759616;
        Mon, 13 Dec 2021 07:52:39 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id m14sm7876140iov.14.2021.12.13.07.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:52:38 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id w1so15380120ilh.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:52:37 -0800 (PST)
X-Received: by 2002:a92:cdaa:: with SMTP id g10mr31230629ild.142.1639410757022;
 Mon, 13 Dec 2021 07:52:37 -0800 (PST)
MIME-Version: 1.0
References: <1638427092-9139-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1638427092-9139-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Dec 2021 07:52:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VB6hsEHEb8yZmB=xA__47p4vC6dBc528RV37dvAKTgOQ@mail.gmail.com>
Message-ID: <CAD=FV=VB6hsEHEb8yZmB=xA__47p4vC6dBc528RV37dvAKTgOQ@mail.gmail.com>
Subject: Re: [PATCH V2] mtd: spi-nor: winbond: Add support for winbond chip
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 1, 2021 at 10:38 PM Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Add support for winbond W25Q512NW-IM chip.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
> Changes since V1:
>         Added space before name of the flash part as suggested by Doug.

When someone comments on V1, it's nice to CC them on V2. ;-)

> ---
>  drivers/mtd/spi-nor/winbond.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 96573f6..44f19f2 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -100,6 +100,9 @@ static const struct flash_info winbond_parts[] = {
>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
>                             SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> +       { "w25q512nw", INFO(0xef8020, 0, 64 * 1024, 1024,
> +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },

I had a quick look. Though I'm no expert on this driver, I believe
that the name should be "w25q512nwm", not "w25q512nw" (you need an "m"
at the end). Evidence:

The Winbond doc [1] shows:

W25Q512NW-IM is 0xef8020
W25Q512NW-IQ/IN is 0xef6020

Comparing to a different datasheet [2], I see that:

W25Q256JW-IM is 0xef8019
W25Q256JW is 0xef6019

Since "W25Q256JW-IM" is in code as "w25q256jwm" it implies to me that
for the "-IM" suffix you just add a "m" to the end of the name.

[1] https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
[2] https://www.winbond.com/resource-files/W25Q256JW%20SPI%20RevJ%2003102021%20Plus.pdf

After changing the name, feel free to add my Reviewed-by (and please
CC me on v3).

-Doug

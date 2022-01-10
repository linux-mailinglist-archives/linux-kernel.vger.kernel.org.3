Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D43E489CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiAJP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:58:37 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:34594 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:58:36 -0500
Received: by mail-ua1-f42.google.com with SMTP id y4so24290577uad.1;
        Mon, 10 Jan 2022 07:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMgV+mDX/K3qcOomX1PVvdIm2AvlPzqwI7apstT0jDc=;
        b=7hhJ89Z2m7jVUem1mmSgv5OGbK1KIILTVdyJgkcfcotL4TAnpAX2elh+GqW6eN13om
         nTjHnxkHrN0dgEUmqaxy8gmblFIvSpneG3F10TBoJWOpkFEgTXO0ETARhdGQIfHdAJ5y
         JUatgCxD5i0N/IxPuIokYqdj+7twIE1fZ2wBNNhywgeSZxBBk7M7fbv+H3NdFvYQ0N4i
         llEN/5q+1g57UlBhD+gtj5ynzkLo2nSZ8kPAFbH/Xjg8lgoe3kZ5mGGZAGGD4eAqWRwk
         Nkefu0zYX4pckkfr34KHCjXduLxWf+DhlvEEWouM9HpalK8q2mhY+oFYkEQ9ibozFw8y
         yxfw==
X-Gm-Message-State: AOAM530Xj9DJm+sV9orDZqjyp4zPszNLMwkwqemguz+fVn2rmIoDJL5V
        u3oixoRtYQEGSZvS4+mxALACKEEIHpXclQ==
X-Google-Smtp-Source: ABdhPJyWN4B4eZMiBcSg1cwVCQ7atzYk2KSZ/RugCIOb2Ux3wrz3PnhJ0UE2mkY0V7s9svpKlYCO1w==
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr235721vsl.0.1641830315145;
        Mon, 10 Jan 2022 07:58:35 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id z8sm1399286vsi.15.2022.01.10.07.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:58:34 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id r15so24296627uao.3;
        Mon, 10 Jan 2022 07:58:34 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr182967vso.77.1641830314339;
 Mon, 10 Jan 2022 07:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20211226082530.2245198-1-nikita.yoush@cogentembedded.com> <20211226082530.2245198-2-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211226082530.2245198-2-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 16:58:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+Yb1As-2fjq+1eeUEiTo21OH+aUQwEcSCAEErDh2A7w@mail.gmail.com>
Message-ID: <CAMuHMdV+Yb1As-2fjq+1eeUEiTo21OH+aUQwEcSCAEErDh2A7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] staging: most: dim2: update renesas compatible string
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Sun, Dec 26, 2021 at 9:25 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Use "renesas,rcar-gen3-mlp" instead of "rcar,medialb-dim2"
> - the documented vendor prefix for Renesas is "renesas,"
> - existing r-car devices use "rcar-genN-XXX" pattern.
>
> There are currently no in-tree users to update.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Thanks for your patch!

> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -1086,7 +1086,7 @@ static const struct of_device_id dim2_of_match[] = {
>                 .data = plat_data + RCAR_H2
>         },
>         {
> -               .compatible = "rcar,medialb-dim2",
> +               .compatible = "renesas,rcar-gen3-mlp",
>                 .data = plat_data + RCAR_M3
>         },

Looks sane, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But there is no DT binding documentation covering this block :-(

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

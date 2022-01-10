Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8691A4895C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiAJJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:55:30 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:40925 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiAJJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:55:29 -0500
Received: by mail-ua1-f50.google.com with SMTP id v12so22332661uar.7;
        Mon, 10 Jan 2022 01:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BP0jTeln64BsVxh0F56vcuTVCny3JMxOIhYQM1VFh20=;
        b=T0Rv28pQc5omPuvaOE/1mLeYrDaeg5NCfLWNpcPPmc9ThmRvrLEm0KStCkxR9odTQI
         7/1N5DpCjF19MmfWkkUB3IGs+Ojvt3JK3BTASUA4tNAndf4Xdt76ysRxWRz2NWpBdPM9
         +1jijGMqUM0ImVJeyEFjfGjTkXY/umjt/OrD9zTyOXeqt6SYTknEgsvAl96CaEK+bK71
         V08Z3GH+znpONh5UEZpk6hVeqxPZHhj20MWjQv3waI+R7ea7q8X8bPHyb9H4kMok62k6
         GuwRsxaPAkn3ea09ZdnrFqQLBSgIY7IY8iuqFpBYrsxHDFaMoS0EaDDNGv8m/2FfeqTu
         g05g==
X-Gm-Message-State: AOAM531t47dTuK83f9iFTop3JHjumAwy8NN3jzx4yv7cL0p6HCSFR+JG
        LLb+xbxEa6+fikyBcj0NeFYL/BWVzvULMg==
X-Google-Smtp-Source: ABdhPJyoUB08V50XRrcsZBAwszA3EBFYc2aZo0mHmqoF+TLiFYfSZTAo0lCpdlnPn2oFz2GaSWjaag==
X-Received: by 2002:a05:6102:3026:: with SMTP id v6mr1876928vsa.19.1641808528261;
        Mon, 10 Jan 2022 01:55:28 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id d15sm1657908vsb.16.2022.01.10.01.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:55:27 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id i37so2857498vkr.8;
        Mon, 10 Jan 2022 01:55:27 -0800 (PST)
X-Received: by 2002:a1f:2344:: with SMTP id j65mr1408688vkj.7.1641808527113;
 Mon, 10 Jan 2022 01:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <CAMuHMdVHMzZipXaUE_SrkHtj6edZATefC908P1ngLrnOry8KCA@mail.gmail.com> <fbabf712-ea2a-5bd4-56d4-70cf4d7f72f6@cogentembedded.com>
In-Reply-To: <fbabf712-ea2a-5bd4-56d4-70cf4d7f72f6@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9hgzRJn7xL=PWC66UpJ4nB2krZY6VkL9dN7nT2fY_uw@mail.gmail.com>
Message-ID: <CAMuHMdW9hgzRJn7xL=PWC66UpJ4nB2krZY6VkL9dN7nT2fY_uw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Mon, Jan 10, 2022 at 10:51 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> > i.e. will queue in renesas-devel for v5.18.
>
> that is, for current + 2 ?

That is correct, as the merge window for v5.17 has already opened.
The deadline for new features to be accepted for v5.17 in the soc
tree was around v5.16-rc6.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

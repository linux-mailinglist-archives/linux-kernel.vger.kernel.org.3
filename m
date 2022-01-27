Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5149DEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiA0KAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:00:43 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:40654 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0KAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:00:42 -0500
Received: by mail-ua1-f52.google.com with SMTP id w21so3702558uan.7;
        Thu, 27 Jan 2022 02:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYcVuPoB0oi6VcbUyfjJ45yJ95BHctSH0SlEgz3cJO4=;
        b=C9XHE7eeOBn/5NoRyJirxxDrbXGHUjKJ8M5Y0faTL81ZgRa79rvpYSmFDnmUIsQWaP
         2W7Tu6VqmkCmut7o9IG5pCsnCzrgYAsV7LxyNaF5D6yiQPXB7ZisFSqblEL3xknubtKt
         5NYyLSOWA0BRu0o5oJOrqRPAgwKn0XxKBTRZN7dVJzaJEj7ijwx0UKOUoUDxSiQe/oRg
         6bbOHFRfmMmSikeHeffNBLmMjUHxOW7yAJvOm7NiRbcnbx+C3jGIPOHvlueOkChuYNfX
         X9dLQ0ETQGrowmBirBTVQYC/GGOdKW1pGnFeYg7pGxgSTY6/mBmheJ6UYhGLK1rdRu8Y
         wcUA==
X-Gm-Message-State: AOAM531/oupUw5+aoqEN9RN9Xofkh948cWBOls84B6/g27Zwnk3LWzMg
        X4eAKManaFS/mXTvZDtE09/bF7QvXAOHrl8O
X-Google-Smtp-Source: ABdhPJxH9P+HIWa+EYqILXxpgvpbzz1WMdaTvMY9lWm+30IGfvdbSfTl0pXByDYtL32By7zHuAwiFA==
X-Received: by 2002:a67:fd63:: with SMTP id h3mr1109545vsa.77.1643277641523;
        Thu, 27 Jan 2022 02:00:41 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id w124sm474100vke.20.2022.01.27.02.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:00:41 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id l1so3699240uap.8;
        Thu, 27 Jan 2022 02:00:41 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr1106654vsb.68.1643277640872;
 Thu, 27 Jan 2022 02:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20220120051559.746322-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20220120051559.746322-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Jan 2022 11:00:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVw5BZUys-yOotRApgpXjGviWoBFtFrbQost2TcX4j8YQ@mail.gmail.com>
Message-ID: <CAMuHMdVw5BZUys-yOotRApgpXjGviWoBFtFrbQost2TcX4j8YQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: renesas: add MOST device
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 6:16 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This patch adds mlp device to dtsi files for R-Car Gen3 SoCs that have
> it.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Note that as this device has no DT binding documentation, and the driver
is under staging, this can not be considered stable.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

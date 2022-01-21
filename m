Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8526F495EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380307AbiAUMHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:07:30 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:45590 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350391AbiAUMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:07:28 -0500
Received: by mail-ua1-f50.google.com with SMTP id x33so16400889uad.12;
        Fri, 21 Jan 2022 04:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoDen8PtW8byWyF8mhXAdlajtdUoL42XdSGYBm/7DR8=;
        b=HSPnkDxne/jviXJ4owJs1Up8aaaTScl5CwdeKL/11zvvT52R4rXB6AoifEAZHc/lyh
         cF0qa6WY0dR78BaHnmTJpPxmRt1EjUY7ZkoD1ZyB98XIk00Shjw+WRDkDt+t35sv2tzq
         RMBu5vpl1LrXF4ikOsH+qEPrVyvE4OvdzhKB49A80IdHaEKYvtzh0zliDOQVQoSPqPcv
         V15aS/la2DQRU24zkLWwjijKedWLtPtCtK3DHMpplTsEZKuG1jUAQhqa7dzMhyJpZkIt
         5aVKGdQpGP2SeEHgmx+jo2jJ9+CxnNuW+uiU0gVCKLsrVf2TWySR3JQxczHe4ceWdZCO
         JsgQ==
X-Gm-Message-State: AOAM533FeEIQdwlUPs7Kik4L2b/qqzCCQRIyT7K3o/H5ql95YKMG3WDT
        DcBmAsJNLA6yXFz7Lu8jushmsy5uO2E8qg==
X-Google-Smtp-Source: ABdhPJxA6ts74iGWB8W82UyCajy28harvc4I2/MTnlkltKn0HEfVCOA8P9kvAp/V9Bn2VYXh45vmkA==
X-Received: by 2002:a05:6102:3a08:: with SMTP id b8mr1701713vsu.53.1642766848044;
        Fri, 21 Jan 2022 04:07:28 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id o131sm1299739vkc.42.2022.01.21.04.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 04:07:27 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id m90so16536220uam.2;
        Fri, 21 Jan 2022 04:07:27 -0800 (PST)
X-Received: by 2002:a67:e055:: with SMTP id n21mr1535004vsl.57.1642766847462;
 Fri, 21 Jan 2022 04:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20211225115308.2152364-1-nikita.yoush@cogentembedded.com>
 <CAMuHMdXdW=bCxBeEu81bRBwAs5=x_KZmPcXoMe=CmFdWz=rdfQ@mail.gmail.com> <f49794a0-096a-1f27-a250-5a74a9ed6ba6@cogentembedded.com>
In-Reply-To: <f49794a0-096a-1f27-a250-5a74a9ed6ba6@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 13:07:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyRpEE2i4ak3Gg7EOW8LHPk8jZe+ZeVZTW0TWaXJ5k_Q@mail.gmail.com>
Message-ID: <CAMuHMdVyRpEE2i4ak3Gg7EOW8LHPk8jZe+ZeVZTW0TWaXJ5k_Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add KF HDMI output
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

CC Mark.

On Fri, Jan 21, 2022 at 11:18 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v5.18 with the sort order fixed.
>
> Thank you.
>
> I have a question regarding defining regulators.
>
> In case when drivers expect regulators to be define, but physically chips are just wired to VCC (or to
> some non-programmable power logic), what is the policy regarding regulator-fixed objects?
>
> Shall we define per-consumer regulator-fixed objects?
> Or have a single regulator-fixed for each voltage?
> Or not define regulators at all and let the code to create dummy regulators?
> Or something else?

That's a good question.  I don't know if there is a policy. Mark?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

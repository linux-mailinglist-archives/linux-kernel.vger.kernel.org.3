Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E346BCEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhLGNv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:51:56 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:39674 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbhLGNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:51:54 -0500
Received: by mail-vk1-f175.google.com with SMTP id 84so9295564vkc.6;
        Tue, 07 Dec 2021 05:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0L/U4lHg7r2G0KTHxmsk0qHApW5otmpmmAocXJGGt5U=;
        b=iA0/DjVbvId2nTmOPGhvVButYzdrUbnlTNksaWfsFuP7Rg0mAXRAh12G76Usa11QSH
         wRUjLq6x5iHlMFDQgGG3nwhkGqnHeY/ZFbDJ0CWIAIIfGv9YzxSyLbOo/BULurrnUWWA
         EqfYY2yA2HEjM8yCpJDsj0iqlNAuE2tIWtTGX2zDS+vi80qzn7SddTQvDAIcwGWo1IH9
         C5lRWbpK2JaCR9Fat92nbVTMKO1hltw5vnAst1h5zrs+cqEgdBL1If3cGtxw4CZ114o8
         yS1NKMEHuprGN6DlAh4Nr6AiMWRApImexnSdfSGtGPJQKfRcDiTgRLtFeUMSQGkpB+4Z
         rz5g==
X-Gm-Message-State: AOAM5320sMdAi1CQw4SwkgsF+kz3WXjtJ5rQBithkbH5G0ibGbG2xJqY
        U+9MviS57nAPObLfKeqRl/9gQZIcCCVHUg==
X-Google-Smtp-Source: ABdhPJzQfVkmQr0G4rezSnBKH3ssy4Sl1PxiiE73ADr3R+7kdw6EhgX/pt9QFl5WBZP3AsSylIetQw==
X-Received: by 2002:a1f:a787:: with SMTP id q129mr52287113vke.40.1638884903059;
        Tue, 07 Dec 2021 05:48:23 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id t20sm6519901vsj.27.2021.12.07.05.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 05:48:22 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a14so26752176uak.0;
        Tue, 07 Dec 2021 05:48:22 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr44197529vst.5.1638884902312;
 Tue, 07 Dec 2021 05:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20211207134531.19560-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211207134531.19560-1-lukas.bulwahn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Dec 2021 14:48:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUbSbWVexx+jRN+XQvpYFTZ3K1M13=x3AHQ-fqM8TYCg@mail.gmail.com>
Message-ID: <CAMuHMdWUbSbWVexx+jRN+XQvpYFTZ3K1M13=x3AHQ-fqM8TYCg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for ROHM MULTIFUNCTION
 BD9571MWV-M PMIC DEVICE DRIVERS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Tue, Dec 7, 2021 at 2:45 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Commit 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
> converts bd9571mwv.txt to rohm,bd9571mwv.yaml, but missed to adjust its
> reference in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> a broken reference. Repair this file reference in ROHM MULTIFUNCTION
> BD9571MWV-M PMIC DEVICE DRIVERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Mea culpa
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> Lee, please pick this minor clean-up patch into your -next tree on top
> of the commit mentioned above.

Note that there's another broken reference that needs an update in
Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator :-(

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6046A067
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390806AbhLFQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:03:35 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:39433 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380269AbhLFPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:48:05 -0500
Received: by mail-ua1-f53.google.com with SMTP id i6so20398713uae.6;
        Mon, 06 Dec 2021 07:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy3338Qktced19OV69eNGqaLOwGIfSaex03EYB876QU=;
        b=tSQoMX/u3t8Zfrqn3pE0X+viVaHEDe2CRj/cuCXDHX14DbUbPNCl3hHp9GteofNTZO
         AVtqpJfbScOBUatoMDHBXF0/v0OKCaPQVNrtjUkvrtgvzUtZX7GRVWvMMqTbGLLTtrVo
         BXjvXonexh25tZbaTFOMwek2JyEijLr1nh/jtd0I0SiShKqwRnBmtYO0Z7EHnW/Uq8nn
         s2Dc+EuhaNpg9IQrqWfivvvmx/WzJmltnbIxuyHlak4Eo3MKs+DgIdDSZ5SvILrbohse
         r+9iof0aQELdk8n82c7yIBcwP3qMtOOsX3kPO4qu3n/UB9Qjq4wVjndVhO3R4HjY5Qu9
         4T/Q==
X-Gm-Message-State: AOAM532w1cZ/WJ7owWykfIMLJySnzDog3QATMZLyEDS9DWM3ZOLLNJoN
        5OhJDUOuXumcSIGc24DY0AmHatgeqWpNQw==
X-Google-Smtp-Source: ABdhPJwYaqBSIH4vYBT/cM0UkpgTxOgXJJT2kgBeQavRnv+4FRiqBBEyhQiVjvr+iqaxJJMMFeqT8A==
X-Received: by 2002:a67:fdc3:: with SMTP id l3mr37963775vsq.42.1638805475997;
        Mon, 06 Dec 2021 07:44:35 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id z188sm4193582vsz.12.2021.12.06.07.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 07:44:35 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id o1so20427958uap.4;
        Mon, 06 Dec 2021 07:44:35 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr36267266vsf.38.1638805466989;
 Mon, 06 Dec 2021 07:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-3-gsomlo@gmail.com>
 <CAMuHMdVJZp+YuaDnXabOgeTajNo0JA9nwCmkiTg2=69L9-6-ew@mail.gmail.com> <Ya4uETXlJc7PMY81@errol.ini.cmu.edu>
In-Reply-To: <Ya4uETXlJc7PMY81@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 16:44:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6Nktw66s8pY5T6tra8j0kGePsWn1uT59j45=b92CBsg@mail.gmail.com>
Message-ID: <CAMuHMdV6Nktw66s8pY5T6tra8j0kGePsWn1uT59j45=b92CBsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Mon, Dec 6, 2021 at 4:36 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> Some of the *.txt formatted files in Documentation/devicetree/bindings/mmc
> had an explicit "Optional" section, but all the .yaml formatted ones
> just seem to assume that if it's not under `required:`, it's
> implicitly optional. So I'm removing `interrupts` from `required`, and
> adding `reg-names`, as you pointed out.

That's correct: if it's not listed under "required", it's optional.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

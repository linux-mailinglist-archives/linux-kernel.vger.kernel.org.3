Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12C44785DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhLQICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:02:52 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:34486 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhLQICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:02:49 -0500
Received: by mail-ua1-f43.google.com with SMTP id u40so2907049uad.1;
        Fri, 17 Dec 2021 00:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fx7tWOtL8mG5j0QcSY4U9yZmw2gjvIvwXDDbEmQGZfE=;
        b=wCw2olc/3lBVZX8EqyIwtgfycnwlJT2vP7NboX19ujIfJS3eXMkvY7BZMl/ww95FfR
         rdZEpGnzIKN9M1BNbAhAWnmLj81YI2XjkiroDMwyU1Mwr+84TeXjg9/bbmB1IpBamsR1
         jGVwnvZZhD3SumStcYxgJXq50tHOgkBvznMhFeeYZ3SYCF2OPO2IXCbYzRRQCrueW4j0
         /bSv9tILxLu6DzRRKvDokuo9836Egz3DboOJW7oVHz5p/2+LhPwOzptR1tNPuoTh6hnc
         2uNU4Em7ltuDkarlXMErn8ZF1+JLE0TnPzNheKt3c8PbJf9Af0WVKcdl5Vtst9YBW9cK
         087Q==
X-Gm-Message-State: AOAM530x6Em6d8RmvuDFsHOO5XOwHAuvr5asTdrO7qUbMWFczUvIz+yB
        BnavcFpQ6ZYanTOTOf4HTXh789RfpUOevA==
X-Google-Smtp-Source: ABdhPJyh8LAq1kHetPvpEzCnxPiEcI/zKnsI6RG7L7sufUOeUjVDhjYKax6uy9iRAJu9GXipbXo9Kg==
X-Received: by 2002:a05:6102:38ce:: with SMTP id k14mr575905vst.70.1639728168380;
        Fri, 17 Dec 2021 00:02:48 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id j145sm1642578vke.47.2021.12.17.00.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 00:02:47 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id 30so2770112uag.13;
        Fri, 17 Dec 2021 00:02:47 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr552893vst.68.1639728167350;
 Fri, 17 Dec 2021 00:02:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639661878.git.geert@linux-m68k.org> <Ybuvg3h+VLCMji4J@robh.at.kernel.org>
In-Reply-To: <Ybuvg3h+VLCMji4J@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Dec 2021 09:02:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzknbzS6wL2=e1RGHB69fGDZM_C8R61aDz29PNmr5bAg@mail.gmail.com>
Message-ID: <CAMuHMdVzknbzS6wL2=e1RGHB69fGDZM_C8R61aDz29PNmr5bAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: interrupt-controller: sifive,plic:
 Miscellaneous improvements
To:     Rob Herring <robh@kernel.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Dec 16, 2021 at 10:28 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Dec 16, 2021 at 02:41:20PM +0100, Geert Uytterhoeven wrote:
> > This patch series contains two improvements for the SiFive PLIC DT
> > bindings.
>
> Lore is thoroughly confused with this and several other series. It seems
> to be doing subject matching and pretty loosely.

My apologies, that's purely due to a silly mistake on my side.
I sent out 3 patch series without noticing I still had two cover
letters from previous "b4 am" sessions in my working dir, so they
were mailed out as part of the series, too :-(

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

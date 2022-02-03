Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799C4A8BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353501AbiBCS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:27:15 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:46975 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiBCS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:27:13 -0500
Received: by mail-ua1-f48.google.com with SMTP id c36so6692207uae.13;
        Thu, 03 Feb 2022 10:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfFHx9Zq0C2AreFEJiveO0p8U4RyKLhiuAIUAB4ewYc=;
        b=7oU+fmcKrYhrpGqR0Y572y0ZZIwA+xZPoxTjDOm7DFfvqso1G+iaulWcxzMCYaUfw1
         Z7FVFb4/mbtGrV611EGszxtDy/UZI8RMp98/lvQW/7/PtKKsZ232mvVW9gkMK/ogQyVL
         EiYxvgf31eHshE3VVXCj+gXYKp5pxI/AInnIF3tlI4vuqzXn2qi1fWjcuvOmLxCq0mxh
         gJYhvBrs4HsO2ueh/WpRPe4lbR34+hleJboz+f6X7pHMzs1cJ40KpyXw2It2oPxXhy4g
         Ix0Gue7fxad8kXtVmbAB33kRrszid50t1jo4HszI1ZWqTy4emUuON6FA4Me1WmPsv8oY
         wy3Q==
X-Gm-Message-State: AOAM530goV4hBTSyTtZ/00DXSdrr9uqlh1NsgbBA6K8hkkSZ8e7mFLSK
        IlBX7JTFXWsGHrTiCwFTZ7OvPJdTFJscVg==
X-Google-Smtp-Source: ABdhPJzcAcVXAq8iQG2HsM5TbuKypKZGbSHaT2cwB02n3++GG/wnz2esfA1mMs6z7hKZkAVAmN/SkA==
X-Received: by 2002:ab0:6ed2:: with SMTP id c18mr12546622uav.116.1643912833008;
        Thu, 03 Feb 2022 10:27:13 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id x14sm3017584uav.5.2022.02.03.10.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:27:12 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id y192so2260185vkc.8;
        Thu, 03 Feb 2022 10:27:12 -0800 (PST)
X-Received: by 2002:a1f:5d84:: with SMTP id r126mr14355988vkb.33.1643912832487;
 Thu, 03 Feb 2022 10:27:12 -0800 (PST)
MIME-Version: 1.0
References: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru> <CAMuHMdVjCzEpDLnW-jy_kpHoV8DEa=KCAjp=QeXnr8auh3B5Pg@mail.gmail.com>
 <ad4930d0-7d4a-6a81-5830-3a62a44572f5@omp.ru>
In-Reply-To: <ad4930d0-7d4a-6a81-5830-3a62a44572f5@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 19:27:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXcj8tDdGLZ=K29YDUqb_=_kM42ZOE6F2kCJhf-uPSzzw@mail.gmail.com>
Message-ID: <CAMuHMdXcj8tDdGLZ=K29YDUqb_=_kM42ZOE6F2kCJhf-uPSzzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as Renesas R-Car SATA driver reviewer
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Thu, Feb 3, 2022 at 7:24 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> On 2/3/22 9:13 PM, Geert Uytterhoeven wrote:
> >> Add myself as a reviewer for the Renesas R-Car SATA driver -- I don't have
> >> the hardware anymore (Geert Uytterhoeven does have a lot of hardware!) but
> >> I do have the manuals still! :-)
> >
> > I guess some of the manuals are publicly available on the Renesas
> > website?
>
>    Have they finally published the R-Car manuals? 8-)

The same SATA block is also used in other SoC families. See e.g.
"RZ/G Series User's Manual: Hardware" on
https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rzg1h-ultra-high-performance-microprocessors-quad-core-arm-cortex-a15-and-quad-core-arm-cortex-a7-cpus-3d

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

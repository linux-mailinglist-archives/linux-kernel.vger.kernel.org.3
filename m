Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1792B48EFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiANSbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:31:22 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:38855 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiANSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:31:22 -0500
Received: by mail-ua1-f46.google.com with SMTP id h11so18441271uar.5;
        Fri, 14 Jan 2022 10:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ia/9q2E3tSjqPvHPFubkiPIGbF6QBSNFRiW9j/QalMo=;
        b=DWgdUAXK+zqhjgodeqIvt8csbouUVo6gEibhZi7IhSiqyjvRscK2TSlJgKjCv3R0e/
         tWCeB3ems3gaPWt+vd8vLYyG5wN64iBv/eQzhmbkfIrhPw+A6lr4jP8o4pgiW1knWhs9
         fIQo9gfrqEm8ubPF+BIT08qcJwoRPkq/0XY0kDbLgOn86YMaiwiLZ1EavEvflFxxhOwK
         iHNvrM9Th/f9wI2kvDP3SbGOfVBB5N4kDdzQsdUkjexIt3/7C2URXY6FnJ93+oNpwKzP
         HxVxbmlpwafajj8v+jlVWEONgxX3KThBKkEzFXWvkj1Zl5Jir9C3rUi8/lyOu8y7NyNY
         Aypw==
X-Gm-Message-State: AOAM533hD3Cgckq9pPdAYGd6OI1R2/evFkz55mxH8nV/3RMvsL1sA91w
        oxMAXeamwPQqutUpZUs0uqO5oN8v/Q9MKP0M
X-Google-Smtp-Source: ABdhPJw5zR72GeLcKWBQpvlWAQ/C/SHUE3jf8tEfopq9XERJ2+kZTTnr9thfAK9cUvDGXg1ZmMPGEA==
X-Received: by 2002:ab0:13c3:: with SMTP id n3mr4673460uae.39.1642185081230;
        Fri, 14 Jan 2022 10:31:21 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id u137sm2248766vku.42.2022.01.14.10.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 10:31:20 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id h16so6359109vkp.5;
        Fri, 14 Jan 2022 10:31:20 -0800 (PST)
X-Received: by 2002:a1f:384b:: with SMTP id f72mr4877434vka.0.1642185080729;
 Fri, 14 Jan 2022 10:31:20 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530>
In-Reply-To: <YeG8ydoJNWWkGrTb@ls3530>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 19:31:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWNzDb--Ud1DzGyoqWsgFU9m8YZ6fa1TqfBWtg4pkd==A@mail.gmail.com>
Message-ID: <CAMuHMdWNzDb--Ud1DzGyoqWsgFU9m8YZ6fa1TqfBWtg4pkd==A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Fri, Jan 14, 2022 at 7:12 PM Helge Deller <deller@gmx.de> wrote:
> The fbdev layer is orphaned, but seems to need some care.
> So I'd like to step up as new maintainer.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks a lot!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

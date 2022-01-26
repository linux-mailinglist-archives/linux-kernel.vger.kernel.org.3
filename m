Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17449C6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiAZJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:41:40 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:34491 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiAZJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:40:51 -0500
Received: by mail-vk1-f179.google.com with SMTP id j185so10303328vkc.1;
        Wed, 26 Jan 2022 01:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAy2zgm466oxNuRFWuwR8M0eUPIcptlYMjnsJ3k50hs=;
        b=E5Pj4tsrNvdpnjvv+HAt4cAq4Fic1kLma3lHfsoibGHfTgwhSJhcU8cd1urdzr0up0
         VU3zCOxtIgN0HEZWFSo3jRcjM+W5YFt0L8uLgKg8MNVT0OB8IxhGlvkyZAuAOu5IVwde
         FwtwkWs9cx0XYgW8uLcyqw0+llPd4Ol4P54onIluY08pDEYK1coFITgSwvMkpwjS/T9e
         PFrjuLLH2ogrUoqK4ogjYBxVkYb1RZGsxjFsZDpnjgO3RrrMHNjDhngk7+nXZ0i4BdAT
         1+gibCU1VPEMfp6NlkvyGDk0U5YWvcfkFOehbg9EkKWAgVVU0ySIJp9dRquKAoG0nhov
         zJqw==
X-Gm-Message-State: AOAM530PeWckAx0QnWt+3Zf67R52miO38Yq/t2Uny9wM/d6+X8guUiLD
        y3fFqkciSNMoLVQWqrAShzJEha05lWp9MKr9
X-Google-Smtp-Source: ABdhPJxfCcHvBam4yzeX/pM3bK/rLp1bumxgoxSEMw+aq0Y2HiCTtpHoz5j/6Qg4CwkEwqaXLfAnHg==
X-Received: by 2002:ac5:cc42:: with SMTP id l2mr265388vkm.38.1643190050151;
        Wed, 26 Jan 2022 01:40:50 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id e66sm2590676vkh.35.2022.01.26.01.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:40:49 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id f24so42200884uab.11;
        Wed, 26 Jan 2022 01:40:49 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr5189111vse.38.1643190049539;
 Wed, 26 Jan 2022 01:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org> <20220125171809.1273269-6-daniel.lezcano@linaro.org>
In-Reply-To: <20220125171809.1273269-6-daniel.lezcano@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 10:40:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXZEYNjFh2T4beWdfn8av_qXaPbg4yFk=9whESnLBaFAQ@mail.gmail.com>
Message-ID: <CAMuHMdXZEYNjFh2T4beWdfn8av_qXaPbg4yFk=9whESnLBaFAQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for rk3399
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>, lukasz.luba@arm.com,
        Heiko Stuebner <heiko@sntech.de>, arnd@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Jan 25, 2022 at 6:18 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The DTPM framework does support now the hierarchy description.
>
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parent.
>
> This patch provides a description of the big / Little CPUs and the
> GPU and tie them together under a virtual 'package' name. Only rk3399 is
> described now.
>
> The description could be extended in the future with the memory
> controller with devfreq.
>
> The description is always a module and it describes the soft
> dependencies. The userspace has to load the softdeps module in the
> right order.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for your patch!

> ---

Can you please insert a changelog here, especially if you don't CC all
parties on the cover letter?
Yes, I can get it from lore, but it's easier for the audience if it's included
here.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

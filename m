Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592DF49CF11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiAZQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiAZQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:00:06 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:00:06 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id m131so57087vkm.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHaP8QZUNOCjkmPNKPCf4d3+Z1dAMC/my/c1DAn1of0=;
        b=ybq9EBHbWhdev8ZXcKZTiZ/INdzXZFvzoyB1/xLVff4cQTjbd14nSLmXVqJ76AqI+f
         UuZDjGwEHcI1rLCEwsfl4KrhMV49Q1/Rr74Q3TSluTntGIxVRM8JUZe+IeknyXHvg2hf
         g+fwQqJ0k0bG7t8/mjt6FvHsvoqOOFGNTGIfK5cx++bID8bz+pIPUjZf9LuOi97VtzAR
         rDAnZAJx62JMwMx+ygDKWRwywEZnYtsZthzDvR+XTQCshs1CUzKQmRNu56tMTupjBJWl
         VWvHeEtG+RRLWlXBm5O1v4YE12J880rD1juGvfQkjldyHpxJI1USDyChyzPpCcSMSkl3
         J69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHaP8QZUNOCjkmPNKPCf4d3+Z1dAMC/my/c1DAn1of0=;
        b=w+mAvWQlR13Dtx0FT9u5ct7O0gX5K6t3aG+4hK19oReZvrT3ap+WL9mJUpz26bf3Qp
         WwaETB2/G7rXCTxPjZxqvE8BOXbxRoP4WzahrLeqxxgyPae+yRNsZ7kKAuHopR+9nDT0
         oDryKKBUHkhFaN7RiUZOo4lwi/Uj++8AvjJAfInUVBeWcUqmGu6D2hELM3jMW//gf0q2
         nxxE3mKt74E26dkJI/JHgY/1I2eSs2lGSk7Bxpl9iuzdMU4HJx95wHqR4E1o9tskwDBx
         Mlt8jeJ5pIGHSCGcmlxWhIOqybY/WuctxtGsxhV4tvt7PNT/DLW1O3rWU9Hob0KKVuSx
         6+eg==
X-Gm-Message-State: AOAM532nlz7CApEj0wLMNNcqWtnn9l6PPaKVccX5ToxuvHgqQ80ss5A5
        cs8LA8Q1jDsPttPnGl6vTXdnH2H0yT66PgAxW1Q02Q==
X-Google-Smtp-Source: ABdhPJyQds8T0nBhNW3ATVRZZXvbEaXj0bT6cR2EpD03NOqGrTF03r2QT/LxlL3vII2Cb832ApVWiclaTBJKgwUulfY=
X-Received: by 2002:a1f:a4d8:: with SMTP id n207mr8993217vke.10.1643212805666;
 Wed, 26 Jan 2022 08:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20220125155447.179130255@linuxfoundation.org>
In-Reply-To: <20220125155447.179130255@linuxfoundation.org>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 26 Jan 2022 21:29:29 +0530
Message-ID: <CAG=yYwmrqD+kb2_tLDY5zAzeD21gbLA+sEt2pU9eEiFbQ8kPpQ@mail.gmail.com>
Subject: Re: [PATCH 5.16 0000/1033] 5.16.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.16.3 release.
> There are 1033 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jan 2022 15:52:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
  hello,
Compiled and booted 5.16.3-rc2  on VivoBook 15_ASUS Laptop X507UAR  .
NO regressions from dmesg.

Tested-by: Jeffrin Jose T  <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology -  autonomous

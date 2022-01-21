Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08DA495C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379649AbiAUI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiAUI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:58:45 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BFC06173F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:58:45 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g81so25575236ybg.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/CAdEqGBk7N/8QQ5A23zI2nrO/utlv2ElHpvb6u4CA=;
        b=REKUOzbTnrnoKH+nWoApUShHgZjf318EWK9itQNe1JkF4qXv+SGJQbIKI+K3H7D+95
         bcr2KPcZ5+mPIb6DxeTuv7HF9kN8W9UUcXvjL4p++kLrmkaD1KNf1eEWqFs7PSKC8dEm
         ME9OL35fUckRg3MVWpk8FylBI+5zGpdZDH3d6rrEzRZCBsJGqGX6DMeqRYiwOOP4Ja/G
         7wGTaZEhKOLsAWLQD4u0b3GOi+vYHxZgMv8Cev8mA3sgaVtzvmxSN8U5g3ueAb/LMM9f
         t55rvr2CTMly8LmNPhlTR+npOVIclcOhEtDaxU0kpotd50fmAekkmRn8B7XG0Wr161Cq
         TIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/CAdEqGBk7N/8QQ5A23zI2nrO/utlv2ElHpvb6u4CA=;
        b=ByfpXX3MvAPpmKeXFqITzVWe0jpUZyBoEtRSILHwXvkuZm72XszV1Q2BM9mDbuRdLy
         m6OaRHQTsYPYhmVlCqNYO2iLHqI4IyNd2wjuD1uLUfHpP6FrGJwWnfjgF7oNhOdGdG9D
         nhKNrzJDjDwd5xvckRDeJt8xF+hn+EmNycWWMJW9rgN0VRQF3R+VDC3d8Wf+4fBnLNoO
         /Tvc6y2lgpikdhKa/ZV7HBfFpZsdF9Gna5JtVe1J9+0bQM07mN7T4yCBIvQ1NuHVuewL
         aognu6NhZMTF/Wfx5wPFkz1XpM3Y7MtTpzqbKl7TAu2yhZrF1pd0s8hhHzSF5YWuKV1Y
         UUBQ==
X-Gm-Message-State: AOAM531S1GSMqnX5rASKvdvcRz86zfSMkOvTeHhCSI4DTxLHzGX8ArP9
        vTZLK6U2RdgnvnHlZ90HYuIjli2rpCKxhkewRGjfLg==
X-Google-Smtp-Source: ABdhPJxGI0tWvbu3C1KPF9nJZim+8Kq1aJ/5f3LrEb7Cs7qRdYvtHbmNg0CYHyFs7ws6XGnbWWn724o1yPYmp+AIMhU=
X-Received: by 2002:a25:9082:: with SMTP id t2mr4422729ybl.684.1642755524616;
 Fri, 21 Jan 2022 00:58:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtq0wzSeG8YG-a+=KrbdWqHJMXk1hvq0FKeAvj9sZAK2g@mail.gmail.com>
 <6249735f-e6b7-1331-eb2b-361bb17d6115@opensource.wdc.com>
In-Reply-To: <6249735f-e6b7-1331-eb2b-361bb17d6115@opensource.wdc.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jan 2022 14:28:33 +0530
Message-ID: <CA+G9fYu__OOvk-ESXoOqbd-Lk+CmO8CSQ8chEFf3MyeTjKtp9g@mail.gmail.com>
Subject: Re: [next] mips: cavium_octeon_defconfig: pata_octeon_cf.c:598:23:
 error: passing argument 1 of 'trace_ata_bmdma_stop' from incompatible pointer type
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I just posted a fix. As I do not have the environment to compile test
> mips, could someone test please ? I will send the fix to Linus asap
> after confirmation that it is OK.

Please share your patch / patch link. I will test it with tuxmake.

you may also give a try with these easy steps.

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

 tuxmake --runtime podman --target-arch mips --toolchain gcc-10
--kconfig cavium_octeon_defconfig

- Naresh

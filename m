Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE27347F6E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhLZNGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:06:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72687C06173E;
        Sun, 26 Dec 2021 05:06:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j6so51353990edw.12;
        Sun, 26 Dec 2021 05:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mv1TZbhvoh2chJhCcunQKTwBfvV5ipUwhvosrgB5vM=;
        b=V7lfX6FvMNAxY0TMpaAQq/FSh8ZwfYbDJSYjZw0NpZiMMpSS+zTvmdTH5AFI750qlS
         HJosN6RoAej/5Jd4f9KbRjmn73CMgRIE1JVNMJ+rl8zCqkneMCw1BXAarQz5DyMHxE0K
         elqWCLoZjJwnu0WeaWhU/A2nFJ0LFbMag+vktx36mc4V00oRANSHFJF75jy2r8MH0VeD
         kCPRVMtHIrrP9MVZkPzT0e6VJD3DFa6pRPdbpWRdRiqpkmN4pVfnb8A8h5RXa4qZ5yKu
         Bf1TxW+MPCTP8qBXaUyD5SMV+weQSN/DJVA3CvDqviElEaSHxkWs6PGJAatwP8HMKkPT
         8Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mv1TZbhvoh2chJhCcunQKTwBfvV5ipUwhvosrgB5vM=;
        b=n+OjSEJY2vb/BrnhREWugNffeEpYIXI9iEImYM/5303ng6vZ+F4t2y4aUcULjoUlmR
         Q9z3vCDJ0SqA3WIWtZNo2wILyA/TT8SBCvgw51+JCCfeRXZrX3vNKNfV5FNIiici7Paj
         ySuyXQthkdrQ+4q5RVxzDNm/MVlKhdd0vv5rJOVxfdYJEE0J5WfJ2Qs9bB+MIJsN/Ux1
         agDyRNbWQb3SwWCKMPc7is9sPjKKnhFH9TCOj53NN1u10SyilRdqlAXF5KXZS6OC2Vr0
         0vYLWVZQkmRSzKbFy4jn/k3FZymzi5Egwgb0bMGNG2KhL1KZs1AjI9ovINp9gubxAimA
         m0rQ==
X-Gm-Message-State: AOAM532EaSMjOTGpjo5bVAkHVEZ++E6wcBeQWNmu9M41hF1rdnTT28EA
        HOmz7ZkMeHjtPqM+254iNQOgUviAsgYSrggb6Ms=
X-Google-Smtp-Source: ABdhPJzxD7hL11VINZDFfTCPkZHbLm7V2jLsv2udOhICQzAsLZ0Gh60Fp0KoExxP77XYzDlEpNJJLvl1pzwh72Gxs8s=
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr11544791ejc.595.1640523995951;
 Sun, 26 Dec 2021 05:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20201211184811.6490-1-grzegorz.jaszczyk@linaro.org>
In-Reply-To: <20201211184811.6490-1-grzegorz.jaszczyk@linaro.org>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sun, 26 Dec 2021 14:06:24 +0100
Message-ID: <CAH9NwWcDj1odYuAvMVRG5zMOA-Q95EvoTDqq1o-M-s45NTcwkw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce PRU platform consumer API
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Cc:     ssantosh@kernel.org, Suman Anna <s-anna@ti.com>,
        santosh.shilimkar@oracle.com, Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
        Tony Lindgren <tony@atomide.com>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI all.

Am Fr., 11. Dez. 2020 um 20:15 Uhr schrieb Grzegorz Jaszczyk
<grzegorz.jaszczyk@linaro.org>:
>
> Hi All,
>
> The Programmable Real-Time Unit and Industrial Communication Subsystem (PRU-ICSS
> or simply PRUSS) on various TI SoCs consists of dual 32-bit RISC cores
> (Programmable Real-Time Units, or PRUs) for program execution.
>
> There are 3 foundation components for TI PRUSS subsystem: the PRUSS platform
> driver, the PRUSS INTC driver and the PRUSS remoteproc driver. Two first were
> already merged and can be found under:
> 1) drivers/soc/ti/pruss.c
>    Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> 2) drivers/irqchip/irq-pruss-intc.c
>    Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
>
> The third one [1] was accepted and applied to andersson/remoteproc.git
> (refs/heads/for-next): [2] but is not merged yet.
>
> The programmable nature of the PRUs provide flexibility to implement custom
> peripheral interfaces, fast real-time responses, or specialized data handling.
> Example of a PRU consumer drivers will be:
>   - Software UART over PRUSS
>   - PRU-ICSS Ethernet EMAC
>
> In order to make usage of common PRU resources and allow the consumer drivers to
> configure the PRU hardware for specific usage the PRU API is introduced.
>
> This patch set depends on "Introduce PRU remoteproc consumer API" set [3], which
> is complementary to this one but goes for different, remoteproc sub-system.
>
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20201208141002.17777-1-grzegorz.jaszczyk@linaro.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git/commit/?h=for-next&id=b44786c9bdc46eac8388843f0a6116369cb18bca
> [3] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20201211142933.25784-1-grzegorz.jaszczyk@linaro.org/
>
> Best regards,
> Grzegorz
>
> Andrew F. Davis (1):
>   soc: ti: pruss: Add pruss_{request,release}_mem_region() API
>
> Suman Anna (3):
>   soc: ti: pruss: Add pruss_cfg_read()/update() API
>   soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and
>     XFR
>   soc: ti: pruss: Add helper function to enable OCP master ports
>
> Tero Kristo (2):
>   soc: ti: pruss: Add pruss_get()/put() API
>   soc: ti: pruss: Add helper functions to get/set PRUSS_CFG_GPMUX
>
>  drivers/soc/ti/pruss.c       | 257 ++++++++++++++++++++++++++++++++++-
>  include/linux/pruss.h        | 221 ++++++++++++++++++++++++++++++
>  include/linux/pruss_driver.h |  72 +++++++---
>  3 files changed, 526 insertions(+), 24 deletions(-)
>
> --
> 2.29.0
>

Is there any update on this patch series?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255258751D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiHBBjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHBBj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:39:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3015ADF61
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:39:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so23393570ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 18:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n/hvrcN3haklNL4BZT6Q3NHuwV54nZb1V2WNeAo3614=;
        b=kwt4HjBfsem/AP1lC8+VnuEw5nbGzMpMdJdWcv6GaiHH9ZN+uCfG0foM/H5gOb7epn
         RQasGtuwVIdA9i9+K8V8xNKJb8N+VLaOwE0HDkUO5018L8vyNKH5n0YJB0+SPZKSZoym
         gJ7ixLRhZL/KQNDBydRa4yP6Cntxsv6fwqcHkE9IGGjoq9ZSc1WqEdBTwz6WkHJUQJCe
         YQuEXhmu1uiTX2S42OBjjdrJnmpnM6raTynQPitWqVAosgK6sAFk0Kv6NoYRcVzqydUy
         YjXcirupuQxcFNvVVZnW4T8dRm72d2y4q4lKOOeliub9Q8If+6Zo5bW16t6hnd2fAiDj
         oaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n/hvrcN3haklNL4BZT6Q3NHuwV54nZb1V2WNeAo3614=;
        b=bU+Rs4YjByPIuo6rA75eGVAk3g5+fH652oMsPm71lO5Fut7KZkJBHhnRNbGKWJsfBN
         p3WFCu/7QwimaEH1L/w6vE8UfwR2JtyNHwK1h1rMbFMjTvOPYB8AZ4MTMv5eJAcfH/Li
         6PMulGyvD2/HXpYl+wcKmzd6jvq1XmyH6MiafzxJ2RVwbcwZtguLd4UJOaRGw4pibyv7
         dUowf9H7og2busKmx4v1Ba0ClVeyhIhXHDBqtNGzGTO36mP0sv7XVDsDFLEMKTliv0GQ
         gXEurLcdPh1gHrIl67WAWQQwlujOYvwtVsuTxHakUML6/n+PFExidgXjotk9zaGxxU23
         kaDg==
X-Gm-Message-State: ACgBeo2cI5240By5i0YOFa3VFy5MoSHPaFLqk3wzXL+9PjFNpmyOTWEu
        ZmggeGnLgvjQdNDXQYmPDfI1BY5xtki4k36MMzg=
X-Google-Smtp-Source: AA6agR5pN8Z8H/ZuPdvMznjqvuBVxB8TB4Qfx+HlpJlxtD6l/Bi4IsqHBHf6Akw6ERiuYYPmUJnTa1w+uD/6zzc0ROw=
X-Received: by 2002:a17:906:9b09:b0:730:9480:9729 with SMTP id
 eo9-20020a1709069b0900b0073094809729mr3785983ejc.588.1659404363236; Mon, 01
 Aug 2022 18:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
 <20220801225538.qtdb5zd66g6ipewz@pengutronix.de> <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
In-Reply-To: <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Aug 2022 20:39:12 -0500
Message-ID: <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 6:12 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Marco,
>
> On Mon, Aug 1, 2022 at 7:55 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> > Question is, does your setup work for all modes after applying your
> > patches and without using the NXP-downstream porches settings? We also
>
> Without Frieder's patch:
> "drm/exynos: Fix horizontal timing settings in MHPORCH/MSYNC
> registers", I get no HDMI output.
>

I managed to get my HDMI output working. I had the lanes set to 2
instead of 4.  Once I switched to 4-lanes, the monitor came up in
1080p.  I haven't yet been able to get other modes to work.

adam
> Regards,
>
> Fabio Estevam

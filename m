Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB44EAA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiC2JGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiC2JGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:06:10 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A522C6C7;
        Tue, 29 Mar 2022 02:04:27 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b189so13515757qkf.11;
        Tue, 29 Mar 2022 02:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LLXUdiKn5zGolda6p6nU0L90Q8R5gkNG4kyWBHOgl4=;
        b=jTBCnavhbYn1qmvPUHSZTL1jm9rswjvhPFWBSrhkQ8JUg2BKFRTp3u8MQhWbNntjJk
         kWE64bCN2CwuQ+IpLDY12XYUuegloUCJmkQm7Z9r++kol/uizjkT3X6sVxQxxg0XeeMc
         zEYZqWrdRMZpCMuOMDMw7VwaO1XYRnh2Ejo6VVG3iyZXNnnf6Xt0YQPvoODywClnP5+j
         QSeJjbHDbF4hTXo/wPYlYdxyZI7HGC245S8NFDo1KtrP/gADZj/GCwpP99emrjJE7nsy
         lqTUp7kwPx2fKI5L8RLji47JS8nrzu3wy1xLsQokmA/sQZ+3MyE/CqjI3A5MbVcmqRKm
         zfaQ==
X-Gm-Message-State: AOAM531US/X3SXm3TWUgzfy2CyIh20N9HljGzjLL9xIvMzblwGX5tvHL
        0PSVD49bcdzfuq1b6Ouljy8fGEPISKnuuA==
X-Google-Smtp-Source: ABdhPJzDopCbNDtyCGoe9wRWBVi9hCb13ztEHXO3PZi2GQRQpiOxx1zNj6ekJUyjnx5gr5ruPqLNSw==
X-Received: by 2002:a37:b983:0:b0:67e:c0d2:c3ca with SMTP id j125-20020a37b983000000b0067ec0d2c3camr18640587qkf.749.1648544665921;
        Tue, 29 Mar 2022 02:04:25 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm15154223qtc.50.2022.03.29.02.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 02:04:24 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ea1b9b3813so70801577b3.2;
        Tue, 29 Mar 2022 02:04:23 -0700 (PDT)
X-Received: by 2002:a81:24d6:0:b0:2e5:b253:f9fc with SMTP id
 k205-20020a8124d6000000b002e5b253f9fcmr30366724ywk.438.1648544663596; Tue, 29
 Mar 2022 02:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <YkK691VG6ON/6Ysn@atomide.com>
In-Reply-To: <YkK691VG6ON/6Ysn@atomide.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Mar 2022 11:04:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDDNTgBdJTa8+H1H5v1gAarp07xxWu_E1JL8mXS8HPMg@mail.gmail.com>
Message-ID: <CAMuHMdXDDNTgBdJTa8+H1H5v1gAarp07xxWu_E1JL8mXS8HPMg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org,
        linux-tegra <linux-tegra@vger.kernel.org>, linux-oxnas@groups.io,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-unisoc@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-realtek-soc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, Mar 29, 2022 at 10:03 AM Tony Lindgren <tony@atomide.com> wrote:
> * Daniel Palmer <daniel@0x0f.com> [220328 08:53]:
> > On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > > as the title say, the intention of this ""series"" is to finally categorize
> > > the ARM dts directory in subdirectory for each oem.
> >
> > While I agree with this change and think it's for the good (browsing
> > the ARM dts directory at the moment is frustrating..) I think
> > buildroot and others need to be told about this as it'll potentially
> > break their kernel build scripting for ARM and probably messes up the
> > configs they have for existing boards.
>
> Yeah.. And ideally this would be done in smaller steps as these will
> conflict with all the other pending patches.
>
> For example, I have a pile of pending omap clock clean-up dts patches
> posted and tested waiting for v5.19-rc1 to apply. I'd rather not start
> redoing or fixing up the patches with sed :)

Git merge/rebase/cherry-pick should handle renames fine?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

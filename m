Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3724B4EAE08
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiC2NCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiC2NC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:02:27 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C77E09C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:00:44 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id l128so18966362vsc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3QBw7v8dFcqiPGnMNGvYxmkFShqWbPFpXvENucN03A=;
        b=VxZTK5h2ceMHc0/gkFAJptvPI0du5DQIRls/n+UwbaTdbHCDnM2ebVJ80dZR2rH4BU
         ymkj9X9JCvS/PSNlv2cauvXJ1Y/raQZQvlWyFCyrroGNFa7Dt55P8IvLV0zits5NgIo6
         mMDaxi4cJktMnNVJYMstrEU4sAZj8cNDh5/p/KCfVGzqYH5O4v/Tfg0IwPoUaJpx36kq
         u8EllufJwIGFJartxop8e9fN5dB7lChUsQ1lUjW8FkAKnSBb87uD8dTAu3H/+8whgVnz
         xC0YrgRjZgvqy2VLLNMa7t3snxpyTs7h7bhz7I6HNyPjd6p4mS++oB5Yx6hmRDG8ob3Z
         Gq7Q==
X-Gm-Message-State: AOAM53081Y6yrK6/e+mwYv2yOqzevT1F42fufVi/ey6jwHRvJ8sRoDhm
        jNt2TGJx3oj/wKeUrFSDFkjUhxmBm4XbjQ==
X-Google-Smtp-Source: ABdhPJwP+/HddBIDVmTI0IUF33YCTTe/lG2bn0t+siM28svMWfvfUE3xM+r6WPOgxtcQR8/FIoDxBw==
X-Received: by 2002:a05:6102:11f7:b0:325:ce67:8e52 with SMTP id e23-20020a05610211f700b00325ce678e52mr1009279vsg.17.1648558842949;
        Tue, 29 Mar 2022 06:00:42 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id l18-20020a0561020e9200b0031dabda5919sm1384459vst.34.2022.03.29.06.00.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 06:00:42 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id w21so7625148uan.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:00:42 -0700 (PDT)
X-Received: by 2002:a05:6902:101:b0:633:ccde:cfca with SMTP id
 o1-20020a056902010100b00633ccdecfcamr27067216ybh.207.1648558816249; Tue, 29
 Mar 2022 06:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <YkG6jOtPmhHehQoz@kroah.com>
In-Reply-To: <YkG6jOtPmhHehQoz@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Mar 2022 15:00:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6oZPBsuOyc_Pe=_rxJP3wPk65SfEdFEfqf5R-_RGqYA@mail.gmail.com>
Message-ID: <CAMuHMdV6oZPBsuOyc_Pe=_rxJP3wPk65SfEdFEfqf5R-_RGqYA@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc and other driver updates for 5.18-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 7:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
>
>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc1
>
> for you to fetch changes up to 37fd83916da2e4cae03d350015c82a67b1b334c4:
>
>   firmware: google: Properly state IOMEM dependency (2022-03-18 14:18:15 +0100)
>
> ----------------------------------------------------------------
> Char/Misc and other driver updates for 5.18-rc1
>
> Here is the big set of char/misc and other small driver subsystem
> updates for 5.18-rc1.
>
> Included in here are merges from driver subsystems which contain:
>         - iio driver updates and new drivers
>         - fsi driver updates
>         - fpga driver updates
>         - habanalabs driver updates and support for new hardware
>         - soundwire driver updates and new drivers
>         - phy driver updates and new drivers
>         - coresight driver updates
>         - icc driver updates
>
> Individual changes include:
>         - mei driver updates
>         - interconnect driver updates
>         - new PECI driver subsystem added
>         - vmci driver updates
>         - lots of tiny misc/char driver updates
>
> There will be two merge conflicts with your tree, one in MAINTAINERS
> which is obvious to fix up, and one in drivers/phy/freescale/Kconfig
> which also should be easy to resolve.

Unfortunately the conflict was resolved incorrectly (next-20220328
did have the correct resolution).

I've sent a patch to fix that.
https://lore.kernel.org/r/20220329125631.2915388-1-geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

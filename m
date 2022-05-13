Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D677525C87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377866AbiEMHtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351043AbiEMHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:49:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3B134E22
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:49:13 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8VkX-1nuLnd05OD-014TRP; Fri, 13 May 2022 09:49:12 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2f7bb893309so81570147b3.12;
        Fri, 13 May 2022 00:49:11 -0700 (PDT)
X-Gm-Message-State: AOAM5316YKf+gP57DY3fAo5OEgITAsx+0IwWF02SZuKIGMIIjT8bqDqU
        NYer9JQ+OJO09tRRq1cbPmXRu1jv9452qZ/UMY0=
X-Google-Smtp-Source: ABdhPJxFlTtlbVt8Bapilb2mz1n3siKTHBGzN+uJGcJLbo3/z08lYLAGD7AIepRl493ydddcUOdI8OAt4TkJKfkDI/0=
X-Received: by 2002:a81:54e:0:b0:2fe:c027:1ca7 with SMTP id
 75-20020a81054e000000b002fec0271ca7mr118018ywf.249.1652428150734; Fri, 13 May
 2022 00:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220513064952.3610672-1-gerg@linux-m68k.org> <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
In-Reply-To: <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 09:48:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2HpzBEy8F5CyJp0EbKcEmZdPivjjBmHQgh+mOAq3YvpA@mail.gmail.com>
Message-ID: <CAK8P3a2HpzBEy8F5CyJp0EbKcEmZdPivjjBmHQgh+mOAq3YvpA@mail.gmail.com>
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wSTf2c8yDJ/USo5n23QI1JUIkHDbjZEBjCvnLQ+YpEbzdzjeIMU
 v1lOFjbxQXUdakvLzd/Pdm2aK7avDXmLQCFZFIzi31kpuxej02x984xF9AGSEy0GVP8PEmp
 WpFEkny1/+xIFNDtznAtok4wy173XsZi+Vrhc8fZOEHXJotAIk2UuSFmHU1+XAwTxo4QS06
 lAwhrCBoRUPO0nlmv/BGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XhwSw5P9egY=:7MoH35VSskeSdERSbMUy6J
 UToL1lUzY8WifIkC7qNYlijg7Iip9CL1lxmtUBaREYiKjk+ZijjMP0Zv/tkLVijqiRXy5jw1Z
 DTnZxQ8QXPEpvjJEFsrB1K/foqclpr03KKKTtx2xf0/MNz8rmmIMm+EXg0561Ao/3VY3Spmce
 sKKNBB0Mpk6tYNBqy4bAPHryR8VjaqcTsssDkyR9c4/a4oBRE9f62hxtFNSDl/GFs9+SKsa/F
 DoqH/NBUL4vWjXcm8YIQ7tVYNwdQa2o5zTFdHXt67FHRpE1OluyXKz49a/QYcv/O9Ur7fNPsj
 Qj9tLYj8Qi3il4nFxmUH8IMRnOf1J104aXphNF7Q5+GP47Xa/Sjgt+sC2VVe6yhMZjlsM73qF
 936Bz9YaJMhnp3dw2garKAthFh3B/BXVH/AN+/BuF5397IIjHrLOr/kM44x5PTKdmO1Q4Dese
 Vj38Gle9YlYORU/j273b8lVv0XPG/7Y5WcY1X6M4INWTAvMdGuk0j/eoklsuFa0QE2ymYdydt
 qlttV9QwOb8+H7O2A6Z4V6Fs3MQwlB1FjieSVYrF1AfP5qHrwP5eLoq9RxzZ32+OCxQrJUBgl
 o3sAJAhJy6fN6JZXnQBX7Oqc46snz1luVeyZxHw5KeMRQUTiTJ+KePBRaQ0ry4/AryKKBefqC
 uYMUxuX5RSLvyhSD677or6idQoW42c+Poci8ytIjNk+JDrFDMabMgNQFIz04QGRgIH4k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 9:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > -#ifdef CONFIG_M68KCLASSIC
> > +#if defined(CONFIG_M68KCLASSIC) && defined(CONFIG_MMU)
> >  #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
> >  void read_persistent_clock64(struct timespec64 *ts)
> >  {
>
> read_persistent_clock64() uses mach_hwclk(), which is provided by
> both setup_mm.c and setup_no.c, so it's always available?
> Albeit not populated by coldfire or nommu platform code, so I see
> the point in depending on MMU (no nommu Amiga support yet ;-).
>
> Perhaps rtc_ioctl() should depend on CONFIG_Q40?

I think the best cleanup would be to turn the q40 rtc support into a
standalone driver using rtc_register_device(), and completely
detaching it from the rtc_generic support in arch/m68k/kernel/time.c.

        Arnd

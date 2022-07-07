Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A830756A354
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiGGNRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiGGNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:17:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2662F3BC;
        Thu,  7 Jul 2022 06:17:32 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQvH5-1numNx1zxX-00NwU8; Thu, 07 Jul 2022 15:17:30 +0200
Received: by mail-yb1-f171.google.com with SMTP id 136so649075ybl.5;
        Thu, 07 Jul 2022 06:17:30 -0700 (PDT)
X-Gm-Message-State: AJIora9wVMgSkeYa2Fw1xQvY0SFiYMk4V9+IKUHeyrSWpFDHcdk1GB5Z
        Y6Th2gPSHMFmfUIqxL3FaTCQw+c7GJ6oEUvRH3I=
X-Google-Smtp-Source: AGRyM1sIVP+sKzdVYFj+QYsC1OY+fEPgMo3nlsTTen8lbyAjHTJh0NZ0UhttkuKcfl2p0A0KvTfiIntFQ2qrS/pVGTs=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr49906358ybq.472.1657199849284; Thu, 07
 Jul 2022 06:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220707112645.5147-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220707112645.5147-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 15:17:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3f0H2gnZFCah_HiNTdwyp4pLKd4w=yN6-0FxrF2+3ihA@mail.gmail.com>
Message-ID: <CAK8P3a3f0H2gnZFCah_HiNTdwyp4pLKd4w=yN6-0FxrF2+3ihA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark ARM/PALM TREO SUPPORT orphan
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6u4FdKJKUiHlASxckZ1Jifeq3AQjDM5G0/ugNCBj8mgO+YqCLel
 v58mLglqbrK/wJiI4tX2JHbGrc8//2LvSwyzBtWRUUOYAeshZ5CSTw+pfdBrZbIwS02vIq5
 Dv22moH2R/ROiZvhHRJ2ycAgytl4nCil+1hwxbGpyxMWOQPFkXfGaG/hI/UtxW+PyLO6jul
 6WuxKTQ4X67dWXC1N8K+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Qf4fi8A2iU=:A9WWyXSH+HP8nUgm7HFrO6
 CLVT6IcAToedOH9/oA8sn8opuqqlRhNykUaTqShbM1LF9d0aZRo77Jlro/v6KjBe1gJ49oLkT
 Sffkn4Oze0iBOgg5FPCyZwUaQRAGs5IntOK06LghbwwnkuaOLU2Lp3p7fIfgMahUyWzMMSAbE
 fCXHurvFQlg7Ot1cZM2EFx4h3soI+AAt0430+cxKjhG/MZ/Su0vorPnYX9ZQeuh7/rs4dgHMp
 TGEgX6wPbJOsC1eyjjT4a7rUPK7xlQqOQCzahnPTky2v1+/Ur08AoLDzbN6cFvSXN/10RVmAG
 1BWe1OswUZYGzJ9BpBYG115wvqxQRAxFTAch9rNJksNRxYU76R6yUtLlDdutLb/foGaK+Y6jd
 HcAZBgbA9EizGw9nq29Jq932hydDhbGgfLXHE/WaA69TgJlQBj4IT4KAghWbSzwfXGcM2ouRI
 2no2JBt/n7dmpTSEvnkU/dcvu7Vg3TzVk4upLsYDth9HWfd8+e89GuhtKx8DeCXSCoTjwwxLm
 tcaT2zp2IXcOxGHkhTFDe3+6P+bnLEYtkQwWl19HM8HOWa2ibdhoi71o7JdsuaDn751u8DH9e
 a+2RcH+g65OXRJE3w+z8VMLMftz9LMsp5+uIspcuHCVHKZVxi1JdTyfa3T1sEkraOC4OJOfNR
 dgePqkNRn8/lbKOKqNvtqAtpYbhK/ay89rDH5jHP+JcgZFhX1zjlC2E830dxQgtoQjrXlFO6l
 h/OKF+Kq5OKQd1YUgqwtJ5rACaOBiyoZY0MWDRHH5UdB96UMzPjzqzC2sUBDMn5aS4/jyCnqU
 bZsrZt0tLQQVhD9zqF/WemLgipgyoHyoSdx/B7zV0w66q1sNZtbPM/WJphoTI5Ill+08kOwF8
 C4rK0MTWKz9ICOmZyyTri4T8NJGNmYnES0WbV9ris=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 1:26 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The email address sleep_walker@suse.com and the url http://hackndev.com/,
> provided in the ARM/PALM TREO SUPPORT section, are not reachable anymore.
>
> Make this machine support orphan, and give somebody the chance to step up.
> Move the maintainer into CREDITS to keep the attribution to his work.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> RFC patch: https://lore.kernel.org/all/20211229191828.21317-1-lukas.bulwahn@gmail.com/
>   - received no comments
>
> Russell, please pick this minor update to MAINTAINERS.

I usually take the platform specific MAINTAINERS updates through the soc tree.

Applied to the arm/fixes branch there.

       Arnd

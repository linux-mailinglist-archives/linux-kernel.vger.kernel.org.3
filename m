Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263051D1F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389140AbiEFHMO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiEFHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:12:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0366F91
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:08:27 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmDAW-1oDAOw1KDo-00iFcl for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022
 09:08:26 +0200
Received: by mail-wr1-f47.google.com with SMTP id j15so8797537wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:08:26 -0700 (PDT)
X-Gm-Message-State: AOAM531/9RJcscNm/LRQYFtWTq7xzfoBRrcKGUPwmsaVYrVomEeglH5F
        nb3Fco+wbwykUU0XQWt25hJGSbG0gB6PNYrskoU=
X-Google-Smtp-Source: ABdhPJyxQL7zXUvqc8Kd4IsKQ8DDXXLoN0a7JzRoOljSaWzZBetR0EfL9eTA1FbUSvR8gVY1EVpw67HhWtjipCJXf7Q=
X-Received: by 2002:a5d:5986:0:b0:20c:5844:820d with SMTP id
 n6-20020a5d5986000000b0020c5844820dmr1442079wri.192.1651820906011; Fri, 06
 May 2022 00:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220506022638.15864-1-yuehaibing@huawei.com>
In-Reply-To: <20220506022638.15864-1-yuehaibing@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 09:08:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2iPwOaRgrW6gw+8ZvxwKDROWFtoCz2LLF9RFDuDrEcJQ@mail.gmail.com>
Message-ID: <CAK8P3a2iPwOaRgrW6gw+8ZvxwKDROWFtoCz2LLF9RFDuDrEcJQ@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Fix build warning without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:CNiqlD/xUWb4ReQRrIpAB3nFbgvHzIzdacbOuXOTOWu3XApThwU
 ve8R52qBZnzuhc0zXsmvrJDiIkJ6PelWR5nAWpTWrV92PbT8M4RadB14zX/NL4ooAXM9nlu
 ptFXqUW7rFkTma2ggpUllGqhvJpOMWS/IsNcFWwawPhEh0Zm799aZJRrHazek5cLSsodqyD
 jpXjGwIp8QrQGkLy9W+zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xq5bWTpBw9E=:cwyDe8LkUmcOy3ThB0PWbV
 r4zNRg5WHNN5SvQVXtdP3uYVhnRgyGcx3Yr2+ChtexUnqZ3sulzSXZQGtkIJ9sUoKB4nzTW5b
 v9DpMX9MBBf8n5iRqC18LKayCJjOebf6c1svte2Epj2mz+zj5su+xYu2AAGwMf1wHnz/LR8Yz
 Z+QEXkL//gqlmr3btBR1+3hXEnlm+LGFNQfPcozOdxzErvyYTqoNXfPAZStnLks0EStVNGks+
 lZmDtWbSdURKIEQ9CJowUhG5YV8k+E1l+a/RpClNYyVzf2PtyzPa1KROEEu7MNBpnCEeIwC0m
 dzFJ8BoPDuw7K2zQSKQmXMkytKN1CPsPL3+I7Yx7RdmnX69q2YGJeaUg1OiQ7LJ6gd1NJOz40
 87+BJu58lYtxcOh6ugvMQ8wyTErjRf/sN4M63+V7uKq0Xsp3QZySZDO6FAtBLeVsoEVl69V1D
 dOZPqkhb+pFByNy/awT1rm70350bEB3kyJwdOLIJY+ptbs2N8waI3i62wukfBwNcc1T3oShry
 1Ta7kuuZ18ZZcqfIs9EZ4+USreKHGN21oO32GhbA1kbt0Pl283aNpijl+ZdhCL8AGcaXtl3/B
 zXJTQd10IPGaESNYHJEpI4WtHYm0OQarwlxsCRZLZRQJbTD1Yxs98wS2rGpNFq8EG2ZELdYrL
 MhFlWdEXNx5FLZht3FgH5m2CHJZ09fywxptERfvqwwN0tlp+3CBDJF3SfMXoXBwG++pA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 4:26 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: ‘mt8195_mt6359_max98390_rt5682_card’ defined but not used [-Wunused-variable]
>  1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1634:32: warning: ‘mt8195_mt6359_rt1011_rt5682_card’ defined but not used [-Wunused-variable]
>  1634 | static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card = {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1629:32: warning: ‘mt8195_mt6359_rt1019_rt5682_card’ defined but not used [-Wunused-variable]
>  1629 | static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> These variables is only used with CONFIG_OF, move it into the ifdef block.
>
> Fixes: 86a6b9c9dfff ("ASoC: mediatek: mt8195: add machine support for max98390 and rt5682")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

It's generally better to remove the #ifdef rather than expanding it,
there is no need to
save a few bytes on kernel builds of this driver that disable
CONFIG_OF. Just drop
the of_match_ptr() macro as well.


        Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBE51E5A6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446094AbiEGIqp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 May 2022 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353489AbiEGIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:46:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950A3F304
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:42:55 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mcpz0-1oM2sW0TXG-00Zy7Z for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022
 10:42:54 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f83983782fso102669887b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:42:53 -0700 (PDT)
X-Gm-Message-State: AOAM5322CmA4jcmXJFqubLD/uuMF9qvN0HIECDP4MsitlvhBxfrqvZvx
        EI65BsGjoxaowsR4hGcxGdKmY4Q6whdy2mue2L0=
X-Google-Smtp-Source: ABdhPJz41aUj/+pW1sZWxLrXajtnNs3IdnmCkPvNJurEZtj0IpvMA1ea1Z+O8FJy68YG/6GjY7AECeBWF00pOfGqm4g=
X-Received: by 2002:a81:9213:0:b0:2f6:eaae:d22f with SMTP id
 j19-20020a819213000000b002f6eaaed22fmr6217535ywg.249.1651912972980; Sat, 07
 May 2022 01:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220507021424.12180-1-yuehaibing@huawei.com>
In-Reply-To: <20220507021424.12180-1-yuehaibing@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 7 May 2022 10:42:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3haxtEjZL4jZ9a1xbZdEGAgG=NxDwWQ=syvQArett2Fw@mail.gmail.com>
Message-ID: <CAK8P3a3haxtEjZL4jZ9a1xbZdEGAgG=NxDwWQ=syvQArett2Fw@mail.gmail.com>
Subject: Re: [PATCH v2 -next] ASoC: mediatek: mt8195: Fix build warning
 without CONFIG_OF
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
        Arnd Bergmann <arnd@arndb.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:aEO9BWrzheQz+hIa4c4SSMNuFnz/+haayRgUjvx+Zdc0IImKCIi
 JO9oYhtDNI9CSucFvKMNKyIwrSfjdNk0RPllSBcqtHWbK9wHTWyjn3352SAMAfEgc3MF0EQ
 Azqad6qGUPzwbOCTkWoI5EMd+NjpHk0pxm2bgmQnhWqA3km37x1b10ICEm+58hM+mJhMvu+
 /6NaVSkuti9fPGQYuwz6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YgdEmg4tKuM=:a2Vtn7rv1eDzEUKV9sty1M
 IuVP9JW4hPq5tyfUzR+rxMGlrx5bE9t4EvfPujqYQbVRgd1qdwaQj8Fgkm3juLfBZGtXTcNfq
 SwGqZYlaourLDMmTtMxwSFrsy7QIKiJi+qaS2y/KXYRQOZePSeNguzUBJudJn62XuDc5JyMjd
 d0Igzc7IoN3y1NYlXcpcALU6Ihw+8hCfqs8fbjGKUW0tHcF91SYpghIghveCK6HHKMJiIoYTD
 vfVUVR6Q86DOeEO2RQO1v7qhqDd2tDyzgN5V/LifKOLxJqOMLUFjbc4RCVNA1Jb0zk3nB5ALA
 Jx9Cdze8UvwVUFRutKv4ySs0KbtrykA+iaci4QsqS6NqPmz116MgoyoCQxXAC1IlT4iHzmpx5
 2h4rKY70r5NfKknIF4k4w6Rk/0BGf9Kmj5ygrxTiaIkc2lW019q311fu0mu52e+T0kkwWsR32
 wyTAj6w3kqUPXo8EhayVn/VX6yKrjdTlz0m2tccdbQ9++kiUuhQU5hKde+NKSmY4kh/oPL50F
 wOSAmqabtF3NK8rQSHB7YtDSFjJOTr/vmmZLZvbqM+nxnlqpMTBFI6W7RE4MB/ar0eAUvz6rT
 qdGhyVq08IAYrsU2SdhNcWFFFiyy1JW3K49DIZbwGC70XROe89fSQSJqfM5ynVe//p6aCQXw8
 voJA81MMBRS677t30MAy9y4vtN38YkE7GuvWYYfW61aBAK6dZhJPJKGESr46ACh/ZsS4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 4:14 AM YueHaibing <yuehaibing@huawei.com> wrote:
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
> Since all users of this driver do need CONFIG_OF anyway, there is no
> need to save a few bytes on kernel builds while CONFIG_OF disabled, so
> just remove the #ifdef to fix this warning.
>
> Fixes: 86a6b9c9dfff ("ASoC: mediatek: mt8195: add machine support for max98390 and rt5682")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: remove #ifdef block as Arnd suggested

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

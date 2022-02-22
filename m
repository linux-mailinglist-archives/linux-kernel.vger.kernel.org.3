Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A64BF997
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiBVNlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiBVNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:41:53 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDFC1081B5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:41:27 -0800 (PST)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M26j1-1nOyOS1Iqn-002U9c; Tue, 22 Feb 2022 14:41:25 +0100
Received: by mail-wr1-f51.google.com with SMTP id j17so6647561wrc.0;
        Tue, 22 Feb 2022 05:41:25 -0800 (PST)
X-Gm-Message-State: AOAM53253vlgjUczge5LNVq1b0GVlyTXiEt0v6mUwufIT8DSvpbz8lS2
        G9gR5+4XF7KojTG8bTynHeF8Afa1Rn5RDwGokaE=
X-Google-Smtp-Source: ABdhPJyr+2RhXG63IhBc5XIrliIkimhF56LiOI66mJ7uVY+o3TbaU5WI9zGAVLchk95JIXaawBejBzGFhacNF+x7UJA=
X-Received: by 2002:a5d:59a3:0:b0:1e9:542d:1a35 with SMTP id
 p3-20020a5d59a3000000b001e9542d1a35mr15302491wrr.192.1645537284771; Tue, 22
 Feb 2022 05:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20220222114203.686638-1-broonie@kernel.org>
In-Reply-To: <20220222114203.686638-1-broonie@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Feb 2022 14:41:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0EhPNp6HCJuwJGze1GxdbQpcbYsS9J+tqC1yt2Z13W_w@mail.gmail.com>
Message-ID: <CAK8P3a0EhPNp6HCJuwJGze1GxdbQpcbYsS9J+tqC1yt2Z13W_w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mips tree with the asm-generic tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MxGuVEvjMBhMOPKTUFNMp8hTQ2GOBUY22ewzWMLQtndI6zCrXaS
 mLQRfIuWO/WA/RWvDVa4spH+Yf+oWyJ/MmTzrk7vnBJJbFQPvMYMCTFRuS/GDBFscEfjcCk
 NRR9GeBtGyrdbq71hF3J4tYfeP5OKl4ejsl01k7Hpn5Bo/i8dPJGxqswYGs86hIgVmzgCuY
 XX+hN9Y2DybxYX+YlCrvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zpY6D7qUkeU=:XO4NvpveeiX7kdS0YUyEma
 U87zz9QZW9UUZgGM2lg9hHmQfuhC33G9yv7o3BSxkYlRpLD+JE7R7jA0FHoY5aQ8BQFmpx/y4
 tBjv7CBo/49nlyJJ51Z+wDxoucsPVOwXZ+V1vF/1kmFRi+GhKvReBNnJGTFLKuRrVUFhr3tlo
 fowbXpujiAuLA5DzQfd2OBVQSWvzpmaA+1YTjXVrcO151YR7EV/6Km7ZVxTagAISGbrTrrxgQ
 cCycHJmFvVjQ0i1aVr2CtRF+m/xIwe4qxVZtWqgrJles9t+wMDWUB4S66QeexTJN3tYU/+6py
 DSc6d7l/i0W6jQLhVZlMOzT/Km26WDXmluf2F7Lg7D0bFqykA9GoRIxm0oL55SCirlh1AXlbY
 jPyxWrbdMXZWuW9IuMdDfDF4IodaiVo8pbAJ+15zLTP2v3+R3koeZkGhf8yaR0oyalBvqB9p5
 Rz3+TezSlaK17owFsrrohOpxi32YK7ICrboOJGoNBBPcWi61IZ9OekCbHJWcUzItCBrpwc4I0
 dafgymf44RH5ozAXSTXJCbMapWtN6ylI3+KMtue+WIp6T3zM/paNHyjAQ2TFDRNOuIs33lY4Z
 hPN8Cv85tVEP4DCp7rpbYq85RTDAR1BtIl0E8bjJqMMX/NSIVFtq17CxNa/h+b6pv6E+BEWPr
 o9hbqx1FahtRJymSGpsnPUOUfC3y5TM7kLswwKo4YuASdit4qTdHgxJ+1OA8vRQSqlGg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:42 PM <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the mips tree got a conflict in:
>
>   arch/mips/sibyte/common/sb_tbprof.c
>
> between commit:
>
>   27e8140d7819b ("uaccess: fix type mismatch warnings from access_ok()")
>
> from the asm-generic tree and commit:
>
>   10242464e506b ("MIPS: sibyte: Add missing __user annotations in sb_tbprof.c")
>
> from the mips tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the report. I needed to rebase my tree anyway, dropped
the duplicate change from my local copy for now, should be part of
my public branch in a few days when I send a new version of the series.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243844C5DE7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiB0Rwg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Feb 2022 12:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0Rwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:52:34 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD7A5AEE6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:51:56 -0800 (PST)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McGtA-1nwL150b40-00ce5b for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022
 18:51:55 +0100
Received: by mail-wm1-f41.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so4558195wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:51:55 -0800 (PST)
X-Gm-Message-State: AOAM533oCtQy9HPo7knX3mYM1136riliOxkKOc4w8b7UnOhLXRaXz1iT
        13Iqc8Ri0WuGqKcwGrSB3nhP1RLYascgn1Dxvtw=
X-Google-Smtp-Source: ABdhPJwugkJcuiIV8A+C+FZBvXEsLZf1VOV/XY8mOV3k6yHO2nwlo+GfZB4ycERAieoxG5A+rEp6EMhfGWt5u8ULX+s=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr10637984wms.82.1645984314782; Sun, 27
 Feb 2022 09:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20220226222457.13668-1-rdunlap@infradead.org> <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
 <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org> <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
 <0D5Z7R.NUOWBMRT4GQ2@crapouillou.net>
In-Reply-To: <0D5Z7R.NUOWBMRT4GQ2@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 27 Feb 2022 18:51:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3=5uud3jd7N3FEAnaLapX-0OYaiscBFNEQm2hzkTmj7g@mail.gmail.com>
Message-ID: <CAK8P3a3=5uud3jd7N3FEAnaLapX-0OYaiscBFNEQm2hzkTmj7g@mail.gmail.com>
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jPbLlFCcLzNP9jqcC4nPPobKsS+39MyIPltCDIyI0piBR2FwYMD
 5MMku5ADGwp8SVXTVoIRjXvxZh8L75NcGl3p3HfzVQ25zVxkftoUIf6SEzxLi+v7U/UoiO1
 3TmgHqkdBYyQ6kvQtgeLzADll9LFro77giLYlTfgQSXgpThE1qmnNuvScMuOqgsHpRe9lKP
 zweKhKdUX3VGGaVTaoO9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kDptffftpv8=:WiVD2glCDHkQTN2nCxiw9E
 mWilfzDjXomKLXcWxjIN2VHzWP3ER2luFvPc1k2xmcMWYzsokTwmzz7OKVqotEH/pLkOloGcz
 Clvz7J/5safZnfWPJfu0J6JWnvdiwb/496+QqRcAQ3OxTPbUNOcoiRkwZgcQFVRWz3MSXQUrI
 BEASAoaQ2AIWuw40j1tis5zIIn6qCVnL1lOMIx5JLCCbwYHy8xax8jqlBnPtkOoMyVLBaWeJV
 xofSi9cCzhalPkdfa0fxcCBvpg3nrkU4xfxKfpBBfXrJO3cS0LORYHAMfsGl/qKZDmxeEJFWo
 zd5Uk5xd0LW7hGsP5DzITSgUUl/boEN3uPqKXINkg1PqQxukxjRuxf33JmzohlubrPuWeJEa/
 FKeNsPk76tdpO3NcEa6qm6oj2bbPlQMA6GSYkiALksyWGyvFyp6c0p4GJr0f7YHuaCBLx+vGJ
 slNTvLHLPzldPNk6+0ejS8O5adX5Px6dJNOwV61Knznad2bgIntlbvuQmZ/mjGkBQ94teKvNe
 YESfKnSpcH2y9N/Om4bVIN1YJstAcq60xKz8raj9izu2BCNzzOr8yDwQvDgSnSc+ZHEod3hI4
 LcGi1gzd/+gWHpho9b9EeVOW4RND3E54SQUumu8oBiQrdPbDhVk1KoyzTT+zuiAfdZ8zCkcif
 ShqjgwMhjUhH7wlG0tfP1EyX2th9MGg/3FYMlc7g9iwo+Vu9P2pwKmmPJO6BnhMRkA855Uw49
 cLonZVbtWUmEioKxnfK/BLK/4ZQZqMQMGFvf6pmAGSvCBlmTzoDod11m+o5EgSlSxudpjVTGh
 kNu9nBK70NnlbMRO3HNAFrDksg/KDr5c7cyeGYewk4xgYnD1UM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 6:46 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le dim., févr. 27 2022 at 18:30:16 +0100, Arnd Bergmann
>
> There could be a DEFINE_DEV_PM_OPS(), but I don't think that's really
> needed - you can very well declare your struct dev_pm_ops without using
> one of these macros. Just make sure to use the SYSTEM_SLEEP_PM_OPS /
> RUNTIME_PM_OPS macros for the callbacks and pm_ptr() for the device.pm
> pointer.

Ah, of course, so it comes down to
s/SET_SYSTEM_SLEEP_PM_OPS/SYSTEM_SLEEP_PM_OPS/ while
removing all the #ifdef an __maybe_unused annotations. The pm_ptr()
in driver.pm makes this slightly more optimized AFAICT, but has no
effect on behavior, right?

       Arnd

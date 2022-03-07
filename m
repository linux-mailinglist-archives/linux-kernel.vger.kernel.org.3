Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAB4CFFAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiCGNLx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Mar 2022 08:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiCGNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:11:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6456E54F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:10:57 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1x2P-1oBvwU3egr-012KH9 for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022
 14:10:55 +0100
Received: by mail-wr1-f41.google.com with SMTP id u10so21565162wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:10:55 -0800 (PST)
X-Gm-Message-State: AOAM531o+8Kx3rHdcBCVgyGqZuiZq3/wmMY25CzKnVBB33qYoKieCTHq
        39BJWNfqVGg4eoUbrSqjdODV8GuEbjoV5AFcut0=
X-Google-Smtp-Source: ABdhPJwTx34jmJfLDWjOnHVKhEip3RUgR+Mvrr67EPb6dzbty95WKubHaZ11Yl2wZxrMue9sQ0pwft5xMjMOGBUclZU=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr8692015wrh.407.1646658654942; Mon, 07
 Mar 2022 05:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20220305123116.26828-1-yuehaibing@huawei.com> <860002a4-4e52-c399-fda6-054fa64df3ce@csgroup.eu>
In-Reply-To: <860002a4-4e52-c399-fda6-054fa64df3ce@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 14:10:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2p+Yryg1y5h=kTLP72WGYc2d4qctFuW+opR6F=1uYJPw@mail.gmail.com>
Message-ID: <CAK8P3a2p+Yryg1y5h=kTLP72WGYc2d4qctFuW+opR6F=1uYJPw@mail.gmail.com>
Subject: Re: [PATCH -next] powerpc/spufs: Fix build warning when CONFIG_PROC_FS=n
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hxHiOWB3uoOvLr+J/OFJRNwdHybTaWx4ZLUpcs7OThwOTAFXq55
 kaqMl2hg80O2Q0vssUM64GSRKsOTDi7ZVKzDTQlsOwVoYA+OU4WdcMN4jbkCib6+QEzsBUg
 dP/bXmrWMa1zq1ct8n0lV2fr8wPL/l0a9RoIVLYFzjcu4MVzJXblQKncyU2wIK2TOa24WHE
 yEeNoFzb3DKZwJ937yAXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vWG8kEpXy7c=:1uNFLYrUy13vhWw/kYLlyG
 pYqRiHy7I1jNBhzbHB1uppGf4k6vceFBQfyKg+kQmo+nENQfOB36oud+Em99O6JdDyIsHYPaI
 ufVOA+ZZOJe2vsm+th50gqv5zitilmph55XjjIjB9PgDwKxpkUslnED6RBvrLyylk+tptaVEH
 9S8L3ElvTcaONBH31EAPVPhUXDhnYPCagotBYoTv1WQH/b0an2+Y7IeukIApuN3JPNOUxSHbv
 lPHfjxJP/QtaGy7A7ywZw7HeQyvjLLnsNzFarC/KBqoe0iA9pZ0uPWJPcdia6BRPtL/hZ0EJk
 H/984fuIuH08lj0y3imBU02ZqArn2FRk/pFfh0IuqF0U1D14PFDWDsOnJJ6TIBiwJrewN1ou5
 g26cmfyyB5PcvS89lJbzxjIHF9bR4VReh1lJyldzZK6XQ2ndmq+7iLw4NWX8jbMXyTAYMr3ym
 YNJ6c/AJE/mvR6IYNxGAifxis6sWeODdCShDPjY4mhfd0FD5eXMCrQ1sqiCoF8B1G2GmOkMYB
 6EaDeB24zFoZ8vMJvFRPyofZd/tnp1xttK0ArXwdJjJJ6D3fJqfWGxUergCRqyL3GtHOszhp3
 7KPvydtSyFVAcFqTKSWQsg+juIhHh8ZFSbrH4tDVy42W0k8w27R2twNOGNP9tQcJEZ/y30wV+
 w/wSIhPGoipLxVfuFjfLcmg+kcuW0g/tpFIDSuY4qqpSveJ3hjvXoCfxjbxD8GYw78vq9URsn
 fQ8soGscc6MYcjJkJyee7LihNb3YnHGb9nYl1zEeK2DY9qGnJE++QARR2D7QWaaAyo2aIbDpe
 Jtg4rODchDVZkx2L7XB+Hzg6b17PzzV8uKoyZcMg/ba+xq7zQ0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 9:04 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 05/03/2022 à 13:31, YueHaibing a écrit :
> > arch/powerpc/platforms/cell/spufs/sched.c:1055:12: warning: ‘show_spu_loadavg’ defined but not used [-Wunused-function]
> >   static int show_spu_loadavg(struct seq_file *s, void *private)
> >              ^~~~~~~~~~~~~~~~
> >
> > Mark this as __maybe_unused to fix this.
>
> Marking it as __maybe_unused doesn't fix it. It just pushes the dust
> under the carpet.
>
> proc_create_single macro should be fix to avoid that warning.

We discussed that when proc_create_single() was introduced, but ended up
not doing it that way because there were already a lot of files using an #ifdef
around the function definitions. To change it back, one would have to audit
every user of proc_create_single() and remove the #ifdefs.

        Arnd

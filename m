Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8712658D568
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiHIIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiHIIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:32:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6F1F619
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:32:45 -0700 (PDT)
Received: from mail-ej1-f43.google.com ([209.85.218.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhClw-1nhIp41hvW-00eLLm for <linux-kernel@vger.kernel.org>; Tue, 09 Aug
 2022 10:32:44 +0200
Received: by mail-ej1-f43.google.com with SMTP id dc19so20876909ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:32:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo0SUdbBO4Dx5cLdbJed7Ph9yRC7icTRVU6HyDFyCXruhFTTwM/U
        VE6wEbCOkJfvXtHmDoDSGU7HKBjaPAEQZuhhL3Q=
X-Google-Smtp-Source: AA6agR4TKFxtd5LiYcX73HbGF2u7VeVKCRTYtwOOZ8D2bVS25LcWy9weFOVCptPzjGX0tAq94ORtgLDqHbENdmCFPc8=
X-Received: by 2002:a17:907:7395:b0:730:b636:2c89 with SMTP id
 er21-20020a170907739500b00730b6362c89mr16431662ejc.547.1660033964094; Tue, 09
 Aug 2022 01:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <YuvctaLwRi+z0Gw4@nvidia.com> <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
 <Yuxi1eRHPN36Or+1@nvidia.com> <CAFCwf13QF_JdzNcpw==zzBoEQUYChMXfechotH31qmAfYZUGmg@mail.gmail.com>
 <CAFCwf107tLxHKxkPqSRsOHVVp5s2tDEFOOy2oDZUz_KGmv-rDg@mail.gmail.com>
 <YvCozvgodIY19LSr@kroah.com> <YvFOEPdC9r8QBH11@nvidia.com>
 <YvH9X5puer4jpzMX@kroah.com> <YvIU/wMdqFA1fYc6@infradead.org>
In-Reply-To: <YvIU/wMdqFA1fYc6@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Aug 2022 10:32:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3y2=FyzK4S6MRfZdrz=DdLat1ajdT_uPmN533mNYmF9w@mail.gmail.com>
Message-ID: <CAK8P3a3y2=FyzK4S6MRfZdrz=DdLat1ajdT_uPmN533mNYmF9w@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5E5bCciRIBKhYs8DONl/B/spZHbKI7r800+vqWgPu43CFVIOFTu
 m2StS3+sqLXuHOo9PcuJi0uizp1xuIpFG6dXqa+rvxrDTcbOG/AEwhAXp88JqQZJjNj9cPJ
 tzkRCQwdinppWbVwxCnUmCDiK+VcoDrrm6IyOYtVkQHW2BS03N5ddpARgSMgyJFJ23G1979
 RT82PSVuQm1sorbhri/4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IUbD/5MRfm0=:wORYGYWlIPTD4JBHNA62p+
 3os6aBT/RUwOOX/Z/Cw4P0+W8uGghbFBflZDNfEPPuUuRNhjKAbmidj85wPGOElfvXYBBSRHP
 cwZ5e2zaX2NiWltTR7fr5VJPXeXfyl2GNZQWmITZIR4yfcF/D4DNyAhRbwRpnbRQkkyEmeWSR
 Na5gpN7JO0SPG+z2gFwLtClkLcKw3CuTWFyKos354aJ2NJ/bdYXh4x0dqkbH56uJm1+13IE7R
 qWKtcuTQzvH7YwXi+9a9QjIKUkE1pCuEgOOaHz8MXeBvLIKFI8Ic+EjTwbSgClD5Zr2FXs16d
 5Yuib6Ce2gPPGsFWEQDOF03A/6iU9kP2g+2142TUy0HBl+NTH3lD1JMDYZYY61rIrSIydNClV
 wXTwwSiPyoTeyLOEjzBPJz3wlpkwHp8z821FGBPmA0gVvHYG9bcZ0v2vwOSnIzmZ953mnC3Ae
 hoGb44NuJZmQ676y6ZZODnxwj/93555iAsP6aR9/4ovGAAmjfKJb7OaFOLYu6KSpc0Dkbf+nK
 dWGbj5JrxKSimhWh40bHBekG8mIZXAJhe95Raw/J/mdEy45hdntpuBqXlUniOQgk8k5t1T2Ot
 dzqGW+LtbaW9Oq0OjBdZaD8KZCXnPK5UXriiIrnTvfLi8rkN6HcJF6uavJ7Nfbv3+xpsZzjvE
 PIrJ1e+i/5luDUZ2gKXtScXSzQjyQ1tT+rePW4N13p8YN6Q9sVEMNl4SS9LsXj/TRgoddudyr
 wk5SH2HdSM849NVt5Yqd5yOoqBTXdwOVBABr/r6xxn1HuiHYYf9f8/UtfAw/iMmBcybChwLEa
 hrxbkpV80wJZMu+eR84cHFHmBPCFZ9992mAYvsOM6jTE1CBjd83k/qodj1V7mWKLm2X7pgxtt
 CN6Ahd7uQOvptwHNvYtQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 10:04 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Aug 09, 2022 at 08:23:27AM +0200, Greg Kroah-Hartman wrote:
> > > This is different from the number of FDs pointing at the struct file.
> > > Userpsace can open a HW state and point a lot of FDs at it, that is
> > > userspace's problem. From a kernel view they all share one struct file
> > > and thus one HW state.
> >
> > Yes, that's fine, if that is what is happening here, I have no
> > objection.
>
> It would be great if we could actually life that into a common
> layer (chardev or vfs) given just how common this, and drivers tend
> to get it wrong, do it suboptimal so often.

Totally agreed.

I think for devices with hardware MMU contexts you actually want to
bind the context to a 'mm_struct', and then ensure that the context
is only ever used from a process that shares this mm_struct,
regardless of who else has access to the same file or inode.

We did this in a somewhat hacky way in spufs a long time ago, and
I would expect this to be solved more cleanly in drivers/gpu/drm, but
I don't know where to look for that code.

        Arnd

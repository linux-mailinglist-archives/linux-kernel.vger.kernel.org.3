Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFB4B560B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356303AbiBNQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiBNQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:23:14 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638C60A9B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:23:05 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJV5K-1nZ7eB3Pb6-00Jr7m for <linux-kernel@vger.kernel.org>; Mon, 14 Feb
 2022 17:23:03 +0100
Received: by mail-wr1-f41.google.com with SMTP id j26so16901372wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:23:03 -0800 (PST)
X-Gm-Message-State: AOAM530MzYqMCZBshDWyR0r/WpufWbb0Cb9yLQ9cx1kOmeHtKp4pI6HI
        hv/eiP2WLUu2/AZb034plDdgQnZ5C+CdPAjydmc=
X-Google-Smtp-Source: ABdhPJyG+jgpVi3VfDfCUUdvqz8L8f7kQFYsusxm0coFeTiylsS6SErvSFrlMbDk8neM8L62+ULjFBu3y9eBOV0ciJc=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr303823wrn.317.1644855783467;
 Mon, 14 Feb 2022 08:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20220207184652.1218447-1-michael@walle.cc> <YgpkCyoSMg5RYfkO@google.com>
 <YgpkQMbhWAJG6oCh@google.com>
In-Reply-To: <YgpkQMbhWAJG6oCh@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 14 Feb 2022 17:22:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0UWO=h6K4NpzCVC2vbOvThJH28GM5ddm9U1crr1Su7vQ@mail.gmail.com>
Message-ID: <CAK8P3a0UWO=h6K4NpzCVC2vbOvThJH28GM5ddm9U1crr1Su7vQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:O+YnL10ezeU7myro1RjijajOTfmvAEDE5xmIbCJNcUuhk+2z9T+
 d7K1rZIoVFDaMQb0QfSPZbWLjCn9D1ex3nbP4sJ8BGBbnZ7GVWcYSKNHCl9ndBh09aJB1zk
 /Xvj2mQVzTxkV/+b9BtXhij63l/6jy9vXf/Tp6iId8WXKleO+m4rz3bDVNtmnmOIe8qGDqj
 16z95wXKPZVyhWXG9AEEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kTns834XWFs=:+o71QcMnOtIwg4WAquKVdR
 KzSK1tnOriW66iZgjKnjSz0escEE3t9ZQhSwZLQsQdqgDufsIeUhaslkSw2Kk8kXnioGgn656
 IWPWYGYhm7gUAOLZU3pKR5j6040kdoEKgdnpUUmzxVFlNZ8KvUB71QkEzHFb+ijtyZPQsHSRM
 s8dlaSe0zMOiy9IphIWjLb0tRU2cHzxw0wLkYOqQtpo4zH7MryA7Cr29wxMemy9chXDxWtL9k
 hL3oUyxlmaENMYzDNOmhKkNCjRRtlcSNLTLGHAw+9r0wMaa3OB2M4sqqTBUSQy/IR5qKNcupj
 U075+9dtl2k0F5PJgxX+70ITqiuw3pdNMg6RnAzsVwuHAHYWXx0JiHlFfrQTh2iuxZjB6F15e
 osOZg0u74Sv7L7RW+72E3Mm1McONbOmoc8uD3t9lTAoVdJSOAIwfoe/8BLszNuykydxf1TmT+
 CoDnnjUV7CbaMfTTsRnQn1RMRG2rpH/rHD5SKb9ZKAaa/m/818JlE2ledGg6WrJYZ7CfQo5lq
 f1Qwzywdzlgwbj7m7VZSzTNTNZvPwrz5zY2aoKT61mAZF87iQEtPe5+2/5OcNIpRs0iFFRF8C
 ZUnIz/URLYytKqwOfiUKwG4AcgUFn9sTbYgbCxWaz/AlnmTWVtlGD45/0YMTB2Uu4QlUXN7m8
 5Nq5rfntDSazkmEYknVQF9kYad8GX05Gp3YbXgt3YogNsh0i7uSXtT0z20f/D7fmMbGifHdiB
 bcshVNGqZ7DZqqdFCkOP3G3t+dPSIuIirSBoypPhuabtlPJYVNaw64XzorYfWR//ruHARhQRH
 8iyzFfEXEK7WTf0ADi5oLQMfy8FX5kBghgxbzkdzzU4vFQVGG0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 14 Feb 2022, Lee Jones wrote:
>
> > On Mon, 07 Feb 2022, Michael Walle wrote:
> >
> > > The sl28cpld is a management controller found on the Kontron SMARC-sAL28
> > > board for now. Support for it was added by me quite a while ago, but I
> > > didn't add a MAINTAINERS entry. Add it now.
> > >
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > > Hi,
> > >
> > > since this affects so many subsystems, I'm not sure through which tree this
> > > should go. I'm sending this to the arm soc maintainers because it's an
> > > aarch64 board where this driver is used as well as Lee as the MFD
> > > maintainer.
> >
> > I'm happy to take this, if it pleases everyone.
>
> Hold on, you're not going to get many Acks if you don't send it to the
> other subsystem maintainers. :)

I've already applied this one through the soc tree.

         Arnd

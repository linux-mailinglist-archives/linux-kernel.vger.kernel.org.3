Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B147D103
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbhLVLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:31:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:42579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhLVLbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640172673;
        bh=MdM7kzBDgVNWTP51iMDRW70b9sRcwz8d6Hl3mr0489E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UNOmH0q8xEM73PFVubxgwrSNyQ5F6t89zvM6uNKBTpoAcb2b5B+kEyTXHB0B/GhF1
         Yv3GYrlbpwscf4JIlpPi2Qiq+aeGLFxYCCdrTm7aSkbFdRY0g1eY92clXaa2ZRliAr
         aWQzgQaSJh+qxFu4l2xQ+Cy7Hv85WJV1L2I7HQwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.158.107] ([217.61.158.107]) by web-mail.gmx.net
 (3c-app-gmx-bs44.server.lan [172.19.170.96]) (via HTTP); Wed, 22 Dec 2021
 12:31:13 +0100
MIME-Version: 1.0
Message-ID: <trinity-4d94e8dd-1499-4d5f-84c3-85075a4085dd-1640172673779@3c-app-gmx-bs44>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 22 Dec 2021 12:31:13 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <YcMHhJTsQMLDRRsN@google.com>
References: <20211220144654.926112-1-pgwipeout@gmail.com>
 <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
 <YcGU6pQqfEPBqjrO@google.com>
 <4963E4A2-63B4-48A1-BDDD-5F9D07D71598@public-files.de>
 <YcMHhJTsQMLDRRsN@google.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:KGEgF5qQ21JQN01aGdoEOA62OA061J+/OnVHxn4ML35EA/ptxgN38i6eLG158yz5gmtA9
 bY2AX0Di93cd4zzM17Ous7KXSrAftUz7/+l8aL0Yc9Q4Ag6Sr/ml5fLshWyUDKkREC8FFznkMFAV
 CfaHYRpddc9I7l+sOhVQhyBFrWEYrrOM9/gFd5ZYc/u2iA9BhZqNHYPy8JdKgMDixYj2PfqW5U6z
 zu8DX5Z0Yp5Ue33oFT2DMmsJQYpnEE01UATU6v7Wkh1MTQ0VjU6XC/ZHNEPHRfTKXmxvKOYcltPR
 4U=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dFwgK6+7/7c=:5aAQXyipNr8rH+YeaoQCAI
 HAuWxI4apX2+Z5zjk0tZlLo0n0n7D+fkeZohBK3u0qhmAZbpv28LvqEnwHbFFWISWgWcwZsE5
 9dQZXsDoJwG1n8ROdS5l9KXRfjZ6Bv6YVuwP6KizmRXr4itpaxgLsManOSetVM8uUDBvjE7uf
 7mrxwuQVAL1BjqQl3c/TmgxdhxmW3MbnoJty0NDEm36WhfK2LzIR6xnWkKSBEFCZjvX4vfxSd
 ee/6JEuHAJJOFYWLMmjnDIUW4DmR8Cn2HAx8+GyRWJ+FBm6bfSDdJUsbuBoMgGThNigH3Qc62
 9v+hdwXvg9tBairj/DTnqL2ugXCbsq+l0PWM+yOpdiGiyhz9DN5mHsKGRmKE7ZULv/3damDGA
 FLM5bAIRxK6Rl3Xj75P748MGS2wjQONvh5Li+4R81B/JO777MAP44tCFs3CZ2tZXzEPpEQRr0
 cCkGwHEEWKoLU9IQMw2Jo23l81ok86IiXA0vfK9hMmKucJA6P3DkgSMImsZn7uIvcXHEn9rWL
 en7MGzx2hSOO0YzCLEt0KLP7ktKwDqede0QLMLt/sLFuNTxDXIm9y8DWCBpS77NPv8kzwLcD/
 Y9r+HIZ6sVPzrkiLmyooocO+2RsuFbnrFSm5TNpyLyDZE2e28HB1pa0c7wzD3jSGR5vmCNufh
 fCGY7ydQBoSxUb3iOfNiBzBhWraDV7r0HDGHuab/NhR2mF5VWfRuxn6c5qAErL/z6CY7LX+Y7
 TK32IMRQ9a+0Ij7a3pw6gyyZe3gX+dqJb7yoR9Jel7NpcNsIWtjfLfK3gg7JT/WOAfW3qgN5s
 lcmFc3G
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Mittwoch, 22. Dezember 2021 um 12:09 Uhr
> Von: "Lee Jones" <lee.jones@linaro.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> > Here i have squashed the change in:
> >
> > https://github.com/frank-w/BPI-R2-4.14/commit/06430ffcb6d58d33014fb940=
256de77807ed620f
> >
> > With the change i can compile it...
>
> Not sure I understand.
>
> Please make sure all patches you send for inclusion into the Linux
> kernel are fully tested.  They should also be bisectable i.e. not
> depend on patches applied *on top*.
>
> > But in v4 (patch is tagged as v3 too) the of_property_read_bool was dr=
opped completely.
> > regards Frank

only v1 was sent by me :)

v4 is compilable and works on rk809 (Bananapi r2 pro)

regards Frank

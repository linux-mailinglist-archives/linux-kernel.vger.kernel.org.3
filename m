Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCABD523DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbiEKTkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbiEKTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:40:36 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEF021936A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652298027;
        bh=VvsSj+I3QLO+GT/1Y+Fy8QHCuIf/f9a+/vykm0pmAPo=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=caKufFHpFZ/ya4QCGYXAnqfuVYr8zimRiJIqWarKdQCzjXq+eMOTNAurVWV9NiGXU
         SY0Qy1XAGIS6esFR2qhEphr2/CwNZjyXGoBqPLdNDYAFNt1+dmpBWL9pE/MduN2Q2K
         QQ3Z3ttML8D4Ken6So43p39J05xgFrlcsOcYg7r4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.8.110.13] ([143.244.37.9]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1nsOwp15SW-015L7Q for
 <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:40:27 +0200
Message-ID: <6e63294b-399c-4c56-deb6-2997e2f87bc8@gmx.com>
Date:   Wed, 11 May 2022 19:40:26 +0000
MIME-Version: 1.0
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Linux swap file and LUKS
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zg+vUbgnbWFN5YGjshGF+GQYkk/jwb6qZMTHkn7N1Ua5DbBAzbK
 FkIDTY/171FEMz5tcPmH9wRvMTa1heBtnPbw2OP9sf9u0LN+0owGQ+S8scW3FMUbAwXuz9D
 DKLhP1MTE+QYFcRwbPcceRIPky4YM7T3bXc3LnVWQvje45OckZM9k7rOemFHs6G3c5J1CaL
 N6RnQ+ad6yOer9ZNqPFUw==
X-UI-Out-Filterresults: junk:10;V03:K0:KigoD8omvAA=:9pIV6fDIDc9XDNQqj/GtuaeZ
 NoczLO4B9czg86Zwv+GA0Pssi190/jZYfbGnz8ZB/qwOP0I5qnlByna+TX0ugdANAKOwsy0wI
 Kg1BDjJ625t5refy95Hk7ZiOu8v80ZhJkJln8QdorIQIs6ASBAVu1bBDbkV+K5MsAo+hfjS79
 nD312rprYHgVOa3bNiwGbUeWmrilK0J9n3n4LsdBt9rI83UI/NYtCAOIJt++QPhmEOBM1+tM8
 kBwtggEBuYaKuFbXBW35ORGG+npK6NzKG5U1EdY7TYso5pqyup1LNiZM8O3WQPqs/bUxAQQCj
 o9VWkjXuIEwSL/+KZJbxemOmQkRdJPSU5RaOsAfcjsq8c9OjZ/JeWB/WkPL4rO+Of6QdExtaJ
 QP3HzBiNKWvbOL9TUksOzDAEq0RCNZOUaA/2YZLlz770jVV+M+/u5K+3y+6wMphjjd0RvWsOL
 THi5JTfaZR9r3Ezi1HWSBfHqWa4Od2h70iyWL3LLYmphjKFMEncdeCYCxLfOSR7ceXfhtstre
 C8rg42G+jFA3SaFWuY7e8kfrQNadPEs7VaXrOx1C5xIqgYh/kLir28s8OsZZJb4kM0QRDbq+A
 kHESQczmJ2ogUc6L7sSs2SUhvUKaP+rqfk00Vo53pceOku++7fS/ryBDGyaozP6qisdcrF2Ib
 xUOgN1KEhDuEFkQh1lOm7il0U2uF5/dt56UNGqJhAaq8gP/Cn6bTok3N+D2DF08g6B3Q0QFAP
 uTjBOOOOwWY5wb7GgyydCmn/te1EyFHUY1IcrisOLNinn2pABx74O+zz0YCt7KYOV93GPNgG8
 G20SnVhCKWrJ//wwfFZ/dfgE/YSJAEJBHJqMKqKGVE9GdcOtPrtyrQhiJYqLs4qOqS3n+vgWB
 ZeocEIx22bZZ+r6ko/KLNTORfjJ1wwt+T3EsZAWkEOssY8ZT8CP9GpNGyHFtXAibIGEiF4qut
 V02uETNXPH1ee7nG02DERgGm/jQQ7OMvhbKPSK/cwUjG35mjPidTMU8YclPsq2CXE+Jbx6w9j
 duEzTZvhcjj3gdbcVCr+Hegi3Ol/PxTvd8oqyHpqpLTq2eaFaWzuW6tVItsazpwNgiqmuy6nz
 PItzFJQFj08+OPzkIHbj0v7n/QQYiOwwiuVnh0UM3unspWu3S/pOAuMy4Eg1Fy7wtsWwmgWpK
 4M4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The man-page of swapon says:

      The swap file implementation in the kernel expects to be able to
write to the file directly, without the assistance of the filesystem.

Does that mean that if the user has a LUKS volume with a partition on
it, in the end the swapfile on this partition will end up unecrypted?

Could someone please explain it in more details?

Regards,
Artem

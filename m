Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2204FA595
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiDIH01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDIH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:26:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB836155;
        Sat,  9 Apr 2022 00:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649489033;
        bh=71qv70vZxF+QqOQSgEW+RQ5BfofYTTkw2+VdXFLTcNA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Vc6rWvHiBmEpggo1vCR0Z6lX9UhZXC6n7sOzWUULSB0v0Vnnnrwgthw7hWl7wEb3w
         6Z+n/zEU1Ue82RBSqD7uLa8aNjd/uchDo9j68qrYHG4RzOQGgWL+NirQlAPCyDUAt3
         uS0l0wSlXXnJPSv8jTfjXYBDBYWrBBQ3c4NQ6GR8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 09:23:52 +0200
MIME-Version: 1.0
Message-ID: <trinity-7dbd5148-923f-479b-9eed-a75f000456e5-1649489032880@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [PATCH v5 3/5] arm64: dts: rockchip: add rk356x dwc3 usb3
 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 09:23:52 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAMdYzYrK2KV1svrHS=zMjGYh=dUis-JKjgYHaeOB4LQWXM1+4A@mail.gmail.com>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
 <20220408151237.3165046-4-pgwipeout@gmail.com>
 <trinity-3ae2b0d1-a3f0-4c64-acb6-2fb4fa0b36b3-1649434480623@3c-app-gmx-bap48>
 <CAMdYzYrK2KV1svrHS=zMjGYh=dUis-JKjgYHaeOB4LQWXM1+4A@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:TeZQKSghMMZUkUJKs83ylTXQSsU7yV7FSkqP/fuUaLAE6KQax+QMuXgqsf3qW1M6JW66d
 NHzdML2cIYdHIRESCTwArTUiHYPIaXTSsBm+y2j1c/jVZNx61/K1vKsD6piKqna0HLktYtRt6Sba
 eKjfuS2RyCepOg45TbGRY3XDLFZw8WlmWh33BvGfVtmiF2Lc0vd3LemRfBN5gfStMh03Fn3xOMgK
 Aq0PervdwShRT7KoRrCr0bUjd6NoCI1YXwsmvKiTJ43EsDOi8dBsY7va9ajIXvhocpiOGlTog/mN
 ZU=
X-UI-Out-Filterresults: notjunk:1;V03:K0:xgRQTaYlAUc=:XIjlEiF7C5aazhG/BoUhUm
 T91Mr8O3RSzpflZWmrPJ1NAlQZLLeHmYJQG7HQ+X4L7nm1zSf7IPBrLUMDh0gizBIVyloMW3L
 0fE/pJhELkc1s1lxf49VodX+qU8xmxBIRdReI6otgP+S8dhoxXFBjzA/0nUMJIDJpKo9PMNcc
 N5afQ13D3XzUdGnxZkdVXinIGyYqiMC8byFQUmusFR3Pnks5SUv8koMNicPw4DL4V2/UAvpoR
 dPMhJj0bY6dCz1OTqaMN46f2OGMqaTCOFjxn0Jh3ja/P6qvAggzKBDGNtKmOmqaamvuibVMBS
 vP6l9pZePvrjOjMNU9s8PFqBuwxLe9m+xbdGl4GqIw5nhXfqJj2L1evKpeB5v/F4BSzvGTAqI
 IKPVx5GBdQT4jhWKvRTDxDtm+YwLOev4awU8Xm7blpcLCg+Xyrir9MeQW2tLvTvzwSn6xC5e3
 2PxfmAesluRiyRWbdfgA+/aF3wkU351BvzZ1gZKl+sFTTetuVnZHS8EU8F0XkvxercHMQop7Z
 CVrDUuKyRjHIOThoMAWGUgNnx8LSiR+mtKrUUe8z569cQDBSqnw6Kay7lWdV1VmSWyGVYXIOE
 WIlNFj8hPYvxhYmNDHQhPvcFGIirraR5oaBzY4CPuxsc/xoEQxrosMzc1FhjBIMwKOV9Gohz9
 xmsQFwyApZx9ukzSK5nXFFI3htl8kbyR+J51889ABYNy74beFY8OO4batPBsAQkQtTo0MxjLN
 q7i3RN4FH5hQhUzX1mViDs3gzQp9KM3IoyGx1K0+z+GkgXs0NYVmA/FOMI+lxM7uqlP9HsPJv
 HjyXXel
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on mediatek board (mt7623/bpi-r2) and there xhci is working.
So it is no problem in core/protocol and specific to rockchip xhci driver.

at least i nailed it down to these 2 commits in drivers/usb/dwc3/core.c, w=
ithout them it works

5114c3ee2487 2022-01-27 usb: dwc3: Calculate REFCLKPER based on reference =
clock
33fb697ec7e5 2022-01-27 usb: dwc3: Get clocks individually

regards Frank


> Gesendet: Samstag, 09. April 2022 um 01:39 Uhr
> Von: "Peter Geis" <pgwipeout@gmail.com>

> On Fri, Apr 8, 2022 at 12:14 PM Frank Wunderlich
> <frank-w@public-files.de> wrote:

> > seems like usb (2+3) is broken in 5.18-rc1
> >
> > i see controllers, ports are powered, but no device detection.
> >
> > maybe anyone else have same behaviour with different board?
>
> Yes, it seems you are correct, there has been a regression with xhci
> between v5.17 and v5.18.
> I'm bisecting now.


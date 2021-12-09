Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319E46E998
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhLIOIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:08:04 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:57638 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbhLIOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639058668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27CpbSSRvy1jd6MiYfFrehhgJ2HcF0yT0PcMYD8pezQ=;
        b=v877vYqEST5qU/KfaHJNsLcjCMbvAjseY3TcVcuWUwsU2ERn+AbCt9vJa5pGJoHPqZkFAQ
        w+w7E4l/80DAqC0djEqWfT+yE5Nz8M63qrjiX9vDf6sO68AsXRZ/Xl7zv0Q3gKi+TUNKgF
        uC/PamQZSMMvQwxGKs48bCjAhsEeDZ8=
From:   Sven Eckelmann <sven@narfation.org>
To:     jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Deren Wu <Deren.Wu@mediatek.com>
Cc:     Mark-YW Chen <Mark-YW.Chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Deren Wu <deren.wu@mediatek.com>, jf@simonwunderlich.de
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date:   Thu, 09 Dec 2021 15:04:24 +0100
Message-ID: <3841963.FhVex8QpIh@ripper>
In-Reply-To: <2314855.OJx0zA1Pyt@ripper>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com> <2314855.OJx0zA1Pyt@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1990156.1ky84pn987"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1990156.1ky84pn987
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Deren Wu <Deren.Wu@mediatek.com>
Cc: Mark-YW Chen <Mark-YW.Chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>, YN Chen <YN.Chen@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com, linux-firmware <linux-firmware@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek <linux-mediatek@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Deren Wu <deren.wu@mediatek.com>, jf@simonwunderlich.de
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date: Thu, 09 Dec 2021 15:04:24 +0100
Message-ID: <3841963.FhVex8QpIh@ripper>
In-Reply-To: <2314855.OJx0zA1Pyt@ripper>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com> <2314855.OJx0zA1Pyt@ripper>

On Thursday, 9 December 2021 10:21:02 CET Sven Eckelmann wrote:
> Tested-by: Sven Eckelmann <sven@narfation.org>

I would like to retract this again because it seems like the firmware is now 
hanging all the time when the default runtime-pm/deep-sleep settings are used.

    [  521.553436] mt7921e 0000:05:00.0: Message 40000002 (seq 12) timeout
    [  521.559884] mt7921e 0000:05:00.0: chip reset
    [  521.661983] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20211129210838a
    [  521.661983] 
    [  521.684088] mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build Time: 20211129210917
    [  521.723561] mt7921e 0000:05:00.0: Firmware init done

This doesn't seem to happen that often when I perform a

   echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
   echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep

before setting up the interfaces.

But even then, on the first "ip link set up dev mon0" (not only for mon0 - 
also for wlan0/...) it will crash with:


    [  806.731357] mt7921e 0000:05:00.0: Message 00000046 (seq 4) timeout
    [  806.737730] mt7921e 0000:05:00.0: chip reset
RTNETLINK answers: Connection timed out
    [  806.867666] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20211129210838a
    [  806.867666] 
    [  806.888441] mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build Time: 20211129210917
    [  806.928204] mt7921e 0000:05:00.0: Firmware init done

But when I then set up the device again then it seems to work. This is the 
case for monitor and managed interfaces.

I've used commit 678071ef7029 ("mt76: mt7615: clear mcu error interrupt status 
on mt7663") in mt76.git for this. 

Kind regards,
	Sven
--nextPart1990156.1ky84pn987
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGyDOgACgkQXYcKB8Em
e0bkhBAAkqBMV5xrzHFlOV75veDIUYPQjwNP/KZsTUL7bCc1NDkhuQHd73iwqM9H
5xpdF/8DQm0A5Sbqip8Sxi29zbwffh35iO+J+E8opxi000oHuslOUMCWg0Og6XZD
yB7J8ONjDSC+yZ3gNNeESAMoU06PDQQg7oJ2zA9lUPWtRNZ/Eiq6QH4mJRyXHUP2
IQSQ+d0DdVDFx9j77kkyJNAKIRPNSB/M23y8bAxvQ9m+gXlmTsFfAOzCke+Z3qN6
clkpHhXqAaSIin2XjCTHzSjYcnEmgMFu4tof6Vk6geMxvc16tl0/sky6AzZf4mHk
XPhIEOUK3gxyZPpD+z8QeqIBtOZPtyTjtpDlYiMCoBGXnYM35ZZuTHivX1UvuSg4
3v/TKHmftEJ7J+8dRAKO5aw1BJm6bLO7rmMz/niwYdKwN7q6Kj66nM0HGCfmXNav
N3Lkjkz34k0o1i4PSnEI1e4kff2Ll2nnahChmud6ReFjaIzrZjmYDgeimBZT5kma
Rck74zBstLqB3eD79mzNPd20Fd7MnCCOgUclFxwEETwedNVVRKEaHktnsyq5KB3/
xS5wQzeci879l1XuyZFiz65riN6XyGOYJaOFld+ALkaIO9QQ1l3qh9YAB4ba9v/w
nav7b07bmgpSHaDoekFPec6N6E5/MsKK6nXlZphJw2+lmXSLu7w=
=iVCx
-----END PGP SIGNATURE-----

--nextPart1990156.1ky84pn987--




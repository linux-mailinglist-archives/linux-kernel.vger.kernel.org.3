Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07B446E589
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhLIJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:31:53 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:52302 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhLIJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:31:52 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 04:31:52 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639041665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HKfoBlRfsPWUt5hnOkqJORTtA2aNncI/9GyUqXURfVQ=;
        b=wKzcE01/NZcjkvW5RMDJ2EPP36tRpCwo0vG+t7E/66evxG9D5lx0y5VQQy0B0RJQVXUuTV
        PMg/f8kgcqOf9Rjek3YnAqQrTtjYbOU11faThswZXApeD559sjQqLDfG8DxN2GSVne3gTb
        kuRGeiKZ5cjpBgKY5dNeZPO7aDduZRU=
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
Date:   Thu, 09 Dec 2021 10:21:02 +0100
Message-ID: <2314855.OJx0zA1Pyt@ripper>
In-Reply-To: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3341260.rLAWO6SjPS"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3341260.rLAWO6SjPS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Deren Wu <Deren.Wu@mediatek.com>
Cc: Mark-YW Chen <Mark-YW.Chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>, YN Chen <YN.Chen@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com, linux-firmware <linux-firmware@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek <linux-mediatek@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Deren Wu <deren.wu@mediatek.com>, jf@simonwunderlich.de
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date: Thu, 09 Dec 2021 10:21:02 +0100
Message-ID: <2314855.OJx0zA1Pyt@ripper>
In-Reply-To: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com>

On Thursday, 9 December 2021 09:24:11 CET Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> Update binary firmware for MT7921 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin
> Version: 20211129210838a
> File: mediatek/WIFI_RAM_CODE_MT7961_1.bin
> Version: 20211129210917

Thank you for the firmware update. With this firmware and the mt76.git 
commit 678071ef7029 ("mt76: mt7615: clear mcu error interrupt status on 
mt7663") + hostapd commit 14ab4a816c68 ("Reject ap_vendor_elements if
its length is odd") , I was able to connect to an 6GHz AP:

    $ cat > station_sae_test.conf << "EOF"
    country=US
    network={
            scan_ssid=1
            ssid="Maverick6g"
            key_mgmt=SAE
            psk="testtest"
            proto=RSN
            ieee80211w=2
            beacon_int=100
    }
    EOF

    $ ip link set up dev wlp5s0
    $ ./wpa_supplicant -D nl80211 -i wlp6s0 -c ~/station_sae_test.cfg -B
    $ iw dev wlp5s0 link
    Connected to 00:03:7f:12:8c:8c (on wlp5s0)
            SSID: Maverick6g
            freq: 6115
            RX: 3092674 bytes (26805 packets)
            TX: 114756 bytes (1073 packets)
            signal: -49 dBm
            rx bitrate: 1080.6 MBit/s 80MHz HE-MCS 10 HE-NSS 2 HE-GI 0 HE-DCM 0
            tx bitrate: 6.5 MBit/s MCS 0
    
            bss flags:      short-slot-time
            dtim period:    2
            beacon int:     100
    $ ping ff02::1%wlp5s0
    ....
     

Just as note: It is still not possible to see beacons when using the card in 
monitor mode.

Tested-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Svem
--nextPart3341260.rLAWO6SjPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGxyn4ACgkQXYcKB8Em
e0YICA/9HP/KgPvp7hf4CLElCGNnekR8cj2P6tEOYqIpQwvmG+FfxVSBESzKJDbL
jb0U+dnm9hooIkgX/UPcaSiiaDPRzek3xqZyaFvl4aZRN3iK64ovTt4ytDrGmBi6
Ew5kI7vevnAjt/RDYNKCPobGqmjKyslCezJnReNAVTlk7v0R5fiX2i+mwsKv3GB0
mzpVEaIoWsKuYHwhypHF1l2Ay2SuRRpnORQg2DyfWwd5bU39Q7kN/r4nybhPjJ+W
QUA6sYhx/p09c/SzJo9lL+vBVbrBzZwxGTaCdGi7i0EoEMblIcmruB3d3OHam5y/
uBwOy6E46PIStRfw3vbq38ZBM10g3z4qjA/OgfSUBY3kTF/PcLUDwnMaYqKgFAcp
W7MfHa0tpDixKTortPic7QBzp8KGvsAYfXWvN7xSVZCVbZZBRHqCaBYW7dVPC/9M
CNiGZj90gUqLDnLirm/O/K3UvMJqZYqhVula3BxNSIkL1TczyBtIZDQYF4iRwfIb
XTJX8eVpcij9DCuMOEp0guQ5ogbgP/+OG6E6RUlw9eX9KcjZl+a+BsCyy90J4m0P
d2sxR6qMwa8NoV7cF0iyoEyhVpEs9FPzLXWRhM4dDIR5FRObMTaFsmXrgQKwxOL7
q2lQra2dtTU5Az11mZd0WxqPFr9/sbBIWjSv6V+vZy5PEb1HqBI=
=syZA
-----END PGP SIGNATURE-----

--nextPart3341260.rLAWO6SjPS--




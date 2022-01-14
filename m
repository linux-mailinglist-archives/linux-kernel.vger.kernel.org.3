Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2857148E7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiANJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:52:22 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:50798 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiANJwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1642153937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLaupujYUIyWM+riOpBqKRJ0S0xnm+HoiMPD+r7hoME=;
        b=a7FxUdecDzVAATA4GGXFCiZpb3d591RfqPYPCRADWRzxVViyw6rFh6U9IxyC+BLcvxwHNE
        38o5ct9TUNWJH9IOe//zjTjnTmpii1gbTG6wypQUT1OfhBuDW/t6EOhuurNWebl6tfpmNK
        JKc8LdquZK2Epbmp1UkN3R0bZAMhxHk=
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
        Deren Wu <deren.wu@mediatek.com>
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date:   Fri, 14 Jan 2022 10:52:14 +0100
Message-ID: <46921394.S1zCe5f9UI@ripper>
In-Reply-To: <8badb0ca1c11e2060d997c199d20da8a1e0e59bf.1642141259.git.deren.wu@mediatek.com>
References: <8badb0ca1c11e2060d997c199d20da8a1e0e59bf.1642141259.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3643850.YqUZ2QbrSU"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3643850.YqUZ2QbrSU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Deren Wu <Deren.Wu@mediatek.com>
Cc: Mark-YW Chen <Mark-YW.Chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>, YN Chen <YN.Chen@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com, linux-firmware <linux-firmware@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek <linux-mediatek@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Deren Wu <deren.wu@mediatek.com>
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date: Fri, 14 Jan 2022 10:52:14 +0100
Message-ID: <46921394.S1zCe5f9UI@ripper>
In-Reply-To: <8badb0ca1c11e2060d997c199d20da8a1e0e59bf.1642141259.git.deren.wu@mediatek.com>
References: <8badb0ca1c11e2060d997c199d20da8a1e0e59bf.1642141259.git.deren.wu@mediatek.com>

On Friday, 14 January 2022 07:51:24 CET Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> Update binary firmware for MT7921 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin
> Version: 20220110230855a
> File: mediatek/WIFI_RAM_CODE_MT7961_1.bin
> Version: 20220110230951
> 
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

This is not a regression but I've just tested whether this firmware fixes the 
problem of missing beacons [1] in monitor mode: No, it doesn't.

Kind regards,
	Sven

[1] https://lore.kernel.org/all/Yd170LnF5Y2D8by5@lore-desk/

--nextPart3643850.YqUZ2QbrSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHhR84ACgkQXYcKB8Em
e0YKzRAAyOYq/uNn8TEz9bXXXHShuKspeRz7GT2vYp4yOB0WWjE3lXAzUXkujwoF
s0DV7YDb9sK2l1/JDqUVnilfGR1o5aDXe76eo5ICDqiqzAgbrWdjdPmROvYDBp2t
us7JDNoNbWS4t377TiRZFhDX3Il8uSmSUzsWM1bo7kLNB6Vv0OFDeOjc3CHJC3of
Va02Xfo7+rhz6n/qVxjnDLOa86VctR6was3LBpZ8lBXPvhNfIW/x/VdjJcdpTqLu
zsVHYGdLASOMsWJhbDIHeJVKlF/AODgI6/OXWcQVbbrrTu69oecIF8KbEbM3rGYp
T0kZisepJrL456NEt7M+GYD61LXzPnEOgymoqLyG+YNT+4S+bqTlt6aXU+CmkxPq
Xe5tIwMl5XZdTwBY8n8tM1fg2BrCZ8W43lCGgOyRUKrqvABhJuwcuHXegru2SKY3
zb6k4uxib1S9WZrHC3Z/0VSEithnMusMQ0h3AHzmtpOItw/HnUOxvhCx1DhX60D8
tUretH3qCtkgV473tSgmuo6io1FKS5loowOE1vmQsTRFZlEcm33smPKkhhfvnTrX
GxXubSwkQj1rO17tt8vFKrlhosPHC75CWjjsqkvTD5qgBQFyey580uLBoIQ2w39R
Jx89RD5VPyNoSsSU8JJDlk0a4GNFGpGhCISoMQQ+JlH41iRSovQ=
=QAbs
-----END PGP SIGNATURE-----

--nextPart3643850.YqUZ2QbrSU--




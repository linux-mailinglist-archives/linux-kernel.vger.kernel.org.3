Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D446EA73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbhLIPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhLIPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:02:41 -0500
X-Greylist: delayed 20273 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Dec 2021 06:59:07 PST
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C4C061746;
        Thu,  9 Dec 2021 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639061944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8rslS1FwdC6+mnfMg8oxAldamxYdPmhK7VgY20Z0JM=;
        b=IzcZtoVd3D39YHEGONQtIMkASDH+SBLZfKC2ANEC0PXE0/0RSpFrV/enBt7NJV8IjMWNPO
        tsko/yGGBLH2Pu6W7VQUGL43r5TzSxGYVbf/15J3n5ChE+91GctpAN5fVu0oKJONPrAVOs
        bAz2uN1XEMPnUQ/uyiZtVtXwq0WcUL0=
From:   Sven Eckelmann <sven@narfation.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>, Deren Wu <Deren.Wu@mediatek.com>,
        Mark-YW Chen <Mark-YW.Chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jf@simonwunderlich.de
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date:   Thu, 09 Dec 2021 15:59:01 +0100
Message-ID: <3198471.FQF0JACdhR@ripper>
In-Reply-To: <YbIPFIaya1vKF6bM@lore-desk>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com> <3841963.FhVex8QpIh@ripper> <YbIPFIaya1vKF6bM@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28758891.yo5t8FPOW8"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart28758891.yo5t8FPOW8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk, Felix Fietkau <nbd@nbd.name>, Deren Wu <Deren.Wu@mediatek.com>, Mark-YW Chen <Mark-YW.Chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>, YN Chen <YN.Chen@mediatek.com>, KM Lin <km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com, linux-firmware <linux-firmware@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek <linux-mediatek@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, jf@simonwunderlich.de
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Date: Thu, 09 Dec 2021 15:59:01 +0100
Message-ID: <3198471.FQF0JACdhR@ripper>
In-Reply-To: <YbIPFIaya1vKF6bM@lore-desk>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com> <3841963.FhVex8QpIh@ripper> <YbIPFIaya1vKF6bM@lore-desk>

On Thursday, 9 December 2021 15:13:40 CET Lorenzo Bianconi wrote:
> does it occur with an older fw?

Before this version, I've used WM Firmware Version: ____010000, Build Time: 
20211014150922. This version was not able to connect (and stay connected) to 
6GHz at all (so I've used 2.4GHz/5GHz).

But the old firmware version worked fine as station on 2.4GHz/5GHz with 
runtime-pm/deep-sleep set to 1. And I didn't see these crashes when starting/
stopping wpa_supplicant. But I've just reran it with the new firmware and
it seems like this is not 100% reproducible all the time. But when stopping 
the wpa_supplicant would leak to a crash with the new firmware then was also 
a problem to receive packets (not sure about the TX part).

I also didn't see the crash when using runtime-pm/deep-sleep == 0 and then 
setting up the mon0 interface with the old firmware.

But interestingly, i could also see these crashes when
runtime-pm/deep-sleep == 1 and then starting/stopping wpa_supplicant. Just 
didn't notice it because I've never used this configuration before.

    [   95.246429] mt7921e 0000:05:00.0: Message 00000046 (seq 8) timeout
    [   95.252734] mt7921e 0000:05:00.0: chip reset
    [   95.386747] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build 
Time: 20211014150838a
    [   95.386747] 
    [   95.407850] mt7921e 0000:05:00.0: WM Firmware Version: ____010000, 
Build Time: 20211014150922
    [   95.447509] mt7921e 0000:05:00.0: Firmware init done
    [  102.403012] wlp5s0: authenticate with 4a:13:65:00:0c:92
    [  102.524727] wlp5s0: send auth to 4a:13:65:00:0c:92 (try 1/3)
    [  102.536201] wlp5s0: authenticated
    [  102.542294] wlp5s0: associate with 4a:13:65:00:0c:92 (try 1/3)
    [  102.555600] wlp5s0: RX AssocResp from 4a:13:65:00:0c:92 (capab=0x431 
status=0 aid=2)
    [  102.582864] wlp5s0: associated
    [  102.716868] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s0: link becomes ready

Kind regards,
	Sven
--nextPart28758891.yo5t8FPOW8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGyGbUACgkQXYcKB8Em
e0YDyg//WHZBiTC9+jIIJdjPUNzZ+MhRdLrrCnREj8Cs1rZiGja0nd8btXkWvUpz
h7MHwEAj0Ka4gNj3XWdl4NDqQCNCAeNS/J3cFjyrc9rhOts1tAtGc4AsMNO2O/Zs
judT4R+SMhX+ZQSayalzDgc5sQ13NJNdmSwYAXcbFMuv2xX8oHwDtYQd9053STZC
pGqP6oe8FQUKBMy+yVgZit11rknDYC+MVlqta5y4SdlK2VIAx/SWFvcotlgZsnx4
ueLrAnQu0MyikjgbKbVkxFZhbhYF66H++yeAXPQq/Pv0i7g1g6yv3TJaftOMDGWw
vhoh6GBr9ldLd7f2nPWf8yo8ersHbleuGiWbDBG2O1KToMGPJrPCaIuwtGgPy2N/
8omO9forOEdrwChyavOl1uiZAeSxnSIyV64mWJh3zsj3v/VXG+P/yJD7D/Cg6XUx
CONmgDfHPfPQZv438k2Z7EAVdISDV62yQRLkx4VLi77NduB7jnwo2DgjVCaBfITx
mBL+DUZ21jm4m4cd4uW6mq7WDUyo0KwMgc2rb0x19MAvk7tzA2Owi6uWWUTmk65D
xWMUMz0YcNelbUqWqAlMDqP0OleT8iSN9FzCpC3IEF3P9O79FSiqtadn3p5ZVyzU
MppRQX2uA/TBIOQy12VvzPm0j9RRlVrHqWJf3k0umPfHQXmXCZQ=
=meGf
-----END PGP SIGNATURE-----

--nextPart28758891.yo5t8FPOW8--




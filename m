Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716795A23BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiHZJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiHZJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:08:05 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64407D5EBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:08:03 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:07:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vanalboom.org;
        s=protonmail3; t=1661504880; x=1661764080;
        bh=n+rpQXQC2wMZM690xvnClwo6nWn5j50ssFsl+8Si1bw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=TtE6RWLw7iNHbOO4DQ22V8yTQ1nclLKDoGOZmiclGYqR0B2GFH2HWTKeOsfGkaxVK
         Y59RRE3F3irhGsFtxjyJPIAkFl41ujHsatPkc3jbPkC8m4qyHGukZ4i1+1kSUU2qfd
         Zulolfip3tZqYmfw2ouZriRsCmrfGcCsETOA1GWNIt9BNBmbcd5wWIaN/QZ0SJpiIx
         70TkuMQk6B3Eonpbrh/hRqwJVd0hP5f76HAaqROxHS08HWptgo33LaH2X0oxttvSfx
         0f4X/zJIxgZZLeA82/g3C1WwsCqiW7rCtXgDBa1gdP6BTtgDfZhTkHap6sWpQ6/EOu
         VqtkqgaPEC+FA==
To:     Takashi Iwai <tiwai@suse.de>
From:   Lennert Van Alboom <lennert@vanalboom.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ls.yoyo.m@gmail.com" <ls.yoyo.m@gmail.com>
Reply-To: Lennert Van Alboom <lennert@vanalboom.org>
Subject: Re: [PATCH] USB DAC broken since commit bf6313a0ff766925462e97b4e733d5952de02367 (5.10.0-rc5)
Message-ID: <m8XpaeWJS23wth20p7EgE-Cxwi-5ZwWl0InTEc-wsDGOwh8Nw5RViGXqM_yP92eOmX0Kxfs2hcizPwZaEce80T3OH1rLQ3ph555M1iTCmFc=@vanalboom.org>
In-Reply-To: <87bks7leun.wl-tiwai@suse.de>
References: <T3VPXtCc4uFws9Gfh2RjX6OdwM1RqfC6VqQr--_LMDyB2x5N3p9_q6AtPna17IXhHwBtcJVdXuS80ZZSCMjh_BafIbnzJPhbrkmhmWS6DlI=@vanalboom.org> <874jy0mvwv.wl-tiwai@suse.de> <JGbq2exwKdQ4T8GQCI5YWzGredZVbYtBOxlnBN0ROtba40PvCdEKfz2mKzClqejgZMck374nGQyEIwzjiBi6sKYYNnJgKp26n1-_j6GT3hw=@vanalboom.org> <87bks7leun.wl-tiwai@suse.de>
Feedback-ID: 20549952:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------ef761aa875a8d72b3eb13d1a059424a33f71dcc57218a91d14c54f84ab374302"; charset=utf-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------ef761aa875a8d72b3eb13d1a059424a33f71dcc57218a91d14c54f84ab374302
Content-Type: multipart/mixed;boundary=---------------------8b892d9366ef34166f40132dbe860f52

-----------------------8b892d9366ef34166f40132dbe860f52
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

------- Original Message -------
On Friday, August 26th, 2022 at 08:05, Takashi Iwai <tiwai@suse.de> wrote:
> =


> This option is passed per card instance, as the driver may hold
> multiple cards. Check your /proc/asound/cards. The first argument of
> quirk_flags is applied to the first USB-audio card, the second to the
> second USB audio device, and so on.
> =


> At best, give alsa-info.sh output before and after applying the
> quirk. Run the script with --no-upload option and attach the
> outputs.
> =


> And, as a reference, you can see the existing quirk tables in
> sound/usb/quirks.c.
> =


> =


> Takashi


Not sure why it failed before (didn't look further then, so possibly PEBKA=
C) but as you suggested, this works now (tested on debian's 5.19 kernel):

# modprobe snd_usb_audio vid=3D0x2522 pid=3D0x0007 quirk_flags=3D0x10000


Confirmed that setting a quirk_alias also works: =



# grep -A 1 "0x054c, 0x0b8c" linux/sound/usb/quirks.c =


	DEVICE_FLG(0x054c, 0x0b8c, /* Sony WALKMAN NW-A45 DAC */
		   QUIRK_FLAG_SET_IFACE_FIRST),
# modprobe snd_usb_audio quirk_alias=3D25220007:054c0b8c


I've added a patch for quirks.c to make this default behaviour for this de=
vice. Looking at the Arch bug report at https://bugs.archlinux.org/task/70=
636, it's likely similar behaviour may be needed for pid=3D0009 (LH Labs G=
eek Pulse X 1V5) but I have no way of testing this. Added the reporter in =
CC.


Thanks,


Lennert


-----------------------8b892d9366ef34166f40132dbe860f52
Content-Type: application/octet-stream; filename="patch"; name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"; name="patch"

LS0tIGxpbnV4L3NvdW5kL3VzYi9xdWlya3MuYy5vcmlnCTIwMjItMDgtMjYgMDg6NDk6NDIuNzQ5
MjQwNDMyICswMDAwCisrKyBsaW51eC9zb3VuZC91c2IvcXVpcmtzLmMJMjAyMi0wOC0yNiAwODo0
OTozNC4wMTcxMzgwNDIgKzAwMDAKQEAgLTE5MjMsNiArMTkyMyw4IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdXNiX2F1ZGlvX3F1aXJrX2ZsYWcKIAkJICAgUVVJUktfRkxBR19HRU5FUklDX0lNUExJ
Q0lUX0ZCKSwKIAlERVZJQ0VfRkxHKDB4MmI1MywgMHgwMDMxLCAvKiBGaWVybyBTQy0wMSAoZmly
bXdhcmUgdjEuMS4wKSAqLwogCQkgICBRVUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIpLAor
CURFVklDRV9GTEcoMHgyNTIyLCAweDAwMDcsIC8qIExIIExhYnMgR2VlayBPdXQgSEQgQXVkaW8g
MVY1ICovCisJCSAgIFFVSVJLX0ZMQUdfU0VUX0lGQUNFX0ZJUlNUKSwKIAogCS8qIFZlbmRvciBt
YXRjaGVzICovCiAJVkVORE9SX0ZMRygweDA0NWUsIC8qIE1TIExpZmVjYW0gKi8K
-----------------------8b892d9366ef34166f40132dbe860f52
Content-Type: application/pgp-keys; filename="publickey - lennert@vanalboom.org - 0x0320C886.asc"; name="publickey - lennert@vanalboom.org - 0x0320C886.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - lennert@vanalboom.org - 0x0320C886.asc"; name="publickey - lennert@vanalboom.org - 0x0320C886.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWHBHZWNoWUpLd1lCQkFI
YVJ3OEJBUWRBSFBRaWM5VER0TURQaDgwclllNFlDRHh5aEFTdkhMcUcKb1NTQWMwRGNaVGJOTFd4
bGJtNWxjblJBZG1GdVlXeGliMjl0TG05eVp5QThiR1Z1Ym1WeWRFQjJZVzVoCmJHSnZiMjB1YjNK
blBzSjRCQkFXQ2dBZ0JRSmVrWjV5QmdzSkJ3Z0RBZ1FWQ0FvQ0JCWUNBUUFDR1FFQwpHd01DSGdF
QUNna1FmdENYYy9pU21tNE5IZ0QrTUdVQ2hkZHdRckw4R3hGZVlmVFRLSVJiQ2huVTgvK1MKVU8z
SE1ZdmlnUDRBLzFFdVRhU1RQMU5jVUJkRllvU2pqU2gzQWE2Zis3dFRISXN2TWl0TGF5NEx6amdF
ClhwR2VjaElLS3dZQkJBR1hWUUVGQVFFSFFOTlR3dG11TGpqOXJNZnhOaUtUZ0JyWVNmY3lEVDRX
U1grdQpZY1l3RWdCQUF3RUlCOEpoQkJnV0NBQUpCUUpla1o1eUFoc01BQW9KRUg3UWwzUDRrcHB1
TUlJQkFLMEQKc2g3alVsUHBWTUlzTVdZRDZETkhmaVFEZXcwQVh1WjJhd0JvWEtjRkFQOWJZZkpR
M29ENTNpelNLYkpFCmlLQkh1Y2pDOWJmRzlOcjdsdFA3OHNZN0NnPT0KPXpraXYKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------8b892d9366ef34166f40132dbe860f52--

--------ef761aa875a8d72b3eb13d1a059424a33f71dcc57218a91d14c54f84ab374302
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmMIjVUAIQkQftCXc/iSmm4WIQQDIMiGf8zUXWpveld+0Jdz
+JKabmKgAP4hkH2QQWqbUzCWRV4OJkkNUXa/I2ZZ0ZLPTdx1vxV2BAD9Ff1V
W0vO4lniRGQiw7BOv9iRFJvCsXmQrT7lDTxbwAE=
=ND+y
-----END PGP SIGNATURE-----


--------ef761aa875a8d72b3eb13d1a059424a33f71dcc57218a91d14c54f84ab374302--


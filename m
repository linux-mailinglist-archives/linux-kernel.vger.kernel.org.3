Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ACF5158E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381699AbiD2XYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiD2XYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:24:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E554B2442
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:21:17 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1nkZuw-0002MG-FN; Sat, 30 Apr 2022 01:20:54 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1nkZup-0004od-7p; Sat, 30 Apr 2022 01:20:47 +0200
Date:   Sat, 30 Apr 2022 01:20:47 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 0/3] Enable JPEG Encoder on RK3566/RK3568
Message-ID: <20220429232047.GG7671@pengutronix.de>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
 <198ce3981ad15844627581f9519cab67ed2a81c1.camel@ndufresne.ca>
 <2438841.KJ31GcehEG@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <2438841.KJ31GcehEG@archbook>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 00:27:06 up 30 days, 10:56, 58 users,  load average: 0.04, 0.10,
 0.09
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 29, 2022 at 05:28:35PM +0200, Nicolas Frattaroli wrote:
>On Freitag, 29. April 2022 16:46:01 CEST Nicolas Dufresne wrote:
>> Le jeudi 28 avril 2022 =E0 00:44 +0200, Nicolas Frattaroli a =E9crit :
>> > the following series adds support for and enables the hardware JPEG
>> > encoder on the RK3566 and RK3568 line of SoCs by Rockchip.
>> >
>> > The JPEG encoder is its own little Hantro instance with seemingly just
>> > the encode functionality.
>>
>> I'm a little suspicious about this statement. I believe the Hantro combo=
 is
>> identical to RK3399 and that you are confusing with Rockchip JPEG encode=
r here.
>> Here's the source of my suspicion:
>>
>> https://github.com/JeffyCN/rockchip_mirrors/blob/mpp/osal/mpp_soc.cpp#L6=
37
>>
>> As this get burnt into DT, we really need to get this right. Perhaps we =
need to
>> run the reference software to verify ? Ping me if you need help with tha=
t.
>
>I believe there's three separate questions here:
>
>A) is this a Hantro instance with more than just JPEG encoding?
>B) is this the same as the other[1] Hantro instance, just with a bigger
>   offset for the encoder?
>C) if A is true and B is false, does this also have decoders?
>
>I think I can only answer B). I do not think fdee0000 is the same hardware
>instance as fdea0400. They are in different power domains (yes, this one
>being in the RGA PD is correct according to downstream code, TRM and my
>own testing). They also have their own MMU each.

>Your findings point towards A) being true. I'd love to be able to just
>throw a mainline VP8 or H.264 driver at it to check, but that sadly does
>not exist yet.

Not Mainline, but for the the RK3399 Encoder there is some initial work
available made by bootlin.

https://github.com/bootlin/linux bootlin/hantro/h264-encoding-v5.11

They also implemented some initial userspace tool to test this.

https://github.com/bootlin/v4l2-hantro-h264-encoder

If you have some time on your hands, it would be great if we could test
this on the RK3568 with the VEPU121 core.

>Upon checking the TRM again, it seems it documents registers for H.264 as =
well.

I would like to describe the whole sitation a little bit more in detail.

In the Datasheet of the RK3568 there are several decoder and encoder
entities documented. This encoder instance is called VEPU121 in the
TRM.

RK3568:
-------

Look into "Chapter 10 Multi-format Video Encoder and Decoder" (Page 463)
of RK3568 TRM Part2.

https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part=
2%20V1.1-20210301.pdf

We also find some mentionioning of JPEG encoding in the RK3399
datasheet.

RK3399:
-------

Look into "Chapter 5 Multi-format Video Decoder And Encoder" (Page 297)
of RK3399 TRM Part 3.

http://www.netbsd.org/~mrg/rk3399/Rockchip%20RK3399TRM%20V1.1%20Part3%20201=
60728.pdf

* Supports encoding of the following standards:
  * H.264: up to HP level 4.1
  * JPEG: Baseline (DCT sequential)

Which probably refers to the core that is also available on the RK3399.


Comparing the register layout of VEPU121 of the RK3568 with the
encoder part in RK3399 we find nearly the same register description.

10.5.21 VEPU121 Detail Registers Description (Page 704 of RK3568 TRM Part2)

vs.

5.5.4 VEPU Registers Summary (Page 443 of RK3399 TRM Part3)

However this is just the documentation, this could mean nothing to
the real world. Getting the core tested with the bootlin stack
or getting feedback from Kever would probably tell the whole story.

>However I can do this to answer C), and I will once I get the time.
>It would be somewhat surprising if there was a hidden third H.264
>decoder on this chip.

The corresponding decoder world on the RK3568 is also very unclear.

It supports RKVDEC (referd as VDPU346 in the TRM), that is probably also
supported by the mainline code you can find in drivers/staging/media/rkvdec=
/.

Then there is VDPU121 which seems to be just the same G1 as in RK3399,
regarding to these patches:

https://lore.kernel.org/all/20220213195316.4149106-3-piotr.oniszczuk@gmail.=
com/T/

The last Core you probably refer to is called VDPU720 JPEG Decoder
located at 0xFDED0000. I also really don't know where to put this in
at the moment.

>I'll also CC Kever Yang from rockchip, maybe he can shine some light on
>this.

Since the RK3568 seems to get more and more of attention at the moment
I would like to ask if somebody is planning to write support the RKVENC
in mainline. That is the VEPU540 core refered to in the RK3568 TRM.

I would start with that in the next weeks, taking the bootlin H1 support
as an reference to handle the request_api for the encoder part. Which is
currently completely untouched in mainline AFAIK.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmJscsoACgkQC+njFXoe
LGSbiRAAwCISPC4Va5HEdBHABLuRteCTtHhDhkuYj8/IMqOrN8S8vIYEpo+TRY2+
hkt0QkY06mgDwmcUhiw3plaMGnAMMgvZMSQwS4YTS5LelpsbugQS3gSaznQq7cc5
zvznuZlNFfY85Kz7HrPrtWiCHbZOyRNb3IH42uwFB0c4dqAr58C/eA1bMuoxj4jN
xxQ8e2lU8h8BpvNSvy1GwkojITWK4S3U4t52ZnfeQCXImy332kIWBcXmPC+8JSnT
SgU2t2F94E0v5l5HSbm+FGqugn/ALt3PWF+PFin4Ux5KSUnLiYWhOp28HC8wMIiw
3LCWjqknc3PUL6MKw2/7PqIlXB0uPVgpR9my+aXn3dpHoFRLkM4rQ+FxvjnRzW1H
CRhgvoUukFDQsYwT5UndJhEMHPBnG+4n+6aE7AqI2HKjPdnSoXaEqpz1Qij1Jgb4
BQ0S9R5oa1WZk7GMA/9WCgIevOtn4bGFGCTZQPAWAqubVZQ9SvBEuTjPsDQX0F6l
Dt03o+hUzL3yYFJZjhWUBcf9rs4dG4oKwdPbqz72IPzfb/xxc9iZLR12cqzgwwci
lYdH/5VVDrTFbjCnLrMahw+EHN3OXqtP97fjTgfHkyAyzw5ksjnTqzJ6QFdVO4BI
Nth/At4dnJeCPAWrEiOFd6XY1q06YHxgOBvnzE8KIURGBHeUdFU=
=OhKV
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1458DFDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiHITIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiHITFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:05:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE9414D24
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:43:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oLUCR-0005YX-Q3; Tue, 09 Aug 2022 20:43:31 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oLUCQ-0000nP-Ee; Tue, 09 Aug 2022 20:43:30 +0200
Date:   Tue, 9 Aug 2022 20:43:30 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] media: hantro: Add support for RK356x JPEG encoder
Message-ID: <20220809184330.GA4380@pengutronix.de>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
 <20220427224438.335327-3-frattaroli.nicolas@gmail.com>
 <20220809124508.GL14307@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20220809124508.GL14307@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2022 at 02:45:08PM +0200, Michael Grzeschik wrote:
>On Thu, Apr 28, 2022 at 12:44:37AM +0200, Nicolas Frattaroli wrote:
>>The RK3566 and RK3568 SoCs come with a small Hantro instance which
>>is solely dedicated to encoding JPEG. This patch adds the necessary
>>structs to the Hantro driver to allow it to function.
>>
>>Tested with the following GStreamer command:
>>
>>gst-launch-1.0 videotestsrc ! v4l2jpegenc ! matroskamux ! \
>>              filesink location=3Dfoo.mkv
>
>I just tried this pipeline on v5.19. The filesize generated is increasing =
and
>data is generated. However the content seems to be unusable.
>
>When playing foo.mkv with e.g. vlc the following errors, that no JPEG data=
 was found
>in the images, is generated:
>
>
>[mjpeg @ 0x7f2f08c1f780] No JPEG data found in image
>[mjpeg @ 0x7f2f08c1f780] No JPEG data found in image
>[mjpeg @ 0x7f2f08c1f780] No JPEG data found in image
>...
>
>
>The same with gstreamer:
>
>gst-launch-1.0 filesrc location=3Dfoo.mkv ! decodebin ! glimagesink
>../ext/jpeg/gstjpegdec.c(1418): gst_jpeg_dec_handle_frame (): /GstPipeline=
:pipeline0/GstDecodeBin:decodebin0/GstJpegDec:jpegdec0:
>Decode error #53: Not a JPEG file: starts with 0x00 0x00
>..
>
>
>Do you have an idea why that is? Did you test the pipeline with an earlier
>kernelversion and validated the generated content of foo.mkv?

After further debugging, I found out that my latest port of the bootlin
patches to support h264 encoding broke the hantro driver somehow.

https://git.pengutronix.de/cgit/mgr/linux/log/?h=3Dv5.19/topic/rk3568-vepu-=
h264-stateless-bootlin

The good news about that is; it is possible that the same issue
was the cause that I thought the h264 encoding is not supported on
the VEPU121. So the support is still unknown

I will come back to that.

Regards,
Michael


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmLyqs8ACgkQC+njFXoe
LGQItRAAj/Maz6S+qvjgj2qxwTHOXNKpxXLuukYWID55zyIjCBhMX0TmPsGTIQQD
bkD2FB31dykYjtx5JepDztiDPoTFe1JH8FFrnOR/d1rNl40oZRVefBBMxgcS3niF
PZXOD0tQ3Z3jyXOVD9AUPUJWsJl0w5ROBJjtkgCpF0KfH+29S90xPe3ktFZaU6bY
KScHe3dLKEKNEHs/6tjgI3VphHabmxcFj3iucSm88jio8GLx67uWN6rKjKkZxHz8
f5yw6Ta96yVUL3G0mPrlMVL4SlI7jnEinbGL5lYHXO5sfKej4nZfLEIbtVxXTHP2
TfHup6Ws6dFAoYUcKTGwvzblbtH5Y/6Nk8LyCud/NZT3DBEr9MZRbjizlC/QGeAY
yjryjYiCJMxi0f7IkhCGYupBRKb7eofugJAymiaMKHrGRctRSXUfj0twHxrBzMz6
fYVWhYqSmjrZjsRIqg1q0GUu24kG1UtCnvqnkhSJIvSGYpIXmKeeKkDaEVhD0V6r
wP2VX0dJfbf5Jp9zpNynVY0YacOngis5muLKTnbBeATXEH1Inv+ShzoaiHRrk1t8
FQ6IFRv8HiR+zZFy4y3vWDo4m1xzoRR03Jmhf/CYBASPIHhQk3oU3ArqtEEigkA9
OO2fTaFTnrFipkOSgysdGAl9/KXpuwXFdmiwoXmWlzj1ZEsFlGI=
=BxJZ
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

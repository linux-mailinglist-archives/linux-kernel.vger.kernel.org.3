Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F951A1EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351129AbiEDOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiEDOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:15:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F5419AE;
        Wed,  4 May 2022 07:12:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 75386320027A;
        Wed,  4 May 2022 10:12:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 04 May 2022 10:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651673529; x=1651759929; bh=xUUhuAdWl5
        ztZDGXsYgh3f41yA2CkH+/W2wG9PAr7kU=; b=wiHx1q5liF64+jC1h+QiniPKBL
        t2dX9X2+maVEUh+r7S37r7+EpzQ3ujUGzSre70LRHxqZ3Aw2KbBV7D0wB5qe3zmR
        UOf3/8GRHvCjpvP1LpjtfAOnmqGSkPqTCBIdbkPQCRZ5paJ3EVwhV7zFfnFhdJ4Z
        XG1hdve7+c+YHoB1IqJsSeOL59ce4fYQzIsYQurD9eXiGFTp7hgYT76QjZmVGNtJ
        Jpermg9Be8ZZC1ZzCkCSC6PdPIs0JIaBHgdQi2hUrlhavkLb2UuRyM+JStqAy090
        SSs1K8l576D+f7UxxX8Kj8XRLc9JMRS58RZgb+JwgjA7H/v84slLSAG+hSHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651673529; x=
        1651759929; bh=xUUhuAdWl5ztZDGXsYgh3f41yA2CkH+/W2wG9PAr7kU=; b=b
        4CD9mu/DX2GZhwPHXlDAlHSWDPiq6U3YCdxPREQzj+Ixonm9DnW2V0ACn9aRsX/X
        XWtX2hxcwjKlbxlhpTduqH5ZXlUfC+MYdJUYkqXVg2XRPn6q+iGR7HqXb17lFH70
        QyVdoAqIpD26RtMbGuRMehgjazoBPqNGwY05JcNikkfPbm5Y87JvnQdnJyPIfqRu
        MgiD3TnWJm80yUopP1UNgiXiuneP7tvaGevSLreozrOz6HMZtPk9pLLYcz3peBqX
        H8UM1Wc+NozWSh1tqbRwLkGjU5LqQFdiUDpkf1J4FtMnXwlSiJnQWXHhITNTei0a
        whWCUxlxd/aAhRmfsfA2g==
X-ME-Sender: <xms:uIlyYunEAHSjVfHJkOdq7LSA4pIQ7k0Sjjd95wq69EgYOK4wErA9ew>
    <xme:uIlyYl1J__EqRGeJ7VddqJaBim9zcXGqszhSXOt2yYO-8Ci2pONhpfGX5ny8utHgJ
    _4g89uHyoc48I2eiLM>
X-ME-Received: <xmr:uIlyYsoiuKTxN47W4nAhz4bqlSG4hKBtEvV9vWrJEHQ3o8CihAtLjszjUjvpzgWIdXf2zwTiGigs8uuVyWmDT1Ex-DAN80XPHzDqHLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffekleevgeejieeigeeftddtgfejheekvedvudetgfduudfffeffueekfeeh
    ueegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhhugihfohhunhgurdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:uIlyYim4wxT3MBp7xYXWU7dJt_ELeHilF_g8l1e7VpJPOyrc7D8P2A>
    <xmx:uIlyYs0D2j4msU21Z9dqwLT8lyMLQjmHEAn1w4IPQoQSTDnrdXszIw>
    <xmx:uIlyYptoIGoGVEAFQSMaUwVx-P7DaA8koWYxwBZsoGxdBRrRnX9UvQ>
    <xmx:uYlyYiw1y7yGZeoAFBKDd1COur6orF-Ov15gxE9xDrcW4GqRgPWfNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 May 2022 10:12:07 -0400 (EDT)
Date:   Wed, 4 May 2022 16:12:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220504141204.iqjwa62ije2pedal@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
 <20220502112112.3ne7zy4b6gggxzoo@houat>
 <4aabfd63-18e2-65c5-d1c2-d7600afc1c40@roeck-us.net>
 <97e3af18e947492b1ac968c058ba509f@fabmicro.ru>
 <20220503161446.tl3qoqqnkzq2f3hn@houat>
 <18ded45dcd670edcc9eb9811e7c7c034@fabmicro.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="66mbevpbgads7k7l"
Content-Disposition: inline
In-Reply-To: <18ded45dcd670edcc9eb9811e7c7c034@fabmicro.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--66mbevpbgads7k7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2022 at 02:37:32AM +0500, Ruslan Zalata wrote:
> Hi Maxime,
>=20
> > At the hardware level, I'd assume you would either use the LRADC as an
> > actual ADC, or use it to drive buttons, right?
>=20
> Yes, exactly.
>=20
> > So I don't think a new device tree binding is such a deal breaker since
> > you have to describe it differently anyway.
>=20
> ...
>=20
> > Since that would be a completely different use-case, the IIO driver
> > doesn't have to support input right away, it can be done later if
> > needed.
> >=20
> > And you could have the two drivers compiled at the same time.
>=20
> As I got you right, you propose do add new bindings, say
> "allwinner,sun4i-a10-lradc-hwmon" and "allwinner,sun8i-a83t-lradc-hwmon" =
for
> new driver, which will allow two drivers (hwmon and keyboard) be compiled
> and loaded at same time, only that one listed in DT will be instantiated.

Compatibles are meant to describe the hardware and remain OS-agnostic,
while hwmon is linux-specific so we should probably drop the hwmon from
the compatible. But otherwise, yes.

> If two are listed at same time, one of the calls to devm_request_irq()
> will return with an error preventing second driver to be probed (some
> error message would be necessary to let user know what's going on). If
> this is ok, I will implement it.
>=20
> I think moving this driver to IIO framework is overkill. We use LRADC to
> monitor battery temp and state (voltage) and that's what HWMON was made f=
or.
> It's simple, easy and elegant.

Yeah, that's that *you* use it for. If someone wants to use it for some
other use, what's going to happen? Will we create a third driver for the
exact same controller? That's not reasonable.

> IIO, on the other hand, is for data acquisition and is much more
> complex beast. Can we stay with HWMON, please ? :)

But it's generic, and you can plug hwmon on top of it. So you don't lose
any feature, but it also doesn't prevent any one else to use it for some
slightly different usecase either.

> I looked through the code for a number of iio/adc drivers and I could see
> that all of them initiate ADC conversion inside read(), then wait for
> completion and return single sample. For me this very flawed approach
> because a) much more overhead/load on the system,

To monitor a battery? What kind of polling interval do you expect on this?

> b) initiating conversion may (and will) take more time than a single
> consequent conversion,

Ditto, I'd expect to have a request in the order of seconds for a
battery, so the setup time will be negligible.

> c) samples will be read in irregular periods of time, hence acquired
> data will not be consistent for any further processing (like FFT). So,
> this whole IIO framework is no way better than HWMON, yet more
> complex. At least for ADCs. :-)
>
> A better approach for an IIO/ADC driver would be to implement some
> serialization mechanism to let reads go in sync with updates (IRQs), with
> buffering, guaranteeing no same sample is read twice and no sample is los=
t.
> The read() would return next available sample from buffer with nearly zero
> overhead or sleep till data is available.

Like this:
https://www.kernel.org/doc/html/latest/driver-api/iio/buffers.html ?

> And the best way is to extend IIO framework to support ring buffers
> mechanism like the one proposed by Analog Devices, but that's a way
> different story. Link: https://events.static.linuxfound.org/sites/events/=
files/slides/iio_high_speed.pdf

Those suggestions were to handle more than a ~100 kilosamples per
seconds order of magnitude. How many samples per seconds do you expect
to get out from this ADC?

Maxime

--66mbevpbgads7k7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYnKJtAAKCRDj7w1vZxhR
xdtKAQD8ETOpp5uHBoLQ0BmZsA0blycwGb6XqOpbIuD8ExWyPgD/cak7iCKVEfxm
6SJtMB+QLLQYe4LICLR1en4ssJd5nQQ=
=RTTX
-----END PGP SIGNATURE-----

--66mbevpbgads7k7l--

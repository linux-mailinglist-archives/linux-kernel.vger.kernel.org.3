Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC63518951
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiECQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiECQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:10:55 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AF245B5;
        Tue,  3 May 2022 09:07:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C3F01320090F;
        Tue,  3 May 2022 12:07:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 May 2022 12:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651594038; x=1651680438; bh=S6jBLD8l+m
        Ir0OzRt6qgeH2J1Vwk8FdNOOo2AvGlnGY=; b=JgC0htdr53/McvizUOUop1w8ra
        AuLKzW+TMwSdIZ9dcpvFAveVzIoEQ1oyzQpV4UbEEcKkJZSgE0flClZhE6XUaO5c
        JvXgr0JLR55CgDMEr7A0zRicW1gsyejasG75Yyu/cvmmlIy95gV9HLbVH2VROK8Y
        sSs/r6uI/RhBWZ9Yh0rsCAazxV8gNd8GZbVNFaFAdAUN9Rt1jmuiX84OJiLs6E/1
        hPUCB1FpT5NovLjp/jSzQFji2W42x9ItMMav9BC4rckpEp/I3W1m1ucYsj5J7ies
        uAG871iwoViNQSg3ZWKVvSNA6WofWPdoCKwlvIQRX+YZoNE/jm2wdiI2zGRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651594038; x=
        1651680438; bh=S6jBLD8l+mIr0OzRt6qgeH2J1Vwk8FdNOOo2AvGlnGY=; b=X
        j5+twy5OwmxFkKSCwC9YvG0wzd1S04zkqRgBtdGTgO+UivtzlFLA+UD5X6ZTxyt/
        fMxAEIR4DPtJld4z5IIvLxIHyuKtK/+rKIwwMYms/bMllDHl7yBJ+q0GLMUc0Cb3
        KnswFDzG6wnfHevEruUdJlMO8NU1EzDa20PK3gHcq01YQzWeDbwjNvKjQat7mfOA
        EW9pNy78y7KaTDddDBEz1AhsJcxj12LVwTynw4bGva9N6kxZAgmoJoPu9kqQvNZV
        +MaiQ2U8xDW2PlZuT3jnG/JbRH4//5xwTNaQoZ78LSwsHaA4F3BWGrRYD94mPIF3
        KFw2SwHQg+zUhy5Otf5fA==
X-ME-Sender: <xms:NFNxYq7MW2e4oeOMm-bPtR-r-Zl8kkVZniv6jmT9FFPPXMNoB9KKsQ>
    <xme:NFNxYj6WWFgYzr6rgVh5Xn8fVovESqHxHwJwHWheeNiJImFOp61WNWY_iEtD7NJjY
    isX9aZpsUcOz8oCy-U>
X-ME-Received: <xmr:NFNxYpcEPHGKBllVpD1iT97CFClOajIjwafjWikiw-9fdX8QHi3LsV8kD7Bia0bK8GW3JouqrGkqBARjKhDcUVq5wuyyHtMbicEjUfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NFNxYnIKxZTY3cT3b-T0BC_i3UNejWx4x2rCHlbrcZXg-z8G-0SHwg>
    <xmx:NFNxYuKioxjX8tJimduJWAQ47shg_gN3HbSsyIl_JV3S0stvrVfFTw>
    <xmx:NFNxYowCQicvH7wAEGpXRxNBz9PHhfp1rq346ofnjwwq6Z87tzg53A>
    <xmx:NlNxYt9AYSRBtZPogH7rtehgAW7qDSdkm-pxska8vyFZkXkkwnK-Nw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 May 2022 12:07:16 -0400 (EDT)
Date:   Tue, 3 May 2022 18:07:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220503160713.7kdikhd5kkgkotcp@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <6009fbef45a8b77caa4fc137093a1e23@fabmicro.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o7q6542x2x5bfqc5"
Content-Disposition: inline
In-Reply-To: <6009fbef45a8b77caa4fc137093a1e23@fabmicro.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o7q6542x2x5bfqc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 03, 2022 at 01:50:39PM +0500, Ruslan Zalata wrote:
> > I guess a better path forward would be to either register an hwmon
> > device in the original driver, or convert that driver to iio and use
> > iio-hwmon.
>=20
> My first idea was to add hwmon to sun4i-lradc-keys.c driver. But soon as I
> began hacking the driver I quickly realized that it would be a mess since
> keyboard and hwmon belong to two different subsystems.

That's not really an issue in itself. There's plenty of drivers in Linux
that register into two frameworks.

> Besides we would need to invent a way to control which way the driver
> works (new bindings?).

I got confused there, and thought you were adding temperature reading
that is in another ADC on those SoCs, sorry. Yeah, that doesn't make
much sense to have both in the same drivers here.

Maxime

--o7q6542x2x5bfqc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYnFTMQAKCRDj7w1vZxhR
xSoRAP9r204XnvG9FZ4a7NWbYj251o27k2mVVJqIz+t4Sa+vUAEA4W71CIx9ZBaA
7muZe/5EDx4iJnaVyoBUgq/XK0A4wgQ=
=tNMn
-----END PGP SIGNATURE-----

--o7q6542x2x5bfqc5--

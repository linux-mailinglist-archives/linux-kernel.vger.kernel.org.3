Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86222586E56
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiHAQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiHAQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:12:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3387120AC;
        Mon,  1 Aug 2022 09:12:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 241095C0053;
        Mon,  1 Aug 2022 12:12:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Aug 2022 12:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1659370322; x=1659456722; bh=ilT1VhmGWY
        p841mQwG/DMZv6fb55bb/GzH+Kzsjzuvk=; b=V9Ss7s+kXj1/youCDMlbn66hL1
        zGbD4qcJLkNBzSkUuIexDCjXysZO3pALqg8oDdAv3jNYRwiTPdTql8a+Rz6Jc7Xe
        KAJdO+3xCnCFXEdMjbadMpnZMBCNwElIVr6r6YYuyzirAlYOx9p4hoEGWDdtV95Y
        4pKbnJv3ojePQ29ET6TxJzt8j2fKMsdyAEOjq8XuY0BpHw4bcVy7/KF2DOXN4qO9
        xukWSDBI5KNYKxDpyArVGY9O3uUuQror0AZkRaYnGZR0DAU6fVQZ39DsADkctdLi
        Y0IDOgQB2rhSUDMYOu9D4baC5IvqpPFWlK6fXinkJSSsIP6InH6sGOQM5/vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659370322; x=1659456722; bh=ilT1VhmGWYp841mQwG/DMZv6fb55
        bb/GzH+Kzsjzuvk=; b=Ocld+HYUku2/sI1jg7zEb73DGtKeobcaBuv4S8wTZ2yg
        io7DcAsxsyBgxJBlxL1wzp6Pf0SNYK+2GFK454w5c3U3Rgsr1+vyV/KYE23lUgdZ
        M8VohemhPgGdU7BnLv3FM9OIJyy5zBU1dOOACEX1k2Ve3UmLSe1kYMCOMNAgug4O
        kxwOzJr8IvZR3JkvTPGyqLk5ZvdfQ/NdegFk8gwpdwm3IGEt10qOunLC2k24cdpk
        rdgmZXimelwDQGBRJjCbYZ4vAbuNhKwyijTFfN/MJTIDSglNZQPvRspE31ctV7FK
        dxGyjUwiAOTFunYXn/xcsETtGQkK8BGIPRkhzafq7w==
X-ME-Sender: <xms:UfvnYqzxt2eWlV_o5cosfyzrBvsye0bXHpaqyp02WpfKpE6oHbRt8A>
    <xme:UfvnYmSK-KYUFjZFt_F1wCAn7rYFoR_RQ6W57ADK1mopGtqtbklet5_4BuPLoDv9b
    rm6r41k51TQoqgKIcA>
X-ME-Received: <xmr:UfvnYsUcuaf9t26lPb9EzJWbaNXYeNYMhmLjkMt9X8laBLZyGJ1NukZL6zf8uS_u1BgBjH4JlHX4yRoQSEnLmai47Wr_cAHZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:UfvnYgiqKVrLgZlHmdS_lnCS3UyJfZQpAZqzXrbcqM3cvVGi2Qy9NA>
    <xmx:UfvnYsBZJL68goMPPUOlw4CQMQHBQ396JnnO_nPsbbrrP8Wa5Ao5LA>
    <xmx:UfvnYhJTA1zM0jKHZgrDISSiQ-HNM1HpyCcFDX1iw1m170YbwrH6KA>
    <xmx:UvvnYr58dwckJQiWWx-1SaqfmMVcYgZHPFGZGNVnCTzcuTzw3LCq6Q>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 12:12:01 -0400 (EDT)
Date:   Mon, 1 Aug 2022 11:12:00 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Potin Lai <potin.lai.pt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
Message-ID: <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com>
 <20220731130959.50826fc4@jic23-huawei>
 <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com>
 <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Gjd1qHuI9vRoQdHR"
Content-Disposition: inline
In-Reply-To: <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Gjd1qHuI9vRoQdHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2022 at 10:22:16AM +0200, Andy Shevchenko wrote:
> On Mon, Aug 1, 2022 at 3:52 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
> > On 7/31/22 20:09, Jonathan Cameron wrote:
> > In our hardware board, we have "ti,hdc1080" as main source, and "silabs=
,si7020"
> > for 2nd source. This two chip are locate at same bus and same slave add=
ress,
> > and we want to use multiple compatibles to support both chips with sing=
le device
> > node in device tree.
> >
> > Ex:
> > compatible =3D "ti,hdc1099", "silabs,si7020";
>=20
> This is simply broken DT, you must not put incompatible hardware on
> the same compatible string. DT is by definition the description of a
> certain platform. What you showed is a combination of incompatible
> chips in a single DT.

We were mistaken that this is the appropriate way to specify this
behavior, partially because it works as long as the probe functions
return an error the next matching driver from the compatible will probe.
It does seem that specifying two different compatibles like this would
violate the intention of the DT spec:

    The property value consists of a concatenated list of null terminated
    strings, from most specific to most general. They allow a device to
    express its compatibility with a family of similar devices, potentially
    allowing a single device driver to match against several devices.

>=20
> > In order to support this, I need to add ID checking mechanism into the =
current
> > hdc100x driver, so the si7020 chip will fail to probe with hdc100x driv=
er
> > (because the ID checking is not failed), then success probe with si7020.
> >
> > Base on you explanation, it looks multiple compatibles is not suitable =
in this
> > case? Would you mind advise us what would be the better approach for ou=
r case?
>=20
> If I may advise... fix your DT by dropping the wrong compatible item.

This doesn't really give any helpful advice.

The reality is that these two chips are pin compatible and function
compatible but not driver compatible.  Boards have been manufactured
which are identical except for this chip replaced, due various to chip
shortages.

Making probe fail so that the next 'compatible' is chosen sounds like it
isn't desired.  I'm pretty sure you can't have two DT entries for the
same i2c address, but with different 'compatible" properties, and even
if we did you'd still need probe to fail on one of them.

Are there any other suggestions for being able to inform the kernel that
one of two chips might be present?

--=20
Patrick Williams

--Gjd1qHuI9vRoQdHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLn+04ACgkQqwNHzC0A
wRlfTQ//amKYKmMJr6Mt4WHMpVSsZLyIFAM08NxGUnDkF/8jJ9z+PUWKcsSuiwnf
VjRdBYnliOA83OA0JSgwFQcTFWyJ8pIZ85aiI+nDqzkS7yPhdOY6Y7O2wBFmM+Fo
mUuHDyJx997lVWL7pjSkSwi718ejEjeKvkuZmxlOF79SCh6L63TH93FzO6xcSwyI
e9mUOYq/BR4DSW+HWSJVHenBOOU8EZHcHxtP+fHrrk8QGz2KAIS01XdySYscZCgf
woK1ndpaMovHOKNT9qrUX21/FaCYqz8z01W0WEEU5KriH3Eg7b1/wNek3jVSNKau
PRfi3HDIS7TXWK37QV+JgO5lYplj3zZl7C3ij+7+Wz6V6fNywh4OIpCJL7QAWZdp
2DL2x0K8rjOABV3HSPvyby9DdR7RUFJ+x9+uUW22vJEe0XBD8YZhFCmXDXgqWzA8
9tmEmqZVwZZpyQESKRyKq3uP6ZaZl1hn6qDK8NCgXZMbdbWm2sb9PYHJEtEFyMNu
xOPLKGRte39XaD/fXL8d4PnRatt37VdImOepN/FUPyyCM66mUwb7Sv0bHik22+/e
Vq+Cv70o5emWQFnMmmiNItlHWJxpQS/R2Btshdr79Zzv8W9XvVTE/q5hRjzAD71F
Tq6xWsfclzIyeBaTCB1rmTzjvGwWBqZ9JSS7lcRWR+0uE6WveDM=
=iSnM
-----END PGP SIGNATURE-----

--Gjd1qHuI9vRoQdHR--

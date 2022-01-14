Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1B48E76A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiANJWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:22:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60467 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237209AbiANJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:22:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D6D1B5C00DB;
        Fri, 14 Jan 2022 04:22:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jan 2022 04:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cQmLUW4L1FEJoG2i78hQInelQBw
        j9IPgEIxv1HzyOnQ=; b=Kkhko+aLF18aWSTBVP/JIdJhX7jRp3g9gabM0ilBFDb
        jfQM4BteZRuJq1n1UH62IS0LZSs3YrDM826dyWSOVsy1wll9DdK8Sh+nfJRe3tD7
        DL+w0xuFyqxvBsgdEwkBjQlZXF1sEGbE0/sIuQPlFZCz+h9E7g+f05nYZcGJX0PR
        zDkphLPiCqQd68shJVe3+QLbCOUSjyCpRhE3dGVvtGRWQ95I50s9mOLoYPIBfqUw
        lWQFA5APNHAB/X04ifxxHjJmfgM4mZs/9f93VlBPw/78Oj2v5o5laoWlcPPHxGwf
        uFduc+3P+NN4mfsA/63cPHmK6B8MVeKlXcuOEa47ykg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cQmLUW
        4L1FEJoG2i78hQInelQBwj9IPgEIxv1HzyOnQ=; b=gvfhQSnP7KIInyriGsSrsG
        VrvXXyZ6XKYSe+c7sYgBJd/YVAS01EGCNuzuM4AySb+oGT7+6mZWG6EGLuxtp5Xr
        u+XgP0nLD0bH8jcQTRGValojMXdofPJKDENh2ur6eC0oDCn5jdwQaBFHqqn4E8OI
        2XNzhr6o4CjUx17+WkmRlvY0cvT9J6jZ4G5nhx2Raw0+YxiOUJ7nzyrfMPA+oWK4
        QUrn3xP3QoCUMwAMivp6mgkYOekFIGtHt856bysQ/WApQkhjDwvmdEB2/rUtU5i0
        DUV8i6tC5QaQ2gCYzPxNXR7dOlzVpxDy6+KRy8BKuwdgCzOZlLD1SazQkwzxY7vA
        ==
X-ME-Sender: <xms:6EDhYXR3jc8qJLPTY53rX0Q8c1sezQGVbQ6vYd4t9JE80JkTbner_w>
    <xme:6EDhYYwwdHfO3KO9X8AJKnrgdRxycto0-INEGVw4Iz_FKaeqsdmgj3QZ7bYCSvOmW
    6y3abFYC5lh_r-cbps>
X-ME-Received: <xmr:6EDhYc3LhmDjW8QNjUo01OdgcQuit3jViWzTRdiy5frY5lpbokJD2qHaYrNngoX-3wwz7fIHLwTkZwabss3pPipVopfRporTCbUSMJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6EDhYXBgXiCiY0082cTCJzBVFO9ODL2Cop1YDGC3GjbZHBMSMTvqfw>
    <xmx:6EDhYQh0V9a8_4HvNS4VDkV6A0XfeaMmUCj1ut29sklOF76EK-BaIA>
    <xmx:6EDhYbozwj3oEaBYNFwV7qfUgv7RHrFwXsMeka-E0_DLQ7sHRoUAuw>
    <xmx:6UDhYZuWs3nO0Bm_hiXpP3IBzbsxHSOcwI1MBOkCnyUw8e77YAWV0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jan 2022 04:22:48 -0500 (EST)
Date:   Fri, 14 Jan 2022 10:22:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Conley Lee <conleylee@foxmail.com>
Cc:     wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sunxi.yaml: add HAOYU Electronics Marsboard A20
Message-ID: <20220114092247.rp6ym4jvsdqdrkib@houat>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
 <20220112031347.2492813-1-conleylee@foxmail.com>
 <tencent_A92DC943F79DB360AE14672BB749BFE08A05@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udown3pb3uwkp7mh"
Content-Disposition: inline
In-Reply-To: <tencent_A92DC943F79DB360AE14672BB749BFE08A05@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udown3pb3uwkp7mh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 11:13:47AM +0800, Conley Lee wrote:
> add haoyu,a20-marsboard bindings
>=20
> Signed-off-by: Conley Lee <conleylee@foxmail.com>

The prefix should be dt-bindings: arm: sunxi

Maxime

--udown3pb3uwkp7mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYeFA5wAKCRDj7w1vZxhR
xQVDAP4uGnwAKIXC/n4kDI8zrWYe34MlaPqsw9SmTEqOIN/2jQD/T2JSkEisGBpm
CadSdeGnrp42O7MLucn/aaPr/TtTjQA=
=89hF
-----END PGP SIGNATURE-----

--udown3pb3uwkp7mh--

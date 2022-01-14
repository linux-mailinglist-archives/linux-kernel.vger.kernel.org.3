Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309748E762
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiANJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:22:20 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34971 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237209AbiANJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:22:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B0135C00DB;
        Fri, 14 Jan 2022 04:22:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jan 2022 04:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=feN1Oydf4qVcC2clWvUDDBDr4O6
        rqWSb956LBoZ4ZDM=; b=S8lMbUdBELTVyaNDokxKURuMdAlD6oKggcEK5TotPvS
        kiY8Y2eGH18fSyAhcW+xUVmAAb6w5RAk88qRS9RCo73TnGYShKHtDV4xUwSBmIBf
        +dcxLjxLwwANu41rvl/+cKz7y4F3Ot1kOHdJIZSZLw2OlIKNhWxbbT/ylUPDd4XF
        3+MU14W+6HuQ/xxhL/XXsbg5keDa6PMriQy3Nxsnu83MltzsnUqN+vVhSstfZg5X
        v2f5NFvG7wWQJqOmvYYrKH5zSQHYOtclSYOSM8fW6feofrFFzt3hVpweLmy519D9
        pZROtkrEVwtYXUbfokN1D1bMQoV1nFj3OTtUQysrmgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=feN1Oy
        df4qVcC2clWvUDDBDr4O6rqWSb956LBoZ4ZDM=; b=TlkBs/RF/HK0zVLZb2AIdE
        Qrq1Hm/1M5LRE7/R+YPPuKbxlHFdCf1JQkYv2hs6ABxBJ1Hqv5yZsp5webPs8QsD
        AZiq+cnBoIlRHLS2KVaA7pB+eLVH4r1GTeTxpTbYMfd+Ofxp/jEc+kc2MCBTK8nd
        wnDVTzXMs7aA0rlleInd4XFTqBesysB6qtbhClRv6pFzQnRDQ5XC8AXt6uV47dc2
        mM3CmyN084/Gn8swQmibvB4B8gG/92ZQrIY+LEXfvLWhs+DgV8mVMkEZs5bRq3kU
        GtEnQZE34aPjS7jcaGDuT2Fm5fytdziy5apdpKa8PcEYtWUvqYkSfEZlmRG7EqnA
        ==
X-ME-Sender: <xms:ykDhYQT85q5FOGSeYEeJBY1F3Bl7hbcOHIITv9WNgXqAzEduQAE0pw>
    <xme:ykDhYdwBaxL86_YkWh4Rp_hatNq7BFjjAUHrlCzeDW6l9lfI_rrFLI-C3b7gsrsu6
    p1lmhu2xlj01X11NB8>
X-ME-Received: <xmr:ykDhYd3Ka3EZOrFtcV70LolRbfphJwrFdSjPODlNS1R5gWtCGTq10Yo46oPW2na1_VLGkrOmHOkzzj1cW-e7O3_I5jRjt6qglbfz8bY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ykDhYUBaxxH0WxlLf5huNjZUpjpDqlkGBLeW3svYPdxUEkz5_7mMGw>
    <xmx:ykDhYZixOpwRrwIP_W56iNnSVRTiakf7Rlr5DzFIbiP6Ab6sXIy3DA>
    <xmx:ykDhYQrKkkmGCQr1rlMj6pQWuOA0ji3RcdUTgcpBlmvfKQ2BQ3-QzQ>
    <xmx:ykDhYeumgvbKlU7-ns1KUnd0NrzMgvOxDWGEig5FdYm9CM9ZG6LObw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jan 2022 04:22:17 -0500 (EST)
Date:   Fri, 14 Jan 2022 10:22:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Conley Lee <conleylee@foxmail.com>
Cc:     wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sun7i-a20-haoyu-marsboard.dts: add marsboard-a20
 support
Message-ID: <20220114092216.xfuaplbrlpsr4zao@houat>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
 <20220112031347.2492813-1-conleylee@foxmail.com>
 <tencent_00147CCBB6C9A0A0830DCE43F25DBC40A505@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v6n32xwppyng6qc6"
Content-Disposition: inline
In-Reply-To: <tencent_00147CCBB6C9A0A0830DCE43F25DBC40A505@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v6n32xwppyng6qc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 11:13:46AM +0800, Conley Lee wrote:
> Add sun7i-a20-haoyu-marsboard.dts to support haoyu marsboard a20 SBC
>=20
> Signed-off-by: Conley Lee <conleylee@foxmail.com>

Also, the commit title prefix must be ARM: dts: sun7i: Add A20-Marsboard

Maxime

--v6n32xwppyng6qc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYeFAyAAKCRDj7w1vZxhR
xfOFAQC9NTLGsSOk8xCGZqUk6rxMTRFG737kUpsOf5B9t8RawgD/QrfEPITBI/dH
qQwhcaMQQzrJIwKk14ZveveT8TrdAQA=
=Y0zu
-----END PGP SIGNATURE-----

--v6n32xwppyng6qc6--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AE4BE0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359438AbiBUNn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:43:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376307AbiBUNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:43:03 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58515A0B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:42:38 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 79E865C01F7;
        Mon, 21 Feb 2022 08:42:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Feb 2022 08:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=K7rFrIBYf0uO6TgHksH5pKcSFdzMTJjXHIGSfD
        UUimM=; b=RkT9rQLepumS98LayolF68+E0XrZsgaE6o7a1LCWUjlgufC/14XoIx
        xTBs3yxUkysB/a3yoUZ565fNL7y8EmXeiRwGV6zGieRGf0XPjW2hnWUALeGK8aDd
        M3NG/8pNsgRblbvvettx9V+54FZXpIF79Wn1ER3uX/zxzkndg79ciydbL3S5hZAQ
        QYxg97ratpPniammPj0Uy2SE4pCnHaZEMgcQmqR/FJxu+4xGU6Vr85Y4G+KTeLMz
        E2ctDqpdOY7ISSLp71Z/EOxVwP2EEq662x4D9TE/UyhIntZ391jsg/ytOht/ah9b
        rAT/X5dKcye6QB4iseAUYzI3dib07NYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=K7rFrIBYf0uO6TgHk
        sH5pKcSFdzMTJjXHIGSfDUUimM=; b=fw29BePoWU71ySEEv3dnkUtgf0fMrQ3H4
        bx8DYhd0TemDz7so3znIl+MvRNj18RtluDSKKPRIN66Rr4qsE6uLOxzzHprkzh9f
        cX5o9BYbFEZe9YP7jkvJXNy6ftF06YWTpNL46mh1N6tuNfdFJq3A8JEsslV4TCow
        drbfP7bphJoiL5YFeulUIdLYnPfDaecawgCokIf7WB3L17TRaBdTYOmM7StAfrW3
        tfYFxtxD4X8siyXiQgbe+fZcf6n4V93u1da5T6E+m6SAR390djkXxZzy6GELlJoV
        RMGMXj5eXZZa0pnfbmgBgn+2X9Ys3aps7W8tGghTxjnUdZFLz9Aeg==
X-ME-Sender: <xms:zJYTYulXYCg8EIGWJVHYwuveVAJUeXI0NvkcHlwhoMovYJsPJ94Nkw>
    <xme:zJYTYl3gwiCHsbnqSHcxGfTljNoBKI1nU82uoXR-SrKTfM8Wqj0MxoF5667q2XgYQ
    vOjBtND0oTtatWseKU>
X-ME-Received: <xmr:zJYTYsptqXsOkLyXJQ2ImHx4Blsd4Yc0YF-bELFUP9jlCcedDHVWY6hYAVEAlSKzWE_nAbZvzgSv24x18myIAZDHYHfibcJnJayyE0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zJYTYimn4oYKNaS-ii72y-Y4aMzLirr8UyOxM1LRKPef-I7RfCVwQg>
    <xmx:zJYTYs3Gv_Rf4r_YLHoC-ZBTGsxZTMiJgPmDWPKy5XnvVIcpks90Ag>
    <xmx:zJYTYptvJg5JSIaffiS9WMkwaUJnota8o8qCjsxxTBq4bYiC31pkOw>
    <xmx:zJYTYvSS1GBI1Sea8MBi6bWGKjYdu5d1BCIvBNvOT5g38hTjfn89LQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 08:42:35 -0500 (EST)
Date:   Mon, 21 Feb 2022 14:42:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, samuel@sholland.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Update Allwinner SoCs maintainers
Message-ID: <20220221134234.vt7bleqk7gylxefg@houat>
References: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="llrydr3wtufzcdbf"
Content-Disposition: inline
In-Reply-To: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llrydr3wtufzcdbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 20, 2022 at 10:07:14PM +0100, Jernej Skrabec wrote:
> Maxime is stepping down as a maintainer, I'll take more active role and
> Samuel joined the team.
>=20
> Maxime, thank you for your effort! Samuel, welcome!
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks Samuel for stepping up :)

Maxime

--llrydr3wtufzcdbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhOWygAKCRDj7w1vZxhR
xRVbAP0Xh0EhtruTFmUarXJiUw+cl/Wvp7GwJFZIbvflHr086QEA+jP7G+F4aoNa
UPMfaxLcjQI9QEdllmVV5fLcd+o16gQ=
=ElNN
-----END PGP SIGNATURE-----

--llrydr3wtufzcdbf--

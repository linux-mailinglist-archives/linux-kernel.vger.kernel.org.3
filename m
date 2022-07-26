Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535165816F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiGZQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGZQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:04:45 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CEE15716;
        Tue, 26 Jul 2022 09:04:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A22025C0144;
        Tue, 26 Jul 2022 12:04:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Jul 2022 12:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1658851480; x=1658937880; bh=a6f1CrYBK3
        cjjtgqfVGH2IZkfk4izkWqCxCWdm306FM=; b=UFuOY2TSZfah37xjC8T4IpQ7+Z
        8gSsFs8TwmGzqvaB4aY7WDi7ZGeXI1nLQ35ukRhcH4zFDERxLQmYrqAQJJddWglc
        TowMxf4BbjiSw22twSXlHj01yDIt/wiguMRtoJDJijyWUGnlKYRfulnYtwN26Qhh
        4FoZEXXbcSmqVOHQSC1t+W4XaRLNPXBogWGS+tvFyFvcsPF3ACMXHrmy7LVvoglb
        Is+WCvLN4zY5fKmVVmImMWaExLh4SpbWc2/nGthfqzE7Kc+MBWwjoAH1ZZ1wPxft
        cqhceFRswIbjHseSPwJTkzkMM7W5eHEFUlO2uUdW5ZDrd75ifKHBFSR46wag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658851480; x=1658937880; bh=a6f1CrYBK3cjjtgqfVGH2IZkfk4i
        zkWqCxCWdm306FM=; b=WCdZd1MTT8Kk+U94GnteZyW2cfL6zjjWkShB8Wa0jNpx
        4IpZKNQW3BNde4rogqyYyo14TOMutX941FEaZy4PwFby32evm+Zasjc65l2V0c2q
        7cpyzzIRJNu7wOE4PNbfUZEFhTuc0jK0Gi1nePk3XZLNaBUDcwVaAEcCl7Yk31fO
        XljGpW/Fyz/vfLbaxfFJ1HjlGdhBTkGo9qW794sb04Bxy/5OLXxZw3zEvIMlAGUx
        pTvvRAIH2z7ElB+WDGUvIW04iox4m9ED8eVc1d1WIggOnnEqYnCme2n8eMwdZ7Ve
        kUOlJ7YbGTgN8PjATkU1hfr3gjdw240UyRACWH+qxw==
X-ME-Sender: <xms:lhDgYpuiJmBk9PJ9QSWiWegpeACkZNU2DEFtiIZFnbJ1SK8vDAfdiw>
    <xme:lhDgYieaZD_TsC7wbT6zUaPxsd7h7ma_bTGlPQr6S55B4LbxK0idzsMq7_H1tG66j
    enj4sIemLq48AwhQmI>
X-ME-Received: <xmr:lhDgYswEqUW7Pb9yuZga61jlTCtOHkO1RhD-C1crubDc5SBF-cvRMTwuP_3ms33sSQVOPNQAhMTHUfb2JUJ8fp6jzaW2s2xn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:lxDgYgO_ORzrGfx89uXBOqLX9fYWqBgmlYtFVBBybYtjG1pUry7XyA>
    <xmx:lxDgYp_KOtP7x6vCfY72gCIOxwI94vz8oEx2yONZ_g_SbeXH9sw2FQ>
    <xmx:lxDgYgW8je86Gx4X5dDEuhdw4tkvs9E0GJgfy-V8mRtrl5qf0sNDeg>
    <xmx:mBDgYtVD9lWRLecMlTHoxsIv21dK01w73RY8H4KkeVRkqN6sMAixPw>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 12:04:38 -0400 (EDT)
Date:   Tue, 26 Jul 2022 11:04:37 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Logananth Sundararaj <logananth13.hcl@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, garnermic@gmail.com, thangavel.k@hcl.com,
        naveen.mosess@hcl.com, velumanit@hcl.com
Subject: Re: [PATCH v5] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
Message-ID: <YuAQlU8IfBK4zI9R@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220726132445.GA22389@logan-ThinkPad-T14-Gen-1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oJH/1hxiws+0ENCW"
Content-Disposition: inline
In-Reply-To: <20220726132445.GA22389@logan-ThinkPad-T14-Gen-1>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJH/1hxiws+0ENCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 06:54:45PM +0530, Logananth Sundararaj wrote:
> The Yosemite V3.5 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V3.5 platform based on AST2600 SoC.
>=20
> This patch adds linux device tree entry related to
> Yosemite V3.5 specific devices connected to BMC SoC.
>=20
> Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--oJH/1hxiws+0ENCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLgEJUACgkQqwNHzC0A
wRneRA//ZQzNIoyRePI4dlJRvGZUaMFxkV/lNgQ5tvL+Zqo6Eu80BE6LekfIvSQ5
n0NXmbveTLyp6G5ZxN2FCxOuuPV/HFgnabM6GN6J+DUjmaaFEAH1TW2e2FTdC8su
T4JtaRNVIFpQfKE5U1x23wvVtjhqy+KtE2sNdE/TVxlXZF8bMjsz15LPfExtGBId
1Dyh4tkEX1vbrUGuaELTRc7jkl9R5BecViN1CyKUngapW+lE2hNAvfzy4uwvGyi9
8cf/V55a+XqEq7AUoyRJC4grswnKrs3FTItQfiwJLbq4mp/7pJSP2ooboprFdXQL
3QlmiFOsV2Uq3nPlC6U4Tuj8pq7nGxdG4OL/140Rb1c6don1JjlnfCQMRhDyYgnU
GKomtike5wFRxMzKF7YVC1KEauWFXPeh6aQJtXg0cTL+wwN1Aav86EOrZrd6LpTO
YTLBRHr50R0bnKZfos/ZFwuKYsU/4XF24GUp6WwqiqYSSZo+ZUJLT/txKmLZNKbZ
Bqpz89bmvHnN2vkaFXJt/YMo4M1v5QJIXcfqEMLxr/IgH89bUuiP8asTJXYPXQUq
LbbnMAJWafdQhgnBnXPtZDLx4BeBTZ/nzLK4dHtOeDqVZpWIewVjhNWHDUNp4iuS
jwubG8I1zIiHJBe6VC+36Ru2JXv6V5e5CEiUUSTHnZ0YbSqlRV0=
=guU1
-----END PGP SIGNATURE-----

--oJH/1hxiws+0ENCW--

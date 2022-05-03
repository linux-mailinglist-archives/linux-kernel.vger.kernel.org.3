Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10AE518788
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiECPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiECPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:01:42 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C23969C;
        Tue,  3 May 2022 07:58:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CF5343200984;
        Tue,  3 May 2022 10:58:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 May 2022 10:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651589887; x=1651676287; bh=u3/ZTfENb3
        6qvkDrkbhGccJNHgVBQ0azaIzvNqhQoDA=; b=KMZZ/hu5iJPlXGlgO50mCLMnIx
        U53mZgwzBD8pSfvPdIkT1Mfhs9gpIPaERDOAw0wwPmkEFV0SexVCJBN+Im8Hq+4D
        70D/SW3+xEmBG+UaX78M1cQsnsVQK+718vlo4IADXJo1y+hXpQ+vQJ9Lb2nN3PeJ
        tz4mFBkrO2VI9l67vnccF3fJNNXmWsfDqcpahYLmxMsMFhYiapnwtokwuub2pvdc
        xJ1W1QRoj5BYnTpMLb9Bx7KKtQx1Q+wBaHEhgsnsLPdX0vpALTNf5c6c0MbHCmhH
        +x1hOw7qtrmJ4u4iG4KnKuCsTyMsJ1JM4GPwntZmBglRhYa9sjW5W+s2cN7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651589887; x=
        1651676287; bh=u3/ZTfENb36qvkDrkbhGccJNHgVBQ0azaIzvNqhQoDA=; b=e
        enu4DqsvhhUXtyYtBmttcSTFhVtllQ/uoqiptQTMDqKxUYwi8ZJ+TA9XgCkWlV4A
        ECZnF5OBoEqxmoVMu0Imo4jSB7Zx0hQj7sJaJKVCO4Tp2aD/OqSiqopRzcTZkUq5
        XFTABuZ1kqs7gcOkWKGp8hoYCL5tXMB4SEuAQYxE5W9VDye/Sci5v5hmg6k34Z0N
        xqg7S+U/YtsVnm7qWhMLF0xb3dkFW9xwGOEnC3ba6LEJoZT52m4MpLY4WNCHF1Ou
        twYi6P/IUIMi0GUuhOO/XoKZBouca68ckvfz9Kjlu89S+G5ghppfeovRAfRG+0ic
        z+ZtSWK22Lf3FOga5jZNw==
X-ME-Sender: <xms:_kJxYs5dnO_HKlqFvCR7WXShBS7EGs14ET_AX0hl9hrt62VLWx11iw>
    <xme:_kJxYt4gueeje4sAfHtutlhsPseor4VP8aoCWoAinKRditld14wEviqE3CIEjC2i-
    OWVAPOVtgerS1TX40k>
X-ME-Received: <xmr:_kJxYrfKYsUw9PZpz2IpPpYaX1HaguTOn0ORicFUXiu9Lz9mg2_andM6u1j57qfrEbX30I1WasfBrKaadSBOngyBdhz_t-qjxtbroi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:_kJxYhImyKRXJ4ybMxVrDE1lB33gVdQdLKwZRa0vwBc49zIcnrvQMA>
    <xmx:_kJxYgImSOz-VxG3T8h2XJzCoWc3I89Y4F-Qr7heQd3HAIlkO5KWkg>
    <xmx:_kJxYiyXnLOUFb1ZvcaEooP_n3eoQtSg0Zq4WKG4-2vEe58gEA8gSA>
    <xmx:_0JxYlXvWoR-m8CEqEa2zBOZEB_BVnODc5i7IhVk4xtMmOodfNt5fA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 May 2022 10:58:06 -0400 (EDT)
Date:   Tue, 3 May 2022 16:58:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
Message-ID: <20220503145804.b2xz4etzc6kpr3fk@houat>
References: <20220428183010.1635248-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2wiobkotqpc7edr"
Content-Disposition: inline
In-Reply-To: <20220428183010.1635248-1-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2wiobkotqpc7edr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 28, 2022 at 08:30:10PM +0200, Stefan Wahren wrote:
> The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> accidentially breaks the behavior of bcm2835_clock_choose_div() and
> booting of Raspberry Pi. The removed do_div macro call had side effects,
> so we need to restore it.
>=20
> Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

I only found this patch after debugging why the HDMI driver was
returning -EINVAL at probe on -rc5.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--p2wiobkotqpc7edr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYnFC/AAKCRDj7w1vZxhR
xaGNAP9Y+6Prx+q4EP/YHCQrzXAiTYGIPXHLEHBJRgXpGPAW3AEAp/a2alQMqIpr
NxKtSYXFfTi1DT0QYYAxidlxOOAqkwc=
=gbju
-----END PGP SIGNATURE-----

--p2wiobkotqpc7edr--

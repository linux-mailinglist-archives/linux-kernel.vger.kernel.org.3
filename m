Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805F0554836
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiFVKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiFVKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6DA3BA52
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED1F60F31
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4EEC34114;
        Wed, 22 Jun 2022 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655894436;
        bh=GFrMnFZ+Th8WbgJcF2ZE18R6Cvj1UfF2VY0kpane+PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lC+7t+g4ROmC+BkVhSBwTBLwchV4VlwueOj5dh15jUiSTFOnBXTuwdbFWwONDsPDR
         q4XwoOnAIFI0waJ+i/YvLyhIoMsg890HBzIBTCj+RmHYReoQqgkXqCpHfn/EPdo0GZ
         YDaIJ+rXjcQntfuKwoV4CUDbDNROs/PaWJPKsOn1NEXuB1NwLx8CbT3mX+zohxHOYz
         T1yk2ybZCuHzsr13qIxZT7HjNaHbXjXfLDs/BG8WhV+0Luwh7cj3UP/GWBsIZp3PaB
         2iUohoxNauLUvi/miqVzQ5rMsM6EV2Ql9+2iHQx6ilPu4/eKRzPAlPpWBoJjhX+qRE
         /1plOunZ3Z8fA==
Date:   Wed, 22 Jun 2022 11:40:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        bigeasy@linutronix.de, geert+renesas@glider.be,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64:kernel:Fix typo in comment
Message-ID: <YrLxn14W7snJZRdY@sirena.org.uk>
References: <20220622091443.51062-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i2BWpgtofENy4SJ8"
Content-Disposition: inline
In-Reply-To: <20220622091443.51062-1-yuanjilin@cdjrlc.com>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i2BWpgtofENy4SJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 05:14:43PM +0800, Jilin Yuan wrote:
> Delete the redundant word 'in'.
>=20
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Acked-by: Mark Brown <broonie@kernel.org>

--i2BWpgtofENy4SJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKy8Z4ACgkQJNaLcl1U
h9BLlgf/ZJ6IyiMLlvlkOaTw9MdIW8mimSEmZH268azEIUP6x62R8BqILd+tgPdV
KGEfXQiGsDluN5eKyPYIVnRRmP8w9l1ekwtw4HzyFG8ZRFjXgz/IyqYRTmNHFe+k
Hq3L4z6EgCZVLEYlChrOoQgxo5mEQby1/63/9FNs/IWtmBX/fYl+2nSFb/rJKESw
RAeOUQcjBwdwVOpQ9f4pEEFTkWmJCE5nSxkC9+o2D3Fq9p0DxN6mmsHJmLPjipOL
hBzciqdzQ5Lc4D1muM5fJ3qEhoO0yCSLdkdfjr4Nm0vZMWPZYLwTo31+ZLILGkf8
u1eqzD3tg5ywicvn43/k2oF9ALBixQ==
=kh+i
-----END PGP SIGNATURE-----

--i2BWpgtofENy4SJ8--

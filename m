Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733C14864AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiAFM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:59:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59420 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiAFM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:59:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA8761BBA;
        Thu,  6 Jan 2022 12:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B9DC36AE5;
        Thu,  6 Jan 2022 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641473960;
        bh=jInIbXvarsX6TNet4OakeBJA6YBefMPG5+MbxEc2B60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+/YxtIkPBS/kaKo1S6jKr+sdCdloc8avdgZftnwK3x0RyIOkyo9cD4/C9mRPbRsD
         lkXpxIzJ4jCI5+M1mEjZqFZQ/3zSqX6qCAOgwbggh5g/G+SgP9BUlIvaYe536vqb1x
         Aq9X0cHCSC4L5SoVCJz99BbejTE/idjf0BXNaiqZEjSa33NjQX/qpTuq+2LeChfS8J
         O4KP4oS5RX23CGF5acrbmAy2gcGLU3hCKIFFFKUKoi/h5HpWA242qY3B1I2z/mt8J5
         3d4Ultl40z1bVCnzxbkH++n70WY45Q0zN05ZW9p+n6U2xkFzUbh0NSo5GTJaFvVwJP
         NqdW0PswUbatw==
Date:   Thu, 6 Jan 2022 12:59:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 2/4] regulator: mt6366: Add support for MT6366 regulator
Message-ID: <Ydbno0JM8YP9NhNh@sirena.org.uk>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-3-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HMjMTKWCs7502cOB"
Content-Disposition: inline
In-Reply-To: <20220106065407.16036-3-johnson.wang@mediatek.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HMjMTKWCs7502cOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2022 at 02:54:05PM +0800, Johnson Wang wrote:
> The MT6366 is a regulator found on boards based on MediaTek MT8186 and
> probably other SoCs. It is a so called pmic and connects as a slave to
> SoC using SPI, wrapped inside the pmic-wrapper.

Reviwed-by: Mark Brown <broonie@kernel.org>

--HMjMTKWCs7502cOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHW56IACgkQJNaLcl1U
h9Dnfwf/aNvswddLATuwHO1btHmXygSnrjKxqpbMIL7KwJg8L9tEGthhzIJ6+xgc
rx9WwA+Smt7mMWS1YKCQ9KN/TaW9Mti2sMCLrjNlz+G8H/bU3TCdXpJk6/Ve1ZPF
eGJfUZqunpetCrOi4r/flf9zCAN06+p0DF3haYuMxoZI7UGtyy5qNUjXIE+5iIJF
KGVSlNViduNOj1RQjmBQx3OE2E1vW6BTN2g97U3CO6aGAcsvBD+T/i/xVSz3OY7y
pSLdD2UW3wEAC0sz3r8dm/WyAjd25zTb06FR1y8HbvMLtB218Seov6CoeBhvQDGP
B3/S8gTT8fSbtxfuISScQoHvlYmqIw==
=wBRY
-----END PGP SIGNATURE-----

--HMjMTKWCs7502cOB--

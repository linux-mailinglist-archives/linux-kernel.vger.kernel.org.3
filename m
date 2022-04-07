Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A84F886C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiDGUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDGUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120473221D4;
        Thu,  7 Apr 2022 13:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAD59B82988;
        Thu,  7 Apr 2022 20:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6271C385A0;
        Thu,  7 Apr 2022 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362722;
        bh=jB0b+SlC9dwLd3Fneo0zI4vY6syokc28jlRCIf8zXA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BViEv3Ix23CEmQyPeLPIvzPN5CfBrL0hOlw7aNMliEc1PT1E9pzPJu2fN+MaAocj0
         XwUm0AAe3v0+kPjxq5vGB3uOBwbBFp2pP8+KY1Am3ubinpziYn3R/qgfStksHt9s0u
         KQ/P16rA2pQz2YgnRsC8LFfe5/6YgKOmnLhtiGuhWnysN9qhCXgjCnyne38akLJl0k
         brHc87e4U/gP7s/O/57/WIYM3/HXbVKZ7ugL2LX9Jos6SRzwP8vPxPbZJBg5sr3G73
         0R5Gz6IYd4RZ5TA4du6R15lCPSUHRYoXojqqLkJnpj7e3RkIG8zVmKuomh7zVnkhER
         CJUQrWreD71zA==
Date:   Thu, 7 Apr 2022 22:18:39 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] clk: si5351: use i2c_match_id and simple i2c
 probe
Message-ID: <Yk9HH4CI2aIfCJpb@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-8-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V4K66V1CeXlEv5ce"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-8-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V4K66V1CeXlEv5ce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:28PM +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--V4K66V1CeXlEv5ce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRx8ACgkQFA3kzBSg
KbZEFw/8C52BDRz7DaBFM9zyIZgS+vC+kx2zV80DnVNBBnEfjCATQtljjsxhjuid
Dc4m41tVM5UlwhPnWOsT+aola6xudbfZKo8Oi6gz0HtbpMnevMWEGRCPJniNYTuv
M/b61pISLL5OrEo8e3sWg2XFZctnr4CNiE+b5kjSm9qC9a3gNRvzLFubw834H1yF
JeFg1acWkZG+znzCFbRvI9F405V2Ywe2E1Q0nfiEhmhbiry19fc2zRcXNaEe8R/E
Pdk0Ez75J7y4pR9IzbO8+e/gXxtRRvtgmjAwh1ba8IUo0nF5cW53vEOskN0AxOUo
VxzYcYt9+W1l4zAtRF2ZCFeSE+DzlK9GvKFHnQD3VixCVv6aVy+u4ykLGjgDu5Hm
/p36VLH4VGdLmzz7qt1hsUTSr2z5XmPf9jKUCPIzJ9R5ZQhodv/qCVSd4dvAcwe1
2KXWzJSPDo7SHjmVD4nrd6h9WFWZp4OUx7YcGXdBlUtNKFeafc7hh8XbkiHvSiET
4Xt2oHYnJG/Qw09HgfkRncpXh0L+Tl5K2NouthL5mI5ztbqoJDDKDx8JJmhZm1QO
t3e6aAfdcr+IoxOqqa8r8Jb6pUDzg4gg+e21wOj8Pkt7C33Ul370G1BHy2XXyIE0
mOXovlH9HXvUNfKW98Imnz1lFy8sSWKnmLcDdRXNTmYhislNSfk=
=FoRp
-----END PGP SIGNATURE-----

--V4K66V1CeXlEv5ce--

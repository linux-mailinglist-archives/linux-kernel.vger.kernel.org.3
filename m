Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A64F886E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiDGUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiDGUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17779488582;
        Thu,  7 Apr 2022 13:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BD260FD0;
        Thu,  7 Apr 2022 20:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD18DC385A4;
        Thu,  7 Apr 2022 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362441;
        bh=Ory3bJORFZJ4ro9wMV1GkV5iCozFO5IKAD1TZRPL+4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rb1yhzDTndTwydnLZgKkom6IjQUNcKk9vbebaFO2AZUg1jHcCdi0OD3H5mdugIBDH
         7RKIzpvaLjeEDboNgStLaY3vTq7veQFAJwY2y9/LP5iLxbCvsRKGL0qzfPC434OmNy
         aaCfx+tm7jw4XtghUYpEnl35gMxRwevvRE9RhnF1Qoj5KRrTczHOkX4b6cKWSOXyEo
         MNpRi8yqm7PsvSQ02laiLAwJ5Nw+RogXs6daOb+lP+Usv8HoyJWMnEgjw1LYGYBCC9
         qigDRd5BUKejf6wGqg8dWGa8REEsSBO7a46/CGFQ5eMcZPD0bAgjndn7PRV46t9fly
         +tpRuoV4eYyrw==
Date:   Thu, 7 Apr 2022 22:13:57 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] clk: cdce925: use i2c_match_id and simple i2c
 probe
Message-ID: <Yk9GBZtMngOMi6b5@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QAwNc0UyivCrPLbF"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-3-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QAwNc0UyivCrPLbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:23PM +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--QAwNc0UyivCrPLbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRgQACgkQFA3kzBSg
KbZ+1Q//dvf44/ZZYFKiPq7IBQkBR1GvTLAK54S5fuDNJMjS+9Go8yehKgzQP0RD
O7m9Ryuh3xTtGonC6boRBKQZaidCoOG294yOmyUZ5MDL4yZNHV7AIKeBjjYfj7pC
GpDTU7mt2e/WfNByF2ldkF82iBmziuzagbJQIQcCtCg2x4m6JSGI25eIPhDCdZJK
Lj7Ebd/TLP+mvZyvE+JZzZKRa7c7ZKwWzhQFHGlAIqdBjLDSp72ThtBMYuYlBOeg
rQd3Ao6N6f16MgpSrWo38y17RTHlDkqsRobz6/Ad7SgFPxMNd88wLoOM7XjAilYu
8cMsDujJ/KfE5JG0PP+WIWihooI64yqNkh3hvYPp/brS5+PfCIIJMLwgmF9/P9u1
mVusYCtxDAsKqxw9vaPSqh1bvUCDL1yWBC+hKXdjXFDA/qAmvIja8iuYAZQZnuU7
ZdDDvhD6MBh9RXduqxZR5t3saTIn0Nb2sjcvwWtgO1IwTBtFhG1ZAXCWTGep6iWK
/CTdo002V5rVw0Kh8C+CYg2mDjdh1uI/z4dtc5yUxJNEO3YAKwNxhy9j5CEbqYBk
3t+VDwr9xz8QP/Yc5JY4U9YP52IsWPZRTfXKnznJnKSm3U4C1xCnJvV29PaPGn1u
BEUW9O1601uVMjMTgNfbU7GtdrYfjowxr12AXfHRefJXrp/mNN8=
=RYNI
-----END PGP SIGNATURE-----

--QAwNc0UyivCrPLbF--

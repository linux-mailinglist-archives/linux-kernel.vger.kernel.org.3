Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8804EBDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiC3Jho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiC3Jhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:37:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67F34BA4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68968B81BBC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CEFC340EE;
        Wed, 30 Mar 2022 09:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648632956;
        bh=HbEee/3cbokqZj/zjaAwjaHltY+HxpWE6Ylk/Z14ZbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCVWUxP7+WI7USS2tFqmDsPecHVBRppBhi5S2g7r0cyBhGv0YlJpEQScDC01iucb2
         kzBGH7yCYqDRNIOkwL7iT6CSUUYRY5C94d3Bl02D7pypq7cSiNhkGpPueSEcB93cQV
         fLc/hNJ2/aETjLpEeMenZqHeApe9NOIfGFi4PYnPxPL01OwuBj0OTq6lkfG3krMhHV
         OVKJNXS+Oc/RbWDUCi8cZ9siUFfo7e/k9o4xEstEHfaS7GgoWkp6b8YnvnAD7bR7Wk
         GlnR54Mdp/Mf6E2cBW4Xa/1eLNzNeMtfAif8HwyNVjmLztG4hfcF4+6HN/ZUMZ0/5y
         /QRRp+V98/fzw==
Date:   Wed, 30 Mar 2022 11:35:52 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use i2c_match_id and simple i2c probe
Message-ID: <YkQkeBoiBz/xMGy0@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220325162515.1204107-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nXQ4p7Ftsxs5KiN+"
Content-Disposition: inline
In-Reply-To: <20220325162515.1204107-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nXQ4p7Ftsxs5KiN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 05:25:15PM +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

I vote for moving the device tables up.


--nXQ4p7Ftsxs5KiN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJHgACgkQFA3kzBSg
Kbb8NhAAro/ObrPebW/EcK3fq7oKvp0gww/og+jKjyJflxwcKFz4/44hl8iZlnn7
YVZGcp7i89djVm2erhdlzKPeAB6TDajhoKAaInqFcvudRUFVcx7Sel51E5LR7RTc
m27udQVx89HAxGaSfPX1h+UtIC0pxAvYbg/Dr6vahhEjHDo2jNt52QiS/Wdu07Tk
Okd0WKJ+nsvZqZ93LrcHLojgq/VZbf1xAQiM0AYkU/uO3fTmsBSyOxywk7YhXs2l
/nTiaRNvgjKBvD+wu6qA3GHSwLikFH2y2tLd4Unpmd55WZjGu8ku9x3cgCt/flg9
4oyUnyFnsC8nxUl1WcYXUpMMf+CSnn2t8QlVKhSCvMi+yY8YsHlobvWBU8DA18mM
cDG/CXWcO2hff/Dj5v5Rqd9p8wLx0qSNM6vJ4v7xrJFB/GJjjuJEzKMKJLxG5Ffc
fY6UZhkQ/LKW8GbroPDuiB25RBU34bv3X+WeK7Tv6kZRN/1FodmXWnQfwHWPucKK
q1LDtOSbmV1pr8ukVTCBshpU5dR6+AhL/0QsL7BErrwnstQgvfK2Rtamv5Ep74IB
aQO3gBBvNCHqTDc19XPGks439D/LLulvWoE2YEDvGmfIfqhssQJ3ehtzg/FeV6xO
tfBrLHOnpNJv4FG/jFQ3q+1pZaNwNLWc6xmKn3+0zMkyva+z3zc=
=8tFe
-----END PGP SIGNATURE-----

--nXQ4p7Ftsxs5KiN+--

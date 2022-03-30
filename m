Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75C4EBDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiC3JbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbiC3JbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A42ED47
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A16B611BD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DF3C340EE;
        Wed, 30 Mar 2022 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648632556;
        bh=Hp4RlrHug0KaKVvDVGbTXqg7ImRDGfoP8dhsLxkB6M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHN9Oa/qVk6GfP9pPC5136dbzWTGkgUCzxNCGUPttW4jmoujgyWAeFTzI1ZpM16kT
         DzfTygo+YvzQ4cTd/JcMPxR5FPt/Ip+m6MDBfRQ5MDrTDlJ1Yo9zrOzZjk2p0h2w+R
         oYrSHaBJXwAxFSgikqXdQhmfPoJ8r1ekzxHKb4qKTdOOPgilZSgutP1os57LFIcBri
         FseRO0GDiMi+Yao88CHI102+lHfF0Vs3PucVi6KDRPZ00l+/IAbmQAEqwRn+cHJaog
         brs1GXJC5SP2LB8NEv5VQ8JvS30gOlQbxLtMqh4ZKjLt6kmqNkIq8Eum4cPmLSCxDu
         fg4SYPRKPMnNQ==
Date:   Wed, 30 Mar 2022 11:29:12 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: use simple i2c probe function
Message-ID: <YkQi6EIhknRJgv3i@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>, Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220324171159.544565-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5Y8YpsuyBp6Sni+"
Content-Disposition: inline
In-Reply-To: <20220324171159.544565-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5Y8YpsuyBp6Sni+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 06:11:59PM +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Looks good and builds fine:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Y5Y8YpsuyBp6Sni+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEIugACgkQFA3kzBSg
KbYzPxAAnN1jaP+MzBCgNTKk4nwfK6Tfc/1LLV3SQv1oX178sDzuUrJCLJWe7TAV
Isu/tGqzNlJZdaSYlgEsyvQe+fymxhssUAnkjZPdLai40THDXihpxGBQ3vI4K+mX
B0Qq8nwkhdNF3qSyAT7o3fBghte8NbrzXPxs9SVD6zIpS+BOzyA3pfkPRkwS//iv
qAJ5UiFPuJB0RfleP62P7yQ9H7XkdyGtmDtnKSETmUQHor9ipcOJzH6bgOwL+TIK
TwyhQHFpDIbe5382QxiSMKBCPTUeDCtsEeRaKbKgwkD8rhrnFYkn71Ft0q0P3Vp2
EQkytOq0gtxAwRkAa6+QhiPCmABILQruuSi9TwhWWn41cgC0e+q/x8ZwnMFQ/93I
Y06hHmGBRxtsfgCwZ5jDGyy8pXGxk/3DMxNQW+rggAigHBgbRpl4MyPHABN1iAk6
3Bg/wp7EP5X3j+irYx+RNwhyP4l9RsZj+/SIajubYSU+uH+ZgxPHy834wIcWexUk
pgQKFL8UiJI8o3IN69uCexCPBgc4FAbhHixJI/nLKthios3aUhNYEoUKyqCWg7/D
/UESDwwBnma4ARZtAEuXbuIf1rZwy9T1t+0WBah5r9//MKcROOmU8yg+vHReKIZP
mYPdWdB/KYVg5CIVfTB75Zhpxwmtvq0oz9tNk+5m9PlBQDXP5vc=
=oWtJ
-----END PGP SIGNATURE-----

--Y5Y8YpsuyBp6Sni+--

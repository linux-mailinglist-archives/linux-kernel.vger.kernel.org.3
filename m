Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF64EBD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiC3JRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbiC3JRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F924F0F;
        Wed, 30 Mar 2022 02:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0ECD60EE3;
        Wed, 30 Mar 2022 09:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B658FC340F2;
        Wed, 30 Mar 2022 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648631730;
        bh=jpg/7rzO++XcwDYy2uwyxQWCmUOGBmeiWParIk9q5wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Olp8a3NGzQ7/nqX6Y0+jLKSH+61HcY4RJS64V5srFeDw1h08JZR9v+CAQtYnnwvPx
         8MexTEX/7+SyyISw9/bM58i19i0Wv12/Snd6U33vn9l9haxI2m6pFItkjZXJV21CJd
         M1lUt0Evf5pmTS4ZJkvckFLljjtOGtFGM+L8/nyVZsn6ow3IjjAKCQWxSJ0WZCy34B
         TwVHvR1w89aQZLoJppTsHXUEHY7aqBPcyrp5FE+qMAh4sChtofk0IEmd1o1zOyltCq
         uTPErLazM6ZJZXo8xrDXuoIzgAVZgL9N0kf7yXI9VvLotByltA96RcAD1QT6/KcOSt
         7ou2ME6y5RgqA==
Date:   Wed, 30 Mar 2022 11:15:23 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: use simple i2c probe function
Message-ID: <YkQfq+FBqGql3H9Y@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220324162904.530140-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+tniazS4rF4ZkjeW"
Content-Disposition: inline
In-Reply-To: <20220324162904.530140-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+tniazS4rF4ZkjeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 05:29:04PM +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Looks good and builds fine:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--+tniazS4rF4ZkjeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEH6cACgkQFA3kzBSg
Kba+WRAAlgO66pbw2gE+iyHve2LJqABk3dad5pvxym0lOAHHY3HXBEGbK6XxIw3M
p8adOatqnM/M7C7pwhslgto7kETxygqpB6LytkE9Vf/Wk/wG5Z93Rj2TeGyrNEGx
9EiMEvDCgj3t/mHnBn9rCmBkzO6ilo03RFeM1Sgo9DjQZ680OUVBJXYZOyXse1yC
/Zn8hQ284zeYYUsLaI0lM8nc+SjWLhPRD43EVW24xtr9P98eyA9KOnHOBtrgl4mN
W/8rQvCvd5+RMOHKIepHZrQ1y9DJB9ydCZRILg6DNBPZ5H7NogOnvfPbmCnfYtg8
HcBTrez+w824Nm6wNwFg4EhWM+2rgtreN6fb9IXxw1XLmQxOZTr72Fx4zkWAQFvT
5lyLMeKdtSSJv3KGxVx4jMCGL79/adozTs/2Hgp2tgWhYvul9rZq9n/9nZLiZPE0
IBJ+av7lnyVFgqmS/kkqj4w4kFhmEuIkR4jdIZ9VoY8dHtwUrldSCzlJIpaeWF1+
jFF2eX/l7O6ewqKBOCTVIdZfxhIF6Eg1WeYlQw+aoLCJoXwXmadzs0QjMprFhyf8
CNZNktgE8Xe9wgi/bNqk/aIS70sEpDPYdDok4cSGIMCghn5538H+fGq0TzQvnKLJ
6F05uk9T2lzWNSur3rXAV9CRfdEAaw4VU6vgnMgWpKIsNdRojK8=
=oRTj
-----END PGP SIGNATURE-----

--+tniazS4rF4ZkjeW--

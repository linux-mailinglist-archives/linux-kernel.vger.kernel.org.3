Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2824E7C47
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiCYTlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiCYTkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7120A94D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A7F8B8298A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F9C340EE;
        Fri, 25 Mar 2022 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648230987;
        bh=pLArRgRsH2EGhfVE6MeFscj0eSZASGF8z0GoIq7ugYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1LWF+eOQTUzrHG1KfI/4gZHgCC92fuWtiO1qgy5pZx0AzwGdJY0BF3k5FMIai43y
         iWjnlX9c4HtN5bHNyfMyRmTgB2c3YeL92UBYzJyW/0XDWS+Kff3LIp46L0y1rUtR+s
         LFTbHwGqaUXmClbvdr/4lwiWEMQIvA44c+gAOjnjD40czXXhGfqu/1NfqewOx4rFjm
         81wyRzP1s2MJfCHwN1Unt+glDgwjjDvgh+v2N0Fp/YrWIrFggp2oBB40XPAV6cvANE
         6FOQS/HTYnYvqQ1TB+3FJff2kb5YlTwuI/IiXbwHHnFUkwvN982yi32Qh5frsBVmdT
         g+kW0ALf7/HgQ==
Date:   Fri, 25 Mar 2022 17:56:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use simple i2c probe function
Message-ID: <Yj4CRpNDiOr6PNbP@sirena.org.uk>
References: <20220325162439.1203870-1-steve@sk2.org>
 <Yj34gLRxhmXD1Y5B@sirena.org.uk>
 <20220325182616.6fb6e13e@heffalump.sk2.org>
 <Yj3+ILE03nOxbpsT@sirena.org.uk>
 <20220325185134.1096bcc6@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrlMwcEKYmDD2vj8"
Content-Disposition: inline
In-Reply-To: <20220325185134.1096bcc6@heffalump.sk2.org>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrlMwcEKYmDD2vj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 06:51:34PM +0100, Stephen Kitt wrote:
> On Fri, 25 Mar 2022 17:38:40 +0000, Mark Brown <broonie@kernel.org> wrote:

> > Since we're in the merge window non-fixes patches just aren't getting
> > applied at the minute, you need to follow what's going on on the list at
> > the minute.

> Apologies, please ignore all my patches then, I=E2=80=99ll re-submit them=
 at a more
> convenient time.

There's no harm in them if nobody else is doing anything at the same
time, it's just that a mechanical cleanup like this is going to get
dropped in favour of essentially anything else if it causes conflicts.

--mrlMwcEKYmDD2vj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI+AkYACgkQJNaLcl1U
h9AFBwf/R7FSkqFzZcQbfL+qxuPAxc5MJL5ZYuM4UIQfnmgsrcmF+5oGNPDXlyRQ
MsHO38S+3Rh3G7CczwPXNs+49BEnjnHrbp4U10A3BuPQB/0E3KojWsbcPgAzzsGW
uZo0/jJU3RtLtCOIwbQR8A7qRNH+t1WB4jM4ja+tX+jyeiN79MBZQd8V+AECZjsB
UkIBEOaExTCukJL+fNSzkZEsIqLRw+08Zf7tLQXZv022SFf1srA8EYpYlwECDw7W
awLZ+vSSuzm+lmknauGbAXT0ShxUwLNCi4dqSIYfMVNPx29M68MshHM6jpX6Lq1b
FLQEZLj/oLBTqeR1sBs2CCnOzeiNlw==
=Yvog
-----END PGP SIGNATURE-----

--mrlMwcEKYmDD2vj8--

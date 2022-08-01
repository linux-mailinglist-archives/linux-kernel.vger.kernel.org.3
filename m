Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED78586D82
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiHAPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiHAPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:16:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD024BC8;
        Mon,  1 Aug 2022 08:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089C6B81217;
        Mon,  1 Aug 2022 15:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35175C433C1;
        Mon,  1 Aug 2022 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659367015;
        bh=pSXSf1aeVqWVQCcBcL4HOgiZB3i5p+bYXDxKTnDwCTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaF7w62TEI/sbGdBt8MnFflAEp8kXVgpMoH3YB9X0wvHly6XTRUedvj8W2tYAhh4x
         +fkpOT5ZOsLIA5umEt6cJwShiOLPk73YX5EKCuj2Zc1ollwBNFqcrYuff0fKyBN3RC
         6TplN9Gc9zJqZ5wgZucx3xBY7PqW2m/qIccqdCH7WXqOhobznc6wDgqxuXMNrcl2N9
         0Wv7ZJnTWRRITEqYEFM69ea2+SfCIrocMXPt/mCkQvaTJ3V6taLvhCMkLOtbc7iICp
         fX5C08Kpof37krH7hQ2sk9OB+rpyLHk/1Ss4dn6BAp4VNUejPCZZxZFo8PSS0DjaTU
         gKCQJ5uP9EPoA==
Date:   Mon, 1 Aug 2022 16:16:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: regulator: pca9450: Allow arbitrary
 regulator names
Message-ID: <YufuYabz0MeJ8r8z@sirena.org.uk>
References: <20220801131554.116795-1-frieder@fris.de>
 <20220801131554.116795-3-frieder@fris.de>
 <YufTP621Bsu8HVpP@sirena.org.uk>
 <16f688e9-7777-c5f1-0269-f83ed6788831@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xDyTfeOSnKbkpx89"
Content-Disposition: inline
In-Reply-To: <16f688e9-7777-c5f1-0269-f83ed6788831@kontron.de>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xDyTfeOSnKbkpx89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 03:45:52PM +0200, Frieder Schrempf wrote:
> Am 01.08.22 um 15:21 schrieb Mark Brown:

> > This should simply be removed from the bindings for the device, devices
> > have no business placing any constraint on this generic binding.

> Ok, IIUC something like below should do then. I can change this in the
> next iteration of this series or send it separately if the rest of the
> set gets accepted as-is.

Yes, just send it any time and I can apply it as a fix.

--xDyTfeOSnKbkpx89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLn7mEACgkQJNaLcl1U
h9DcvAf+OL6kk/U+n1i8yT2A0OedNTTVypjDULReLCbVRBhiJfKjexG/ZKBMGs1a
y3ogBBbb7O5rzCnBkcZmn7c94GNUCvk7QfpJzB7OcgRORoAzTNB3Nkcc0rhO586v
91NzqwhOSpDSWsHkOjFHaixJJRuvTaGlR4LptFQdPk8DGN42Pn2zQ/FThRi2c5iU
k2B/Dtp8oWAA8Z60i/2s3S6p2neCsOTihV3aYHy5GLGPL9yMZSEraQHO0TzDNyM3
Em/o/L4cIzlBnKfO5AHdJNDjBE85Om0HfkrSGBgTjJ46RvuGfztZY5kZga1VNBUs
Euk0j9lKJBqVciVhv4khDRd7Ol851w==
=/gmk
-----END PGP SIGNATURE-----

--xDyTfeOSnKbkpx89--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A881573685
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiGMMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB36DC88A;
        Wed, 13 Jul 2022 05:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385F761B7D;
        Wed, 13 Jul 2022 12:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61E1C34114;
        Wed, 13 Jul 2022 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657716165;
        bh=zgu01rK9c5SNFhNzhkt3VGhcrNp7QNRsnRzbqsQTjPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmV9Pk7hfKqsst9MzMnyCOTYa7Fqr5fbLUqQgBAms71txwFRHOCc/oScENOZFoRN/
         Axbaf6+La3Ucvw7ykvcJ0NKbykeyF7SRcVt0++SlhdcKUefZAkv7jtl4R1wT1cKcRn
         mEkpQTyxdj5As3pKtKUNHGbsT1WZpmibYcfv5+vBfuDsaFXRuG1MHJ1/HWblXC5OEK
         cCbO2QnP3uat4FImhwijjmkdGEydHMqFgQXusNofkP0iF+yumdQdoz2rKZuQPnDMex
         exi7wfxclaBZtHTzpxGQbc7kkn2xSOp9H4+pAPEcqdze7aXOPFQeDsthjx+wcQG94Q
         Nn4aMdyl24syQ==
Date:   Wed, 13 Jul 2022 13:42:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] Revert "spi: simplify devm_spi_register_controller"
Message-ID: <Ys69wVhUih0dXdQc@sirena.org.uk>
References: <20220712135504.1055688-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DrIIh0QSaaF4ll/Y"
Content-Disposition: inline
In-Reply-To: <20220712135504.1055688-1-yangyingliang@huawei.com>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DrIIh0QSaaF4ll/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 09:55:04PM +0800, Yang Yingliang wrote:
> This reverts commit 59ebbe40fb51e307032ae7f63b2749fad2d4635a.
>=20
> If devm_add_action() fails in devm_add_action_or_reset(),
> devm_spi_unregister() will be called, it decreases the

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--DrIIh0QSaaF4ll/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLOvcAACgkQJNaLcl1U
h9BQNwf/R8wBjNGVA/XwCXWS0laSWOFE2OQ+OrkUV/2VuwiUhHnaLxXs8hmsQgYe
XMnBiM/8JF7xNLrV5hGWMOihSetjWnKXMTimZc/22HamSInwF+dZIFyLaNMOLzkf
R9yB8JBlpCInl6RsAIWru3udTL6XXNTgYf+2mampM74hIqt32d/xQaeIUiPPBYRF
bAPXPRO40ZbjYymmTl/Qti09lCtTSc+vlOp9S6uoKjYuG0ekkGGZbFQUlozXx9lQ
dtYVdktqdOp4ujXGAXMwv3zIapzVniw6S9lanFzNgP7u7ZyRZHc9LSVaH900mNNB
O7rqRNmeRpYa8BofNMxEHRKaayuLUQ==
=9ei7
-----END PGP SIGNATURE-----

--DrIIh0QSaaF4ll/Y--

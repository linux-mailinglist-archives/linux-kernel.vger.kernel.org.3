Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775DE5B0355
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIGLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIGLoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:44:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F331A5;
        Wed,  7 Sep 2022 04:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F35DB81C3A;
        Wed,  7 Sep 2022 11:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71612C433B5;
        Wed,  7 Sep 2022 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662551060;
        bh=NIjhTuXP3sheyE9a03ASvWQApuFcNLvSRe5pdoLxRgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMtxkVZodoPLUt1klXaRSv1PvwQvqBJGC7rv58MBRt6Vq8yPLkmiWK7Da0oWXK+c7
         mROgAs2/lY61TMF0KarA3Iol8otB0FvAWWX8vLY9xgJak4KSMHLUIEWWmwp2izbS4H
         r77uhnqMBymuyvZROi6hvan6xNEJLJLp5Zqshufz5JoK6hSi53V/WMXJViwJGXvTA1
         067BIXihlkjk7eu9QyosFIgoFuF2DGVQ0WbHF5crOuyOG5uP6lA2zMrIH8K5Uzm7nR
         J3BrjHWfbclafiPw42gViK74nNppxQfS5ml1MUC1AlICkBV5AJmuRWsy9cNIyooSrP
         LD02WkINrV8nQ==
Date:   Wed, 7 Sep 2022 12:44:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3] spi: Add capability to perform some transfer with
 chipselect off
Message-ID: <YxiEEP3krNUiUvlg@sirena.org.uk>
References: <fabbc87627e5ddc2c913b368ae99386668d8dcfb.1660830866.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vw8CZPmgU1ZXszZV"
Content-Disposition: inline
In-Reply-To: <fabbc87627e5ddc2c913b368ae99386668d8dcfb.1660830866.git.christophe.leroy@csgroup.eu>
X-Cookie: You have a truly strong individuality.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vw8CZPmgU1ZXszZV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2022 at 03:57:49PM +0200, Christophe Leroy wrote:
> Some components require a few clock cycles with chipselect off before
> or/and after the data transfer done with CS on.
>=20
> Typically IDT 801034 QUAD PCM CODEC datasheet states "Note *: CCLK
> should have one cycle before CS goes low, and two cycles after
> CS goes high".

This doesn't apply against current code, please check and resend.

--Vw8CZPmgU1ZXszZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMYhA8ACgkQJNaLcl1U
h9Dehwf/ahB7Y3/qYpjIGP3p3s9Rvgt+5WLI9klNAA5Bdj0IuS99Ig63rQEVAUMb
uKhQl8VAlkMOcp0CJie7W1aAZcOoR2FWImaaiOQnnh5HVP8WlFcsLvQqbmqNOqjY
DABkgdevz8aCzS3giSaWwaK2PbKsv64B3vqxl6sgDvsEebhYWsJ4m2TGmks3rIhD
zbIAVWC4h/BsC/nuZamBbDP8LEeWMhl1Gsh5VASV+ZKuIOl5nwv9IBWa8zuMIk2d
fsG2FVH3m2+PyuQ4wtMu6n0Wmj1ybcv44VfMw2oUJ25zuaV95oFMeQLJzp2/aQ7o
ngczTR21+csO8GG6hhJo0JhgjCuOUg==
=8qJG
-----END PGP SIGNATURE-----

--Vw8CZPmgU1ZXszZV--

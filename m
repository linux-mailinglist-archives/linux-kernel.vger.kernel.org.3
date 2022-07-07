Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F556A3F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiGGNoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiGGNn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711A17075
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8006620B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CCAC3411E;
        Thu,  7 Jul 2022 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201433;
        bh=cnNPOociy9HXk4BfEMks/1vQI+oFpBGWCRVHQQ9BrsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSL5zY6KZ9fXAFmdHeNw3BGEnBoTaSQyi6DagE4ovzWN9OsYcgdBS7FokIKK4FCVW
         D4rRtJscP23RcbjyUQoQoOjPYscPNdIY0fARza5zUS9XervMN2+B0NHmFoXls8RIg8
         XZqmf0M1Q43zWKl+npaaoZGK0lxnWkHrChoP6cer5IGC9rFxrYPEg5RWwD88WUtoyx
         Otj/YhLCqn8SDz3nL+SvS8UMJjSGTsZ5cY4xRols1smfVz0I9kTPYR+E7KP4g2e5mC
         ayl4BdkD+qfS0nhEye4ZthTjS5Hv5gwi2l0Jp1BLmD58d7LM/RsrpS9igiDJD0As8d
         Q1eYLl6cQCGLw==
Date:   Thu, 7 Jul 2022 14:43:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v2 3/5] regulator: max597x: Add support for max597x
 regulator
Message-ID: <YsbjFKyoSc2UxnBl@sirena.org.uk>
References: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
 <20220707134141.1172300-4-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c6RQ3hMvUs2y+/vz"
Content-Disposition: inline
In-Reply-To: <20220707134141.1172300-4-Naresh.Solanki@9elements.com>
X-Cookie: Tell me what to think!!!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c6RQ3hMvUs2y+/vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 07, 2022 at 03:41:39PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> max597x is hot swap controller.
> This regulator driver controls the same & also configures fault
> protection features supported by the chip.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--c6RQ3hMvUs2y+/vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLG4xQACgkQJNaLcl1U
h9A5mAf/RjG2oQXWO4ztVbKbt4m/5gpJGIlaooYyncL1DGugYpeaUe4kQAoQu7Fg
D98KIm1uPl36yMPepZ7WThNJRmldcqcibd72SeZkjCto/hovzkfx7Rm2PcjR1+gW
I2D8zl4UdBoczdd/eo5u7LP4POe8AwMJJxNatCkOH9GDLS1bOk8wQZuq84zcEBZo
n5yYvlFPGmo0j9zWE1HBV0GzK/ha1zrkY0o2pY6t3KRGzOQLBd0NT73GKOCsmCc3
DrODlCUi78buu4i+ZxmC3j3+0DFC7KBxYNKvJPp9H9HcMsu0Sc8Bup6Uvu2O71rL
glaE/XwzAJDaw8hYKBL3Lj5TEWkU1g==
=Fi9w
-----END PGP SIGNATURE-----

--c6RQ3hMvUs2y+/vz--

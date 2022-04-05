Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5664F4A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiDEWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458051AbiDERGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:06:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE34AC055;
        Tue,  5 Apr 2022 10:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 449D0B81E8B;
        Tue,  5 Apr 2022 17:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9940C385A1;
        Tue,  5 Apr 2022 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649178269;
        bh=iGN91+OiBItNZNzY+Mn+vZ/ESbyWFHcFeK6CblH8sQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQZ6tqagjnEpbIvhMEyUXiNO0AQegHgbIMoiap6q9+4lMoK0pXeq1oRmztByxY98g
         YNspkHtIX+jJXKjcUVjfjZKQ2UxBvQEdgHrP97VMJmqM5Kopm/gEHhfztMezezKOkq
         HoXMiPCcWVAQlxPfosqTX2z4F5MmHZ6koOEik3tExhBOhssf5ekfneV2bzstCQKdPx
         uZDkPCI7BQwR6mtvvatZNyCcIa6U0+Wq/1eenyZr6FYTdpceFPFJRVM9S+l5t4bJXs
         99DK5bpO1mDq2sOIPa8H4fxy2nQnVOxXkbh8KOD0eAVdUkIqwf5JY+CvGT/AkflbO6
         CstoCAedzwk0w==
Date:   Tue, 5 Apr 2022 18:04:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] ACPI: bus: Eliminate acpi_bus_get_device()
Message-ID: <Ykx2mOzf/xy8NMXr@sirena.org.uk>
References: <5817980.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QPzbWFNPsCze9VF6"
Content-Disposition: inline
In-Reply-To: <5817980.lOV4Wx5bFT@kreacher>
X-Cookie: diplomacy, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QPzbWFNPsCze9VF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2022 at 06:57:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Replace the last instance of acpi_bus_get_device(), added recently
> by commit 87e59b36e5e2 ("spi: Support selection of the index of the
> ACPI Spi Resource before alloc"), with acpi_fetch_acpi_dev() and
> finally drop acpi_bus_get_device() that has no more users.

Acked-by: Mark Brown <broonie@kernel.org>

Or I can take this via the SPI tree?

--QPzbWFNPsCze9VF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJMdpcACgkQJNaLcl1U
h9DxDwf/QLzs4X1kcw3lh2J1QFJoikeWfy+wjpGlQvnW8BFu5QtafcdLIgozDZLJ
4p+4bi2dgUoJlaYf0/aDSVE+lI5bUigDn0eaRZQSrbhKFOY3mN4WgiGuBzMMvUav
FSqLEmUbUv8kAnBjiCpa0ICwnYSKuvIdyoN799H8ab8Nh3Wo0lQdWb38fZXiEyMm
0EufArY7CQSoQOK8pyKbZY9hmuC8YtlwTY6MHe4wM6UY2likXlCjcjj5sGJQI/h+
Qq/tWw4Hfb9uklMZQG1YfAOynbIW2xH25ozOyttT6oJdmtQs5RBGt+uAIg0njVC1
NBjlVEy49YGv9PSoLycg3OObkem2Ew==
=j4ZY
-----END PGP SIGNATURE-----

--QPzbWFNPsCze9VF6--

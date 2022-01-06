Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3748641E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiAFMHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:07:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48100 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiAFMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:07:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B7A9B81E2C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314A1C36AE5;
        Thu,  6 Jan 2022 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641470870;
        bh=G4MDEAzc/U/ZL/N4yuMoGB+qdFldDrB+uAJmY/HYB2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyIURGiiF1ixIt4ZcBA6PopYwA48EIo3ASC3alY6xxFjCAoUKY8Sxc7sWYifRcTjH
         HEXgToC9AZG+XZrkUGVqis1EBcDGNUB9sJn1AFbHU/Zwsy74B2PvNbxF1SqA8k8Dkq
         0fXZIFwvSRwPJgYzllXPPJqODR0MnNRDLQKIFqpsaoWwMK547EA1aguLV1yo24sAnt
         DS8NB5T7iOjg0QRz2IKux6O3VUh/DPZp7L0ShYPR9XYN2jT62Tq+uUwbD/Rf9Gg8DT
         Fr6RlCA0rBJQByBpabhehoC+NUfidi99nRW1d3TnFWTyQDqC9L2+EKOaxqWgA2dBc+
         aQXA9nUb/u7zg==
Date:   Thu, 6 Jan 2022 12:07:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: debugfs: Directory with parent 'regmap' already present!
Message-ID: <Ydbbktqvc8PXQQd0@sirena.org.uk>
References: <CAOMZO5A5H7HrCXoTAK98dkT0wEybcnuazPVxZeHvu78Nq7Qm4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NBzw8NocVhY7ZRDC"
Content-Disposition: inline
In-Reply-To: <CAOMZO5A5H7HrCXoTAK98dkT0wEybcnuazPVxZeHvu78Nq7Qm4g@mail.gmail.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NBzw8NocVhY7ZRDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2022 at 08:47:36AM -0300, Fabio Estevam wrote:

> On an imx6q-sabresd board, I am still seeing:

> debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap'
> already present!

> There was an earlier thread about this issue:
> https://lkml.org/lkml/2021/7/26/95

> but I am not sure what was the conclusion.

> Any suggestions as to how to fix this warning?

Like I said there:

| (we should probably clean up the one with no device but that's not what
| your commit does).  I think what you need to look at here is that we
| store map->debugfs_name and don't overwrite it when the device is
| supplied.

--NBzw8NocVhY7ZRDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHW25EACgkQJNaLcl1U
h9DVigf+JN6iDf38upLC46r9q4vAVVqkQc16tS7Z1Gh7P0eYNZe30H+lAKelRaz0
MQ/2kQISlN7Y0QbjYKetn4jEvvTW4I/Cd7egS9ukak9PpOKAbmjq95qn0Y5n35WJ
NlLrY7iSVSjDlc2DunOuJ6uubnJ8kJJJQN11R987fNxTs4Y14MRjZtNiwQ6jmSGH
Rva4N/VH+/tjwOxihDhJiWnJRxRDKjePfqq2HhLc3dfd0NxzUWMDGTnN4gEo1XYE
4xGvE8qQU0dK0WIOjtv0ESv68lcB/E4X4UXqmds5VEwl7696hi31Ld11YDVwA/Z8
IwjNy0AX6LBtiQetTRW90KQuyu9YCA==
=MsKI
-----END PGP SIGNATURE-----

--NBzw8NocVhY7ZRDC--

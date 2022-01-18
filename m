Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972BB492C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347083AbiARRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:12:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42200 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346580AbiARRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:12:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C45C461475
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4D1C340E0;
        Tue, 18 Jan 2022 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642525972;
        bh=GPZlp//3p8yqxQjMYidmu0QfzB/F+RGgxGDKh9DIb44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AY9H43MBFuXUxaAa/RE1Zzt7/tHKdGqzzXoeU5a3mwbU45WQBQLHyGf+jwFawddKu
         F4ittSZ/HyryXFwS7n2OWCzKVTBxfrCb+cnbA5GMt2rTyHlB6FITKAYZdz69nV56/J
         I9EZbR11zHtHkyLW/J3rp60Sid5e+hDFrFzkBAeNnNHd2J+MgNdrVezYQD0+Q9q/6u
         /cy3uGX7ej1YLRGq4K1+ad0Il2+zf/D+0ubtyLD/VLk3l2+VJDnFlbd68nd8uJXqg8
         GlgQwEQScYHONGd8bApCiiecE5Uf257IAK1X9Q6krYJ4PUSKNrrHg0Ojx1IzEPhLh6
         F0o8qYktwaRdw==
Date:   Tue, 18 Jan 2022 17:12:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Message-ID: <Yeb1EOtZKnO4sr+E@sirena.org.uk>
References: <20220117091621.30330-1-quic_pkumpatl@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lBpfOBQ0w1Ud6m8V"
Content-Disposition: inline
In-Reply-To: <20220117091621.30330-1-quic_pkumpatl@quicinc.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lBpfOBQ0w1Ud6m8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 17, 2022 at 02:46:21PM +0530, Prasad Kumpatla wrote:
> With the existing interrupt ack and clear ack logic, only the first
> interrupt gets processed properly and further interrupts will not as
> the ack register is not reset as expected. Use regmap_irq_update_bits

In what way is only the first interrupt processed properly?  How is the
ack register not reset as expected?  Please write a clearer changelog -
I can't tell what problem you're trying to fix here or how the change is
intended to fix it.

--lBpfOBQ0w1Ud6m8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm9Q8ACgkQJNaLcl1U
h9As6wf+OBgFwjYf4CDokNLeGf/AxVEgB6lDNIld2KCOF0bQG45NWmDU7NvHTDWR
eiBGE4Ch5LX7XRAFZFEFjLy27hRNPrdu5uV7Wtn9l10iiGrDGENJuowXlWv0vS6J
cf7SvzGQA2JAKm3nuhFyUw0L/LmR46bTTFCUC3winEqcIFTBq/2vCqyOHLkTeA2o
0SGIwdDotHlKs/WfbV6KLPi1ccSMlsklbb1zVcG8zJC9IaqFZcZpooDJ8kkgA2Zd
ucXS4L/NgSr8Y1fEGyl+/1UcNcM9L/wmJHJkLqeZ2YuIiMepanWWPHWxVUP0NyI8
aRpvojWBT+j8Rw5HLgCGhkLBaVYGJQ==
=2zcQ
-----END PGP SIGNATURE-----

--lBpfOBQ0w1Ud6m8V--

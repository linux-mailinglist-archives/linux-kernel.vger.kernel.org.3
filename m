Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87411593227
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiHOPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiHOPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:41:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BDB11C35
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A3CEB80EE4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B11C433B5;
        Mon, 15 Aug 2022 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578074;
        bh=KViy7rgGOG8yBUor5xKRqj+o9y9wu/2NAhJi5OxxITY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmfYOxlZlwBtXSMtT5ZzO3Lsw69gQpIcF+Vb7n53TegMmenNNuS3ixCKswpdUm+eQ
         HRZKVQn4z3SfPtNP3/DHlk9eZVr+XCL0z7V7YP4qG7+NNCJMQY6v0Qe9fTS0XNaUIN
         5abQGivt/nO42/4QL0HmJUsvMWfNFXtk8cjyazXfaayU3MZNr/QTCF1blAdkPHhXXs
         cyvCj8hYOv28cx+qh0GbpKnfFwxIlQ0y21oQISBXrub54Nn3AQ466bEi4l/yQBUa12
         9uf/72VRKAcTglFaQj1pQsnaq36HkjpUWxMbpAu0Uu0xL38hiXWHPramgjkq4TzTPH
         +OD+4HA5spQgw==
Date:   Mon, 15 Aug 2022 16:41:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regmap: Support accelerated noinc operations
Message-ID: <YvppFf3c/z+ID96B@sirena.org.uk>
References: <20220725141036.2399822-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7zsmDllC3n59rra6"
Content-Disposition: inline
In-Reply-To: <20220725141036.2399822-1-linus.walleij@linaro.org>
X-Cookie: The other line moves faster.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7zsmDllC3n59rra6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2022 at 04:10:35PM +0200, Linus Walleij wrote:
> Several architectures have accelerated operations for MMIO
> operations writing to a single register, such as writesb, writesw,
> writesl, writesq, readsb, readsw, readsl and readsq but regmap
> currently cannot use them because we have no hooks for providing
> an accelerated noinc back-end for MMIO.

This doesn't apply against current code, please check and resend.

--7zsmDllC3n59rra6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL6aRUACgkQJNaLcl1U
h9BLSwf/S9G89iEHdVuBdVkMyCH8qv433oUF5mvgsUva7TzExz4sI4KTo8FV2E+z
P4eczL7HBSKaGngNmGRnb7ikwlcFxOuxVYbO1D2uYESgg3axZd3fCx30FeueZQrN
XimDnGLIoiO6Cfqe1NdZpFg59iRp46+WHs0b7bonHB/R6VUlpkaALTPmQaTwFCi5
+/ijvCBnx+jhjQfruO/jiq/jvSEWN2WaP/Q0O5u6wXe87k10zRw/poEv1gEdaXry
dx9GDUPjQrLdO4jWKHVRXY/HcRjpLttBwTAY01h0VlAe+8W3zAa3/h5GdJ3I6eKF
sx9HCX9GOpqKuiDHdsQ9+CEh6Nk71w==
=Okc/
-----END PGP SIGNATURE-----

--7zsmDllC3n59rra6--

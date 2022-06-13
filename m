Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF4548E67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356514AbiFMPDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355229AbiFMPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA3ED3EB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B832D60EAC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768A6C34114;
        Mon, 13 Jun 2022 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655122142;
        bh=0Yz58uBIJDSOlFZBeiep9orZ7D8sHWo5T5P/MSNO3hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWduXetG4ph2n/ACNxhs9UrxQhXSPgRxrd5td0xUZXpexuHZSBwtx1oVlekNQdLZb
         8UvWqMFMeweFEBbF4QjOECaNCglIsH9BRmnoyYToTUr4qPSxX179g1e1LQzvYF8P0T
         2wSOwCGqL4SDp1/J3Xm1F45WShn82E7DXEE9hsyw1f4xURRXLfuNEgHQCqWNUbuob8
         tM2YzzVRXvUcPwY+/RFtdyhxCuakkeHlAM57lK5PkKnICxU5IbeIgRHrjLsAyksT66
         VTR50CxyqxQOdylxpS4KyGf+NUMT6vrQvCCETtmddL8AwRSLTPxubuLcrKEktqDzcM
         pMl4tX383t0SQ==
Date:   Mon, 13 Jun 2022 13:08:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Fries <David@fries.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev_test: Warn when the mode is not the
 requested mode
Message-ID: <Yqco2kRAKBJ+fQkf@sirena.org.uk>
References: <YqbNnSGtWHe/GG7w@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PO6+BGLX/AaUKjnQ"
Content-Disposition: inline
In-Reply-To: <YqbNnSGtWHe/GG7w@spacedout.fries.net>
X-Cookie: innovate, v.:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PO6+BGLX/AaUKjnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 12:39:41AM -0500, David Fries wrote:

> +	/* Drivers can reject some mode bits without returning an error.
> +	 * Read the current value to identify what mode it is in, and if it
> +	 * differs from the requested mode, warn the user.
> +	 */
> +	if(request != mode)

Please try to follow the kernel coding style - both the if( and the
comment don't.

--PO6+BGLX/AaUKjnQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnKNkACgkQJNaLcl1U
h9Dviwf/az2la0nIlJiQ23zn15junorNo4MCCt1mdVj6wiAbJZA9VxCNKjvHzilv
8zH75BHg0P8AavU/JnPkmf6gvNFk8RVU13PN7DyYoHkTHvpX/bGgfocb3a2ZYkVC
yWyI+mZmgnKflq0t4PHYNGby4QAhzuWd/Rl6UkOUf8opkSofw3crbtFHkXuVC00n
86CrgQPBcgr34YIF86pZUxDMiipVOpnzOjKORhCqfAb9m/oCyJhX2T3EH7z3HDnN
UMxnVyPi41BD+OaWa4z3tGzzxekOaUaaUelFEMjHsbOFIoxHXyx2kU5GSPU6Ou5I
U4xBXeZYJb8xCSmjSo5fY9h+8GxHcQ==
=c5LB
-----END PGP SIGNATURE-----

--PO6+BGLX/AaUKjnQ--

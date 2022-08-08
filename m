Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89F458C795
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiHHLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4FEE2D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729CC61146
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E9AC433C1;
        Mon,  8 Aug 2022 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659958507;
        bh=9VQ1n0RILNN2EvqS51QA1XwBJHh48+eBMzi+ygj4sCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JizWWEZn11txIYZVbJ56cgO7ykOsThjQOD0vYNrf+NaAp24mqeVJEbNAvPyVYsCQU
         OdRGcgp48oilpXBnoJS1z68NxwuQxT9v9ggnZahwKJ6omaSWyuVB5zPXliowJFSfxg
         FF2DQ+s9nm+okOULORVKnN+A8KNwpGKme3xGe7MEYA3nJpS53lzyCXOAv2qPB4Ihbu
         PqSlXjU9UWyl5xrKTCJkD+9NBSM/ACBVwV9C7F4LhzIgViUe6Y6RJ7GIeVih4X4lrN
         n7hO+j8Y7uAQJd37l3jofUUiCAt/b7zonQ+Use/JsBYlQnZEWX808NGYwEcgXFCyyN
         e9I4mbHFEW2AQ==
Date:   Mon, 8 Aug 2022 12:35:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com
Subject: Re: [PATCH v1 0/1]
Message-ID: <YvD0566PDkXhSsNh@sirena.org.uk>
References: <20220807034052.2314-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5MBuROgxpf/k0vpG"
Content-Disposition: inline
In-Reply-To: <20220807034052.2314-1-luminlong@139.com>
X-Cookie: Are we running light with overbyte?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5MBuROgxpf/k0vpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2022 at 11:40:51AM +0800, Kevin Lu wrote:
> *** BLURB HERE ***
>=20
> Kevin Lu (1):
>   drivers: Modify some parts

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--5MBuROgxpf/k0vpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLw9OYACgkQJNaLcl1U
h9AG2gf/eRovvDAKbNKcTZpPmNSV9wbvfGnD1A2yyhYvgfDyeta4LQOeEHWtQkwm
gkS+d7wK9Dz3J9CNy9177R9vyQRyBbV3qqlA3lwdayVmAR/+Zc9HkvObIwdvgTZ3
aI0osklUluhNqWDxO424+5hKaW3Ggw+N/LDcQ99uZKxcPZrp6eJn3PuwFXhTlJVk
AsBc6BNtXg/QXpb4Lwpyk/uyAs7JN1c5Ph7XfRcYYltRirG5o8UfEwq6+YMWuMRm
rIzehflw/iCbKuHZARVfHgOH3mKxigtiHCC8jJQ5GEoUbzQ1VRapldONQdbRzMbR
r2mGcYfQzoceRk3gcRYQ/EDBXZoWWQ==
=Sd9R
-----END PGP SIGNATURE-----

--5MBuROgxpf/k0vpG--

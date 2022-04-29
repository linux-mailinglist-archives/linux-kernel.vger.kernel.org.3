Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7C514A28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359665AbiD2NFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbiD2NFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:05:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2147397;
        Fri, 29 Apr 2022 06:01:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KqXgR3zDbz4xL5;
        Fri, 29 Apr 2022 23:01:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651237299;
        bh=vtp78OdYVuFW80iG+49AB0sF+gT7HB0RMQGuTJ7zQ2o=;
        h=Date:From:To:Cc:Subject:From;
        b=BFVPJdiP2FfCPf050BNOlbhUBdg4SVVmWYtnFwBuScUVgTfNRFgMT7R5SOtw1UH5/
         heuW2zUrXJkj3qo6PR0oyH5/yTeovx9qa4cpQvhTxM7ScbDEmtX24e1dQ9rMr8sUiw
         +RH2jcldR+vZJ1+k0qtDuarR42k4ZImvIda/jXceqGEYuXoPLLKDSFOJARWNS02hbc
         wZts/f7KMytArvoTPcHiZ0vsa/GDNmOGc9O9pcpAQLGiay83ziqqLNt9PLwq7JSFAY
         gJRorqof6lLgAwXtT1CEeK3XF4oGQa8zwHvGk5zArUUgZQDEoiEaefuWVWb1jF5AlT
         HCtjKrbQKi5/Q==
Date:   Fri, 29 Apr 2022 23:01:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the iommu tree
Message-ID: <20220429230138.6647faaf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_zxKQbp=RjHGOJHu4kzsGv_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_zxKQbp=RjHGOJHu4kzsGv_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  df2a0bccf804 ("iommu/amd: Do not call sleep while holding spinlock")

Fixes tag

  Fixes: dc6a709e5123 ("iommu/amd: Improve amd_iommu_v2_exit()")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 9f968fc70d85 ("iommu/amd: Improve amd_iommu_v2_exit()")

--=20
Cheers,
Stephen Rothwell

--Sig_/_zxKQbp=RjHGOJHu4kzsGv_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJr4bIACgkQAVBC80lX
0Gwrsgf9G8lcinLaN1g+yhaK0vgCxdPT7Lkg+o1Fs2zLsqvEzUmCuEYX4CRRl/Sw
6NAX2PhFR0xiLlSewylSV5rwqrGlahXmTXIW8t6riON/jR9/dqt5aP65nFmlXJ5D
dITE+epUp7w/Vn95sZZMotB5WFvYXC9yQgU9l46mPtlJswAf3gPpKJTY6XqdQIkS
S10tT14wxoaf6qhZF9gK9IOsdNQprPDF75fhP2D6lXPw1i08Bl/mbp246FX9xVVx
9s5xiN4Ihn8UuhQ0GCjgEckD5y6twMa7HG/haNHd1slQzrv+HVQPD6eZrF3+UH3A
Qa9WKB98B23WAj5TFSl/W4Z97TVRVA==
=Bo/J
-----END PGP SIGNATURE-----

--Sig_/_zxKQbp=RjHGOJHu4kzsGv_--

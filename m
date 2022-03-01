Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE84C7F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiCAAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiCAAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:34:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4DB7C6E;
        Mon, 28 Feb 2022 16:33:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6ysV1pgzz4xcq;
        Tue,  1 Mar 2022 11:33:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646094814;
        bh=z/WJj9XCSEmqB/UnuvHamlskTmGqIsVIfGA5wXcBP4U=;
        h=Date:From:To:Cc:Subject:From;
        b=df/1vczJO/1FdR67WTE93pYC/N/BvhhXDYhGu8Ane0yXHs5qSA8L9q71NH2/mA4Sy
         BVTkm4WlLvQjCDabYHqc/4bRfGcczTE1qjzCJ+Y7eWjhNwYfpSfbHEJ++ZXtIHPtbh
         peN7d0JFJGv3d/8/xaqtLEE+CzHPg0l8mjJMu03Atx1Uxsvu8SUk9pKUVWu17L7qw6
         Y2OWAXrhqtGX7c83SUIWAB5zOzhwSJmO2u7JmdDr39uCPHukjze+H4R5gZYAGp8OCZ
         kMLbflDc2eIBYlWEIB0AXgAo7vWRL7oXQs31vMDLhMy25iJyDnYaLo0Qk/MnBfJcis
         /M+Izm/2rPLMg==
Date:   Tue, 1 Mar 2022 11:33:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <20220301113333.21d6f0c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yY5vmmlhoayNa1clFUCIoYq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yY5vmmlhoayNa1clFUCIoYq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f131a1296ecf ("module: Make internal.h and decompress.c more compliant")

Fixes tag

  Fixes: f314dfea16a ("modsign: log module name in the event of an error")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/yY5vmmlhoayNa1clFUCIoYq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdad0ACgkQAVBC80lX
0Gx6aQf/Z7AlcrGvv0UiQX9S3DG1TOUJi/OxF/j9yC2YC5qqc2+df+WgQg2jZsQR
PhzJkmesdwf7jY2TP+7rbPA7nKJfYX6GLaM3MLtRmtLD6oSX1wF8iVH3gBp3RQfU
ooGTJbXJWy3DuxXYN0pClTPVwiw5WUullx/D7+8uafxwDS0URWFwdDSa8XhLTRrT
izW6kQ3Zj6i0x9xgqNkAgFZXVo8lqCs6YYVM33EtUUX/tx0GFUUPinVvH71kiCq0
Am1WEGzxJ9nMhTged1MAbAlcDUOjmxmBTZKVlHzA1OXEDCrl1Bw34KluIOcADz9j
mObpDg7vGcraHyFn7FDxhsWhDDZjaQ==
=UDCL
-----END PGP SIGNATURE-----

--Sig_/yY5vmmlhoayNa1clFUCIoYq--

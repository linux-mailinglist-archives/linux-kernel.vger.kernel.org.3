Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B448505B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiAEJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiAEJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:51:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B82C061761;
        Wed,  5 Jan 2022 01:51:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JTPrp22rHz4y46;
        Wed,  5 Jan 2022 20:51:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641376298;
        bh=1hgp8kruCIQnJDveBIyIgTl3QAqnEAYOHyEaJ9NyVl0=;
        h=Date:From:To:Cc:Subject:From;
        b=kRgeLlUj5lZo6gm2OGEMmHsTNDWEtQX7CdmoWKUT1Y6cRkW47I/MuObJ3RwvBx5Yw
         rYphnR6r1bxEEspDBfRBtJs9tW3uTzGZKd+ONoFGOQWbCVudi2v3uz9jexmxcCp3qT
         UHOZCRYRuaXnAISFdSIFf75kQYbbnPqZ0EoGKEKr0fIbfLW4Pl9EAeSW7EMO4Mki2d
         gvHGRbBiqI3P4OWYxuU3cl0H4vvRBvi6hbRpQAKM2sQnmx24kRMLPpEddKDbVIjpfp
         zKlDA81M5V0/Ah8su0pRY0I2W7eSgd24KmTVZruKepYLK8JXmKtXQVXTJUE/CH72UL
         h4xuXejd9PK8w==
Date:   Wed, 5 Jan 2022 20:51:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the parisc-hd tree
Message-ID: <20220105205135.5e5c466f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RF6dgx.=CnPdtN3A667Tj5M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RF6dgx.=CnPdtN3A667Tj5M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  71174cc59436 ("parisc: Add lws_atomic_xchg and lws_atomic_store syscalls")
  8e38228709b0 ("parisc: Rewrite light-weight syscall and futex code")
  3a747b528b6d ("parisc: Enhance page fault termination message")
  e62aecc32fac ("parisc: Don't call faulthandler_disabled() in do_page_faul=
t()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/RF6dgx.=CnPdtN3A667Tj5M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHVaigACgkQAVBC80lX
0GyRUQf9FKjpLqlXnkHw67fc+FvRXGwb+qWu8LUesiYEeu29ZZaqKk2IQ/lrNQQU
kHNdjB+3P3vWrg0ztuWsfkGU99UODVHQPBmIvHO8cdOR7HsNxr8KKUYh1xIkBd00
A8zZmKKZWKeb0dNBTElXx4yBWyXCyOcp/RiN40zF2v6R2X+LpzkjjZ+pCflOtqwo
c971YXIRtAZqPeQfNCzsbf0NjGP8gm7A3kCL9S0wlxqBSTu0c+0XRVi8iwfUSx3U
apR+4bb1xbDVENj3NqBdpcrBHrECwVS2RoH4ew8GGwu3X8n1mVr5npRtzeMn7G9c
Yegy+8nvl76cXne3C4G/m+EWEVYvTg==
=vEdV
-----END PGP SIGNATURE-----

--Sig_/RF6dgx.=CnPdtN3A667Tj5M--

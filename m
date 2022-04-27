Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635451256B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiD0Wp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiD0Wp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:45:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606401E3F8;
        Wed, 27 Apr 2022 15:42:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpYfm3j7fz4xXW;
        Thu, 28 Apr 2022 08:42:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651099360;
        bh=hN+RU05kT3BQ/bSZrT1Y4ytgtwH7Y0bdyCzdEfE9lVc=;
        h=Date:From:To:Cc:Subject:From;
        b=fJBlSeM6q0M5fMzqI/NOfe+gPN/flbr+C026E6pBefdjfGtONq782Z2cVdrizBsGb
         OORF+ppf8LYMw4nOeTXDRveRo378MFDtViz5d+i8l4scmCNE6H1w9SS8GGQQIISGtM
         GSQQTtVe+AGAd7A/18MaO2Wumvb+ni709nsIk8DawUShVsx3i7B1oyJmqI9U8RWcdB
         uIoGApUevh53bQxcOk+wiUMadvp0SMJoue3B7wYE7kcEP3W8UuABUWrZuRscllMg4J
         TRH0TCPcFYmhqaZXxtvWa9cn57JB77ifmKI2sepiyXku4BgYsIrahnRwsw2e0EZU5S
         o5TA3R1mH2m8A==
Date:   Thu, 28 Apr 2022 08:42:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220428084239.06ebf49d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lv4Ugcf46ZP9kaW54xgpTI1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lv4Ugcf46ZP9kaW54xgpTI1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bc7608890065 ("mm/mlock: use maple state in apply_mlockall_flags()")

Fixes tag

  Fixes: 0d43186b36c1 (mm/mlock: use vma iterator and instead of vma linked=
 list)

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 1dfcb33e7c19 ("mm/mlock: use vma iterator and instead of vma linked =
list")

This is a semi-automatic notification - I know this is just a fix patch
that will probably be rolled into the patch it fixes.

--=20
Cheers,
Stephen Rothwell

--Sig_/lv4Ugcf46ZP9kaW54xgpTI1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJpxt8ACgkQAVBC80lX
0GyrUAf/eTEZvVZYhl/T2MlWtwykqau3y1EDWGz/EEhymDXK8Wus6Nx0ueKJirua
SPV0J5CbKIAoht/V1NFyztCyHBijKAX3vZTIltimiTzkN03fGJ4OjnEP/+0v4q6v
XnCvHmUlnMgMKaL/Id33dvdQkkO2Nx0o7Du3dQo/TjR2onCkV8ldy4bZlAcmP1VP
NXEzm0k1Igo6TIzR8CU99qvsQJaEJ7mQbQWuTw9ubNtmkHnirbO0zE2tYieYd2Fe
jGWW7SN/gxkBU/bz7R34cHZRtrnGMUeDbt1j6wlzrYqZYeLm3LVgeA4TlDZWimXn
+Ctao4qHN6wsvhin7mqbhyT7mtRilQ==
=NEZE
-----END PGP SIGNATURE-----

--Sig_/lv4Ugcf46ZP9kaW54xgpTI1--

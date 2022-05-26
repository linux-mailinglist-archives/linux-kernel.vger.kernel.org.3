Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D339534ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbiEZHWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEZHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:22:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26531DC8;
        Thu, 26 May 2022 00:22:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7zs01vW4z4xD7;
        Thu, 26 May 2022 17:21:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653549716;
        bh=5WWR9b/ZDGAu5g9AkjwKCwos2CUqL06PdP8u2JFH55Q=;
        h=Date:From:To:Cc:Subject:From;
        b=AQUc4sS51L+smjQfXn9sHJCIMz4xiaKIxWXPZAwzOC63eZvKyIRUilhAXX66BLNFK
         fWkzmU16P5ySFd8Maj23fZ0K1v3+QnfrnyfIUes0asCllPbekJvqWyiACdXPrcnZFw
         SAdarFo4ek6mL9nMCfKHV20XMAOEAIl+9jplI49YoKb2sSzbtKDWM68LZf968uG1YL
         SbKOZt3bg2ZhNiWvwNV+G7mW+iLFqFEU/pamE5rFA9OPU9G67Ne3snCOeFUgfPmcNE
         aignWXmhyzayMleyp2Ct+FlUpg5rOBrvESamEe69HimR9byV2ABKsX1cGEPHJAsUHh
         kMWs62ZYC2bLw==
Date:   Thu, 26 May 2022 17:21:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Young <sean@mess.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings in Linus' tree
Message-ID: <20220526172154.23853e1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ycxx3/vyq6wl0ZKorA/XSNI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ycxx3/vyq6wl0ZKorA/XSNI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

building Linus' tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/output/lirc.h.rst:X: WARNING: undefined label: lirc-can-notif=
y-decode
Documentation/output/lirc.h.rst:X: WARNING: undefined l

Presumably introduced by commit

  e5499dd7253c ("media: lirc: revert removal of unused feature flags")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ycxx3/vyq6wl0ZKorA/XSNI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKPKpIACgkQAVBC80lX
0GxKRQgAoU3/ooBEt6BF+vn0CWq0hWLKyV6WLa+pSvRRwuYUre7g8iCFjJ7IX9L1
+ss6oAoq2/KCiyNiIkMpaXfjYZqdgQ3+TopKlaCf+x0KV+nl28gCWApj4Ztf2Yy5
aOanj8+StuH+7hdIx3MCTdPcYYoH1pG3JfLvOtBmTvHasdr4pTH2nMFOu6anY2cs
yIQffICheLDY8kTBh3YWw97j4SLFG2g2RfJ35jQxjAgO0Hr9dtyaguclxzvcrkUT
PShbUXgVzfBmZGsJCreOfJq5KsPKIdVVAIHaGNIFrYUn5w6OQmmdW1pL8UgL3Mqe
/Y39DVa77BvL2F6GNDAd8Rg/W4ZPdA==
=wmxH
-----END PGP SIGNATURE-----

--Sig_/Ycxx3/vyq6wl0ZKorA/XSNI--

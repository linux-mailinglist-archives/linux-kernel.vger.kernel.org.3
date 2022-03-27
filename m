Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2694E8A36
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiC0V3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0V32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:29:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F011A1F;
        Sun, 27 Mar 2022 14:27:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRTSg3wJZz4xNm;
        Mon, 28 Mar 2022 08:27:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648416467;
        bh=XtxAUwcR8HOR/SFlN77Mm0kN5FlWpJBq49p3PUzU8eo=;
        h=Date:From:To:Cc:Subject:From;
        b=IDhTWv8HN2uZsmWJWDkRnInUKJm1o9Nk/3k42hiUQwbjR1bXNAbcx7asxqTdM/QwI
         nrbhdZnt7Yl7/W17qL9LnTZp57OyJPMoO870opZ1dE9jWpFofZPYmCwoAKEe9E2kNW
         8bgUTfhfcE5HcB2nLkLCu92t88zYNAP/c64nEdjKIaNjajJhUJtAAxYm1i+qXQfVl1
         h4Ls50M4JEhz/J8nUxvHlFXIftTAMh1MGfs1UY0yqP1nHJxx0B/q6claKTrCCcW/Dm
         zH+W4XM5dL3cGqBW5mE1qU33RYhwVPNCNgQrVAfoyMIOTW//ZglFb2hmPgFmv8w2in
         Ph92lEo3YiiYQ==
Date:   Mon, 28 Mar 2022 08:27:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kspp-gustavo
 tree
Message-ID: <20220328082746.6a9470f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rTGmvsnqvhcqS4YjeY6N+Xb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rTGmvsnqvhcqS4YjeY6N+Xb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e432da2a9c19 ("afs: Prefer struct_size over open coded arithmetic")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/rTGmvsnqvhcqS4YjeY6N+Xb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJA1tIACgkQAVBC80lX
0GzimQf9EMiu3JBOXgBCCJ+FB4axAQmpFuswlp50ptDvmRI4pXRwIP9OoHXDgLii
cDSNTrDNo0lLLt7s0kpjcMy2PP+rroELgsmfoO77QQTlfSv4ISwMP0hDxpcB9MBZ
Ec85tshQ0WYF2IISlWECXAbTja2QyFFL8JwSPKuqQRmCAa5dIs56DM+NCD17TwHU
aiujN95lqLVVIP66EVWixzCxX1kgLlhrOg9PIHP/AkW98Hl36g3rKjUNEVXB+VXY
gCrjP8uKmhYaQy6Rlc2ocGHbeko131ArgQ6UXUR4HFFaP+bX0g+wmIx6ViooCphO
BaxkbIv2flZPucdLkh97Bhqk8zteUg==
=9Lmw
-----END PGP SIGNATURE-----

--Sig_/rTGmvsnqvhcqS4YjeY6N+Xb--

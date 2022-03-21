Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0C4E2735
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbiCUNHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347497AbiCUNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:07:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135D3D4B7;
        Mon, 21 Mar 2022 06:06:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMZcp06bpz4xMW;
        Tue, 22 Mar 2022 00:06:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647867978;
        bh=6EhsnTKmzF1R/kCBmTqXfMmfJS8ROJTFrsWabhsRzlk=;
        h=Date:From:To:Cc:Subject:From;
        b=rIFnQ8Avu/ztEqXxnTnYOT+ljqSMN+O2+msSajs+Me9eFzQHi/F5PDuhsA6QdJlPV
         vJCliM4S43NmK04d/mftlsxZKTCRid438DSdXVi3LOgNHWb/WUQcnb9D5hsO+Ar0A1
         i8386XnZ16DDc/xlmtOyLgOAvVbpTjEjzzalCjDS++aQ0lVgeDooutRB+5Y8pOVkRm
         S7hNoAWfqWuduBkLI9pjxr5TOGGjkRYzRegvB4wVhdfVdgNS6ONgWAiWbyYT/ZpUAR
         IlsRhCP+0XsZKkGhCxZ80eamEadNikUZztD5iP2qNepb1o5LoRFbx1SlfF74dMD7kT
         h1YOToVPYk1sw==
Date:   Tue, 22 Mar 2022 00:06:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the irqchip tree
Message-ID: <20220322000617.0a351d78@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u/MBQDf9tyM4g6GwX=9iIA=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u/MBQDf9tyM4g6GwX=9iIA=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  686121ebe6fc ("irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to clear be=
fore descheduling")

Fixes tag

  Fixes: 57e3cebd022f ("KVM: arm64: Delay the polling of the GICR_VPENDBASE=
R.Dirty

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/u/MBQDf9tyM4g6GwX=9iIA=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI4eEkACgkQAVBC80lX
0GzaOggAmwFUHc7fBbGodqMLLX86o3oValNPA8MEq4lt1uwmwZ6PFCsLAF9KVhtB
5gAK48TuGF2LEQSSmeNAOdR+tHiORu8LeMA16TxA/gYMfvKmJ1f6jFmdq6XZX7x+
M2JVp479h6ReEhIsi0GXoX83/V8qX+IjVh+opi12/O8Tw7BiY4tgPn+Ki76zxZNH
sFihevjoJ7Rt8YxURIRqAUto8POPeeHcwDATiCJQ0m6y8UHRERUQT4YS23PBDWet
5uXp/eSxsTgP46CMMzDDiFEuSgyC7YxmaHFLa+ucDqsJByzaXA9PdT537nq9xuxw
bMl9pPt0GChCijcL8b2x6e0S+atZWw==
=iIfT
-----END PGP SIGNATURE-----

--Sig_/u/MBQDf9tyM4g6GwX=9iIA=--

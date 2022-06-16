Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036154ED84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379143AbiFPWqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378725AbiFPWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:46:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2762135;
        Thu, 16 Jun 2022 15:46:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LPHMj6mjXz4xXj;
        Fri, 17 Jun 2022 08:46:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655419570;
        bh=HxeVi7d3ZFyHoBqxaWpOaIpqsRFHdIqVNPViRgFSW2o=;
        h=Date:From:To:Cc:Subject:From;
        b=RyAjMShYweHsBPGwJ9wn7NDS13AVTbpRKmb+RWGv3dws391Zb3+pmA8SyX0aNdiEq
         dJqv/4PpKKI5s3HUmkaNp++i6TAi881L66Bxk2Ud3+iPJTGNPMvqTKZorjss1gc3lR
         qXFqxCXfDZJvTusk134Poqv1MbyFYh23vCqqvu5w/9qTvWp5OjM4mDweT6QOc3Z09e
         nTik+cU1b9yZaQ1q+nOpGyUfttWp8TS32HBAuHJukgYgoUaqGadgOX7+R1gmcoFhyz
         G9YGgrvA+XOt8Oqtx11i0OgZ+pMJlivRAXlkFd5yL1Y07fOKVHgybCPakAMYswlBcs
         cOPxwph7jFesw==
Date:   Fri, 17 Jun 2022 08:46:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the device-mapper tree
Message-ID: <20220617084609.17ca0af3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CPQGn/vr_5RxyI9K8s27GD8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CPQGn/vr_5RxyI9K8s27GD8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  11199f406eb3 ("dm: fix narrow race for REQ_NOWAIT bios being issued despi=
te no support")

Fixes tag

  Fixes: 63a225c9fd20 ("dm: introduce dm_{get,put}_live_table_bio called fr=
om dm_submit_bio")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 563a225c9fd2 ("dm: introduce dm_{get,put}_live_table_bio called from=
 dm_submit_bio")

--=20
Cheers,
Stephen Rothwell

--Sig_/CPQGn/vr_5RxyI9K8s27GD8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKrsrEACgkQAVBC80lX
0GyxJAgAgNr2oNTpDs63dgtY1gbY1lxZ0FK952rj2riFc2nwv/oI0tkCMSejm+/U
Wayv022aT+UsS50eOQTlYCj+a+dWNCj7iebq/iuwTvjKi0l1cBZQ3m1L8mMxeyMn
XPzOdr9PYkv1LAVjFWLp/Ju529hZwRm5JgPxg75UXWj0sKDWcMbPyxU4/dmthsul
H/HX7/wOJ5dGYbo5k5K4LWWPQ14n2HV9rPjGMvuC4v+bigaVOXjEXMJyMiVpKYsf
nTKUH+scCWwQ2kKiI3abbvpROFgiI0og8kT3Mm00naKAyegTyN5TXAUAXsHKIakh
mM088ZwNgCoMxp/APKKcipEPSO25cA==
=mDgr
-----END PGP SIGNATURE-----

--Sig_/CPQGn/vr_5RxyI9K8s27GD8--

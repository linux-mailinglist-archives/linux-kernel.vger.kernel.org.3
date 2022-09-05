Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAD5ADB08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIEWAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEWAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:00:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98719020;
        Mon,  5 Sep 2022 14:59:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM2Vv1NXCz4xG6;
        Tue,  6 Sep 2022 07:59:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662415191;
        bh=I7G2xctQ7/cWehxr33HzEMAYZCiDkhHylvVLOgUKzV0=;
        h=Date:From:To:Cc:Subject:From;
        b=e/42SZkoDpcPmTdM1Cfs05Vi8R5/nudv3XoNAkOIEIPEuAI1PyKKmv/Ih4mTWQ+qt
         kOovX6qDv8B/hHbnC07sbJarfCow6TzssGW/PzA6+Em3NnjokYCK+P6m8Y/USFfzFV
         flVHMtVX+UEFlGj/caajJfHJAy706P2zgre79DKHTKGibSA66mRHpXwD+VdjcwuPiI
         euQryvyeDYlupXxZ9uLsPV6ee5rL7vjR18MnuVO14xmXJXpxIeUCPJ9Gawm4eqqhDu
         0iXnA8HaClYCRBzfkdRQP9I1SyYp/jmrnKDb5D6b4XUvNUmFf2ME0tFz+CfBWXOn3i
         8d1b3GXSW5MLQ==
Date:   Tue, 6 Sep 2022 07:54:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bluetooth tree
Message-ID: <20220906075407.21f408d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d=Ez8LWrj59Aaff1FxjOm_l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d=Ez8LWrj59Aaff1FxjOm_l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  45d33c081bcf ("Bluetooth: Add experimental wrapper for MGMT based mesh")
  6db7da4c50f0 ("Bluetooth: Implement support for Mesh")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/d=Ez8LWrj59Aaff1FxjOm_l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWb/8ACgkQAVBC80lX
0GyZgAf/RsEMqsgAJHWl8LoEngNutpZaxskttJ+SBpLL8eVbbknuB6KtyrV1yRYi
hVhqQ5Hb0iSvQanCbJYzPECamyupTfHBUXh5zwsZQ8d/OOPzyp3Ujqs6Sfd2qJ5x
/QCtPaqS8FJ/xawkAJOqJQOvn3CMg2jnMvl56aQZ4VQkxeOlMetNKz9srIUDrMGb
eb56kq7snx1UdB8JdkGeWun10VEYxBfFNpl30I1mzZ7WuuY8hISy3ohTymvCLgfq
Ni04xwdN9pS2N9Hshql73ZkJ0eCen7ViwB2n+o3ucp4u+3SKYviN5MrZrbpys1QE
tZ+aXgRJwTHiQhyV5VJqQl8flg8ENA==
=CFks
-----END PGP SIGNATURE-----

--Sig_/d=Ez8LWrj59Aaff1FxjOm_l--

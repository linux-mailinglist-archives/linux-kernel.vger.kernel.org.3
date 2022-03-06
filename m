Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCD4CED9F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiCFUQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCFUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:16:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F79249F17;
        Sun,  6 Mar 2022 12:15:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBXrp5sj0z4xsk;
        Mon,  7 Mar 2022 07:15:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646597723;
        bh=MV1NKlNVu3JMT/tmAcJ7ue77o1BkO/XrAqL6EDAoLtI=;
        h=Date:From:To:Cc:Subject:From;
        b=fbhaBF2q9Cdu1TCZA4joL+c4RmIYc0RVIDxFICi2D5TDbQwQCp0PO9P/LQrjcQrDS
         j8fpTOZG0bUyHIwUFcmrdyZXBjp3wFnvnf2pHz+Aehqlz4wYyYSmCKJQDvnyPGufKz
         Jn724dmjiyQjfH1JsQL7rBpqrFKY7rDBvU2keGUJ2J55x8UiEXmoTGnscgIN5GgTB4
         al0eP43OJ2iLSNKJRrTlPDc9OaWDA+ImjtPhkh8YgH8pFdLv5gpgeH6+IzkDC8e5Aq
         CwIOts4ktwSJPOxhoPelWeBTh94zOi2ptV2pXMRW+83NSYJYslpEcXdko+xWETQmKF
         v2j828tbdeg4A==
Date:   Mon, 7 Mar 2022 07:15:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the vfio tree
Message-ID: <20220307071522.4107ab83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6kcGccvTcxDHYJ58jVcGnlO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6kcGccvTcxDHYJ58jVcGnlO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfio tree, today's linux-next build (htmldocs) produced
these warnings:

drivers/pci/iov.c:67: warning: Function parameter or member 'dev' not descr=
ibed in 'pci_iov_get_pf_drvdata'
drivers/pci/iov.c:67: warning: Function parameter or member 'pf_driver' not=
 described in 'pci_iov_get_pf_drvdata'

Introduced by commit

  a7e9f240c0da ("PCI/IOV: Add pci_iov_get_pf_drvdata() to allow VF reaching=
 the drvdata of a PF")

--=20
Cheers,
Stephen Rothwell

--Sig_/6kcGccvTcxDHYJ58jVcGnlO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlFloACgkQAVBC80lX
0Gwoxwf/eBZW3vP50d+8rCNkLNL/CWY3ItVWbSuQClhjm21k4B3rcf2WQ4tSQxXy
Aqzn5FBH+aJdjgbdcUlmg3w/17Uko264hTCOZrL8M2Kof95wnRCKYELwvlZU0q1D
rwP0Qh8JCefTjiGRTDXzeGPTkmrnGJ7oJHp391NqeZ8SYydIwieEi1qnbDMZzOXf
AgP7MmMhsG61avjvqEpUoCP8GuaSm9KaeHEMZGLjXtFWYcvUGahcWiDBDaou4sxT
dGpGP7uPqYSpWnVKS9O3subLPAYvbP9K0pdRoX95hrLQzQBxaj+oAiLNZ5MuvawQ
teboi/IQyIHZrrB/GLR4SCcTHL61tA==
=Wg3H
-----END PGP SIGNATURE-----

--Sig_/6kcGccvTcxDHYJ58jVcGnlO--

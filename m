Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B8D57297A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGLWs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGLWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:48:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6618C9978;
        Tue, 12 Jul 2022 15:48:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjGBH2c4xz4xvW;
        Wed, 13 Jul 2022 08:48:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657666103;
        bh=YQAXHLEZl/awahUB6FwWpnFdDJdCz12TelvBYYOtNbk=;
        h=Date:From:To:Cc:Subject:From;
        b=E8ayPyxwNS05cfpIL6py1NJxS4x+tMJ9FEWRd3uQKNfzl7UhYXyZ5ISXp8WDC/Wz7
         2CrNf0QnYMxxGrtnLicrJjQ5YOflgr512MZhFGWsRtifQL+j+uD9DO0qRDnYBnpbEf
         /ELJ7sGcEcaaAZdPr4AC8rIyjCAR7sjKBvJg6znHgKj6Gkjuzmr8ieoSyqdBWqIqu3
         YDaaNLKIbPGQ70xcny1auc+/xfpAR4eeTjXANEm79W0VM97i6u2P6e8tvjwbWAWrJh
         EzW5HWOgjp+ou4CRoO1thX/qtFW1AZHVGkQv7f0gz4U7KSDu27fJg071w3W5n1yip+
         cQ6w5axtjf7vA==
Date:   Wed, 13 Jul 2022 08:48:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20220713084822.5e815c56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pQhuONsYb84gJfLur/dysjY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pQhuONsYb84gJfLur/dysjY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0cc323d985f9 ("Bluetooth: hci_sync: Fix resuming scan after suspend resum=
e")

Fixes tag

  Fixes: 3b42055388c30 (Bluetooth: hci_sync: Fix attempting to suspend with

has these problem(s):

  - Subject has leading but no trailing parentheses

Please do not break Fixes: tags over more than one line and also keep
all the commit message tas together at the end of the commit message.

Just use

	git log -1 --format=3D'Fixes: %h ("%s")' <commit>

--=20
Cheers,
Stephen Rothwell

--Sig_/pQhuONsYb84gJfLur/dysjY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLN+jYACgkQAVBC80lX
0GwtJgf/c9+iqgJyiinF7BzZmFNrZNVhTCocBI5xZ2NCGMzMaI1ST8XGZ/mFRwIE
ySwoT2JZCNe/BE1uda3Hj6wakOsW39O3q1Vh+rxcLFPjmC4KBsFhMmtoLWjOUVTA
uJVr8UPJDGATcaBPO07mpvlUJRqgJsFwCro7i87znUHZn4FARrRIl+9LYJ+wCrvn
KJXsmglFr53NwAVH5LWk5grteeM6KIOILn/5C7Ug02ndw53W7cePQ82zpSzMvvSU
St0aW0BkaAe9KA5kA9P2MqZYqdE97DN7YTrRRxHdLHqIu0ZTx1FWnzlZsXOg3jdF
ba2qy95nkfZWXQW2iPa6ImxbgqLArA==
=98M0
-----END PGP SIGNATURE-----

--Sig_/pQhuONsYb84gJfLur/dysjY--

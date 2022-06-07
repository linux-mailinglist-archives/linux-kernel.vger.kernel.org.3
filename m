Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2953F4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiFGEXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiFGEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:23:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB894C797;
        Mon,  6 Jun 2022 21:23:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHHK22fNkz4xLT;
        Tue,  7 Jun 2022 14:23:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654575782;
        bh=QVHHEDdTztVXryisDcPkfeDUhFQlxc7yvWyc2Kz3mVM=;
        h=Date:From:To:Cc:Subject:From;
        b=EStsrPM9ZivQwssA4QZsLUEgPgBY8bO+2iycoFIJcKpu9/yXAP04nXhuW6jaEkPAj
         RjMKl8acJ8ldCu2Ck5bslUatqh0iEJu4jk+SrrktT70eHXGayuz/7Ht1OMdtsKR8Rk
         Ii0luEb5w5+TLPRZVjCQSzbEsyPdGoxCoIaZXA3jLFeZWqK+jqtwsXLvG9fUGSHbfu
         K95fv+QFHk+B4mzBl59Z0Kyng0wH2KIjeHmzHfp5Yg8mkFOYH6CrKQXRvAb45jwl+X
         BKjXUBFUEyz3bSXyBAoAA7V38JUlR05N3iinW6CJHs6ersWPLnX2sqvS9HnJijWfKB
         1IPjq336WqX0A==
Date:   Tue, 7 Jun 2022 14:23:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the hwmon-staging tree
Message-ID: <20220607142301.3eb8a53c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//JJQ3_e7gJbYB1ZjVzg3biD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//JJQ3_e7gJbYB1ZjVzg3biD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/hwmon/lm90.rst:493: WARNING: Bullet list ends without a blank=
 line; unexpected unindent.
Documentation/hwmon/lm90.rst:494: WARNING: Bullet list ends without a blank=
 line; unexpected unindent.

Introduced by commit

  7dd47c2603aa ("hwmon: (lm90) Support MAX1617 and LM84")

--=20
Cheers,
Stephen Rothwell

--Sig_//JJQ3_e7gJbYB1ZjVzg3biD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKe0qUACgkQAVBC80lX
0GzWpwf+PCLWOnB8DlDgeGoylq5wDCiBtJzXj4u2okJK6dfvNWvH4r61kb+9DcTD
rEuP+SoC62GKR0gdlmeiD8ps0z4wIXJiGuSf5vED4jXfThiccPn9iAi9tNQnx9QA
WJmqCASPgeQ5mR/fqLKUPTVhKWwvUUwPuYiDmtF7MURxbANbnlOqzNBsiOu7lfwB
Qt+rMkCuPoT2O6v0OjcTd20medwQ4K3eDK163Dhfrl4vQySx3qbml5WjW1URXlp0
ynHc6VAZ6W+9oVVnGKEeDhOPlN3uP8QlvvKxNkOkzMsRxnHM4b2aQ5YPeTemXldc
CXH31TLYxySjkZwwo4dOFfgloUGUjQ==
=P2/Z
-----END PGP SIGNATURE-----

--Sig_//JJQ3_e7gJbYB1ZjVzg3biD--

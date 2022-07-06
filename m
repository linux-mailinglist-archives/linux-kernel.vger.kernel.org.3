Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBD569542
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiGFWZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiGFWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:25:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCD2AE21;
        Wed,  6 Jul 2022 15:25:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LdYyG0z8lz4xRC;
        Thu,  7 Jul 2022 08:25:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657146310;
        bh=0WVIHiCwdw66BCg6iN9KJByN6VzAlrzYMCtrXOOxbn8=;
        h=Date:From:To:Cc:Subject:From;
        b=ArjAsBByIJhZKIw833cALzEG5M1elhZFUiRtHqUQeIP/YxIIoRwyg0DSEGhXQ5eCE
         2Rttyw/LfkJrJ7Pd2ArwjA2xGujpvd8S2DImYRJDnQ0SQ1gsp9BUnBbr9hyGF2zYrJ
         Uz3PixF/a0fIgSdiutht3AmC40Rl2/Ri70EGeXgm17BdbL93E14ZNmFgC03lssq7q5
         3IkC/RQtKD4wWFx8zoZobEL/flLgFNvAXflfuHrGOf/yZwKc9ltmcYq5rBdKghEkr1
         6tu6ttoT4OkorHFsM67zCf6fZhGHV9nzVdkO9aqUMP/bmCaIBBy3ODa5+4LiL3BVUD
         STXVJZK8CthzQ==
Date:   Thu, 7 Jul 2022 07:35:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tagis need some work in the pm tree
Message-ID: <20220707073554.01b962df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VrtyW8RDDX89KJSkEh7+7.u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VrtyW8RDDX89KJSkEh7+7.u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8b356e536e69 ("ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supp=
orted")

Fixes tag

  Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is sup=
ported")

has these problem(s):

  - Subject does not match target commit subject

In commit

  7feec7430edd ("ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked")

Fixes tag

  Fixes: 2ca8e6285250 ("Revert "ACPI Pass the same capabilities to the _OSC=
 regardless of the query flag"")

has these problem(s):

  - Subject does not match target commit subject

Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/VrtyW8RDDX89KJSkEh7+7.u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGADoACgkQAVBC80lX
0Gx4Ogf+KDaHbnwNIr3x8Sj3csBrdEBT21PG0iZbGCEetmkCpQypH5/RIUPOwPO4
57X1oi4NBdnt8WmK9T/PoNcfemkTU/EvNZ/MfKnPnhFubC+/+mhAoplDaVEli7RO
oARlHnfuhmHdkSH2ADB6Rw1ruKQ333OaQGW/x3D4MYDQIjrf/knq8dEWkRzgEGIt
xjNxFxKU7/rvWPRAnY1IRnHsnVW81+GMgxf9fqMlFnaIo4LAvBKc4LhomaBNIaxJ
kwxD5Uaw/lzv9MDKdF4acNmuslSDQZt35atZWppPRW3LzR7l8KbRZL6Q3VKTg9rd
sl16zlPkgju7OVY00dmtLka8HEB14w==
=3qS6
-----END PGP SIGNATURE-----

--Sig_/VrtyW8RDDX89KJSkEh7+7.u--

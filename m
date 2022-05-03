Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61822517ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiECH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiECH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:26:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A6393DB;
        Tue,  3 May 2022 00:23:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ksryr41Q6z4xR7;
        Tue,  3 May 2022 17:23:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651562580;
        bh=sZTsM1OSLdaRyALwSuPxkejmgWLuY/kECFE+3QS64h0=;
        h=Date:From:To:Cc:Subject:From;
        b=n1WbPR5u4rggkNOm7EX8bgnju+SIn5G32iYp5uFWcSwsLqCkp1x38Jkv7OPKl6eHU
         gfHWV3ZfFGzignyqg2isnNevqVa8iXJURavtXNGM27v21DuExxaQAhIaAHEaZzG1Ly
         kqcCTjtjRHjT7s687zHLh9eNDbo9YxOcQXLD1K+cMsn3PNSTP5V1XWfVZMVATCOmiS
         NbTdIlTBfG1Ws8iDrZIh6NHQ8+MQPgZ6f46dm803IjiR7xsiv+hm8LZn+zk5dYK6Px
         YnwolPg9pA2cmfMNIhHO49yMPGuEC3FsxGcucp8bZBuHz9ArQwYMq6W4r3AMD+JZ3q
         cEWNGlQIK6gOA==
Date:   Tue, 3 May 2022 17:22:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20220503172259.294a15a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UpC=4M6k7ZxZlDU5S/d88Ah";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UpC=4M6k7ZxZlDU5S/d88Ah
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/hwmon/lan966x.rst: WARNING: document isn't included in any to=
ctree

Introduced by commit

  14ed2cdb02e0 ("hwmon: add driver for the Microchip LAN966x SoC")

--=20
Cheers,
Stephen Rothwell

--Sig_/UpC=4M6k7ZxZlDU5S/d88Ah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJw2FMACgkQAVBC80lX
0GxF4Qf9GFSUQb29U0npMfBYc5RjDlEBeC6Pfw+zyZBcabk6imkPkv4SB0fNSc7P
aiUV1ADf89wq/DkWgRkHjIt2bLC8taovG66N6DPlQeqBYWV6sZJr06SNJ8Xrt91e
dUaltTDxLG0Ggz1vfjIyMjRzDsSJbTmQBEVD6qHBIPXWBamCK+coZy69ukCqx3xW
FBPlaMFaWX/PLDNzRwl2Dzexo1vy8RIJy1dOrgY1JY1S20eStOi/G0OGsCc1qYi8
QbuUr+SGjexBPymq6v7U5Pb13ZjmvzMY/phTQomKZ77oxiDnOAbKEDIi9GwOqcDK
KsyIwvrCkki+EEzc7DTFE7a0xdu2Eg==
=vwzR
-----END PGP SIGNATURE-----

--Sig_/UpC=4M6k7ZxZlDU5S/d88Ah--

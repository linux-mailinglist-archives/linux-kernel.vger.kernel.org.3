Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73DF48F4C6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiAOEcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:32:16 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:39919 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiAOEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:32:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JbQHd0m6jz4xsm;
        Sat, 15 Jan 2022 15:32:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642221133;
        bh=DwVna9aPtU+YWGe4lHMtrkXoBPYpSy4EFclecFmNxu4=;
        h=Date:From:To:Cc:Subject:From;
        b=W8SKoP8MW01H0WGrE78ks95r25h7ltwsCCsy37SmAgEn8ELTYLfHu0qsFb30/4P1j
         UQDaYqeU9P+VfdF+dA7h+mBRThaEvpB4nzkjZx8GT1ZpxbmgBmhbpDff9ZhbnZEArE
         G2cWXtnrrmvpi3WRmdswdTsrf15i/yzDaH/ehY1Dr+SYIYmQnRdcH5mZuEttp31p6w
         8UkAOG/vgFfdKpCYgmOAzdmPgRJjD0BOkijSsix8u56MkuGqBshLbIppddph4i4QYe
         A+iSS7QavQKXaNt/zcHJndpl1fODtHYHfnL71++uiWq1y7lHqALkjnHTxTd71mfYmv
         nknhv0xS+KbTA==
Date:   Sat, 15 Jan 2022 15:32:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the devicetree tree
Message-ID: <20220115153212.593f534d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E12w=rlaNwVcckRJ_GIltsg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E12w=rlaNwVcckRJ_GIltsg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree tree, today's linux-next build (htmldocs)
produced these warnings:

include/linux/of.h:1037: warning: Function parameter or member 'np' not des=
cribed in 'of_parse_phandle_with_optional_args'
include/linux/of.h:1037: warning: Function parameter or member 'list_name' =
not described in 'of_parse_phandle_with_optional_args'
include/linux/of.h:1037: warning: Function parameter or member 'cells_name'=
 not described in 'of_parse_phandle_with_optional_args'
include/linux/of.h:1037: warning: Function parameter or member 'index' not =
described in 'of_parse_phandle_with_optional_args'
include/linux/of.h:1037: warning: Function parameter or member 'out_args' n=
ot described in 'of_parse_phandle_with_optional_args'

Introduced by commit

  952c4865d27a ("of: base: add of_parse_phandle_with_optional_args()")

--=20
Cheers,
Stephen Rothwell

--Sig_/E12w=rlaNwVcckRJ_GIltsg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHiTkwACgkQAVBC80lX
0GwJmQf+K7E2G29jvQ0c54JTPW+p01Ov6/TUk5xSPnCaSt9N6TgYobrb0aEDzH1o
tG3StwpKM9yZNh5rc6Htx9vQ9ih7HjDwcpiWPeZKzsdJG7Uqb3+DV6uUx+wKNQ7f
2xKoh8Ri++8lgRZK/xB0BHRywWjnmArod60pIGjW2OIe3iZFnlgjyUJH2OorRp74
Vk43kF5Wig8BXn72VPVmHlif4a1J1lFegjBjWFF7mal3Sbbo9Wa7EUmdgFzZACob
vMBhK7hJqrvazgcrs+DPPOFzWQpVV0hKdf4JAu8u2n1iA5X9n9SdgpZkZyeBSBBd
5y6bSER+kT+uldByZTrE/q3GX8DqEQ==
=+v6G
-----END PGP SIGNATURE-----

--Sig_/E12w=rlaNwVcckRJ_GIltsg--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD24A933F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiBDFQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiBDFQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:16:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8AC061714;
        Thu,  3 Feb 2022 21:16:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JqkKC2dgjz4xQp;
        Fri,  4 Feb 2022 16:16:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643951775;
        bh=+nxKtZ7XKNGP3eYGI9QAyXOREifOM7rzOY5CrcylBoI=;
        h=Date:From:To:Cc:Subject:From;
        b=IqwEr5AMl0s4IMebyNGdHlUjA2HxjPyFl1hpoka2AlV8yb0Km6sfuq+PnSukrmLIB
         3rYUZTKtYBXBpXBr5JFWBvFPofILvzgJUmLyvVOGWjERX4qvmftvc3iUNwja3P76/d
         UGheNBO2SS9my4iaumobg5729iRNGoWskeaeM4zu07/fBPJvdYzKCSafpjbENYazs4
         y4tJJopLM4cynu/3/Y4kXqQAhNHhwqxuxh8c+OaTb26l1ZHl6ZCPRYzUPcZsJtLfWT
         YpPSJJj6+yUXziiym5cA/JZ70JJ4R2WQ484VgOwhvvwS926jzH5tjyX8HVNtVndvOb
         iLZxx9ZAsEuzQ==
Date:   Fri, 4 Feb 2022 16:16:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20220204161614.457ba8a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dSq6/imC.DY2KW52asgk/=P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dSq6/imC.DY2KW52asgk/=P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/hwmon/index.rst:18: WARNING: toctree contains reference to no=
nexisting document 'hwmon/asus_wmi_ec_sensors'
Documentation/hwmon/asus_ec_sensors.rst: WARNING: document isn't included i=
n any toctree

Introduced by commit

  d4b4bb104d12 ("hwmon: (asus-ec-sensors) update documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/dSq6/imC.DY2KW52asgk/=P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH8tp4ACgkQAVBC80lX
0GzbDwf9GSASvm0v2dL3Q39Nu6WkGW2GzLZHbmdxSwptsRmzED5vPEyoFZ6sz5pW
bTugTuy7TImH6PWgo4w+7OZfKyuSmgrTQgcpwmfdpiGKe3hZOSUXoC42jdzzSvlp
lb6QRQsp3pBNQSyURDPIu9KMP8vAx2fLJjAoQ41uWgxvHTOptgXYiyk5SxR/Qdph
nvP2AL/cya8HfvrqC5fr7MMWjEcQkDagwqk97X3aG6gn6fV0Ewm22M4X9Y4rtcs3
VAZbEf8swFWzgzu86j6vQdnEIfwr4LVgvGT/UJclcty3OEp98fQiJJqNTXSaRniJ
XSEzdplQd89UkNkbms/7hxoaxf9NMw==
=yxA4
-----END PGP SIGNATURE-----

--Sig_/dSq6/imC.DY2KW52asgk/=P--

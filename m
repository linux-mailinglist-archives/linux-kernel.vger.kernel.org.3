Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791B04B078B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiBJHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:51:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiBJHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:51:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8F103D;
        Wed,  9 Feb 2022 23:51:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvTTS6nWRz4xcp;
        Thu, 10 Feb 2022 18:51:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644479485;
        bh=B1yq2bMy9lM80w8xA1JlUKwRSLuLjFjKn9WHjv+Tyac=;
        h=Date:From:To:Cc:Subject:From;
        b=QUAk6QnQQaryS8kLj8v66KK8wwxvFnhjWGSmsXbQsz/MMBBNbkoUmHdqNDVV519d4
         k01eSNYceb6YhKe6RjEnC4oLno8ijEN08DcmPe3ddVoFYSSuVIiPHQzgtpsx+nC0Zo
         qfRBwfuReqmwTTMdmNUQBDJts/63+ybLwVofLwa7W15YKA6r2vUWVBSH6hsbhmhYds
         x7aMuUPJ/YIOM4KCu2kuPI3Vl/xIOaurEsqJW/5FLFZLBR0oxD7L3rIAzXIJWD7Xcj
         qidVHuEaL2piymFq3zQqiroXH4XLyHQXNF69KWZU8yICnJON4G3STBJg8m5YOOu4MK
         h52Flw1aZq6Sg==
Date:   Thu, 10 Feb 2022 18:51:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20220210185123.4d39766c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W_77iuQxsfC.=1Nsr_uJRrc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W_77iuQxsfC.=1Nsr_uJRrc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.

Kernel driver sy7636a-hwmon
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  de34a4053250 ("hwmon: sy7636a: Add temperature driver for sy7636a")

--=20
Cheers,
Stephen Rothwell

--Sig_/W_77iuQxsfC.=1Nsr_uJRrc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEw/sACgkQAVBC80lX
0Gz6GggAnBJNpVLR2V4GcHcuXk6upLj96cSBx8FWXo6xC+ByKEAnrXSHoV0zrmVV
gxqOurCgPXWqG9MJXiulTDy0qFK6jCdNAbjlJAQOecxZQYk3jwImAC0nG53lIe4+
AIAAOJPWRDAcVi8ebCUvAslg6CAqPeCSHGZ/e79Uc5gza4aT2k6hGqj1U4St58Qu
JXdZ9Ks0mG2gyxabIoR24WJLJArtuSBog875WHHnazYXPymy1VOafVkRLI59tOLB
vp267qHXR1t0G1q0E6R5h+oXvYuCILro0Rv3CY6eaSJ9uv/O2kRdjKQbIE+hq3MD
qyrOZjaZ5nX3ioAIjDlGbtv8cVkjSg==
=41wg
-----END PGP SIGNATURE-----

--Sig_/W_77iuQxsfC.=1Nsr_uJRrc--

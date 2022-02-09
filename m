Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951004AFF24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiBIVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:20:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBIVT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:19:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82EAC014F32;
        Wed,  9 Feb 2022 13:19:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvCSp48DDz4xNn;
        Thu, 10 Feb 2022 08:19:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644441594;
        bh=rxJNC65oBBpL7X2RVHQafH79h6Jp/lTESREKPAVVvp4=;
        h=Date:From:To:Cc:Subject:From;
        b=RgOfOo/Xpi4tVu4Lh81UDvCOEzTXJztTxDCH20R8Op4RG1PzMf37xmVDNmUCUDJEK
         Ev2XZpFTPqTGuyuPUsYJpg4iPg8OKa0OhYeZt33RN3vIW6c46fEVdGjeOWLqVqQ58V
         5YC3Nz3yrntnbuKPB4bJlQOEjq2B2ffjUr6YN//ZBtmb2kskdWWQro8r4LspCnz5Bn
         Hh2xvUYmHaiFT8RT3395NM7tYgDyTfgJQ3MzEDQ3HvqAbdnhn+unkp8VIgAlb0SCNt
         p9qY2qIWp5TAOPv5ARkKdsYHR299T6OZ5cRQKntON0QdQ3Cfkxdq54RcSn8yHm8+K9
         mZUiBx8e0Nj/w==
Date:   Thu, 10 Feb 2022 08:19:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Yang Wang <KevinYang.Wang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220210081953.48ff4dde@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5LVAXIeXe3Ook3DL7G9=qlt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5LVAXIeXe3Ook3DL7G9=qlt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  41bea173d9b2 ("drm/amd/pm: drm/amd/pm: disable GetPptLimit message in sri=
ov mode")

Fixes tag

  Fixes: f3527a6483fbcc ("drm/amd/pm: Enable sysfs required by rocm-smi too=
lfor One VF mode")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/5LVAXIeXe3Ook3DL7G9=qlt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEL/kACgkQAVBC80lX
0GzKHgf+P+/lUv03I2Shis4TJFcMclj6wxdAHlcL5m+RM5T0De+JyIqvskmvbW/K
+IpE8KwQtz91Ehc5E7XzcFZYJaX+IzZSd5k7vlyMX8fBXEN3eTBhfuybNNN58PkU
oPbJiRRIYNaD6YyyyVhfFYSayabwN5GJywdsx4b6FEUEQ0BlnxzC2HevODiFrLp/
14+qDxG+UoSS0oershDDMkMMA/OXJ0G402ekuXjKCT0LuF+sY390Prda1QNTndFr
B5XpfeyhzxtKNwabK0DGZPRjUyUu79A51pFNOAeTqTZRaUrzhUOU81PU/Lwz0/EP
6ivBsZMHCGhg1TfFNbIyG7vIRSvQjQ==
=81xY
-----END PGP SIGNATURE-----

--Sig_/5LVAXIeXe3Ook3DL7G9=qlt--

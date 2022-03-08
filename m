Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A24D11E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbiCHIQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiCHIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:16:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7A3EAAE;
        Tue,  8 Mar 2022 00:15:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCSmy1hnTz4xv3;
        Tue,  8 Mar 2022 19:15:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646727315;
        bh=wFOMqZZNq0GaaVF2P9ENWmXZWXZjLk7gzmYAs8btRgg=;
        h=Date:From:To:Cc:Subject:From;
        b=QuMQMLMXOJQjIg5yyvl6abS2MZX4t03Ql2dgKcYYJ97aLqXH9VmcVIj2grMTkFJGW
         FUIKW/V1KxrAo2UVZ2+IHQ+Y8on+SvXjLXcSnd9uw03GNDLWE9wHV5xPu+pWSxoB/5
         5NVTp9uqRl1CWb2/1rJWqQoTzzdxcV87UopQp4+ju7Bp/S22iqtuEH4SrIghu+ejRI
         RTNNXlP4aOoPNfSpd1Vob+WJIa4ZbbJ9uKwZ0Nxw2hmBryza3BDfvoiJ2hhKxFuvke
         sCGIl+fA+lHV/XEtusRln2KbWfZytyuImWj4N3rF64PiZDPF1BfVCfiXEQYQO8VqlB
         pvLSS8iQYCN9A==
Date:   Tue, 8 Mar 2022 19:15:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the v4l-dvb-next tree
Message-ID: <20220308191511.7fa2ddba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t0/bTgU7Afo7KhXLrWMglH4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t0/bTgU7Afo7KhXLrWMglH4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build
(htmldocs) produced these warnings:

Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-pix-=
fmt-nv12m-8l128
Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-pix-=
fmt-nv12m-10be-8l128
Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-pix-=
fmt-mm21

Introduced by commit

  72a74c8f0a0d ("media: add nv12m_8l128 and nv12m_10be_8l128 video format.")

--=20
Cheers,
Stephen Rothwell

--Sig_/t0/bTgU7Afo7KhXLrWMglH4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmInEJAACgkQAVBC80lX
0Gz5Ogf/f3wFiSuHzRtIGVG7V7obhEIXawNaERr1coQhi0taiVNE7BAMERS5c3MP
LoEzxwPWkJFZjZ2ahVaERiqrBFtLG6Al0iE20ALcX6Gyr9zxeLf0KafNfn4vmJAB
ycjVVnkGXJV828pwP9Ak6GA6x4f8wj+CF3TJAUqk9BSlMY4L5hfkYCoSLackK7dh
dco+1QSKaAYtYDktClV9hQCFJHk4aLgCuqz7z1Zso6n0PrMiPkq/XNxTxyVREEwT
3TkqKpPr+T8yaTXMdEaeE/qJ3fNq1SS3Ou6HquGjG2XXBIgj3FImFDQc+Rn1B8vQ
YIot3IQ7b0YrEXW310lL6KnvNPa9yQ==
=f91D
-----END PGP SIGNATURE-----

--Sig_/t0/bTgU7Afo7KhXLrWMglH4--

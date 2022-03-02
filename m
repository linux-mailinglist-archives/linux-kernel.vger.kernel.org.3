Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2614CB060
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbiCBU6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCBU63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:58:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589D240BA;
        Wed,  2 Mar 2022 12:57:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K85zM1zmwz4xNm;
        Thu,  3 Mar 2022 07:57:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646254655;
        bh=3Etfr4KgPADZ0bpl/RWZQGZG0bgU9vXJNkKOQRb5fSs=;
        h=Date:From:To:Cc:Subject:From;
        b=CjN6pT3FJw+b+omcNb3X3Kf2EbrQ17r/W4ghWbZ9ooAtFlHG2L8voPAeiGZxG5HMG
         L4rCBLizt6OMSGNcL041waypzCRe3Gy8SOd7cu5aJrcCCKo5qABqj3/oCkTuncDVzE
         MNMUIYWjWPNycV1s8jdWX5GnGyvrhuo/1YzVK53Mnj6gPlprT55IN/fhynys9kL6t4
         JRkY/tkC97MLIoPblL+sZ/EMVepj0DHDEMdGIPlxV/rfOGaaVSzCA8w+XQ0tuuLPqk
         xXRlUAeKb1zC+4AZTeS2JL2+Vy2u2mrKUuGdl6PnomFJNUWrUjhlI41Of/gWgzQ6Ou
         OjXUkw4V9xmgA==
Date:   Thu, 3 Mar 2022 07:57:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220303075733.481987a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xqM+KiargWg_8jAYUJYN9au";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xqM+KiargWg_8jAYUJYN9au
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d15628d483a5 ("drm/amd/display: Don't fill up the logs")

Fixes tag

  Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic=
 check")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic che=
ck")

--=20
Cheers,
Stephen Rothwell

--Sig_/xqM+KiargWg_8jAYUJYN9au
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIf2j0ACgkQAVBC80lX
0Gz6Tgf9Hz7a6m/fzQ8SBpZ4X7RpsUW0cxbKHK6ed1iQt74qRK7i6dKmCWjCfAY1
dmxf/FM2Cwa3gTLSbLXKecFfPuzAtMiTWDwarSJAO411VERuw5s2vGNZrWQIbg8Q
Z6MskYZJNISlTYl1ZL3cSnPYujpbqxTz5ALcBPs+4I6VGCE/6lDJGAHB5FlA6DBd
PahI/Q26Sr6BW74PzQvKLI34pv/akAWRCoTzjD/djqZKd74XOHX3SWQMq5GLg2ky
Dc0dVIVGjvRPaIlMMAb/JWEIw3C3a6Ifqm+ghIawwsWwXgN1axHq/+W3JPlvPaDn
eF/ORTu6oty2oxWM3ZfkAo/YmpLMhw==
=2cyr
-----END PGP SIGNATURE-----

--Sig_/xqM+KiargWg_8jAYUJYN9au--

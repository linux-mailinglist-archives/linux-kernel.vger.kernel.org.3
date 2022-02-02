Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAC4A6AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiBBEKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:10:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:39073 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBBEKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:10:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JpSyZ0gYtz4xjx;
        Wed,  2 Feb 2022 15:10:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643775047;
        bh=FqG0revIyQjV9+Ys6oYq1LnaXb7bQzHO5eXwJcK5vTs=;
        h=Date:From:To:Cc:Subject:From;
        b=lCmQdW22mE7QIrii8qagiY2B61BiMfCGkx0H4CNcjYZKHBFaAW31kn7Th1bnaN+Bi
         rOxG/eGYASxFa+SO8efErUoYrsCkQZ//oH00wMkhi9ZdRC3/GGVr9YW4lYdAIUPK9h
         rR8MZbo7310D42cuc3FQFM1Veandq4qy/4ziJTnWFweOj0z4fPS2eHYSZlrb6tscXn
         n0rEKV49Ji09utlO7WbmxXAyyCDRCGQYCCzh8DSNWyPfVMhzC1ZwTz8vYxkSoBG1yg
         qW81yYZcOgPE5+56YrUeFw2phU/Y+BoklZYKbE5RaGV9kephdW8S7mlhiMZXW7Eciz
         HI2VXaa1O/N9Q==
Date:   Wed, 2 Feb 2022 15:10:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20220202151045.23205624@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aCnuzjM0VF6RvnWI7x4p1Ea";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aCnuzjM0VF6RvnWI7x4p1Ea
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
this warning:

include/drm/drm_connector.h:637: warning: Function parameter or member 'edi=
d_hdmi_rgb444_dc_modes' not described in 'drm_display_info'
include/drm/drm_connector.h:637: warning: Function parameter or member 'edi=
d_hdmi_ycbcr444_dc_modes' not described in 'drm_display_info'

Introduced by commit

  4adc33f36d80 ("drm/edid: Split deep color modes between RGB and YUV444")

--=20
Cheers,
Stephen Rothwell

--Sig_/aCnuzjM0VF6RvnWI7x4p1Ea
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH6BEUACgkQAVBC80lX
0GwqxAf9Gx+Bctg07MRPALSAcThO9QqJtaAa8imgMBOfoM9SApzsrWnho8lbVfyc
Y5AYJ9PdN+qu0yePEHdmsuLN7DvEO24etcX7fJUiE+03iU68CdHWm5dNKgxcwq26
P55EwjlAxiNeRcJ5zj8fn+7ygdpafHwJwcGjdY8Z01h7jqwmc+G1+IgRSBTmQvju
VMYZYRHYWNPhjrViEfB37h7zeSotTsZFVaeL05U+kjHuR5qpWyJTug1FUiGNOUV4
AGf4OrFDhvsxQ4EOJW01Y3NXu9OktEAXvQYm2G/omQtpd2CqXe7yu2WUL0OeUDbZ
EuFh5Lnl6aq+/PDrvYBYPbHWdYwKoA==
=JhTS
-----END PGP SIGNATURE-----

--Sig_/aCnuzjM0VF6RvnWI7x4p1Ea--

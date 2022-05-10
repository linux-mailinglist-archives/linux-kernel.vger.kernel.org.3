Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED797520EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiEJHkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbiEJH2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:28:46 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE6224073
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:24:47 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8029D83E3C;
        Tue, 10 May 2022 09:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652167485;
        bh=v42t0wrj9GqLV8s127IUUQybanR9QIQ7nDnaooUBt6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WyEiuVPmuqAvc8fU/hGB1RC/6cdq88pwNbCQ56Twj3dgvkpv2U8DnGIHoJMsNBWYI
         h9w61x5ZZUi6J9b+UqTjXUHkQJxu61hJEt+vpn1cOxfeQnlCdx5QHJtD8XzqRejwyr
         fKSGf11dNu4CtxO6+TXS36b2OUbR3KWViWKO1Hpcc39NI4xh7C6yplBr3SvtU2OjrY
         W8h+lEZBKNfxEfqjkL8mgm4V5j1fddZXnF9dY2uvshKFQBWyujCTFf1gVp8SSwjIgW
         9OBuDO+adZYMlFoYInwYx8pyAdTyAllI4idDxDTrYvbQFoziUco90NzZvJrsvTK9Qa
         zTrZjEv4IotUA==
Date:   Tue, 10 May 2022 09:24:38 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-ID: <20220510092438.528ef474@ktm>
In-Reply-To: <YnkxIe1nVUiKNmdq@sirena.org.uk>
References: <20220509121055.31103-1-lukma@denx.de>
        <YnkxIe1nVUiKNmdq@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/l5EeiAB24OpqNCHm+5Ik.br"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l5EeiAB24OpqNCHm+5Ik.br
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, May 09, 2022 at 02:10:55PM +0200, Lukasz Majewski wrote:
>=20
> > This adds devicetree support to the wm8940 codec driver.
> > With a DT-based kernel, there is no board-specific setting
> > to select the driver so allow it to be manually chosen.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  sound/soc/codecs/Kconfig  | 2 +-
> >  sound/soc/codecs/wm8940.c | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-) =20
>=20
> You need to provide a binding document for any new bindings you add in
> code.

The second patch in this series adds proper *.yaml file to Linux source
tree.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/l5EeiAB24OpqNCHm+5Ik.br
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmJ6EzYACgkQAR8vZIA0
zr2ipQf8DYNUBWhZGVEpcwS7FiqcW87GPw7EDy7MupmT2l/ScAHov2l3ICd+jwWL
sEZrUl3xdsXFxnUnqe2e35tr59srJoCZdQNbrHLJYZhO3BhDIMS5XHvEiz8UARkz
KqW5qfk5yHQcw7H/0qOh97K31M81BjuaGCoQW1TRz5O72RTqRwjOWFCkQ0XK9j84
OMPIrCLKdLMVuyZZ7SVrEa8iNMgY/GT5i7b4EE++gXkZ6dYymbpX6WMLsP5+wm8T
HE392Fld406Qi5bCkt2cx5YAc/a/BGBOfbyc0yuXrMhNRUZ8OhAyE0egmI+sJp0c
zD0j/vk2FjCMlpj7o+FdTzGvcxNhag==
=Q5fm
-----END PGP SIGNATURE-----

--Sig_/l5EeiAB24OpqNCHm+5Ik.br--
